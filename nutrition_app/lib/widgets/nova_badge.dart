import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../models/product_model.dart';
import 'package:google_fonts/google_fonts.dart';

class NovaBadge extends StatelessWidget {
  final NovaGroup group;
  final bool isLarge;

  const NovaBadge({
    super.key,
    required this.group,
    this.isLarge = false,
  });

  Color get _color {
    switch (group) {
      case NovaGroup.group1: return AppColors.novaGroup1;
      case NovaGroup.group2: return AppColors.novaGroup2;
      case NovaGroup.group3: return AppColors.novaGroup3;
      case NovaGroup.group4: return AppColors.novaGroup4;
    }
  }

  String get _text {
    switch (group) {
      case NovaGroup.group1: return '1';
      case NovaGroup.group2: return '2';
      case NovaGroup.group3: return '3';
      case NovaGroup.group4: return '4';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isLarge ? 10 : 6),
      decoration: BoxDecoration(
        color: _color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: _color.withValues(alpha: 0.4),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'NOVA',
            style: GoogleFonts.inter(
              fontSize: isLarge ? 8 : 6,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            _text,
            style: GoogleFonts.outfit(
              fontSize: isLarge ? 18 : 12,
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
