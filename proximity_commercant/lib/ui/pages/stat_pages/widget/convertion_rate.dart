import 'package:flutter/material.dart';

class ConversionRateWidget extends StatelessWidget {
  final double conversionRate;

  ConversionRateWidget({required this.conversionRate});

  @override
  Widget build(BuildContext context) {
    String formattedConversionRate = (conversionRate * 100).toStringAsFixed(2);
    double completedConversions =
        (conversionRate * 100); // Assuming 1000 total conversions
    double remainingConversions = 100 - completedConversions;

    Color progressColor =
        Colors.green; // Customize the color for the progress bar
    Color remainingColor = Colors
        .grey; // Customize the color for the remaining part of the progress bar

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: LinearProgressIndicator(
            value: conversionRate,
            backgroundColor: remainingColor,
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Conversion Rate: $formattedConversionRate%',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
