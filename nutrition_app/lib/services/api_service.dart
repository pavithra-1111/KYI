import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  // Use 10.0.2.2 for Android Emulator, localhost for iOS Simulator/Web
  // For now, assuming iOS/macOS environment
  static const String baseUrl = 'http://localhost:8080/api/products';

  Future<List<Product>> searchProducts(String query) async {
    final url = Uri.parse('$baseUrl/search?name=$query');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error searching products: $e');
      return [];
    }
  }

  Future<Product?> getProductByBarcode(String barcode) async {
     final url = Uri.parse('$baseUrl/barcode/$barcode');
     try {
       final response = await http.get(url);
       if (response.statusCode == 200) {
         return Product.fromJson(json.decode(response.body));
       } else {
         return null;
       }
     } catch (e) {
       print('Error getting product: $e');
       return null;
     }
  }
}
