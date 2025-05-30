import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  // Getter for cart items
  List<CartItem> get items => _items;

  // Get total items count in cart
  int get itemCount => _items.fold(0, (total, item) => total + item.quantity);

  // Get total price of all items in cart
  double get totalPrice =>
      _items.fold(0.0, (total, item) => total + item.totalPrice);

  // Check if product is already in cart
  bool isInCart(Product product) {
    return _items.any((item) => item.product.id == product.id);
  }

  // Add item to cart
  void addToCart(Product product) {
    final existingIndex = _items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex >= 0) {
      // Product already exists, increase quantity
      _items[existingIndex].quantity++;
    } else {
      // Add new product to cart
      _items.add(CartItem(product: product));
    }

    notifyListeners();
  }

  // Remove item from cart completely
  void removeFromCart(Product product) {
    _items.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  void increaseQuantity(Product product) {
    final existingIndex = _items.indexWhere(
      (item) => item.product.id == product.id,
    );
    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
      notifyListeners();
    }
  }

  // Decrease quantity of item in cart
  void decreaseQuantity(Product product) {
    final existingIndex = _items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex >= 0) {
      if (_items[existingIndex].quantity > 1) {
        _items[existingIndex].quantity--;
      } else {
        _items.removeAt(existingIndex);
      }
      notifyListeners();
    }
  }

  // Clear entire cart
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // Get quantity of specific product in cart
  int getQuantity(Product product) {
    final item = _items.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );
    return item.quantity;
  }
}
