import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../models/product_model.dart';

class NutriScoreBadge extends StatelessWidget {
  final NutriScore score;
  final bool isLarge;

  const NutriScoreBadge({
    super.key,
    required this.score,
    this.isLarge = false,
  });

  Color get _color {
    switch (score) {
      case NutriScore.A: return AppColors.nutriScoreA;
      case NutriScore.B: return AppColors.nutriScoreB;
      case NutriScore.C: return AppColors.nutriScoreC;
      case NutriScore.D: return AppColors.nutriScoreD;
      case NutriScore.E: return AppColors.nutriScoreE;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isLarge ? 12 : 8,
        vertical: isLarge ? 6 : 4,
      ),
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: _color.withValues(alpha: 0.4),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'NUTRI-SCORE ',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: isLarge ? 10 : 8,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: score.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: isLarge ? 20 : 14,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
