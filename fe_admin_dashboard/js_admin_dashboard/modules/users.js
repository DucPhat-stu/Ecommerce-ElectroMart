// ==========================================
// MODULE - USERS
// ==========================================

function renderUsersTable() {
    const tableBody = document.getElementById('usersTableBody');
    tableBody.innerHTML = '';
    mockData.users.forEach(user => {
        const row = document.createElement('tr');
        const roleBadge = user.role === 'admin' ? '<span class="badge-danger">Admin</span>' : '<span class="badge-info">User</span>';
        row.innerHTML = `
            <td>#${user.id}</td>
            <td>${user.name}</td>
            <td>${user.email}</td>
            <td>${roleBadge}</td>
            <td>${user.createdAt}</td>
            <td>
                <button class="btn btn-sm" onclick="editUser(${user.id})"><i class="fas fa-edit"></i></button>
                <button class="btn btn-sm btn-danger" onclick="deleteUser(${user.id})"><i class="fas fa-trash"></i></button>
            </td>
        `;
        tableBody.appendChild(row);
    });
    setupUserFilters();
}

function setupUserFilters() {
    const searchInput = document.getElementById('userSearch');
    const roleFilter = document.getElementById('userRoleFilter');
    const filterUsers = () => {
        const searchTerm = searchInput.value.toLowerCase();
        const roleValue = roleFilter.value;
        document.querySelectorAll('#usersTableBody tr').forEach(row => {
            const nameMatch = row.cells[1].textContent.toLowerCase().includes(searchTerm);
            const roleMatch = !roleValue || row.cells[3].textContent.includes(roleValue);
            row.style.display = nameMatch && roleMatch ? '' : 'none';
        });
    };
    searchInput.addEventListener('input', filterUsers);
    roleFilter.addEventListener('change', filterUsers);
}

function editUser(userId) {
    const user = mockData.users.find(u => u.id === userId);
    if (user) {
        appState.editingId = userId;
        document.getElementById('userName').value = user.name;
        document.getElementById('userEmail').value = user.email;
        document.getElementById('userRole').value = user.role;
        const modal = new bootstrap.Modal(document.getElementById('userModal'));
        modal.show();
    }
}

function deleteUser(userId) {
    if (confirm('Are you sure?')) {
        mockData.users = mockData.users.filter(u => u.id !== userId);
        renderUsersTable();
        showNotification('User deleted', 'success');
    }
}

function saveUser() {
    const name = document.getElementById('userName').value;
    const email = document.getElementById('userEmail').value;
    const role = document.getElementById('userRole').value;
    if (!name || !email) { showNotification('Fill all fields', 'danger'); return; }
    if (appState.editingId) {
        const user = mockData.users.find(u => u.id === appState.editingId);
        if (user) { user.name = name; user.email = email; user.role = role; }
        showNotification('User updated', 'success');
    } else {
        mockData.users.push({ id: mockData.users.length + 1, name, email, role, createdAt: new Date().toISOString().split('T')[0] });
        showNotification('User added', 'success');
    }
    appState.editingId = null;
    renderUsersTable();
    bootstrap.Modal.getInstance(document.getElementById('userModal')).hide();
}
