import 'package:flutter/material.dart';
import 'package:proximity/config/values.dart';

class ColoredCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color cardColor;

  ColoredCard(
      {required this.title, required this.subTitle, required this.cardColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(normal_100).copyWith(right: 0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 3),
              Text(
                subTitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
