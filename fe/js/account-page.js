/*
 * account-page.js
 * Trang Profile (My Account) - chỉ hiển thị khi đã đăng nhập.
 * Nếu chưa login => chuyển sang login.html
 */

(function () {
  function hasToken() {
    try {
      return !!(
        localStorage.getItem('accessToken') ||
        localStorage.getItem('token') ||
        localStorage.getItem('jwt')
      );
    } catch (_) {
      return false;
    }
  }

  function getRedirectUrl() {
    // Giữ lại query (nếu có)
    var path = window.location.pathname.split('/').pop() || 'account.html';
    var qs = window.location.search || '';
    return path + qs;
  }

  function goToLogin() {
    var redirect = encodeURIComponent(getRedirectUrl());
    window.location.href = 'login.html?redirect=' + redirect;
  }

  async function loadProfile() {
    try {
      var uid = (window.getCurrentUserId && window.getCurrentUserId()) || localStorage.getItem('currentUserId');
      var res = await window.UserAPI.getCurrentUser(uid);
      if (!res || res.success === false || !res.data) return false;
      var u = res.data;
      $('#acc-name').val(u.fullName || u.name || '');
      $('#acc-email').val(u.email || '');
      $('#acc-phone').val(u.phone || '');
      $('#acc-address').val(u.address || '');
      return true;
    } catch (e) {
      return false;
    }
  }

  $(function () {
    // Gate: nếu chưa login thì chuyển sang login.html
    if (!hasToken()) {
      goToLogin();
      return;
    }

    // đảm bảo axios có header auth (nếu api.js/app.js có helper)
    if (window.setAxiosAuthHeader) window.setAxiosAuthHeader();

    $('#account-form').show();

    // Load profile
    loadProfile();

    // Update profile
    $('#account-form').on('submit', function (e) {
      e.preventDefault();
      var payload = {
        fullName: $('#acc-name').val(),
        email: $('#acc-email').val(),
        phone: $('#acc-phone').val(),
        address: $('#acc-address').val(),
      };

      if (!window.UserAPI || !window.UserAPI.updateCurrentUser) {
        alert('User API is not ready. Please check js/api.js');
        return;
      }

      window.UserAPI.updateCurrentUser(null, payload).then(function (res) {
        if (res && res.success !== false) {
          alert('Account updated successfully');
        } else {
          alert((res && res.message) ? res.message : 'Update failed');
        }
      });
    });

    // Logout
    $('#btn-logout').on('click', function () {
      try {
        localStorage.removeItem('accessToken');
        localStorage.removeItem('token');
        localStorage.removeItem('jwt');
        localStorage.removeItem('currentUserId');
        localStorage.removeItem('username');
        if (window.setAxiosAuthHeader) window.setAxiosAuthHeader();
      } catch (_) {}
      goToLogin();
    });
  });
})();
