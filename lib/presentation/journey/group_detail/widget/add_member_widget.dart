import 'package:flutter/material.dart';
import 'package:pinpin/common/extension/string_extension.dart';
import 'package:pinpin/common/utils/app_utils.dart';
import 'package:pinpin/data/models/user_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinpin/presentation/widgets/button_widget/text_button_widget.dart';
import '../../../themes/themes.dart';
import '../../../widgets/check_box/check_box_cricle_widget.dart';
import '../../../widgets/image_app_widget/avatar_widget.dart';

class AddMemberWidget extends StatefulWidget {
  const AddMemberWidget(
      {Key? key,
      required this.users,
      required this.onChanged,
      required this.title,
      required this.titleButton})
      : super(key: key);
  final List<UserModel> users;
  final Function(List<UserModel> users) onChanged;
  final String title;
  final String titleButton;

  @override
  State<AddMemberWidget> createState() => _AddMemberWidgetState();
}

class DataAdd {
  final bool value;
  final UserModel user;

  DataAdd({required this.value, required this.user});
}

class _AddMemberWidgetState extends State<AddMemberWidget> {
  List<DataAdd> users = [];

  @override
  void initState() {
    users = widget.users.map((e) => DataAdd(value: false, user: e)).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      child: ListView(
        children: [
          SizedBox(
            height: 5.h,
          ),
          Center(
            child: Text(
              widget.title.tr,
              style: ThemeText.style18Bold,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          for (int i = 0; i < users.length; i++)
            _ItemAddMeber(
              data: users[i],
              onChanged: (value) {
                setState(() {
                  users[i] = DataAdd(value: value!, user: users[i].user);
                });
              },
            ),
          SizedBox(
            height: 20.h,
          ),
          if (!isNullEmpty(widget.titleButton))
            TextButtonWidget2(
                onPressed: () {
                  widget.onChanged(users.map((e) => e.user).toList());
                },
                title: widget.titleButton.tr)
        ],
      ),
    );
  }
}

class _ItemAddMeber extends StatefulWidget {
  const _ItemAddMeber({required this.data, required this.onChanged});
  final DataAdd data;
  final Function(bool?) onChanged;

  @override
  State<_ItemAddMeber> createState() => _ItemAddMeberState();
}

class _ItemAddMeberState extends State<_ItemAddMeber> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onChanged(!widget.data.value);
      },
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 10.h,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AvatarWidget(
              path: widget.data.user.avatar,
              size: 40.sp,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              widget.data.user.userName ?? '',
              style: ThemeText.style12Regular,
            ),
            const Spacer(),
            GestureDetector(
                onTap: () {
                  widget.onChanged(!widget.data.value);
                },
                child: CheckboxCricleWidget(value: widget.data.value))
          ],
        ),
      ),
    );
  }
}
