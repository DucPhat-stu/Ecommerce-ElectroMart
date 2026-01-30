/*
 * login-page.js
 * Trang Login riêng.
 * Nếu đã login => chuyển sang account.html
 * Login xong => quay lại redirect (mặc định account.html)
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

  function getQueryParam(name) {
    try {
      var params = new URLSearchParams(window.location.search || '');
      return params.get(name);
    } catch (_) {
      // fallback đơn giản
      var m = new RegExp('(?:\\?|&)' + name + '=([^&]+)').exec(window.location.search);
      return m ? decodeURIComponent(m[1]) : null;
    }
  }

  function safeRedirect(target) {
    // Chỉ cho phép redirect nội bộ (tránh open redirect)
    if (!target) return 'account.html';
    if (target.startsWith('http://') || target.startsWith('https://')) return 'account.html';
    if (target.includes('..')) return 'account.html';
    return target;
  }

  $(function () {
    var redirect = safeRedirect(getQueryParam('redirect'));

    if (hasToken()) {
      window.location.href = redirect || 'account.html';
      return;
    }

    $('#login-form').on('submit', async function (e) {
      e.preventDefault();

      var username = ($('#login-username').val() || '').trim();
      var password = $('#login-password').val() || '';

      if (!username || !password) {
        alert('Please enter username and password');
        return;
      }

      if (!window.AuthAPI || !window.AuthAPI.login) {
        alert('Auth API is not ready. Please check js/api.js');
        return;
      }

      try {
        var res = await window.AuthAPI.login(username, password);

        if (res && res.success !== false && res.data && res.data.accessToken) {
          try {
            localStorage.setItem('accessToken', res.data.accessToken);
            localStorage.setItem('currentUserId', String(res.data.userId || ''));
            localStorage.setItem('username', res.data.username || username);
            if (window.setAxiosAuthHeader) window.setAxiosAuthHeader();
          } catch (_) {}

          // check role to redirect admin
          if (window.UserAPI && window.UserAPI.getCurrentUser && res.data.userId) {
            window.UserAPI.getCurrentUser(res.data.userId).then(function (uRes) {
              var user = uRes && uRes.data ? uRes.data : null;
              if (user && Number(user.roleId) === 2) {
                window.location.href = '../fe_admin_dashboard/index.html';
              } else {
                window.location.href = redirect || 'account.html';
              }
            }).catch(function () {
              window.location.href = redirect || 'account.html';
            });
          } else {
            window.location.href = redirect || 'account.html';
          }

          // refresh header counts (nếu có)
          if (window.updateHeaderCart) window.updateHeaderCart();
          if (window.updateHeaderWishlistCount) window.updateHeaderWishlistCount();
        } else {
          alert((res && res.message) ? res.message : 'Login failed');
        }
      } catch (err) {
        alert('Login failed');
      }
    });
  });
})();
