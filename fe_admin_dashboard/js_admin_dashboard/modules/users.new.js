// ==========================================
// MODULE - USERS (API-based with mock fallback)
// ==========================================
// Mapping theo admin-chuc-nang.md:
// - API: /users, /user/{id} (GET/POST/PUT/DELETE)
// - DTO tối thiểu: id, name, email, role, createdAt

async function renderUsersTable() {
    const tableBody = document.getElementById('usersTableBody');
    if (!tableBody) return;

    tableBody.innerHTML = '<tr><td colspan="6" class="text-center text-muted">Loading...</td></tr>';

    let users = [];
    try {
        const res = await API.getUsers();
        const raw = Array.isArray(res) ? res : (res?.items || res?.users || []);
        users = Array.isArray(raw) ? raw : [];
    } catch (e) {
        console.warn('renderUsersTable: using mockData.users fallback', e);
        users = Array.isArray(mockData?.users) ? mockData.users : [];
    }

    tableBody.innerHTML = '';
    if (!users.length) {
        tableBody.innerHTML = '<tr><td colspan="6" class="text-center text-muted">No data</td></tr>';
        setupUserFilters();
        return;
    }

    users.forEach(user => {
        const id = user?.id ?? user?.userId;
        const name = user?.name ?? user?.fullName ?? '';
        const email = user?.email ?? '';
        const role = (user?.role || '').toString().toLowerCase();
        const createdAt = user?.createdAt ?? user?.created_date ?? '';
        const isAdmin = role === 'admin' || role === 'ROLE_ADMIN';
        const roleBadge = isAdmin
            ? '<span class="badge-danger">Admin</span>'
            : '<span class="badge-info">User</span>';

        const row = document.createElement('tr');
        row.innerHTML = `
            <td>#${id ?? ''}</td>
            <td>${name}</td>
            <td>${email}</td>
            <td>${roleBadge}</td>
            <td>${createdAt}</td>
            <td>
                <button class="btn btn-sm" onclick="editUser(${Number(id)})"><i class="fas fa-edit"></i></button>
                <button class="btn btn-sm btn-danger" onclick="deleteUser(${Number(id)})"><i class="fas fa-trash"></i></button>
            </td>
        `;
        tableBody.appendChild(row);
    });

    setupUserFilters();
}

function setupUserFilters() {
    const searchInput = document.getElementById('userSearch');
    const roleFilter = document.getElementById('userRoleFilter');
    if (!searchInput || !roleFilter) return;
    if (searchInput.__bound) return;
    searchInput.__bound = true;

    const filterUsers = () => {
        const searchTerm = searchInput.value.toLowerCase();
        const roleValue = roleFilter.value;
        document.querySelectorAll('#usersTableBody tr').forEach(row => {
            const nameCell = row.cells[1];
            const roleCell = row.cells[3];
            if (!nameCell || !roleCell) return;
            const nameMatch = nameCell.textContent.toLowerCase().includes(searchTerm);
            const roleMatch = !roleValue || roleCell.textContent.toLowerCase().includes(roleValue.toLowerCase());
            row.style.display = nameMatch && roleMatch ? '' : 'none';
        });
    };
    searchInput.addEventListener('input', filterUsers);
    roleFilter.addEventListener('change', filterUsers);
}

async function editUser(userId) {
    const id = Number(userId);
    if (!id) return;

    let user = null;
    try {
        user = await API.getUser(id);
    } catch (e) {
        console.warn('editUser: fallback to mockData', e);
        user = (mockData?.users || []).find(u => Number(u.id) === id) || null;
    }

    if (!user) return;

    appState.editingId = id;
    document.getElementById('userName').value = user?.name ?? user?.fullName ?? '';
    document.getElementById('userEmail').value = user?.email ?? '';
    const role = (user?.role || '').toString().toLowerCase();
    document.getElementById('userRole').value = role === 'admin' || role === 'ROLE_ADMIN' ? 'admin' : 'user';
    const modal = new bootstrap.Modal(document.getElementById('userModal'));
    modal.show();
}

async function deleteUser(userId) {
    const id = Number(userId);
    if (!id) return;
    if (!confirm('Are you sure?')) return;

    try {
        try {
            await API.deleteUser(id);
        } catch (e) {
            console.warn('deleteUser: backend failed, updating mockData only', e);
            if (Array.isArray(mockData?.users)) {
                mockData.users = mockData.users.filter(u => Number(u.id) !== id);
            }
        }
        await renderUsersTable();
        showNotification('User deleted', 'success');
    } catch (e) {
        console.error(e);
        showNotification('Delete user failed', 'danger');
    }
}

async function saveUser() {
    const name = document.getElementById('userName').value?.trim();
    const email = document.getElementById('userEmail').value?.trim();
    const roleUi = document.getElementById('userRole').value;
    if (!name || !email) {
        showNotification('Fill all fields', 'danger');
        return;
    }

    const payload = {
        name,
        email,
        role: roleUi === 'admin' ? 'ADMIN' : 'USER'
    };

    try {
        if (appState.editingId) {
            const id = appState.editingId;
            try {
                await API.updateUser(id, payload);
                showNotification('User updated', 'success');
            } catch (e) {
                console.warn('saveUser(update): backend failed, updating mockData only', e);
                const user = (mockData.users || []).find(u => Number(u.id) === Number(id));
                if (user) {
                    user.name = name;
                    user.email = email;
                    user.role = roleUi;
                }
                showNotification('User updated (mock mode)', 'warning');
            }
        } else {
            try {
                await API.createUser(payload);
                showNotification('User added', 'success');
            } catch (e) {
                console.warn('saveUser(create): backend failed, adding to mockData only', e);
                mockData.users = mockData.users || [];
                mockData.users.push({
                    id: mockData.users.length + 1,
                    name,
                    email,
                    role: roleUi,
                    createdAt: new Date().toISOString().split('T')[0]
                });
                showNotification('User added (mock mode)', 'warning');
            }
        }
    } finally {
        appState.editingId = null;
        await renderUsersTable();
        bootstrap.Modal.getInstance(document.getElementById('userModal'))?.hide();
    }
}

