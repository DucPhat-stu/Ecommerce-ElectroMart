package com.store.electro.Services;

import com.store.electro.Models.DTO.CartRequest;
import com.store.electro.Models.DTO.CartResponse;
import com.store.electro.Models.Entity.Cart;

public interface ICartService {

    CartResponse getUserCart(Long userId);

    Cart addToCart(CartRequest request);

    Cart updateCartItem(Long cartId, Integer quantity);

    void removeFromCart(Long cartId);

    void clearUserCart(Long userId);

}