import 'package:flutter/foundation.dart';
import '../models/product_model.dart';
import '../data/mock_data.dart';

class AppProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  AppProvider() {
    // Initialize with mock data
    _products = MockData.products;
  }

  // Simulate scanning a product (picking a random one from mock data)
  Future<void> scanProduct() async {
    _isLoading = true;
    notifyListeners();
    
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    
    // For MVP demo, just shuffle or duplicate
    _products = [..._products, _products.first];
    
    _isLoading = false;
    notifyListeners();
  }
}
