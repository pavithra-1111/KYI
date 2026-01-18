import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/app_provider.dart';
import '../models/product_model.dart';
import '../data/mock_data.dart';
import '../core/theme/app_colors.dart';
import '../widgets/macro_donut_chart.dart';
// import '../widgets/nutri_score_badge.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;
  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _selectedIndex = 0; // 0: Analysis, 1: Ingredients

  @override
  Widget build(BuildContext context) {
    // Find product
    final product = context.read<AppProvider>().products.firstWhere(
      (p) => p.id == widget.productId,
      orElse: () => MockData.products.first,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Custom Header Area
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Curved Green Background
                Container(
                  height: 280,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryContainer,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                ),
                
                // AppBar Icons
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: BackButton(onPressed: () => context.pop()),
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.share_outlined, color: AppColors.textPrimary, size: 20),
                            ),
                            const SizedBox(width: 12),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.bookmark_border, color: AppColors.textPrimary, size: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Product Image
                Positioned(
                  top: 80,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Hero(
                      tag: product.id,
                      child: Container(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(product.imageUrl),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            
            // Product Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                product.name,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            
            const SizedBox(height: 24),

            // Analysis / Ingredients Toggle
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Expanded(child: _buildTabButton('Analysis', 0)),
                  Expanded(child: _buildTabButton('Ingredients', 1)),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Content Areas
            if (_selectedIndex == 0) _buildAnalysisView(product)
            else _buildIngredientsView(product),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: isSelected ? AppColors.textOnPrimary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildAnalysisView(Product product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Donut Chart
          MacroDonutChart(macros: product.macros),
          
          const SizedBox(height: 24),
          
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem(AppColors.proteins, 'Proteins'),
              const SizedBox(width: 16),
              _buildLegendItem(AppColors.carbs, 'Carbohydrates'),
              const SizedBox(width: 16),
              _buildLegendItem(AppColors.fats, 'Fats'),
              const SizedBox(width: 16),
              _buildLegendItem(Colors.grey, 'Water', isHollow: true),
            ],
          ),

          const SizedBox(height: 32),

          // Get Pro Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Analysis',
                  style: GoogleFonts.outfit(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product.aiExplanation,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.star, size: 16),
                    label: Text('Get Pro'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.textOnPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientsView(Product product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
             'Full Breakdown',
             style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold),
           ),
           const SizedBox(height: 16),
           Wrap(
             spacing: 8,
             runSpacing: 8,
             children: product.ingredients.map((ing) => Chip(
               label: Text(ing),
               backgroundColor: Colors.white,
               side: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
             )).toList(),
           ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label, {bool isHollow = false}) {
    return Row(
      children: [
        Container(
          width: 8, height: 8,
          decoration: BoxDecoration(
            color: isHollow ? Colors.transparent : color,
            border: isHollow ? Border.all(color: Colors.grey) : null,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 10, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
