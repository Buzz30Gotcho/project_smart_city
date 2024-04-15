import 'package:flutter/material.dart';
import 'package:proximity/config/config.dart';

const longTextCutLength = 126;

class LongText extends StatefulWidget {
  const LongText(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  _LongTextWidgetState createState() => _LongTextWidgetState();
}

class _LongTextWidgetState extends State<LongText> {
  late String firstHalf;
  late String secondHalf;

  bool expanded = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 300) {
      firstHalf = widget.text.substring(0, 300);
      secondHalf = widget.text.substring(300, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [
      SizedBox(
          width: double.infinity,
          child: Text(expanded ? firstHalf : (firstHalf + secondHalf),
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.start)),
      Container(
          padding: const EdgeInsets.all(normal_100),
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Theme.of(context).backgroundColor.withOpacity(0.0),
                Theme.of(context).backgroundColor.withOpacity(2 / 3),
                Theme.of(context).backgroundColor
              ])),
          child: Text(expanded ? "show more" : "show less",
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Theme.of(context).primaryColor)))
    ];

    return secondHalf.isEmpty
        ? SizedBox(
            width: double.infinity,
            child: Text(firstHalf,
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.start))
        : GestureDetector(
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
            child: expanded
                ? Stack(alignment: Alignment.bottomCenter, children: _children)
                : Column(children: _children));
  }
}
