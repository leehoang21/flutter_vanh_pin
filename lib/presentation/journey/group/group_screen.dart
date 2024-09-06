import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'cubit/group_cubit.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Theme.of(context).appBarTheme.backgroundColor),
        child: Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<GroupCubit>().onInit();
            },
            child: ListView(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
