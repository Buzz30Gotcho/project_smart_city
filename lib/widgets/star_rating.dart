import 'package:flutter/material.dart';
import 'package:proximity/config/config.dart';
import 'package:proximity/icons/proximity_icons.dart';

class StarRating extends StatelessWidget {
  const StarRating({Key? key, required this.rating}) : super(key: key);

  final double rating;

  List<Widget> _starList(double _rating) {
    List<Widget> _list = [];
    for (int i = 0; i < _rating - 1; i++) {
      _list.add(Icon(ProximityIcons.star_filled,
          size: normal_125, color: yellowSwatch.shade600));
    }
    for (int i = _rating.toInt(); i < 5; i++) {
      _list.add(Icon(ProximityIcons.star,
          size: normal_125, color: yellowSwatch.shade600));
    }
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: _starList(rating));
  }
}
