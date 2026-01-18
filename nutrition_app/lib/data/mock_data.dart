import '../models/product_model.dart';

class MockData {
  static final List<Product> products = [
    Product(
      id: '1',
      name: 'Gelatelli Sorbet, Apple',
      brand: 'Gelatelli',
      imageUrl: 'https://placehold.co/400x300/png?text=Apple+Sorbet',
      nutriScore: NutriScore.B,
      novaGroup: NovaGroup.group3,
      ingredients: ['Water', 'Apple Juice', 'Sugar', 'Glucose Syrup', 'Stabilizers'],
      recommendation: HealthRecommendation.good,
      aiExplanation: 'Light and refreshing frozen dessert with natural apple flavor. Perfect for a guilt-free treat.',
      macros: ProductMacros(protein: 0.5, carbs: 28.0, fat: 0.1, water: 70.0),
    ),
    Product(
      id: '2',
      name: 'Oats & Honey Granola',
      brand: 'NatureValley',
      imageUrl: 'https://placehold.co/400x300/png?text=Granola',
      nutriScore: NutriScore.A,
      novaGroup: NovaGroup.group1,
      ingredients: ['Whole Grain Oats', 'Honey', 'Canola Oil'],
      recommendation: HealthRecommendation.good,
      aiExplanation: 'This product is rich in whole grains and low in processed sugars. Excellent source of fiber.',
       macros: ProductMacros(protein: 12.0, carbs: 65.0, fat: 8.0, water: 5.0),
    ),
    Product(
      id: '3',
      name: 'Spicy Potato Chips',
      brand: 'CrunchyTime',
      imageUrl: 'https://placehold.co/400x300/png?text=Chips',
      nutriScore: NutriScore.D,
      novaGroup: NovaGroup.group4,
      ingredients: ['Potatoes', 'Vegetable Oil', 'Salt', 'Spices', 'MSG'],
      recommendation: HealthRecommendation.avoid,
      aiExplanation: 'Fried snack with high sodium content and ultra-processed additives.',
       macros: ProductMacros(protein: 6.0, carbs: 55.0, fat: 34.0, water: 2.0),
    ),
  ];
}
