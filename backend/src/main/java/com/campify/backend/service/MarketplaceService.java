package com.campify.backend.service;

import com.campify.backend.exception.ResourceNotFoundException;
import com.campify.backend.model.CartItem;
import com.campify.backend.model.MarketplaceItem;
import com.campify.backend.model.Order;
import com.campify.backend.repository.CartRepository;
import com.campify.backend.repository.MarketplaceRepository;
import com.campify.backend.repository.OrderRepository;
import com.campify.backend.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class MarketplaceService {

    private final MarketplaceRepository marketplaceRepository;
    private final CartRepository cartRepository;
    private final OrderRepository orderRepository;
    private final UserRepository userRepository;

    public List<MarketplaceItem> getAllItems(Long centerId, MarketplaceItem.ItemCategory category, String search) {
        List<MarketplaceItem> items;
        if (centerId != null && category != null) {
            items = marketplaceRepository.findByCenterIdAndCategory(centerId, category);
        } else if (centerId != null) {
            items = marketplaceRepository.findByCenterId(centerId);
        } else if (category != null) {
            items = marketplaceRepository.findByCategory(category);
        } else {
            items = marketplaceRepository.findAll();
        }

        // Apply search filter if provided
        if (search != null && !search.isEmpty()) {
            items = items.stream()
                    .filter(item -> item.getName().toLowerCase().contains(search.toLowerCase()) ||
                            (item.getDescription() != null &&
                                    item.getDescription().toLowerCase().contains(search.toLowerCase())))
                    .toList();
        }
        return items;
    }

    public MarketplaceItem getItemById(Long id) {
        return marketplaceRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Marketplace item not found"));
    }

    public List<CartItem> getCartForUser(String email) {
        Long userId = getUserIdFromEmail(email);
        return cartRepository.findByUserId(userId);
    }

    @Transactional
    public List<CartItem> addToCart(String email, Long itemId, int quantity) {
        Long userId = getUserIdFromEmail(email);

        // Verify item exists
        MarketplaceItem item = getItemById(itemId);

        // Check if item already in cart
        var existingCart = cartRepository.findByUserIdAndItemId(userId, itemId);
        if (existingCart.isPresent()) {
            CartItem cartItem = existingCart.get();
            cartItem.setQuantity(cartItem.getQuantity() + quantity);
            cartRepository.save(cartItem);
        } else {
            CartItem newCartItem = CartItem.builder()
                    .userId(userId)
                    .itemId(itemId)
                    .quantity(quantity)
                    .build();
            cartRepository.save(newCartItem);
        }

        return cartRepository.findByUserId(userId);
    }

    @Transactional
    public List<CartItem> updateCartItem(String email, Long itemId, int quantity) {
        Long userId = getUserIdFromEmail(email);

        CartItem cartItem = cartRepository.findByUserIdAndItemId(userId, itemId)
                .orElseThrow(() -> new ResourceNotFoundException("Cart item not found"));

        if (quantity <= 0) {
            cartRepository.delete(cartItem);
        } else {
            cartItem.setQuantity(quantity);
            cartRepository.save(cartItem);
        }

        return cartRepository.findByUserId(userId);
    }

    @Transactional
    public List<CartItem> removeFromCart(String email, Long itemId) {
        Long userId = getUserIdFromEmail(email);

        CartItem cartItem = cartRepository.findByUserIdAndItemId(userId, itemId)
                .orElseThrow(() -> new ResourceNotFoundException("Cart item not found"));

        cartRepository.delete(cartItem);
        return cartRepository.findByUserId(userId);
    }

    @Transactional
    public void clearCart(String email) {
        Long userId = getUserIdFromEmail(email);
        cartRepository.deleteByUserId(userId);
    }

    @Transactional
    public Order checkout(String email, Long reservationId) {
        Long userId = getUserIdFromEmail(email);
        List<CartItem> cartItems = cartRepository.findByUserId(userId);

        if (cartItems.isEmpty()) {
            throw new RuntimeException("Cart is empty");
        }

        // Calculate total and create order items
        double totalAmount = 0.0;
        List<Order.OrderItem> orderItems = new ArrayList<>();

        for (CartItem cartItem : cartItems) {
            MarketplaceItem item = getItemById(cartItem.getItemId());
            double itemTotal = item.getPrice() * cartItem.getQuantity();
            totalAmount += itemTotal;

            orderItems.add(new Order.OrderItem(
                    item.getId(),
                    item.getName(),
                    cartItem.getQuantity(),
                    item.getPrice()));
        }

        // Create order
        Order order = Order.builder()
                .userId(userId)
                .items(orderItems)
                .totalAmount(totalAmount)
                .status(Order.OrderStatus.PENDING)
                .reservationId(reservationId)
                .build();

        order = orderRepository.save(order);

        // Clear cart after successful order
        cartRepository.deleteByUserId(userId);

        return order;
    }

    public List<Order> getUserOrders(String email) {
        Long userId = getUserIdFromEmail(email);
        return orderRepository.findByUserId(userId);
    }

    private Long getUserIdFromEmail(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"))
                .getId();
    }

    // Owner product management methods
    @Transactional
    public MarketplaceItem createItem(MarketplaceItem item, String email) {
        Long userId = getUserIdFromEmail(email);
        item.setOwnerId(userId);
        return marketplaceRepository.save(item);
    }

    @Transactional
    public MarketplaceItem updateItem(Long id, MarketplaceItem item, String email) {
        Long userId = getUserIdFromEmail(email);
        MarketplaceItem existingItem = marketplaceRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Marketplace item not found"));

        // Verify ownership
        if (!existingItem.getOwnerId().equals(userId)) {
            throw new RuntimeException("You can only update your own items");
        }

        existingItem.setName(item.getName());
        existingItem.setDescription(item.getDescription());
        existingItem.setPrice(item.getPrice());
        existingItem.setCategory(item.getCategory());
        existingItem.setStock(item.getStock());
        existingItem.setImageUrls(item.getImageUrls());

        return marketplaceRepository.save(existingItem);
    }

    @Transactional
    public void deleteItem(Long id, String email) {
        Long userId = getUserIdFromEmail(email);
        MarketplaceItem existingItem = marketplaceRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Marketplace item not found"));

        // Verify ownership
        if (!existingItem.getOwnerId().equals(userId)) {
            throw new RuntimeException("You can only delete your own items");
        }

        marketplaceRepository.delete(existingItem);
    }

    public List<MarketplaceItem> getOwnedItems(String email) {
        Long userId = getUserIdFromEmail(email);
        return marketplaceRepository.findByOwnerId(userId);
    }
}
