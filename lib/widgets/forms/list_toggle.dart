import 'package:flutter/material.dart';
import 'package:proximity/config/config.dart';
import 'package:proximity/icons/proximity_icons.dart';
/*
class ListToggle extends StatefulWidget {
  const ListToggle({
    Key? key,
    required this.value,
    this.onToggle,
    this.toggleId,
    this.importantMessage,
    this.onToggleId,
    required this.title,
    this.leadIcon,
  }) : super(key: key);

  final String title;
  final IconData? leadIcon;
  final bool value;
  final ValueChanged<bool>? onToggle;
  final String? toggleId;
  final String? importantMessage;
  final ValueChanged<List<dynamic>>? onToggleId;

  @override
  State<ListToggle> createState() => _ListToggleState();
}

class _ListToggleState extends State<ListToggle> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.leadIcon != null)
          Padding(
              padding: const EdgeInsets.all(small_100),
              child: Icon(widget.leadIcon))
        else
          const SizedBox(width: small_100),
        Expanded(
            child: Container(
                padding: const EdgeInsets.all(small_100).copyWith(left: 0),
                decoration: BoxDecoration(
                    border: Border(
                        /* bottom: BorderSide(
                            color: Theme.of(context).dividerColor,
                            width: tiny_50)*/
                        )),
                child: Row(children: [
                  Expanded(
                      child: Text(widget.title,
                          style: Theme.of(context).textTheme.headline5)),
                  if (widget.importantMessage != null)
                    Padding(
                        padding: const EdgeInsets.all(small_100),
                        child: Text(widget.importantMessage ?? "",
                            style: Theme.of(context).textTheme.caption)),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(ProximityIcons.chevron_right,
                          color: Colors.transparent),
                      Container(
                          height: normal_100,
                          width: normal_250,
                          decoration: BoxDecoration(
                              color: Theme.of(context).dividerColor,
                              borderRadius:
                                  const BorderRadius.all(smallRadius))),
                      InkWell(
                          onTap: () {
                            if (widget.toggleId != null) {
                              widget.onToggleId!
                                  .call([!widget.value, widget.toggleId]);
                            } else {
                              widget.onToggle!.call(!widget.value);
                            }
                          },
                          child: AnimatedContainer(
                              duration: smallAnimationDuration,
                              height: normal_150,
                              width: normal_150,
                              margin: widget.value
                                  ? const EdgeInsets.only(left: normal_100)
                                  : const EdgeInsets.only(right: normal_100),
                              decoration: BoxDecoration(
                                color: widget.value
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                borderRadius:
                                    const BorderRadius.all(normalRadius),
                              )))
                    ],
                  )
                ])))
      ],
    );
  }
}*/

class ListToggle extends StatefulWidget {
  ListToggle(
      {Key? key,
      required this.value,
      this.onToggle,
      this.toggleId,
      this.importantMessage,
      this.onToggleId,
      required this.title,
      this.leadIcon,
      this.color})
      : super(key: key);

  final String title;
  final IconData? leadIcon;
  final bool value;
  final ValueChanged<bool>? onToggle;
  final String? toggleId;
  final String? importantMessage;
  final ValueChanged<List<dynamic>>? onToggleId;
  Color? color;

  @override
  State<ListToggle> createState() => _ListToggleState();
}

class _ListToggleState extends State<ListToggle> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.leadIcon != null)
          Padding(
              padding: const EdgeInsets.all(normal_100).copyWith(left: 0),
              child: Icon(
                widget.leadIcon,
                color: widget.color,
              ))
        else
          const SizedBox(width: small_100),
        Expanded(
            child: Container(
                padding: const EdgeInsets.all(small_100).copyWith(left: 0),
                child: Row(children: [
                  Expanded(
                      child: Text(widget.title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: primaryTextLightColor,
                                  fontWeight: widget.value
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  fontSize: normal_100))),
                  if (widget.importantMessage != null)
                    Padding(
                        padding: const EdgeInsets.all(small_100),
                        child: Text(widget.importantMessage ?? "",
                            style: Theme.of(context).textTheme.caption)),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(ProximityIcons.chevron_right,
                          color: Colors.transparent),
                      Container(
                          height: normal_100,
                          width: normal_250,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .dividerColor
                                  .withOpacity(0.5),
                              borderRadius:
                                  const BorderRadius.all(smallRadius))),
                      InkWell(
                          onTap: () {
                            if (widget.toggleId != null) {
                              widget.onToggleId!
                                  .call([!widget.value, widget.toggleId]);
                            } else {
                              widget.onToggle!.call(!widget.value);
                            }
                          },
                          child: AnimatedContainer(
                              duration: smallAnimationDuration,
                              height: normal_150,
                              width: normal_150,
                              margin: widget.value
                                  ? const EdgeInsets.only(left: normal_100)
                                  : const EdgeInsets.only(right: normal_100),
                              decoration: BoxDecoration(
                                color: widget.value
                                    ? blueSwatch.shade500
                                    : Theme.of(context).dividerColor,
                                borderRadius:
                                    const BorderRadius.all(normalRadius),
                              )))
                    ],
                  )
                ])))
      ],
    );
  }
}
