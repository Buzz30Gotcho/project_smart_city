import 'dart:async';
import 'package:flutter/material.dart';
import 'package:proximity/config/config.dart';
import 'package:proximity/icons/proximity_icons.dart';
import 'toast_entry.dart';

/// [ToastSnackbar] types
enum ToastSnackbarType { normal, success, error }

/// [ToastSnackbar]
class ToastSnackbar {
  BuildContext? context;

  static final ToastSnackbar _instance = ToastSnackbar._internal();

  /// Prmary Constructor for FToast
  factory ToastSnackbar() {
    return _instance;
  }

  /// Take users Context and saves to avariable
  ToastSnackbar init(BuildContext context) {
    _instance.context = context;
    return _instance;
  }

  ToastSnackbar._internal();

  OverlayEntry? _entry;
  final List<ToastEntry> _overlayQueue = [];
  Timer? _timer;

  /// Internal function which handles the adding
  /// the overlay to the screen
  ///
  _showOverlay() {
    if (_overlayQueue.isEmpty) {
      _entry = null;
      return;
    }
    ToastEntry _toastEntry = _overlayQueue.removeAt(0);
    _entry = _toastEntry.entry;
    if (context == null) {
      throw ("Error: Context is null, Please call init(context) before showing toast.");
    }
    Overlay.of(context!)!.insert(_entry!);

    _timer = Timer(_toastEntry.duration!, () {
      Future.delayed(normalAnimationDuration, () {
        removeCustomToast();
      });
    });
  }

  /// If any active toast present
  /// call removeCustomToast to hide the toast immediately
  removeCustomToast() {
    _timer?.cancel();
    _timer = null;
    if (_entry != null) _entry!.remove();
    _entry = null;
    _showOverlay();
  }

  /// FToast maintains a queue for every toast
  /// if we called showToast for 3 times we all to queue
  /// and show them one after another
  ///
  /// call removeCustomToast to hide the toast immediately
  removeQueuedCustomToasts() {
    _timer?.cancel();
    _timer = null;
    _overlayQueue.clear();
    if (_entry != null) _entry!.remove();
    _entry = null;
  }

  /// showToast accepts all the required paramenters and prepares the child
  /// calls _showOverlay to display toast
  ///
  /// Paramenter [child] is requried
  /// fadeDuration default is 350 milliseconds
  void showToast(
      {required String message,
      Color? color,
      ToastSnackbarType type = ToastSnackbarType.normal}) {
    if (context == null) {
      throw ("Error: Context is null, Please call init(context) before showing toast.");
    }

    IconData? _icon;
    Color? _color = color;
    const _toastDuration = hugeAnimationDuration;
    const _fadeDuration = normalAnimationDuration;

    switch (type) {
      case ToastSnackbarType.error:
        _icon = Icons.warning_amber_rounded;
        _color = redSwatch.shade400;
        break;
      case ToastSnackbarType.success:
        _icon = Icons.check;
        _color = greenSwatch.shade400;
        break;
      case ToastSnackbarType.normal:
      default:
        _color = Theme.of(context!).cardColor;
        return;
    }

    Container _toastContainer = Container(
        padding: const EdgeInsets.symmetric(
            horizontal: normal_100, vertical: small_100),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(smallRadius), color: _color),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          if (type != ToastSnackbarType.normal) ...[
            Icon(_icon),
            const SizedBox(width: normal_100)
          ],
          Expanded(
              child: Text(
            message,
            style: Theme.of(context!).textTheme.bodyLarge,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )),
          const SizedBox(width: normal_100),
          const Icon(ProximityIcons.remove)
        ]));

    Widget _newToastContainer = ToastStateFul(
        child: _toastContainer,
        toastDuration: _toastDuration,
        fadeDuration: _fadeDuration);

    /// Check for keyboard open
    /// If open will ignore the gravity bottom and change it to center
    OverlayEntry newEntry = OverlayEntry(builder: (context) {
      return _getPositionWidgetBasedOnGravity(_newToastContainer);
    });

    _overlayQueue
        .add(ToastEntry(entry: newEntry, duration: hugeAnimationDuration));
    if (_timer == null) _showOverlay();
  }

  /// _getPositionWidgetBasedOnGravity generates [Positioned] [Widget]
  /// based on the gravity  [ToastGravity] provided by the user in
  /// [showToast]
  _getPositionWidgetBasedOnGravity(Widget child) {
    /* if (MediaQuery.of(context!).viewInsets.bottom != 0) {
      return Positioned(top: 50.0, bottom: 50.0, right: 24.0, child: child);
    } else{*/
    return Positioned(
        bottom: normal_100, left: normal_100, right: normal_100, child: child);
    //}
    // switch (gravity) {
    //   case ToastGravity.TOP:
    //     return Positioned(top: 100.0, left: 24.0, right: 24.0, child: child);
    //   case ToastGravity.TOP_LEFT:
    //     return Positioned(top: 100.0, left: 24.0, child: child);
    //   case ToastGravity.TOP_RIGHT:
    //     return Positioned(top: 100.0, right: 24.0, child: child);
    //   case ToastGravity.CENTER:
    //     return Positioned(
    //         top: 50.0, bottom: 50.0, left: 24.0, right: 24.0, child: child);
    //   case ToastGravity.CENTER_LEFT:
    //     return Positioned(top: 50.0, bottom: 50.0, left: 24.0, child: child);
    //   case ToastGravity.CENTER_RIGHT:
    //     return Positioned(top: 50.0, bottom: 50.0, right: 24.0, child: child);
    //   case ToastGravity.BOTTOM_LEFT:
    //     return Positioned(bottom: 50.0, left: 24.0, child: child);
    //   case ToastGravity.BOTTOM_RIGHT:
    //     return Positioned(bottom: 50.0, right: 24.0, child: child);
    //   case ToastGravity.SNACKBAR:
    //     return Positioned(
    //         bottom: MediaQuery.of(context!).viewInsets.bottom,
    //         left: 0,
    //         right: 0,
    //         child: child);
    //   case ToastGravity.BOTTOM:
    //   default:
    //     return Positioned(bottom: 50.0, left: 24.0, right: 24.0, child: child);
    // }
  }
}
