package com.store.electro.Services;

import com.store.electro.Models.DTOs.Request.CartRequest;
import com.store.electro.Models.DTOs.Response.CartResponse;
import com.store.electro.Models.Entity.Cart;

public interface ICartService {

    CartResponse getUserCart(Long userId);

    Cart addToCart(CartRequest request);

    Cart updateCartItem(Long cartId, Integer quantity);

    void removeFromCart(Long cartId);

    void clearUserCart(Long userId);

}