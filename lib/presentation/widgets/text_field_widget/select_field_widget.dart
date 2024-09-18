import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:pinpin/common/extension/string_extension.dart';
import 'package:pinpin/presentation/themes/themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectFieldModel<T> {
  final String label;
  final T value;

  SelectFieldModel({
    required this.label,
    required this.value,
  });
}

class SelectFieldWidget<T> extends StatefulWidget {
  const SelectFieldWidget({
    super.key,
    required this.items,
    this.selectedValue,
    this.hintText,
    this.onChanged,
  });

  final List<SelectFieldModel<T>> items;
  final T? selectedValue;
  final String? hintText;
  final Function(T?)? onChanged;

  @override
  State<SelectFieldWidget<T>> createState() => _SelectFieldWidgetState<T>();
}

class _SelectFieldWidgetState<T> extends State<SelectFieldWidget<T>> {
  T? selectedValue;

  @override
  void initState() {
    selectedValue = widget.selectedValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<T>(
            isExpanded: true,
            hint: Row(
              children: [
                Icon(
                  Icons.list,
                  size: 16.sp,
                  color: Colors.yellow,
                ),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                  child: Text(
                    selectedValue != null
                        ? selectedValue.toString().toTitleCase
                        : widget.hintText ?? 'Select Item',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColor.textColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: widget.items
                .map((SelectFieldModel item) => DropdownMenuItem<T>(
                      value: item.value,
                      child: Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            value: widget.selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value;
              });
            },
            buttonStyleData: ButtonStyleData(
              height: 50.h,
              width: 1.sw,
              padding: EdgeInsets.only(left: 14.w, right: 14.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: AppColor.iron,
                  ),
                  color: AppColor.iron),
              elevation: 2,
            ),
            iconStyleData: IconStyleData(
              icon: const Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              iconSize: 14.sp,
              iconEnabledColor: const Color.fromRGBO(255, 235, 59, 1),
              iconDisabledColor: Colors.grey,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200.h,
              width: 200.w,
              padding: EdgeInsets.only(left: 14.w, right: 14.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: AppColor.fieldColor,
              ),
              scrollbarTheme: ScrollbarThemeData(
                radius: Radius.circular(40.r),
              ),
            ),
            menuItemStyleData: MenuItemStyleData(
              height: 40.h,
              padding: EdgeInsets.only(left: 14.w, right: 14.w),
            ),
          ),
        ),
      ),
    );
  }
}
