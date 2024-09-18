import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckboxCricleWidget extends StatefulWidget {
  final bool value;

  const CheckboxCricleWidget({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  State<CheckboxCricleWidget> createState() => _CheckboxCricleWidgetState();
}

class _CheckboxCricleWidgetState extends State<CheckboxCricleWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        height: 20.sp,
        width: 20.sp,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: Colors.black,
            width: 1.5,
          ),
        ),
        child: widget.value
            ? const Center(
                child: Icon(
                Icons.check_rounded,
                color: Colors.black,
                weight: 2,
                size: 18,
              ))
            : null);
  }
}
