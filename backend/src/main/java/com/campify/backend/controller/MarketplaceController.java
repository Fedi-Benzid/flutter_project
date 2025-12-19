package com.campify.backend.controller;

import com.campify.backend.model.CartItem;
import com.campify.backend.model.MarketplaceItem;
import com.campify.backend.model.Order;
import com.campify.backend.payload.ApiResponse;
import com.campify.backend.service.MarketplaceService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/marketplace")
@RequiredArgsConstructor
public class MarketplaceController {

    private final MarketplaceService marketplaceService;

    @GetMapping("/items")
    public ResponseEntity<ApiResponse<List<MarketplaceItem>>> getAllItems(
            @RequestParam(required = false) Long centerId,
            @RequestParam(required = false) MarketplaceItem.ItemCategory category) {
        List<MarketplaceItem> items = marketplaceService.getAllItems(centerId, category);
        return ResponseEntity.ok(new ApiResponse<>(true, "Items fetched successfully", items));
    }

    @GetMapping("/items/{id}")
    public ResponseEntity<ApiResponse<MarketplaceItem>> getItemById(@PathVariable Long id) {
        MarketplaceItem item = marketplaceService.getItemById(id);
        return ResponseEntity.ok(new ApiResponse<>(true, "Item fetched successfully", item));
    }

    @GetMapping("/cart")
    public ResponseEntity<ApiResponse<List<CartItem>>> getCart() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        List<CartItem> cart = marketplaceService.getCartForUser(auth.getName());
        return ResponseEntity.ok(new ApiResponse<>(true, "Cart fetched successfully", cart));
    }

    @PostMapping("/cart")
    public ResponseEntity<ApiResponse<List<CartItem>>> addToCart(@Valid @RequestBody AddToCartRequest request) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        List<CartItem> cart = marketplaceService.addToCart(auth.getName(), request.getItemId(),
                request.getQuantity());
        return ResponseEntity.ok(new ApiResponse<>(true, "Item added to cart", cart));
    }

    @PutMapping("/cart/{itemId}")
    public ResponseEntity<ApiResponse<List<CartItem>>> updateCartItem(
            @PathVariable Long itemId,
            @Valid @RequestBody UpdateCartRequest request) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        List<CartItem> cart = marketplaceService.updateCartItem(auth.getName(), itemId, request.getQuantity());
        return ResponseEntity.ok(new ApiResponse<>(true, "Cart updated successfully", cart));
    }

    @DeleteMapping("/cart/{itemId}")
    public ResponseEntity<ApiResponse<List<CartItem>>> removeFromCart(@PathVariable Long itemId) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        List<CartItem> cart = marketplaceService.removeFromCart(auth.getName(), itemId);
        return ResponseEntity.ok(new ApiResponse<>(true, "Item removed from cart", cart));
    }

    @DeleteMapping("/cart")
    public ResponseEntity<ApiResponse<Void>> clearCart() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        marketplaceService.clearCart(auth.getName());
        return ResponseEntity.ok(new ApiResponse<>(true, "Cart cleared successfully", null));
    }

    @PostMapping("/checkout")
    public ResponseEntity<ApiResponse<Order>> checkout(@Valid @RequestBody CheckoutRequest request) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Order order = marketplaceService.checkout(auth.getName(), request.getReservationId());
        return new ResponseEntity<>(new ApiResponse<>(true, "Order created successfully", order),
                HttpStatus.CREATED);
    }

    @GetMapping("/orders")
    public ResponseEntity<ApiResponse<List<Order>>> getMyOrders() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        List<Order> orders = marketplaceService.getUserOrders(auth.getName());
        return ResponseEntity.ok(new ApiResponse<>(true, "Orders fetched successfully", orders));
    }

    @Data
    public static class AddToCartRequest {
        @NotNull
        private Long itemId;
        @Min(1)
        private int quantity = 1;
    }

    @Data
    public static class UpdateCartRequest {
        @Min(0)
        private int quantity;
    }

    @Data
    public static class CheckoutRequest {
        private Long reservationId; // Optional
    }
}
