import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_item.dart';
import '../providers/cart_providers.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Product image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                cartItem.product.image,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),

            // Product info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${cartItem.product.price.toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tổng: \$${cartItem.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Quantity controls
            Column(
              children: [
                // Quantity display and controls
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Decrease button
                      InkWell(
                        onTap: () {
                          context.read<CartProvider>().decreaseQuantity(
                            cartItem.product,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          child: const Icon(
                            Icons.remove,
                            size: 16,
                            color: Colors.pink,
                          ),
                        ),
                      ),

                      // Quantity text
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        child: Text(
                          '${cartItem.quantity}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),

                      // Increase button
                      InkWell(
                        onTap: () {
                          context.read<CartProvider>().addToCart(
                            cartItem.product,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          child: const Icon(
                            Icons.add,
                            size: 16,
                            color: Colors.pink,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // Remove button
                InkWell(
                  onTap: () {
                    context.read<CartProvider>().removeFromCart(
                      cartItem.product,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Đã xóa ${cartItem.product.title} khỏi giỏ hàng',
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.delete_outline,
                      size: 16,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
