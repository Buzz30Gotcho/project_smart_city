import 'package:flutter/material.dart';
import 'package:proximity/config/values.dart';
import 'package:proximity/icons/proximity_icons.dart';

import 'border_type.dart';

class DropDownSelector<T> extends StatefulWidget {
  const DropDownSelector({
    Key? key,
    this.hideIcon = false,
    required this.items,
    this.icon,
    this.leadingIcon = false,
    this.onChanged,
    required this.hintText,
    this.savedValue,
    this.borderType = BorderType.single,
    this.padding = false,
  }) : super(key: key);

  /// onChange is called when the selected option is changed.;
  /// It will pass back the value and the index of the option.
  final void Function(T, int)? onChanged;

  /// list of DropdownItems
  final List<DropdownItem<T>> items;

  /// dropdown button icon defaults to caret
  final IconData? icon;
  final bool hideIcon;

  /// if true the dropdown icon will as a leading icon, default to false
  final bool leadingIcon;
  final String hintText;
  final T? savedValue;
  final BorderType borderType;
  final bool padding;

  @override
  _DropDownSelectorState<T> createState() => _DropDownSelectorState<T>();
}

class _DropDownSelectorState<T> extends State<DropDownSelector<T>>
    with TickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  late OverlayEntry _overlayEntry;
  bool _isOpen = false;
  int _currentIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotateAnimation;

  OverlayEntry _createOverlayEntry() {
    // find the size and position of the current widget
    RenderBox? renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    var offset = renderBox.localToGlobal(Offset.zero);
    var topOffset = offset.dy + size.height + small_100;
    return OverlayEntry(
      // full screen GestureDetector to register when a
      // user has clicked away from the dropdown
      builder: (context) => GestureDetector(
        onTap: () => _toggleDropdown(close: true),
        behavior: HitTestBehavior.translucent,
        // full screen container to register taps anywhere and close drop down
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                left: offset.dx,
                top: topOffset,
                width: size.width,
                child: CompositedTransformFollower(
                  offset: Offset(
                      (widget.borderType == BorderType.single)
                          ? (Directionality.of(context) == TextDirection.rtl)
                              ? -normal_100
                              : normal_100
                          : 0,
                      large_150 +
                          small_100 +
                          (widget.padding ? normal_100 : 0)),
                  link: _layerLink,
                  showWhenUnlinked: false,
                  child: SizeTransition(
                    axisAlignment: 1,
                    sizeFactor: _expandAnimation,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height -
                              topOffset -
                              normal_100,
                          maxWidth:
                              MediaQuery.of(context).size.width - normal_200),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: const BorderRadius.all(smallRadius),
                            border: Border.all(
                                width: tiny_50,
                                color: Theme.of(context).dividerColor)),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(innerBorderRadius),
                          child: BackdropFilter(
                            filter: blurFilter,
                            child: Material(
                              color: Colors.transparent,
                              borderRadius:
                                  const BorderRadius.all(innerBorderRadius),
                              child: ListView(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                children:
                                    widget.items.asMap().entries.map((item) {
                                  return InkWell(
                                      onTap: () {
                                        if (widget.onChanged != null) {
                                          setState(
                                              () => _currentIndex = item.key);
                                          widget.onChanged!(
                                              item.value.value, item.key);
                                          _toggleDropdown();
                                        }
                                      },
                                      child: item.value);
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleDropdown({bool close = false}) async {
    if (_isOpen || close) {
      await _animationController.reverse();
      _overlayEntry.remove();
      setState(() {
        _isOpen = false;
      });
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context)?.insert(_overlayEntry);
      setState(() => _isOpen = true);
      _animationController.forward();
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.savedValue != null) {
        _currentIndex = widget.items
            .indexWhere((element) => element.value == widget.savedValue!);
      } else {
        _currentIndex = -1;
      }
    });
    _animationController =
        AnimationController(vsync: this, duration: smallAnimationDuration);
    _expandAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _rotateAnimation = Tween(begin: 0.25, end: 0.75).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
        link: _layerLink,
        child: Container(
            margin: (widget.padding)
                ? const EdgeInsets.symmetric(
                    horizontal: normal_100, vertical: small_100)
                : (() {
                    switch (widget.borderType) {
                      case BorderType.single:
                        return const EdgeInsets.symmetric(
                            horizontal: normal_100);
                      default:
                        return const EdgeInsets.symmetric(
                            horizontal: normal_100);
                    }
                  }()),
            padding: (() {
              switch (widget.borderType) {
                case BorderType.single:
                  return const EdgeInsets.all(tiny_50);
                case BorderType.top:
                  return const EdgeInsets.all(tiny_50).copyWith(bottom: 0);
                case BorderType.topLeft:
                  return const EdgeInsets.all(tiny_50)
                      .copyWith(right: 0, bottom: 0);
                case BorderType.topRight:
                  return const EdgeInsets.all(tiny_50)
                      .copyWith(left: 0, bottom: 0);
                case BorderType.middle:
                  return const EdgeInsets.all(tiny_50);
                case BorderType.bottom:
                  return const EdgeInsets.all(tiny_50).copyWith(top: 0);
                default:
                  return const EdgeInsets.all(tiny_50);
              }
            }()),
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor,
              borderRadius: (() {
                switch (widget.borderType) {
                  case BorderType.single:
                    return const BorderRadius.all(smallRadius);
                  case BorderType.top:
                    return const BorderRadius.vertical(top: smallRadius);
                  case BorderType.topLeft:
                    return const BorderRadius.only(topLeft: smallRadius);
                  case BorderType.topRight:
                    return const BorderRadius.only(topRight: smallRadius);
                  case BorderType.middle:
                    return const BorderRadius.all(smallRadius);
                  case BorderType.bottom:
                    return const BorderRadius.vertical(bottom: smallRadius);
                  default:
                    return const BorderRadius.all(smallRadius);
                }
              }()),
            ),
            child: InkWell(
                onTap: _toggleDropdown,
                child: Container(
                    height: large_150,
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: (() {
                          switch (widget.borderType) {
                            case BorderType.single:
                              return const BorderRadius.all(innerBorderRadius);
                            case BorderType.top:
                              return const BorderRadius.vertical(
                                  top: innerBorderRadius);
                            case BorderType.topLeft:
                              return const BorderRadius.only(
                                  topLeft: innerBorderRadius);
                            case BorderType.topRight:
                              return const BorderRadius.only(
                                  topRight: innerBorderRadius);
                            case BorderType.middle:
                              return null;
                            case BorderType.bottom:
                              return const BorderRadius.vertical(
                                  bottom: innerBorderRadius);
                            default:
                              return const BorderRadius.all(smallRadius);
                          }
                        }())),
                    child: Row(children: [
                      if (_currentIndex == -1) ...[
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: normal_100),
                                child: Text(widget.hintText,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .color,
                                            fontWeight: FontWeight.w600))))
                      ] else
                        Expanded(child: widget.items[_currentIndex]),
                      if (!widget.hideIcon)
                        RotationTransition(
                            turns: _rotateAnimation,
                            child: const Icon(ProximityIcons.chevron_right)),
                      const SizedBox(width: small_100)
                    ])))));
  }
}

/// DropdownItem is just a wrapper for each child in the dropdown list.\n
/// It holds the value of the item.
class DropdownItem<T> extends StatelessWidget {
  const DropdownItem({Key? key, required this.value, this.child})
      : super(key: key);

  final T value;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: normal_250,
        alignment: (Directionality.of(context) == TextDirection.rtl)
            ? Alignment.centerRight
            : Alignment.centerLeft,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: normal_100),
        child: child ??
            Text("$value",
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(fontWeight: FontWeight.w600)));
  }
}
