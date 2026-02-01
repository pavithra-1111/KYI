import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/app_provider.dart';
import '../widgets/product_card.dart';
import '../core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello Guest!',
              style: GoogleFonts.outfit(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              'Track your nutrition',
              style: GoogleFonts.inter(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
            ),
            child: IconButton(
              icon: const Icon(Icons.person_outline, color: AppColors.textPrimary),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  hintStyle: GoogleFonts.inter(color: Colors.grey),
                  border: InputBorder.none,
                  icon: const Icon(Icons.search, color: AppColors.textSecondary),
                ),
                onSubmitted: (query) async {
                  if (query.isNotEmpty) {
                    // Show Loading
                    showDialog(
                      context: context, 
                      barrierDismissible: false, 
                      builder: (ctx) => const Center(child: CircularProgressIndicator())
                    );

                    final provider = context.read<AppProvider>();
                    await provider.searchProducts(query);
                    
                    if (!context.mounted) return;
                    Navigator.pop(context); // Hide Loading

                    if (provider.products.length == 1) {
                      context.push('/product/${provider.products.first.id}');
                    } else if (provider.products.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No products found')),
                      );
                    } else {
                      context.push('/search-results?query=$query');
                    }
                  }
                },
              ),
            ),
            const SizedBox(height: 24),

            // Actions Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: [
                _buildActionCard(
                  context, 
                  'Barcode Scan', 
                  Icons.qr_code_scanner, 
                  AppColors.primary,
                  () => _showBarcodeDialog(context),
                ),
                _buildActionCard(
                  context, 
                  'Identify Product', 
                  Icons.camera_alt_outlined, 
                  Colors.white,
                  () {}, // Mock Camera
                ),
                _buildActionCard(
                  context, 
                  'Upload Bill', 
                  Icons.receipt_long_outlined, 
                  Colors.white,
                  () {}, // Mock Bill
                ),
                _buildActionCard(
                  context, 
                  'Intake Analysis', 
                  Icons.pie_chart_outline, 
                  Colors.white,
                  () {}, // Mock Analysis
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Recent Products Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Scans',
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('See All'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Product List
            Consumer<AppProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: CircularProgressIndicator(),
                  ));
                }
                if (provider.products.isEmpty) {
                  return const Center(child: Text("No products yet"));
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.products.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final product = provider.products[index];
                    return ProductCard(product: product);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    final isPrimary = color == AppColors.primary;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isPrimary ? Colors.white.withValues(alpha: 0.3) : AppColors.background,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon, 
                size: 24, 
                color: isPrimary ? Colors.white : AppColors.textPrimary
              ),
            ),
            Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isPrimary ? Colors.white : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBarcodeDialog(BuildContext context) {
    final TextEditingController barcodeController = TextEditingController(text: '3017620422003'); // Pre-filled for testing
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Enter Barcode', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        content: TextField(
          controller: barcodeController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: 'E.g. 3017620422003',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final barcode = barcodeController.text.trim();
              if (barcode.isNotEmpty) {
                 Navigator.pop(ctx); // Close Input Dialog logic

                 // Show Loading
                 showDialog(
                   context: context, 
                   barrierDismissible: false, 
                   builder: (context) => const Center(child: CircularProgressIndicator())
                 );

                 final provider = context.read<AppProvider>();
                 await provider.scanProduct(barcode);

                 if (!context.mounted) return;
                 Navigator.pop(context); // Hide Loading

                 if (provider.products.length == 1) {
                   context.push('/product/${provider.products.first.id}');
                 } else if (provider.products.isNotEmpty) {
                    context.push('/search-results?query=$barcode');
                 } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Product not found')),
                    );
                 }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Scan'),
          ),
        ],
      ),
    );
  }

  // Helper method if needed, but we used inline showDialog above.
  // Actually, let's update _showBarcodeDialog to use the loading indicator too.
  // ... Wait, I can't easily edit _showBarcodeDialog in this single chunk comfortably without replacing too much.
  // I'll leave the instruction to just do the search part first? No, user wants it for "dashboard".
  // I will replace the logic inside _showBarcodeDialog in a separate chunk or this one if I map carefully.
  // Let's replace the ElevatedButton logic in _showBarcodeDialog.
}
