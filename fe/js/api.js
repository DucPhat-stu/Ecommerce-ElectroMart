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
      if (err.response && err.response.data) {
        var d = err.response.data;
        message = d.message || message;
        error = d.error || d;
      } else if (err.message) {
        message = err.message;
      }
      return {
        success: false,
        message: message,
        data: null,
        error: error
      };
    });
  }

  // --------- Global helpers exposed to app.js ----------

  // Simple user identifier for demo/frontend only (no auth flow yet)
  function getCurrentUserId() {
    try {
      var stored = window.localStorage.getItem('currentUserId');
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
      return new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND',
        maximumFractionDigits: 0
      }).format(num);
    } catch (_) {
      return num.toLocaleString('vi-VN') + ' ₫';
    }
  }

  window.getCurrentUserId = getCurrentUserId;
  window.formatPrice = formatPrice;

  // --------- API modules ----------

  var ProductAPI = {
    getAll: function() {
      return handleApi(
        axios.get(baseUrl('/products'))
      );
    },

    getById: function(id) {
      return handleApi(
        axios.get(baseUrl('/product/' + encodeURIComponent(id)))
      );
    }
  };

  var CartAPI = {
    getUserCart: function(userId) {
      return handleApi(
        axios.get(baseUrl('/cart/' + encodeURIComponent(userId)))
      );
    },

    addToCart: function(userId, productId, quantity) {
      return handleApi(
        axios.post(baseUrl('/cart'), {
          userId: safe(userId, getCurrentUserId()),
          productId: productId,
          quantity: quantity
        })
      );
    },

    updateQuantity: function(cartId, quantity) {
      return handleApi(
        axios.put(baseUrl('/cart/' + encodeURIComponent(cartId)), {
          quantity: quantity
        })
      );
    },

    removeFromCart: function(cartId) {
      return handleApi(
        axios.delete(baseUrl('/cart/' + encodeURIComponent(cartId)))
      );
    },

    clearCart: function(userId) {
      return handleApi(
        axios.delete(baseUrl('/cart/user/' + encodeURIComponent(userId)))
      );
    }
  };

  var ReviewAPI = {
    getProductReviews: function(productId) {
      return handleApi(
        axios.get(baseUrl('/reviews/product/' + encodeURIComponent(productId)))
      );
    },

    create: function(productId, userId, rating, comment) {
      return handleApi(
        axios.post(baseUrl('/reviews'), {
          productId: productId,
          userId: safe(userId, getCurrentUserId()),
          rating: rating,
          comment: comment
        })
      );
    }
  };

  var UserAPI = {
    getCurrentUser: function(userId) {
      var id = safe(userId, getCurrentUserId());
      return handleApi(
        axios.get(baseUrl('/user/' + encodeURIComponent(id)))
      );
    },

    updateCurrentUser: function(userId, payload) {
      var id = safe(userId, getCurrentUserId());
      return handleApi(
        axios.put(baseUrl('/user/' + encodeURIComponent(id)), payload)
      );
    }
  };

  var WishlistAPI = {
    getUserWishlist: function(userId) {
      var id = safe(userId, getCurrentUserId());
      return handleApi(
        axios.get(baseUrl('/wishlist'), { params: { userId: id } })
      );
    },

    getWishlistCount: function(userId) {
      var id = safe(userId, getCurrentUserId());
      return handleApi(
        axios.get(baseUrl('/wishlist/count'), { params: { userId: id } })
      );
    },

    add: function(userId, productId) {
      var id = safe(userId, getCurrentUserId());
      return handleApi(
        axios.post(baseUrl('/wishlist'), null, {
          params: { userId: id, productId: productId }
        })
      );
    },

    remove: function(userId, productId) {
      var id = safe(userId, getCurrentUserId());
      return handleApi(
        axios.delete(baseUrl('/wishlist'), {
          params: { userId: id, productId: productId }
        })
      );
    }
  };

  var OrderAPI = {
    // Backend sample creates a demo order; frontend does not yet send full payload
    create: function(/* orderData */) {
      return handleApi(
        axios.post(ORDER_BASE)
      );
    }
  };

  window.ProductAPI = ProductAPI;
  window.CartAPI = CartAPI;
  window.ReviewAPI = ReviewAPI;
  window.UserAPI = UserAPI;
  window.WishlistAPI = WishlistAPI;
  window.OrderAPI = OrderAPI;

})(window);

