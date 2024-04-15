import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:proximity/config/values.dart';
import 'package:proximity/l10n/app_localizations.dart';

import 'package:proximity_commercant/domain/statistic_repository/models/region_view.dart';

class RegionSalesWidget extends StatelessWidget {
  final List<RegionSale> regionSales;
  final int totalSales;

  RegionSalesWidget({required this.regionSales, required this.totalSales});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Padding(
        padding: const EdgeInsets.all(normal_100),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 4,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizations!.geographicSales,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              height: 200,
                              width: 200,
                              child: PieChart(
                                PieChartData(
                                  sections: getChartSections(),
                                  borderData: FlBorderData(show: false),
                                  centerSpaceRadius: 50,
                                  sectionsSpace: 2,
                                  /* pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) async {
                                          // Handle touch events here if needed
                                        }*/
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ]))));
  }

  List<PieChartSectionData> getChartSections() {
    if (regionSales.isEmpty || totalSales == 0) {
      // Return an empty list if the data is not available or invalid
      return [];
    }

    return List.generate(regionSales.length, (index) {
      final isTouched = index == touchedIndex;
      final double fontSize = isTouched ? 18 : 12;
      final double radius = isTouched ? 60 : 70;
      final double percentage = (regionSales[index].sales / totalSales) * 100;

      // Check for NaN or infinite values
      if (percentage.isNaN || percentage.isInfinite) {
        return PieChartSectionData(
          color: Colors.transparent, // Replace with a fallback color
          value: 0, // Set the value to 0 for invalid data
          title: '', // Display an empty title for invalid data
          radius: 0, // Set the radius to 0 for invalid data
          titleStyle: TextStyle(color: Colors.transparent),
        );
      }

      final String regionName = regionSales[index].regionName;
      final String title = '$regionName\n${percentage.toStringAsFixed(2)}%';

      return PieChartSectionData(
        color: getRandomColor(),
        value: percentage,
        title: title, // Display region name and percentage
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    });
  }

  int touchedIndex = -1;

  // Function to generate random colors for chart sections
  Color getRandomColor() {
    final random = Random();
    final int alpha = 50 +
        random.nextInt(206); // Opacity range from 50 to 255 (total opacity)
    return Color.fromARGB(
      alpha, // Alpha value for opacity
      0, // Red value set to 0 (full blue)
      0, // Green value set to 0 (full blue)
      255, // Blue value set to 255 (full blue)
    );
  }
}
