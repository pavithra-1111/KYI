enum NutriScore { A, B, C, D, E }

enum NovaGroup {
  group1, // Unprocessed or minimally processed
  group2, // Processed culinary ingredients
  group3, // Processed foods
  group4, // Ultra-processed foods
}

enum HealthRecommendation { good, moderate, avoid }

class ProductMacros {
  final double protein;
  final double carbs;
  final double fat;
  final double water;

  ProductMacros({
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.water,
  });
}

class Product {
  final String id;
  final String name;
  final String brand;
  final String imageUrl; 
  final NutriScore nutriScore;
  final NovaGroup novaGroup;
  final List<String> ingredients;
  final HealthRecommendation recommendation;
  final String aiExplanation;
  final ProductMacros macros;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.imageUrl,
    required this.nutriScore,
    required this.novaGroup,
    required this.ingredients,
    required this.recommendation,
    required this.aiExplanation,
    required this.macros,
  });
}
