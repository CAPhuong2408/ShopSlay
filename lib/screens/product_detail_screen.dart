import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_providers.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: Colors.pink.shade50,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.pink),
        titleTextStyle: const TextStyle(
          color: Colors.pink,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh sản phẩm với container đẹp
            Center(
              child: Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    product.image,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Tên sản phẩm
            Text(
              product.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),

            // Category chip
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                product.category.toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink.shade700,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Giá sản phẩm
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 28,
                color: Colors.pink,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // Mô tả sản phẩm
            const Text(
              "📝 Mô tả sản phẩm:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Text(
                product.description,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),

      // Bottom bar với nút thêm vào giỏ
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Consumer<CartProvider>(
          builder: (context, cart, child) {
            final isInCart = cart.isInCart(product);

            return Row(
              children: [
                // Hiển thị quantity nếu đã có trong giỏ
                if (isInCart) ...[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.pink),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => cart.decreaseQuantity(product),
                          icon: const Icon(Icons.remove, color: Colors.pink),
                        ),
                        Text(
                          '${cart.items.firstWhere((item) => item.product.id == product.id).quantity}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                        ),
                        IconButton(
                          onPressed: () => cart.addToCart(product),
                          icon: const Icon(Icons.add, color: Colors.pink),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                ],

                // Nút thêm vào giỏ / xem giỏ hàng
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (!isInCart) {
                        cart.addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '✅ Đã thêm "${product.title}" vào giỏ!',
                            ),
                            backgroundColor: Colors.green,
                            duration: const Duration(seconds: 2),
                            action: SnackBarAction(
                              label: 'Xem giỏ',
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.pop(context); // Quay về trang chủ
                                // Có thể navigate tới cart screen ở đây
                              },
                            ),
                          ),
                        );
                      } else {
                        // Nếu đã có trong giỏ, thêm thêm 1 cái nữa
                        cart.addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('➕ Đã tăng số lượng trong giỏ!'),
                            backgroundColor: Colors.blue,
                            duration: Duration(seconds: 1),
                          ),
                        );
                      }
                    },
                    icon: Icon(
                      isInCart
                          ? Icons.add_shopping_cart
                          : Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                    label: Text(
                      isInCart ? 'Thêm nữa' : 'Thêm vào giỏ',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 5,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
