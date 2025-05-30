import 'product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  // Calculate total price for this cart item
  double get totalPrice => product.price * quantity;

  // Convert to map for potential storage
  Map<String, dynamic> toMap() {
    return {
      'product': {
        'id': product.id,
        'title': product.title,
        'price': product.price,
        'description': product.description,
        'category': product.category,
        'image': product.image,
      },
      'quantity': quantity,
    };
  }
}
