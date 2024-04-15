import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';

class AdderEditText extends StatelessWidget {
  const AdderEditText(
      {Key? key, required this.hintText, this.onChanged, this.onPressed})
      : super(key: key);

  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: large_150,
        margin: const EdgeInsets.symmetric(horizontal: normal_100)
            .copyWith(bottom: normal_100),
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
              child: EditText(
                  borderType: BorderType.singleLeft,
                  hintText: hintText,
                  maxLines: 1,
                  onChanged: onChanged)),
          SizedBox(
              width: large_175 - small_50,
              child: ElevatedButton(
                  onPressed: onPressed,
                  child: const Icon(ProximityIcons.add,
                      color: primaryTextDarkColor),
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.horizontal(right: normalRadius)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: small_100))))
        ]));
  }
}
