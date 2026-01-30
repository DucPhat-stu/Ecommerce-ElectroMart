// ElectroMart FE API client
// Wraps backend REST APIs and exposes simple JS helpers for app.js
// Requirements: axios (loaded before this script)

(function(window) {
  'use strict';

  var API_PREFIX = '/api/v1';
  var ORDER_BASE = '/api/v1/orders';

  function safe(obj, fallback) {
    return typeof obj === 'undefined' || obj === null ? fallback : obj;
  }

  function baseUrl(path) {
    if (!path.startsWith('/')) path = '/' + path;
    return API_PREFIX + path.replace(API_PREFIX, '');
  }

  function handleApi(promise) {
    return promise.then(function(res) {
      var body = res && res.data;
      if (body && typeof body.success === 'boolean') {
        return body;
      }
      // Some endpoints (like createOrder) return raw entity, normalize to ApiResponse-like
      return {
        success: true,
        message: '',
        data: body,
        error: null
      };
    }).catch(function(err) {
      var message = 'Request failed';
      var error = null;
      var status = null;
      if (err.response && err.response.data) {
        var d = err.response.data;
        message = d.message || message;
        error = d.error || d;
        status = err.response.status;
      } else if (err.message) {
        message = err.message;
      }
      return {
        success: false,
        message: message,
        data: null,
        error: error,
        status: status
      };
    });
  }

  function getAuthToken() {
    try {
      return window.localStorage.getItem('accessToken')
        || window.localStorage.getItem('token')
        || window.localStorage.getItem('jwt')
        || '';
    } catch (_) {
      return '';
    }
  }

  function setAxiosAuthHeader() {
    var token = getAuthToken();
    if (token) {
      axios.defaults.headers.common.Authorization = 'Bearer ' + token;
    } else {
      delete axios.defaults.headers.common.Authorization;
    }
  }

  function authConfig() {
    var token = getAuthToken();
    if (!token) return {};
    return { headers: { Authorization: 'Bearer ' + token } };
  }

  // --------- Global helpers exposed to app.js ----------

  // Simple user identifier for demo/frontend only (no auth flow yet)
  function getCurrentUserId() {
    try {
      var stored = window.localStorage.getItem('currentUserId') || window.localStorage.getItem('userId');
      if (stored) {
        var n = Number(stored);
        if (!isNaN(n) && n > 0) return n;
      }
    } catch (_) {}
    return 1; // default demo user
  }

  function formatPrice(value) {
    var num = Number(value || 0);
    try {
      return new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD',
        maximumFractionDigits: 0
      }).format(Math.round(num));
    } catch (_) {
      return '$' + Math.round(num).toLocaleString('en-US');
    }
  }

  window.getCurrentUserId = getCurrentUserId;
  window.formatPrice = formatPrice;

  // --------- API modules ----------

  var ProductAPI = {
    getAll: function() {
      return handleApi(
        axios.get(baseUrl('/products'), authConfig())
      );
    },

    getById: function(id) {
      // Some builds expose /product/{id}, others use /products/{id}
      return handleApi(
        axios.get(baseUrl('/product/' + encodeURIComponent(id)), authConfig())
      ).then(function(res) {
        if (res && res.success !== false) return res;
        return handleApi(
          axios.get(baseUrl('/products/' + encodeURIComponent(id)), authConfig())
        );
      });
    }
  };

  var CategoryAPI = {
    getAll: function() {
      return handleApi(
        axios.get(baseUrl('/categories'), authConfig())
      );
    },
    getById: function(id) {
      return handleApi(
        axios.get(baseUrl('/category/' + encodeURIComponent(id)), authConfig())
      );
    }
  };

  var CartAPI = {
    getUserCart: function(userId) {
      return handleApi(
        axios.get(baseUrl('/cart/' + encodeURIComponent(userId)), authConfig())
      );
    },

    addToCart: function(userId, productId, quantity) {
      return handleApi(
        axios.post(baseUrl('/cart'), {
          userId: safe(userId, getCurrentUserId()),
          productId: productId,
          quantity: quantity
        }, authConfig())
      );
    },

    updateQuantity: function(cartId, quantity) {
      return handleApi(
        axios.put(baseUrl('/cart/' + encodeURIComponent(cartId)), {
          quantity: quantity
        }, authConfig())
      );
    },

    removeFromCart: function(cartId) {
      return handleApi(
        axios.delete(baseUrl('/cart/' + encodeURIComponent(cartId)), authConfig())
      );
    },

    clearCart: function(userId) {
      return handleApi(
        axios.delete(baseUrl('/cart/user/' + encodeURIComponent(userId)), authConfig())
      );
    }
  };

  var ReviewAPI = {
    getProductReviews: function(productId) {
      return handleApi(
        axios.get(baseUrl('/reviews/product/' + encodeURIComponent(productId)), authConfig())
      );
    },

    create: function(productId, userId, rating, comment) {
      return handleApi(
        axios.post(baseUrl('/reviews'), {
          productId: productId,
          userId: safe(userId, getCurrentUserId()),
          rating: rating,
          comment: comment
        }, authConfig())
      );
    }
  };

  var UserAPI = {
    getCurrentUser: function(userId) {
      var id = safe(userId, getCurrentUserId());
      return handleApi(
        axios.get(baseUrl('/user/' + encodeURIComponent(id)), authConfig())
      );
    },

    updateCurrentUser: function(userId, payload) {
      var id = safe(userId, getCurrentUserId());
      return handleApi(
        axios.put(baseUrl('/user/' + encodeURIComponent(id)), payload, authConfig())
      );
    }
  };

  var WishlistAPI = {
    getUserWishlist: function(userId) {
      var id = safe(userId, getCurrentUserId());
      return handleApi(
        axios.get(baseUrl('/wishlist'), Object.assign({ params: { userId: id } }, authConfig()))
      );
    },

    getWishlistCount: function(userId) {
      var id = safe(userId, getCurrentUserId());
      return handleApi(
        axios.get(baseUrl('/wishlist/count'), Object.assign({ params: { userId: id } }, authConfig()))
      );
    },

    add: function(userId, productId) {
      var id = safe(userId, getCurrentUserId());
      return handleApi(
        axios.post(
          baseUrl('/wishlist'),
          {}, // empty JSON body to satisfy ValidationFilter (expects application/json)
          {
            params: { userId: id, productId: productId },
            headers: Object.assign({ 'Content-Type': 'application/json' }, authConfig().headers || {})
          }
        )
      );
    },

    remove: function(userId, productId) {
      var id = safe(userId, getCurrentUserId());
      return handleApi(
        axios.delete(baseUrl('/wishlist'), {
          params: { userId: id, productId: productId },
          headers: (authConfig().headers || {})
        })
      );
    }
  };

  var OrderAPI = {
    // Create order with payload aligned to api_structure/createOrderAPI.json
    // Endpoint: POST /api/v1/orders
    create: function(orderData) {
      var payload = orderData || {};
      // Ensure userId exists for current backend (later: replace with JWT user id)
      if (payload.userId == null) payload.userId = getCurrentUserId();
      return handleApi(
        axios.post(baseUrl('/orders'), payload, authConfig())
      );
    },

    // List orders (admin or user scope depends on backend implementation)
    getAll: function() {
      return handleApi(
        axios.get(baseUrl('/orders'), authConfig())
      );
    },

    // (optional for next steps) fetch order by id: GET /api/v1/orders/{id}
    getById: function(id) {
      return handleApi(
        axios.get(baseUrl('/orders/' + encodeURIComponent(id)), authConfig())
      );
    }
  };

  var AuthAPI = {
    login: function(username, password) {
      return handleApi(
        axios.post(baseUrl('/auth/login'), { username: username, password: password })
      );
    },
    register: function(payload) {
      return handleApi(
        axios.post(baseUrl('/auth/register'), payload)
      );
    }
  };

  window.ProductAPI = ProductAPI;
  window.CategoryAPI = CategoryAPI;
  window.CartAPI = CartAPI;
  window.ReviewAPI = ReviewAPI;
  window.UserAPI = UserAPI;
  window.WishlistAPI = WishlistAPI;
  window.OrderAPI = OrderAPI;
  window.AuthAPI = AuthAPI;

  // Initialize default Authorization header (if token already stored)
  setAxiosAuthHeader();

  // Expose helper so app.js can refresh header after login/logout
  window.setAxiosAuthHeader = setAxiosAuthHeader;

})(window);

