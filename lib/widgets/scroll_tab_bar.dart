import 'package:flutter/material.dart';
import 'package:proximity/config/config.dart';

class ScrollTab {
  String name;
  VoidCallback? onPressed;

  ScrollTab({required this.name, required this.onPressed});
}

class ScrollTabBar extends StatefulWidget {
  const ScrollTabBar({Key? key, required this.tabs, this.action})
      : super(key: key);

  final List<ScrollTab> tabs;
  final List<Widget>? action;

  @override
  State<ScrollTabBar> createState() => _ScrollTabBarState();
}

class _ScrollTabBarState extends State<ScrollTabBar> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _index = 0;
  }

  List<Widget> _tabBarsBuilder() {
    List<Widget> _list = [];
    for (int i = 0; i < widget.tabs.length; i++) {
      _list.add(InkWell(
          onTap: () {
            setState(() {
              _index = i;
            });
            widget.tabs[i].onPressed!.call();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: normal_100),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              if (i == _index) ...[
                Text(widget.tabs[i].name,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: tiny_50),
                Container(
                    height: tiny_50,
                    width: normal_150,
                    decoration: BoxDecoration(
                        color: blueSwatch.shade500,
                        borderRadius: const BorderRadius.all(tinyRadius)))
              ] else
                Text(widget.tabs[i].name,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: Theme.of(context).textTheme.bodyText2!.color,
                        fontWeight: FontWeight.w600)),
            ]),
          )));
    }
    if (widget.action != null) {
      for (int j = 0; j < widget.action!.length; j++) {
        _list.add(widget.action![j]);
      }
    }
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: large_125,
      width: double.infinity,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: _tabBarsBuilder(),
      ),
    );
  }
}
