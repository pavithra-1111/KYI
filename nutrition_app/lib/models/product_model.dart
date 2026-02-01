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

  factory Product.fromJson(Map<String, dynamic> json) {
    // Helper to extract nested value from product_name struct if present
    // Backend should already do this, but just in case.
    // Assuming backend returns flat JSON as per current View.

    return Product(
      id: json['barcode'] ?? json['code'] ?? '',
      name: json['name'] ?? 'Unknown Product',
      brand: json['brand'] ?? 'Unknown Brand',
      imageUrl: json['imageUrl'] ?? json['image_url'] ?? '',
      nutriScore: _parseNutriScore(json['nutriScore'] ?? json['nutri_score']),
      novaGroup: _parseNovaGroup(json['novaGroup'] ?? json['nova_group']),
      ingredients: _parseIngredients(json['ingredients']),
      recommendation: HealthRecommendation.moderate, // Default, logic to be refined or fetched
      aiExplanation: 'Analysis not available', // Default
      macros: ProductMacros(
        protein: (json['protein'] as num?)?.toDouble() ?? 0.0,
        carbs: (json['carbs'] as num?)?.toDouble() ?? 0.0,
        fat: (json['fat'] as num?)?.toDouble() ?? 0.0,
        water: 0.0, // Not provided by backend yet
      ),
    );
  }

  static NutriScore _parseNutriScore(dynamic value) {
    if (value == null) return NutriScore.E;
    String score = value.toString().toUpperCase();
    switch (score) {
      case 'A': return NutriScore.A;
      case 'B': return NutriScore.B;
      case 'C': return NutriScore.C;
      case 'D': return NutriScore.D;
      case 'E': return NutriScore.E;
      default: return NutriScore.E;
    }
  }

  static NovaGroup _parseNovaGroup(dynamic value) {
    if (value == null) return NovaGroup.group4;
    int? group;
    if (value is int) group = value;
    if (value is String) group = int.tryParse(value);

    switch (group) {
      case 1: return NovaGroup.group1;
      case 2: return NovaGroup.group2;
      case 3: return NovaGroup.group3;
      case 4: return NovaGroup.group4;
      default: return NovaGroup.group4;
    }
  }

  static List<String> _parseIngredients(dynamic value) {
    if (value == null) return [];
    if (value is List) return value.map((e) => e.toString()).toList();
    if (value is String) {
      if (value.startsWith('[') && value.endsWith(']')) {
        // Handle Java-style toString() of a list of maps: [{text=..., lang=...}, ...]
        final List<String> result = [];
        final regExp = RegExp(r'\{([^}]+)\}');
        final matches = regExp.allMatches(value);
        for (final match in matches) {
          final content = match.group(1);
          if (content != null) {
            // Find text= part. It might end with a comma or the end of the string
            final textMatch = RegExp(r'text=([^,]+)').firstMatch(content);
            if (textMatch != null) {
              final text = textMatch.group(1)?.trim();
              if (text != null && text.isNotEmpty && !result.contains(text)) {
                result.add(text);
              }
            }
          }
        }
        if (result.isNotEmpty) return result;
      }
      return value.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    }
    return [];
  }
}
