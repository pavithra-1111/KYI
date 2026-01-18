import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_colors.dart';
import '../models/product_model.dart';

class MacroDonutChart extends StatelessWidget {
  final ProductMacros macros;

  const MacroDonutChart({super.key, required this.macros});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 60,
              sections: [
                PieChartSectionData(
                  color: AppColors.proteins,
                  value: macros.protein,
                  title: '${macros.protein}%',
                  radius: 20,
                  titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                ),
                PieChartSectionData(
                  color: AppColors.carbs,
                  value: macros.carbs,
                  title: '${macros.carbs}%',
                  radius: 20,
                  titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                ),
                PieChartSectionData(
                  color: AppColors.fats,
                  value: macros.fat,
                  title: '${macros.fat}%',
                  radius: 20,
                  titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                PieChartSectionData(
                  color: Colors.white,
                  value: macros.water,
                  title: '',
                  radius: 15,
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               Text(
                 'Water & other',
                 style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary),
               ),
               Text(
                 '${macros.water}%',
                 style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
               ),
            ],
          ),
        ],
      ),
    );
  }
}
