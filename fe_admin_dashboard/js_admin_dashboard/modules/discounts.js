// ==========================================
// MODULE - DISCOUNTS (API-based with mock fallback)
// ==========================================
// Mapping theo admin-chuc-nang.md:
// - API: /discounts, /discount/{id} (GET/POST/PUT/DELETE)
// - DTO tối thiểu: id, code/discountCode, percent, startDate, endDate, status

async function renderDiscountsTable() {
    const tableBody = document.getElementById('discountsTableBody');
    if (!tableBody) return;

    tableBody.innerHTML = '<tr><td colspan="7" class="text-center text-muted">Loading...</td></tr>';

    let discounts = [];
    try {
        const res = await API.getDiscounts();
        const raw = Array.isArray(res) ? res : (res?.items || res?.discounts || []);
        discounts = Array.isArray(raw) ? raw : [];
    } catch (e) {
        console.warn('renderDiscountsTable: using mockData.discounts fallback', e);
        discounts = Array.isArray(mockData?.discounts) ? mockData.discounts : [];
    }

    tableBody.innerHTML = '';
    if (!discounts.length) {
        tableBody.innerHTML = '<tr><td colspan="7" class="text-center text-muted">No data</td></tr>';
        setupDiscountFilters();
        return;
    }

    const now = new Date();

    discounts.forEach(discount => {
        const id = discount?.id ?? discount?.discountId;
        const code = discount?.code ?? discount?.discountCode ?? '';
        const percent = discount?.percent ?? discount?.discountPercent ?? 0;
        const startDate = discount?.startDate ?? discount?.start_time ?? '';
        const endDate = discount?.endDate ?? discount?.end_time ?? '';

        let status = (discount?.status || '').toString().toLowerCase();
        if (!status) {
            const end = endDate ? new Date(endDate) : null;
            status = end && end > now ? 'active' : 'expired';
        }
        const statusBadge = status === 'active'
            ? '<span class="badge-success">Active</span>'
            : '<span class="badge-danger">Expired</span>';

        const row = document.createElement('tr');
        row.innerHTML = `
            <td>#${id ?? ''}</td>
            <td>${code}</td>
            <td>${percent}%</td>
            <td>${startDate}</td>
            <td>${endDate}</td>
            <td>${statusBadge}</td>
            <td>
                <button class="btn btn-sm" onclick="editDiscount(${Number(id)})"><i class="fas fa-edit"></i></button>
                <button class="btn btn-sm btn-danger" onclick="deleteDiscount(${Number(id)})"><i class="fas fa-trash"></i></button>
            </td>
        `;
        tableBody.appendChild(row);
    });

    setupDiscountFilters();
}

function setupDiscountFilters() {
    const searchInput = document.getElementById('discountSearch');
    const statusFilter = document.getElementById('discountStatusFilter');
    if (!searchInput || !statusFilter) return;
    if (searchInput.__bound) return;
    searchInput.__bound = true;

    const filterDiscounts = () => {
        const searchTerm = searchInput.value.toLowerCase();
        const statusValue = statusFilter.value;
        document.querySelectorAll('#discountsTableBody tr').forEach(row => {
            const codeCell = row.cells[1];
            const statusCell = row.cells[5];
            if (!codeCell || !statusCell) return;
            const codeMatch = codeCell.textContent.toLowerCase().includes(searchTerm);
            const statusMatch = !statusValue || statusCell.textContent.toLowerCase().includes(statusValue.toLowerCase());
            row.style.display = codeMatch && statusMatch ? '' : 'none';
        });
    };

    searchInput.addEventListener('input', filterDiscounts);
    statusFilter.addEventListener('change', filterDiscounts);
}

async function editDiscount(discountId) {
    const id = Number(discountId);
    if (!id) return;

    let discount = null;
    try {
        discount = await API.getDiscount(id);
    } catch (e) {
        console.warn('editDiscount: fallback to mockData', e);
        discount = (mockData?.discounts || []).find(d => Number(d.id) === id) || null;
    }

    if (!discount) return;

    appState.editingId = id;
    document.getElementById('discountCode').value = discount?.code ?? discount?.discountCode ?? '';
    document.getElementById('discountPercent').value = discount?.percent ?? discount?.discountPercent ?? 0;
    document.getElementById('discountStart').value = discount?.startDate ?? discount?.start_time ?? '';
    document.getElementById('discountEnd').value = discount?.endDate ?? discount?.end_time ?? '';
    const modal = new bootstrap.Modal(document.getElementById('discountModal'));
    modal.show();
}

async function deleteDiscount(discountId) {
    const id = Number(discountId);
    if (!id) return;
    if (!confirm('Are you sure?')) return;

    try {
        try {
            await API.deleteDiscount(id);
        } catch (e) {
            console.warn('deleteDiscount: backend failed, updating mockData only', e);
            if (Array.isArray(mockData?.discounts)) {
                mockData.discounts = mockData.discounts.filter(d => Number(d.id) !== id);
            }
        }
        await renderDiscountsTable();
        showNotification('Discount deleted', 'success');
    } catch (e) {
        console.error(e);
        showNotification('Delete discount failed', 'danger');
    }
}

async function saveDiscount() {
    const code = document.getElementById('discountCode').value?.trim();
    const percent = parseInt(document.getElementById('discountPercent').value, 10);
    const startDate = document.getElementById('discountStart').value;
    const endDate = document.getElementById('discountEnd').value;
    if (!code || !percent || !startDate || !endDate) {
        showNotification('Fill all fields', 'danger');
        return;
    }

    const status = new Date(endDate) > new Date() ? 'active' : 'expired';

    const payload = {
        code,
        discountCode: code,
        percent,
        discountPercent: percent,
        startDate,
        endDate,
        status: status.toUpperCase()
    };

    try {
        if (appState.editingId) {
            const id = appState.editingId;
            try {
                await API.updateDiscount(id, payload);
                showNotification('Discount updated', 'success');
            } catch (e) {
                console.warn('saveDiscount(update): backend failed, updating mockData only', e);
                const discount = (mockData.discounts || []).find(d => Number(d.id) === Number(id));
                if (discount) {
                    discount.code = code;
                    discount.percent = percent;
                    discount.startDate = startDate;
                    discount.endDate = endDate;
                    discount.status = status;
                }
                showNotification('Discount updated (mock mode)', 'warning');
            }
        } else {
            try {
                await API.createDiscount(payload);
                showNotification('Discount added', 'success');
            } catch (e) {
                console.warn('saveDiscount(create): backend failed, adding to mockData only', e);
                mockData.discounts = mockData.discounts || [];
                mockData.discounts.push({
                    id: mockData.discounts.length + 1,
                    code,
                    percent,
                    startDate,
                    endDate,
                    status
                });
                showNotification('Discount added (mock mode)', 'warning');
            }
        }
    } finally {
        appState.editingId = null;
        await renderDiscountsTable();
        bootstrap.Modal.getInstance(document.getElementById('discountModal'))?.hide();
    }
}

