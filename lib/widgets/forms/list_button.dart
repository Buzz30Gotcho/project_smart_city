import 'package:flutter/material.dart';
import 'package:proximity/config/config.dart';
import 'package:proximity/icons/proximity_icons.dart';

class ListButton extends StatelessWidget {
  const ListButton(
      {Key? key, required this.title, this.leadIcon, this.leadImage, this.color, this.onPressed, this.enabled = true})
      : super(key: key);

  final String title;
  final IconData? leadIcon;
  final String? leadImage;
  final Color? color;
  final VoidCallback? onPressed;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled!? onPressed : null,
      child: Row(children: [
        if (leadIcon != null) Padding(
            padding: const EdgeInsets.all(small_100),
            child: Icon(leadIcon,
                color: ((onPressed == null) || !enabled!)
                    ? Theme.of(context).disabledColor
                    : color))
        else if (leadImage != null) Padding(
            padding: const EdgeInsets.all(small_100),
            child: Image.asset(leadImage!))
        else
          const SizedBox(width: small_100),
        Expanded(
            child: Container(
                padding: const EdgeInsets.all(small_100).copyWith(left: 0),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Theme.of(context).dividerColor,
                            width: tiny_50))),
                child: Row(children: [
                  Expanded(
                      child: Text(title,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                              color: ((onPressed == null) || !enabled!)
                                  ? Theme.of(context).disabledColor
                                  : null))),
                  Icon(ProximityIcons.chevron_right,
                      color: ((onPressed == null) || !enabled!)
                          ? Theme.of(context).disabledColor
                          : null)
                ])))
      ]),
    );
  }
}
