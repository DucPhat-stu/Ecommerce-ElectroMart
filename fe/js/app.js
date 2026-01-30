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

  // --- Product image resolving (template-first, DB-independent) ---
  // Rule:
  // - Prefer a template image key coming from backend/admin (e.g. "product03.png" or "img/product03.png")
  // - Otherwise fallback to a stable template mapping by product.id (product01..product09)
  // This keeps UI independent of DB/uploaded images, while still allowing Admin to "choose" an image
  // by saving a template key in productImages[0].imageUrl.

  function isTemplateImageKey(key) {
    // Keep this strict to avoid depending on uploaded/DB images.
    // Allow: product01..product09.png only (current templates in fe/img).
    return /^product0[1-9]\.png$/i.test(String(key || '').trim());
  }

  function templateSrcFromAny(value) {
    if (!value) return null;
    var s = String(value).trim();

    // Reject remote/data URLs to avoid DB/image dependency
    if (/^(https?:)?\/\//i.test(s) || /^data:/i.test(s)) return null;

    // Accept "img/product01.png"
    var m1 = s.match(/(?:^|\/)img\/(product0[1-9]\.png)$/i);
    if (m1 && isTemplateImageKey(m1[1])) return 'img/' + m1[1];

    // Accept "/img/product01.png" (normalize to relative)
    var m2 = s.match(/(?:^|\/)img\/(product0[1-9]\.png)$/i);
    if (m2 && isTemplateImageKey(m2[1])) return 'img/' + m2[1];

    // Accept raw key "product01.png"
    if (isTemplateImageKey(s)) return 'img/' + s.toLowerCase();

    return null;
  }

  function stableTemplateById(product) {
    var idNum = Number(product && product.id);
    if (!isNaN(idNum) && idNum > 0) {
      var idx = ((idNum - 1) % 9) + 1;
      var suffix = idx < 10 ? ('0' + idx) : String(idx);
      return 'img/product' + suffix + '.png';
    }
    return '';
  }

  function productPrimaryTemplateFromProductImages(product) {
    var imgs = safeArray(product && (product.productImages || product.images));
    if (!imgs.length) return null;

    // Prefer primary=true then first
    var primary = imgs.find ? imgs.find(function(i){ return i && i.primary; }) : null;
    var candidate = primary || imgs[0];
    return templateSrcFromAny(candidate && candidate.imageUrl);
  }

  function productImageUrl(product) {
    // 1) If backend/admin stored a template key in productImages -> use it
    var fromImages = productPrimaryTemplateFromProductImages(product);
    if (fromImages) return fromImages;

    // 2) Some APIs may expose a single imageUrl field
    var fromSingle = templateSrcFromAny(product && product.imageUrl);
    if (fromSingle) return fromSingle;

    // 3) Stable fallback (works for sampledata too)
    var fallback = stableTemplateById(product);
    return fallback || 'img/product01.png';
  }

  // Expose for pages that aren't wired into app.js (e.g. compare.html inline script)
  window.__productImageUrl = productImageUrl;

  function renderStars(rating) {
    var html = '';
    for (var i = 1; i <= 5; i++) {
      html += '<i class="fa ' + (i <= rating ? 'fa-star' : 'fa-star-o') + '"></i>';
    }
    return html;
  }

  function productCard(product) {
    var price = 0;
    var basePrice = 0;
    var discountPercent = 0;
    if (product && Array.isArray(product.variants)) {
      product.variants.forEach(function(v){
        var fp = Number(v && v.finalPrice);
        var bp = Number(v && v.basePrice);
        if (isFinite(fp)) price = price === 0 ? fp : Math.min(price, fp);
        if (isFinite(bp)) basePrice = basePrice === 0 ? bp : Math.min(basePrice, bp);
        if (v && v.discountPercent) discountPercent = Math.max(discountPercent, Number(v.discountPercent));
      });
    } else if (product.finalPrice != null || product.price != null) {
      price = Number(product.finalPrice != null ? product.finalPrice : product.price);
    }
    var hasDiscount = discountPercent > 0 || (basePrice > price && price > 0);
    if (!discountPercent && hasDiscount && basePrice > 0 && price > 0) {
      discountPercent = Math.round((1 - price / basePrice) * 100);
    }
    var oldPriceHtml = hasDiscount && basePrice > 0 ? '<del class="product-old-price">' + window.formatPrice(basePrice) + '</del>' : '';
    var saleLabel = hasDiscount && discountPercent > 0 ? '<span class="sale">-' + escapeHtml(discountPercent) + '%</span>' : '';
    var variantId = (product && product.variants && product.variants[0] && product.variants[0].id) ? product.variants[0].id : product.id;
    var image = productImageUrl(product);
    var category = product.categoryName || 'Category';
    var name = escapeHtml(product.name || 'No name');
    if (!product || !product.id) return '';
    var productUrl = product && product.id ? ('product.html?id=' + encodeURIComponent(product.id)) : '#';

    var imgStyle = 'style=\"width:110px;height:90px;object-fit:contain;display:block;margin:0 auto;\"';
    return (
      '<div class="product" data-id="' + (product.id || '') + '">' +
        '<div class="product-img">' +
          '<a href="' + productUrl + '"><img ' + imgStyle + ' src="' + image + '" alt="' + name + '"></a>' +
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
          '<button class="add-to-cart-btn" data-variant-id="' + variantId + '"><i class="fa fa-shopping-cart"></i> add to cart</button>' +
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

  // Bind category CTA on home banners (Shop now)
  function bindShopNowLinks() {
    try {
      $('.shop .shop-body .cta-btn').each(function(){
        var text = normalize($(this).closest('.shop').find('h3').text());
        if (text.toLowerCase().indexOf('laptop') !== -1) $(this).attr('href', 'store.html?category=Laptops');
        else if (text.toLowerCase().indexOf('accessories') !== -1) $(this).attr('href', 'store.html?category=Accessories');
        else if (text.toLowerCase().indexOf('camera') !== -1) $(this).attr('href', 'store.html?category=Cameras');
      });
    } catch (e) { console.warn('bindShopNowLinks error', e); }
  }

  // Render 4x4 grid of products on home
  function renderIndexGrid(products) {
    try {
      var list = (products || []).slice(0, 16);
      if (!list.length) return;
      if ($('#home-grid-16').length === 0) {
        var html = '' +
          '<div id="home-grid-16" class="section">' +
          ' <div class="container">' +
          '  <div class="row">' +
          '   <div class="col-md-12"><div class="section-title"><h3 class="title">Featured</h3></div></div>' +
          '  </div>' +
          '  <div class="row" id="home-grid-16-row"></div>' +
          ' </div>' +
          '</div>';
        var $newsletter = $('#newsletter').first();
        if ($newsletter.length) $newsletter.before(html); else $('.section').last().after(html);
      }
      var $row = $('#home-grid-16-row');
      if ($row.length) {
        $row.empty();
        list.forEach(function(p){
          $row.append('<div class="col-md-3 col-xs-6">' + productCard(p) + '</div>');
        });
      }
    } catch (e) { console.warn('renderIndexGrid error', e); }
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
      // Top header: USD and My Account
      var $usd = $("#top-header .header-links.pull-right a:contains('USD')");
      if ($usd.length) { $usd.attr('href', 'checkout.html#payment'); }
      var $acct = $("#top-header .header-links.pull-right a:contains('My Account')");
      if ($acct.length) { $acct.attr('href', 'account.html'); }
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
            alert('Added to wishlist');
            updateHeaderWishlistCount();
          } else {
            alert('Unable to add to wishlist');
          }
        });
      });

      // Quick-view page: "add to wishlist" link
      $(document).off('click', '.btn-add-wishlist').on('click', '.btn-add-wishlist', function(e){
        e.preventDefault();
        var id = Number(getParam('id'));
        if (!id) return;
        var userId = window.getCurrentUserId();
        window.WishlistAPI.add(userId, id).then(function(res) {
          if (res && res.success !== false) {
            alert('Added to wishlist');
            updateHeaderWishlistCount();
          } else {
            alert('Unable to add to wishlist');
          }
        });
      });
    } catch (e) { console.warn('bindGlobalWishlist error', e); }
  }

  async function updateHeaderWishlistCount() {
    try {
      // default state (avoid template hard-code)
      var $wl0 = $('.header-ctn a[href*="wishlist"] .qty, .header-ctn a:contains("Wishlist") .qty');
      if ($wl0.length) $wl0.text('0');

      var userId = window.getCurrentUserId();
      var res = await window.WishlistAPI.getWishlistCount(userId);
      if (!res || res.success === false) {
        // If unauthenticated, keep 0 silently
        return;
      }
      var count = Number(res.data || 0);
      var $wl = $('.header-ctn a[href*="wishlist"] .qty, .header-ctn a:contains("Wishlist") .qty');
      if ($wl.length) $wl.text(count);
    } catch (e) {
      console.warn('updateHeaderWishlistCount error', e);
    }
  }

  function bindAddToCartButtons() {
    // Use delegation to work with dynamic DOM (slick, ajax render)
    $(document).off('click', '.add-to-cart-btn').on('click', '.add-to-cart-btn', async function(e) {
      // If button is inside a link, avoid navigation
      if (e && e.preventDefault) e.preventDefault();
      var variantId = Number($(this).attr('data-variant-id'));
      var productId = Number($(this).attr('data-product-id') || $(this).closest('.product').attr('data-id'));

      // Fallback: fetch first variant when variantId missing but productId available
      if (!variantId && productId) {
        try {
          var res = await window.ProductAPI.getById(productId);
          if (res && res.success !== false && res.data && res.data.variants && res.data.variants.length) {
            variantId = res.data.variants[0].id;
          }
        } catch (_) {}
      }

      if (!variantId) {
        alert('Unable to add: missing variant');
        return;
      }

      var qty = 1;
      var userId = window.getCurrentUserId();
      var resp = await window.CartAPI.addToCart(userId, variantId, qty);
      if (resp && resp.success !== false) {
        alert('Added to cart');
        updateHeaderCart();
      } else {
        if (resp && resp.status === 401) {
          alert('Please sign in to add to cart');
          window.location.href = 'account.html';
          return;
        }
        alert('Unable to add to cart: ' + (resp && resp.message ? resp.message : 'Unknown error'));
      }
    });
  }

  function normalizeCurrencyText() {
    try {
      var pattern = /\$([0-9][0-9,]*)\.(\d{2})/g;
      var $targets = $('.product-price, .product-old-price, .cart-summary, .cart-list, .order-summary, .order-total');
      $targets.each(function(){
        var html = $(this).html();
        if (!html) return;
        var next = html.replace(pattern, function(_, num){ return '$' + num; });
        if (next !== html) $(this).html(next);
      });
    } catch (e) { console.warn('normalizeCurrencyText error', e); }
  }

  // Compare (client-side) - stores a small list of product ids in localStorage
  function getCompareIds() {
    try {
      var raw = window.localStorage.getItem('compareProductIds');
      var arr = raw ? JSON.parse(raw) : [];
      if (!Array.isArray(arr)) return [];
      return arr.map(Number).filter(function(n){ return !isNaN(n) && n > 0; });
    } catch (_) { return []; }
  }

  function setCompareIds(ids) {
    try { window.localStorage.setItem('compareProductIds', JSON.stringify(ids || [])); } catch (_) {}
  }

  function bindCompareButtons() {
    $(document).off('click', '.add-to-compare').on('click', '.add-to-compare', function(e){
      e.preventDefault();
      // productCard doesn't put data-product-id on compare button → read from sibling wishlist button
      var pid = Number($(this).closest('.product').find('.add-to-wishlist').attr('data-product-id'));
      if (!pid) return;
      var ids = getCompareIds();
      var idx = ids.indexOf(pid);
      if (idx >= 0) {
        ids.splice(idx, 1);
        setCompareIds(ids);
        alert('Removed from compare');
        return;
      }
      if (ids.length >= 4) {
        alert('Compare supports up to 4 products');
        return;
      }
      ids.push(pid);
      setCompareIds(ids);
      alert('Added to compare. Open the compare page to view.');
      // Navigate to compare page for a standard ecommerce flow
      window.location.href = 'compare.html';
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
      var products = (res.data || []).filter(function(p){ return p && p.id; });
      var top = products.slice(0, 10);
      var $newSlick = $('#tab1 .products-slick').first();
      var $topSlick = $('#tab2 .products-slick').first();
      await loadProductsIntoSlick($newSlick, top);
      await loadProductsIntoSlick($topSlick, top);
      renderIndexGrid(products);
      bindShopNowLinks();
      // Add-to-cart is delegated globally; no need to rebind here
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

  // (removed duplicate loadIndexPage/bindAddToCartButtons block)

  async function loadStorePage() {
    try {
      var res = await window.ProductAPI.getAll();
      if (!res || res.success === false) return;
      var products = res.data || [];
      var q = getParam('q') || '';
      var cat = getParam('category') || '';
      var hot = getParam('hot');
      var filtered = products.filter(function(p){
        var ok = true;
        if (q) {
          var text = (p.name || '') + ' ' + (p.shortDescription || '') + ' ' + (p.description || '');
          ok = ok && containsIgnoreCase(text, q);
        }
        if (cat) {
          var c = (p.categoryName || p.category || '');
          ok = ok && containsIgnoreCase(c, cat);
        }
        if (hot) {
          ok = ok && Number(p.discountPercent || 0) > 0;
        }
        return ok;
      });
      var $grid = $('#store .row').first();
      if ($grid.length) {
        $grid.empty();
        if (!filtered.length) {
          $grid.append('<div class="col-md-12"><p>No matching products found.</p></div>');
        }
        filtered.forEach(function(p) {
          var html = '<div class="col-md-3 col-xs-6">' + productCard(p) + '</div>';
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
      // Images (template-first, DB-independent)
      // Only keep template images; otherwise fallback to stable template mapping.
      var imgs = safeArray(p.productImages)
        .map(function(img){ return templateSrcFromAny(img && img.imageUrl); })
        .filter(Boolean);
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
          alert('Added to cart');
          updateHeaderCart();
        } else {
          alert('Unable to add to cart: ' + (resp && resp.message ? resp.message : 'Unknown error'));
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
            alert('Please select a rating from 1 to 5');
            return;
          }
          if (comment.trim().length < 5) {
            alert('Review is too short');
            return;
          }
          var userId = window.getCurrentUserId();
          var resp = await window.ReviewAPI.create(productId, userId, rating, comment);
          if (resp && resp.success !== false) {
            alert('Review submitted successfully');
            await loadReviews(productId);
            $form[0].reset();
          } else {
            alert('Unable to submit review: ' + (resp && resp.message ? resp.message : 'Unknown error'));
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
      var fullItems = safeArray(cart.items || cart.cartItems || cart.products || []);
      var displayItems = fullItems.slice().reverse().slice(0, 7);
      var totalQty = 0;
      var subtotal = 0;
      fullItems.forEach(function(it){
        var qty = Number(it.quantity || 1);
        var prod = it.product || it;
        var priceNum = prod && (prod.finalPrice != null ? Number(prod.finalPrice) : Number(prod.price || 0));
        totalQty += qty;
        subtotal += priceNum * qty;
      });
      var $cartList = $('.cart-dropdown .cart-list');
      var $summary = $('.cart-dropdown .cart-summary');
      if ($cartList.length) {
        $cartList.empty();
        displayItems.forEach(function(it){
          var qty = Number(it.quantity || 1);
          var prod = it.product || it;
          var priceNum = prod && (prod.finalPrice != null ? Number(prod.finalPrice) : Number(prod.price || 0));
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
      $('.header-ctn .dropdown > a .qty').text(totalQty);
      var $viewCart = $('.cart-dropdown .cart-btns a').first();
      if ($viewCart.length) $viewCart.attr('href', 'cart.html');
      ensureHeaderLinks();
    } catch (e) {
      console.error('Update header cart failed', e);
    }
  }

  // Expose to other scripts (e.g., product-detail.js)
  window.updateHeaderCart = updateHeaderCart;

  async function loadCheckoutPage() {
    try {
      await renderOrderSummary();
      // Place order handler
      $('.order-submit').off('click').on('click', async function(e){
        e.preventDefault();
        if (!$('#terms').is(':checked')) {
          alert('You must accept the terms');
          return;
        }
        // Basic form validation
        var required = ['input[name="first-name"]','input[name="last-name"]','input[name="address"]','input[name="tel"]'];
        for (var i=0;i<required.length;i++) {
          if ($(required[i]).val().trim() === '') {
            alert('Please complete all shipping fields');
            return;
          }
        }
        // Submit order aligned with api_structure/createOrderAPI.json
        var firstName = $('input[name="first-name"]').first().val().trim();
        var lastName = $('input[name="last-name"]').first().val().trim();
        var shippingName = (firstName + ' ' + lastName).trim();
        var shippingPhone = $('input[name="tel"]').first().val().trim();
        var shippingAddress = $('input[name="address"]').first().val().trim();
        var notes = $('.order-notes textarea').val() || '';

        var orderData = {
          userId: window.getCurrentUserId(),
          shippingName: shippingName,
          shippingPhone: shippingPhone,
          shippingAddress: shippingAddress,
          notes: notes
        };
        var resp = await window.OrderAPI.create(orderData);
        if (resp && resp.success !== false) {
          // clear cart
          await window.CartAPI.clearCart(window.getCurrentUserId());
          updateHeaderCart();
          alert('Order placed successfully');
          window.location.href = 'index.html';
        } else {
          alert('Unable to place order: ' + (resp && resp.message ? resp.message : 'Unknown error'));
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
        var opts = '';
        if (prod && Array.isArray(prod.options) && prod.options.length) {
          opts = ' (' + prod.options.map(function(o){ return o.optionCode + ': ' + o.value; }).join(', ') + ')';
        }
        var row = '<tr>' +
          '<td><a href="product.html?id=' + encodeURIComponent(prod.id) + '">' + escapeHtml(prod.name || 'Product') + '</a>' + escapeHtml(opts) + '</td>' +
          '<td>' + window.formatPrice(priceNum) + '</td>' +
          '<td><input type="number" class="form-control cart-qty" min="1" value="' + qty + '" data-cart-id="' + (it.id || it.cartId || '') + '"></td>' +
          '<td>' + window.formatPrice(priceNum * qty) + '</td>' +
          '<td><button class="btn btn-sm btn-danger btn-remove" data-cart-id="' + (it.id || it.cartId || '') + '">Remove</button></td>' +
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
          alert('Update failed');
        }
      });
      $tbody.find('.btn-remove').off('click').on('click', async function(){
        var cartId = $(this).attr('data-cart-id');
        var resp = await window.CartAPI.removeFromCart(cartId);
        if (resp && resp.success !== false) {
          await loadCartPage();
          updateHeaderCart();
        } else {
          alert('Remove failed');
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
    bindShopNowLinks();
    bindGlobalWishlist();
    bindCompareButtons();
    bindAddToCartButtons();
    normalizeCurrencyText();
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
      if (typeof window.__storePageHandler === 'function') {
        window.__storePageHandler();
      } else {
        loadStorePage();
      }
    } else if (path.endsWith('/product.html')) {
      loadProductPage();
    } else if (path.endsWith('/quick-view.html')) {
      loadProductPage();
    } else if (path.endsWith('/checkout.html')) {
      loadCheckoutPage();
    } else if (path.endsWith('/cart.html')) {
      loadCartPage();
    }
  });

})(jQuery);
