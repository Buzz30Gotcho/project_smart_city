import 'package:flutter/material.dart';

class StarRatingStore extends StatefulWidget {
  const StarRatingStore({Key? key}) : super(key: key);

  @override
  _StarRatingStoreState createState() => _StarRatingStoreState();
}

class _StarRatingStoreState extends State<StarRatingStore> {
  int _selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (int i = 1; i <= 5; i++)
          InkWell(
            onTap: () {
              setState(() {
                _selectedRating = i;
              });
            },
            child: Icon(
              _selectedRating >= i ? Icons.star : Icons.star_border,
              size: 30,
              color: Colors.amber,
            ),
          ),
      ],
    );
  }
}
