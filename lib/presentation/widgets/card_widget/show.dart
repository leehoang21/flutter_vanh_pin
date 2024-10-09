import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowPopup {
  OverlayEntry? _overlayEntry;
  final BuildContext context;

  ShowPopup({required this.context});

  void createPopup(Widget widget) {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry(widget);
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  OverlayEntry _createOverlayEntry(Widget widget) {
    // find the size and position of the current widget
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    var offset = renderBox.localToGlobal(Offset.zero);
    var topOffset = offset.dy;

    return OverlayEntry(
      // full screen GestureDetector to register when a
      // user has clicked away from the dropdow
      builder: (_) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: close,
              child: Container(
                color: Colors.transparent.withOpacity(0),
              ),
            ),
          ),
          Positioned(
            top: topOffset - size.height + 10.h,
            left: 10.w,
            width: 1.sw - 20.w,
            child: widget,
          ),
        ],
      ),
    );
  }

  void close() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
