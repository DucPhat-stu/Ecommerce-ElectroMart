// ElectroMart Frontend Integration Script
// This script wires the existing template to the backend APIs defined in js/api.js
// Requirements: jQuery, axios, js/api.js loaded before this file

(function($) {
  'use strict';

  function getParam(name) {
      var url = new URL(window.location.href);
      return url.searchParams.get(name);
  }

  // Helper to add/update query params on a relative URL
  function setParam(url, key, value) {
    var u = new URL(url, window.location.origin);
    u.searchParams.set(key, value);
    return u.pathname + u.search;
  }

  function safeArray(arr) {
    return Array.isArray(arr) ? arr : (arr ? Array.from(arr) : []);
  }

  function escapeHtml(text) {
    if (text == null) return '';
    return String(text)
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#039;');
  }

  function normalize(s) {
    return (s || '').toString().trim().toLowerCase();
  }

  function containsIgnoreCase(hay, needle) {
    return normalize(hay).indexOf(normalize(needle)) !== -1;
  }

  function productImageUrl(product) {
    try {
      var images = safeArray(product.productImages);
      if (images.length > 0 && images[0].imageUrl) {
        return images[0].imageUrl;
      }
    } catch(e) {}
    // fallback to sample images in template
    return 'img/product01.png';
  }

  function renderStars(rating) {
    var html = '';
    for (var i = 1; i <= 5; i++) {
      html += '<i class="fa ' + (i <= rating ? 'fa-star' : 'fa-star-o') + '"></i>';
    }
    return html;
  }

  function productCard(product) {
    var price = product.finalPrice != null ? Number(product.finalPrice) : Number(product.price || 0);
    var hasDiscount = product.discountPercent && Number(product.discountPercent) > 0;
    var oldPriceHtml = hasDiscount ? '<del class="product-old-price">' + window.formatPrice(price / (1 - (product.discountPercent/100))) + '</del>' : '';
    var saleLabel = hasDiscount ? '<span class="sale">-' + escapeHtml(product.discountPercent) + '%</span>' : '';
    var image = productImageUrl(product);
    var category = product.categoryName || 'Category';
    var name = escapeHtml(product.name || 'No name');
    var productUrl = 'product.html?id=' + encodeURIComponent(product.id);

    return (
      '<div class="product">' +
        '<div class="product-img">' +
          '<a href="' + productUrl + '"><img src="' + image + '" alt="' + name + '"></a>' +
          '<div class="product-label">' + saleLabel + '<span class="new">NEW</span></div>' +
        '</div>' +
        '<div class="product-body">' +
          '<p class="product-category">' + escapeHtml(category) + '</p>' +
          '<h3 class="product-name"><a href="' + productUrl + '">' + name + '</a></h3>' +
          '<h4 class="product-price">' + window.formatPrice(price) + ' ' + oldPriceHtml + '</h4>' +
          '<div class="product-rating"></div>' +
          '<div class="product-btns">' +
            '<button class="add-to-wishlist" data-product-id="' + product.id + '"><i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span></button>' +
            '<button class="add-to-compare"><i class="fa fa-exchange"></i><span class="tooltipp">add to compare</span></button>' +
            '<a class="quick-view" href="quick-view.html?id=' + encodeURIComponent(product.id) + '"><i class="fa fa-eye"></i><span class="tooltipp">quick view</span></a>' +
          '</div>' +
        '</div>' +
        '<div class="add-to-cart">' +
          '<button class="add-to-cart-btn" data-product-id="' + product.id + '"><i class="fa fa-shopping-cart"></i> add to cart</button>' +
        '</div>' +
      '</div>'
    );
  }

  // -------------------- Global Bindings --------------------
  function setNavbarLinks() {
    try {
      var map = {
        'home': 'index.html',
        'hot deals': 'store.html?hot=1',
        'categories': 'store.html',
        'laptops': 'store.html?category=Laptops',
        'smartphones': 'store.html?category=Smartphones',
        'cameras': 'store.html?category=Cameras',
        'accessories': 'store.html?category=Accessories'
      };
      $('.main-nav a').each(function() {
        var t = normalize($(this).text());
        if (map[t]) {
          $(this).attr('href', map[t]);
        }
      });
    } catch (e) { console.warn('setNavbarLinks error', e); }
  }

  function bindHeaderSearch() {
    try {
      $('.header-search form').off('submit').on('submit', function(e){
        e.preventDefault();
        var $form = $(this);
        var q = $form.find('input.input').val() || '';
        var $sel = $form.find('select.input-select');
        var category = '';
        if ($sel.length) {
          var v = $sel.val();
          var t = $sel.find('option:selected').text();
          if (v && v !== '0') category = t || '';
        }
        var url = 'store.html';
        if (q) url = setParam(url, 'q', q);
        if (category) url = setParam(url, 'category', category);
        window.location.href = url;
      });
    } catch (e) { console.warn('bindHeaderSearch error', e); }
  }

  function ensureHeaderLinks() {
    try {
      // View Cart -> cart.html, Checkout -> checkout.html
      var $btns = $('.cart-dropdown .cart-btns a');
      if ($btns.length >= 2) {
        $btns.eq(0).attr('href', 'cart.html');
        $btns.eq(1).attr('href', 'checkout.html');
      }
      // Header Wishlist link
      var $wishlistHeader = $(".header-ctn a:contains('Wishlist')");
      if ($wishlistHeader.length) {
        $wishlistHeader.attr('href', 'wishlist.html');
      }
    } catch (e) { console.warn('ensureHeaderLinks error', e); }
  }

  // Ensure footer links navigate to correct pages
  function setFooterLinks() {
    try {
      var map = {
        'my account': 'account.html',
        'view cart': 'cart.html',
        'wishlist': 'wishlist.html',
        'help': 'help.html',
        'about': 'about.html',
        'contact': 'contact.html',
        'privacy': 'privacy.html',
        'privacy policy': 'privacy.html',
        'terms': 'terms.html',
        'terms of service': 'terms.html',
        'hot deals': 'store.html?hot=1',
        'laptops': 'store.html?category=Laptops',
        'smartphones': 'store.html?category=Smartphones',
        'cameras': 'store.html?category=Cameras',
        'accessories': 'store.html?category=Accessories'
      };
      $('#footer .footer-links a').each(function() {
        var t = normalize($(this).text());
        if (map[t]) {
          $(this).attr('href', map[t]);
        }
      });
    } catch (e) { console.warn('setFooterLinks error', e); }
  }

  function injectFooterLegalLinks() {
    try {
      var $container = $('#bottom-footer .container .row .col-md-12.text-center');
      if ($container.length) {
        if ($container.find('.footer-legal').length === 0) {
          var html = '' +
            '<ul class="footer-legal" style="margin:0 0 10px 0; padding:0; list-style:none;">' +
            '  <li style="display:inline-block; margin:0 10px;"><a href="about.html">About</a></li>' +
            '  <li style="display:inline-block; margin:0 10px;"><a href="contact.html">Contact</a></li>' +
            '  <li style="display:inline-block; margin:0 10px;"><a href="privacy.html">Privacy</a></li>' +
            '  <li style="display:inline-block; margin:0 10px;"><a href="terms.html">Terms</a></li>' +
            '</ul>';
          $container.prepend(html);
        } else {
          // Ensure hrefs are correct if list exists
          var map = {
            'about': 'about.html',
            'contact': 'contact.html',
            'privacy': 'privacy.html',
            'terms': 'terms.html'
          };
          $container.find('.footer-legal a').each(function(){
            var t = normalize($(this).text());
            if (map[t]) $(this).attr('href', map[t]);
          });
        }
      }
    } catch (e) { console.warn('injectFooterLegalLinks error', e); }
  }

  function bindGlobalWishlist() {
    try {
      $(document).off('click', '.add-to-wishlist').on('click', '.add-to-wishlist', function(e){
        e.preventDefault();
        var id = Number($(this).attr('data-product-id'));
        if (!id) return;
        var userId = window.getCurrentUserId();
        // Toggle wishlist on backend
        window.WishlistAPI.add(userId, id).then(function(res) {
          if (res && res.success !== false) {
            alert('Đã thêm vào wishlist');
            updateHeaderWishlistCount();
          } else {
            alert('Không thể thêm vào wishlist');
          }
        });
      });
    } catch (e) { console.warn('bindGlobalWishlist error', e); }
  }

  async function updateHeaderWishlistCount() {
    try {
      var userId = window.getCurrentUserId();
      var res = await window.WishlistAPI.getWishlistCount(userId);
      if (!res || res.success === false) return;
      var count = Number(res.data || 0);
      var $wl = $('.header-ctn a:contains("Wishlist") .qty');
      if ($wl.length) $wl.text(count);
    } catch (e) {
      console.warn('updateHeaderWishlistCount error', e);
    }
  }

  function bindAddToCartButtons() {
    $('.add-to-cart-btn').off('click').on('click', async function() {
      var pid = Number($(this).attr('data-product-id'));
      if (!pid) return;
      var qty = 1;
      var userId = window.getCurrentUserId();
      var resp = await window.CartAPI.addToCart(userId, pid, qty);
      if (resp && resp.success !== false) {
        alert('Đã thêm sản phẩm vào giỏ hàng');
        updateHeaderCart();
      } else {
        alert('Không thể thêm vào giỏ hàng: ' + (resp && resp.message ? resp.message : 'Lỗi không xác định'));
      }
    });
  }

  // -------------------- Page: Index --------------------
  async function loadIndexPage() {
    try {
      var res = await window.ProductAPI.getAll();
      if (!res || res.success === false) {
        console.warn('Cannot load products:', res && res.message);
        return;
      }
      var products = res.data || [];
      var top = products.slice(0, 10);
      var $newSlick = $('#tab1 .products-slick').first();
      var $topSlick = $('#tab2 .products-slick').first();
      await loadProductsIntoSlick($newSlick, top);
      await loadProductsIntoSlick($topSlick, top);
      bindAddToCartButtons();
    } catch (e) {
      console.error(e);
    }
  }

  async function loadProductsIntoSlick($container, products) {
    try {
      if (!$container || $container.length === 0) return;
      // If slick initialized by template, unslick then re-init after injecting
      if ($container.hasClass('slick-initialized')) {
        $container.slick('unslick');
      }
      $container.empty();
      var html = products.map(productCard).join('');
      $container.html(html);
      // re-init slick like template does
      var nav = $container.attr('data-nav');
      $container.slick({
        slidesToShow: 4,
        slidesToScroll: 1,
        autoplay: true,
        infinite: true,
        speed: 300,
        dots: false,
        arrows: true,
        appendArrows: nav ? nav : false,
        responsive: [
          { breakpoint: 991, settings: { slidesToShow: 2, slidesToScroll: 1 } },
          { breakpoint: 480, settings: { slidesToShow: 1, slidesToScroll: 1 } }
        ]
      });
    } catch (e) {
      console.error('Failed to render slick products', e);
    }
  }

  async function loadIndexPage() {
    try {
      var res = await window.ProductAPI.getAll();
      if (!res || res.success === false) {
        console.warn('Cannot load products:', res && res.message);
        return;
      }
      var products = res.data || [];
      var top = products.slice(0, 10);
      var $newSlick = $('#tab1 .products-slick').first();
      var $topSlick = $('#tab2 .products-slick').first();
      await loadProductsIntoSlick($newSlick, top);
      await loadProductsIntoSlick($topSlick, top);
      bindAddToCartButtons();
        } catch (e) {
      console.error(e);
    }
  }

  function bindAddToCartButtons() {
    $('.add-to-cart-btn').off('click').on('click', async function() {
      var pid = Number($(this).attr('data-product-id'));
      if (!pid) return;
      var qty = 1;
      var userId = window.getCurrentUserId();
      var resp = await window.CartAPI.addToCart(userId, pid, qty);
      if (resp && resp.success !== false) {
        alert('Đã thêm sản phẩm vào giỏ hàng');
        updateHeaderCart();
      } else {
        alert('Không thể thêm vào giỏ hàng: ' + (resp && resp.message ? resp.message : 'Lỗi không xác định'));
      }
    });
  }

  async function loadStorePage() {
    try {
      var res = await window.ProductAPI.getAll();
      if (!res || res.success === false) return;
      var products = res.data || [];
      var $grid = $('#store .row').first();
      if ($grid.length) {
        $grid.empty();
        if (!products.length) {
          $grid.append('<div class="col-md-12"><p>Không tìm thấy sản phẩm phù hợp.</p></div>');
        }
        products.forEach(function(p) {
          var html = '<div class="col-md-4 col-xs-6">' + productCard(p) + '</div>';
          $grid.append(html);
        });
      }
      bindAddToCartButtons();
    } catch (e) {
      console.error(e);
    }
  }

  async function loadProductPage() {
    var id = Number(getParam('id'));
    if (!id) return; // Keep sample if no id
    try {
      var res = await window.ProductAPI.getById(id);
      if (!res || res.success === false) return;
      var p = res.data;
      // Title & price
      $('.product-details .product-name').text(p.name || 'Product');
      var price = p.finalPrice != null ? Number(p.finalPrice) : Number(p.price || 0);
      $('.product-details .product-price').html(window.formatPrice(price));
      $('.product-details p').first().text(p.shortDescription || '');
      // Stock
      var inStock = (p.stockQuantity || 0) > 0;
      $('.product-details .product-available').text(inStock ? 'In Stock' : 'Out of Stock');
      // Images
      var imgs = safeArray(p.productImages).map(function(img){ return img.imageUrl; }).filter(Boolean);
      if (imgs.length === 0) imgs = [productImageUrl(p)];
      var $main = $('#product-main-img');
      var $thumbs = $('#product-imgs');
      if ($main.length && $thumbs.length) {
        if ($main.hasClass('slick-initialized')) $main.slick('unslick');
        if ($thumbs.hasClass('slick-initialized')) $thumbs.slick('unslick');
        $main.empty();
        $thumbs.empty();
        imgs.forEach(function(u){
          $main.append('<div class="product-preview"><img src="' + u + '" alt=""></div>');
          $thumbs.append('<div class="product-preview"><img src="' + u + '" alt=""></div>');
        });
        // re-init sliders
        $main.slick({ infinite:true, speed:300, dots:false, arrows:true, fade:true, asNavFor:'#product-imgs' });
        $thumbs.slick({ slidesToShow:3, slidesToScroll:1, arrows:true, centerMode:true, focusOnSelect:true, centerPadding:0, vertical:true, asNavFor:'#product-main-img', responsive:[{breakpoint:991, settings:{vertical:false, arrows:false, dots:true}}] });
      }
      // Add to cart quantity control
      var qtyInput = $('.add-to-cart .input-number input[type="number"]');
      if (qtyInput.length) {
        qtyInput.attr('min', 1).val(1);
      }
      $('.add-to-cart .add-to-cart-btn').off('click').on('click', async function(){
        var qty = parseInt(qtyInput.val(), 10) || 1;
        qty = qty < 1 ? 1 : qty;
        var userId = window.getCurrentUserId();
        var resp = await window.CartAPI.addToCart(userId, p.id, qty);
        if (resp && resp.success !== false) {
          alert('Đã thêm vào giỏ hàng');
          updateHeaderCart();
        } else {
          alert('Không thể thêm vào giỏ hàng: ' + (resp && resp.message ? resp.message : 'Lỗi không xác định'));
        }
      });
      // Reviews
      await loadReviews(id);
    } catch (e) {
      console.error(e);
    }
  }

  async function loadReviews(productId) {
    try {
      var res = await window.ReviewAPI.getProductReviews(productId);
      if (!res || res.success === false) return;
      var data = res.data || {};
      var reviews = safeArray(data.reviews);
      var avg = Number(data.averageRating || 0);
      var total = Number(data.totalReviews || reviews.length);
      // rating avg
      $('#rating .rating-avg span').text(avg.toFixed(1));
      $('#rating .rating-stars').html(renderStars(Math.round(avg)));
      // list
      var $list = $('#reviews .reviews');
      if ($list.length) {
        $list.empty();
        reviews.forEach(function(r){
          var name = r.user && r.user.name ? r.user.name : ('User ' + (r.user && r.user.id ? r.user.id : ''));
          var date = r.createdAt || '';
          $list.append(
            '<li>' +
            ' <div class="review-heading">' +
            '  <h5 class="name">' + escapeHtml(name) + '</h5>' +
            '  <p class="date">' + escapeHtml(String(date)) + '</p>' +
            '  <div class="review-rating">' + renderStars(Number(r.rating || 0)) + '</div>' +
            ' </div>' +
            ' <div class="review-body"><p>' + escapeHtml(r.comment || '') + '</p></div>' +
            '</li>'
          );
        });
      }
      // review form
      var $form = $('#review-form form.review-form');
      if ($form.length) {
        $form.off('submit').on('submit', async function(e){
          e.preventDefault();
          // Get selected rating
          var rating = Number($form.find('input[name="rating"]:checked').val() || 0);
          var comment = $form.find('textarea').val() || '';
          if (!(rating >= 1 && rating <= 5)) {
            alert('Vui lòng chọn điểm đánh giá từ 1 đến 5');
            return;
          }
          if (comment.trim().length < 5) {
            alert('Nội dung đánh giá quá ngắn');
            return;
          }
          var userId = window.getCurrentUserId();
          var resp = await window.ReviewAPI.create(productId, userId, rating, comment);
          if (resp && resp.success !== false) {
            alert('Gửi đánh giá thành công');
            await loadReviews(productId);
            $form[0].reset();
          } else {
            alert('Không thể gửi đánh giá: ' + (resp && resp.message ? resp.message : 'Lỗi không xác định'));
          }
        });
      }
      // update tab title
      $(".tab-nav a[href='#tab3']").text('Reviews (' + total + ')');
    } catch (e) {
      console.error('Load reviews error', e);
    }
  }

  async function updateHeaderCart() {
    try {
      var userId = window.getCurrentUserId();
      var res = await window.CartAPI.getUserCart(userId);
      if (!res || res.success === false) return;
      var cart = res.data || {};
      var items = safeArray(cart.items || cart.cartItems || cart.products || []); // try different keys
      var totalQty = 0;
      var subtotal = 0;
      var $cartList = $('.cart-dropdown .cart-list');
      var $summary = $('.cart-dropdown .cart-summary');
      if ($cartList.length) {
        $cartList.empty();
        items.forEach(function(it){
          var qty = Number(it.quantity || 1);
          var prod = it.product || it;
          totalQty += qty;
          var priceNum = prod && (prod.finalPrice != null ? Number(prod.finalPrice) : Number(prod.price || 0));
          subtotal += priceNum * qty;
          var image = productImageUrl(prod || {});
          var name = prod && prod.name ? prod.name : 'Product';
          var id = (prod && prod.id) ? prod.id : it.productId;
          var productUrl = 'product.html?id=' + encodeURIComponent(id);
          $cartList.append(
            '<div class="product-widget">' +
            '  <div class="product-img"><a href="' + productUrl + '"><img src="' + image + '" alt=""></a></div>' +
            '  <div class="product-body">' +
            '    <h3 class="product-name"><a href="' + productUrl + '">' + escapeHtml(name) + '</a></h3>' +
            '    <h4 class="product-price"><span class="qty">' + qty + 'x</span>' + window.formatPrice(priceNum) + '</h4>' +
            '  </div>' +
            '</div>'
          );
        });
      }
      if ($summary.length) {
        $summary.find('small').remove();
        $summary.find('h5').remove();
        $summary.append('<small>' + totalQty + ' Item(s) selected</small>');
        $summary.append('<h5>SUBTOTAL: ' + window.formatPrice(subtotal) + '</h5>');
      }
      // qty bubble
      $('.header-ctn .dropdown > a .qty').text(totalQty);
      // set View Cart link to cart.html
      var $viewCart = $('.cart-dropdown .cart-btns a').first();
      if ($viewCart.length) $viewCart.attr('href', 'cart.html');
      ensureHeaderLinks();
    } catch (e) {
      console.error('Update header cart failed', e);
    }
  }

  async function loadCheckoutPage() {
    try {
      await renderOrderSummary();
      // Place order handler
      $('.order-submit').off('click').on('click', async function(e){
        e.preventDefault();
        if (!$('#terms').is(':checked')) {
          alert('Bạn cần đồng ý điều khoản');
          return;
        }
        // Basic form validation
        var required = ['input[name="first-name"]','input[name="last-name"]','input[name="address"]','input[name="tel"]'];
        for (var i=0;i<required.length;i++) {
          if ($(required[i]).val().trim() === '') {
            alert('Vui lòng nhập đầy đủ thông tin giao hàng');
            return;
          }
        }
        // Submit order (backend sample creates a demo order)
        var orderData = { note: $('.order-notes textarea').val() || '' };
        var resp = await window.OrderAPI.create(orderData);
        if (resp && resp.success !== false) {
          // clear cart
          await window.CartAPI.clearCart(window.getCurrentUserId());
          updateHeaderCart();
          alert('Đặt hàng thành công');
          window.location.href = 'index.html';
        } else {
          alert('Không thể đặt hàng: ' + (resp && resp.message ? resp.message : 'Lỗi không xác định'));
        }
      });
    } catch (e) {
      console.error(e);
    }
  }

  async function renderOrderSummary() {
    try {
      var userId = window.getCurrentUserId();
      var res = await window.CartAPI.getUserCart(userId);
      if (!res || res.success === false) return;
      var cart = res.data || {};
      var items = safeArray(cart.items || cart.cartItems || cart.products || []);
      var $list = $('.order-summary .order-products');
      var $total = $('.order-summary .order-total');
      var subtotal = 0;
      if ($list.length) {
        $list.empty();
        items.forEach(function(it){
          var qty = Number(it.quantity || 1);
          var prod = it.product || it;
          var priceNum = prod && (prod.finalPrice != null ? Number(prod.finalPrice) : Number(prod.price || 0));
          subtotal += priceNum * qty;
          $list.append('<div class="order-col"><div>' + qty + 'x ' + escapeHtml(prod && prod.name ? prod.name : 'Product') + '</div><div>' + window.formatPrice(priceNum * qty) + '</div></div>');
        });
      }
      if ($total.length) {
        $total.text(window.formatPrice(subtotal));
      }
    } catch (e) {
      console.error('Render order summary failed', e);
    }
  }

  async function loadCartPage() {
    try {
      var $tbody = $('#cart-table tbody');
      var $total = $('#cart-total');
      var res = await window.CartAPI.getUserCart(window.getCurrentUserId());
      if (!res || res.success === false) return;
      var cart = res.data || {};
      var items = safeArray(cart.items || cart.cartItems || cart.products || []);
      var subtotal = 0;
      $tbody.empty();
      items.forEach(function(it){
        var qty = Number(it.quantity || 1);
        var prod = it.product || it;
        var priceNum = prod && (prod.finalPrice != null ? Number(prod.finalPrice) : Number(prod.price || 0));
        subtotal += priceNum * qty;
        var row = '<tr>' +
          '<td><a href="product.html?id=' + encodeURIComponent(prod.id) + '">' + escapeHtml(prod.name || 'Product') + '</a></td>' +
          '<td>' + window.formatPrice(priceNum) + '</td>' +
          '<td><input type="number" class="form-control cart-qty" min="1" value="' + qty + '" data-cart-id="' + (it.id || it.cartId || '') + '"></td>' +
          '<td>' + window.formatPrice(priceNum * qty) + '</td>' +
          '<td><button class="btn btn-sm btn-danger btn-remove" data-cart-id="' + (it.id || it.cartId || '') + '">Xóa</button></td>' +
        '</tr>';
        $tbody.append(row);
      });
      $total.text(window.formatPrice(subtotal));
      // bind events
      $tbody.find('.cart-qty').off('change').on('change', async function(){
        var newQty = parseInt($(this).val(), 10) || 1;
        newQty = newQty < 1 ? 1 : newQty;
        var cartId = $(this).attr('data-cart-id');
        var resp = await window.CartAPI.updateQuantity(cartId, newQty);
        if (resp && resp.success !== false) {
          await loadCartPage();
          updateHeaderCart();
        } else {
          alert('Cập nhật thất bại');
        }
      });
      $tbody.find('.btn-remove').off('click').on('click', async function(){
        var cartId = $(this).attr('data-cart-id');
        var resp = await window.CartAPI.removeFromCart(cartId);
        if (resp && resp.success !== false) {
          await loadCartPage();
          updateHeaderCart();
        } else {
          alert('Xóa thất bại');
        }
      });
      $('#btn-clear-cart').off('click').on('click', async function(){
        await window.CartAPI.clearCart(window.getCurrentUserId());
        await loadCartPage();
        updateHeaderCart();
      });
      $('#btn-checkout').off('click').on('click', function(){
        window.location.href = 'checkout.html';
      });
    } catch (e) {
      console.error('Load cart page failed', e);
    }
  }

  function initGlobal() {
    // Normalize navigation and header behavior across all pages
    setNavbarLinks();
    setFooterLinks();
    injectFooterLegalLinks();
    bindHeaderSearch();
    ensureHeaderLinks();
    bindGlobalWishlist();
    // View cart navigation
    var $viewCart = $('.cart-dropdown .cart-btns a').first();
    if ($viewCart.length) $viewCart.attr('href', 'cart.html');
    updateHeaderCart();
    updateHeaderWishlistCount();
  }

  $(document).ready(function(){
    try { initGlobal(); } catch(e) { console.error(e); }
    var path = window.location.pathname;
    if (path.endsWith('/index.html') || path.endsWith('/') || path === '' ) {
      loadIndexPage();
    } else if (path.endsWith('/store.html')) {
      loadStorePage();
    } else if (path.endsWith('/product.html')) {
      loadProductPage();
    } else if (path.endsWith('/checkout.html')) {
      loadCheckoutPage();
    } else if (path.endsWith('/cart.html')) {
      loadCartPage();
    }
  });

})(jQuery);
