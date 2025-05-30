import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String url =
      'https://fakestoreapi.com/products'; // Cập nhật URL thực tế ở đây

  static Future<List<Product>> fetchProducts() async {
    Uri uri = Uri.parse(url);

    if (uri.host.isEmpty) {
      throw Exception("Host không được để trống!");
    }

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      return jsonData.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
