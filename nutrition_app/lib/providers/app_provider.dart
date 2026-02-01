import 'package:flutter/foundation.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

class AppProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  final ApiService _apiService = ApiService();

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  AppProvider() {
    // Initialize empty or fetch default
    _products = [];
  }

  Future<void> searchProducts(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _apiService.searchProducts(query);
    } catch (e) {
      print('Search error: $e');
      _products = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // Helper for scanning
  Future<void> scanProduct(String barcode) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final product = await _apiService.getProductByBarcode(barcode);
      if (product != null) {
        // Add to list if not present, or replace
        // For MVP, just putting it at the top
        _products = [product, ..._products]; 
      }
    } catch (e) {
       print('Scan error: $e');
    }
    
    _isLoading = false;
    notifyListeners();
  }
}
