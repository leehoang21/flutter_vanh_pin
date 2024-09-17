import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinpin/data/models/group_model.dart';
import 'package:pinpin/presentation/widgets/card_widget/post_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/appbar_widget/appbar_main_widget.dart';
import 'cubit/detail_group_cubit.dart';
import 'widget/create_post_group_widget.dart';

class GroupDetailScreen extends StatefulWidget {
  const GroupDetailScreen({Key? key, required this.groupModel})
      : super(key: key);
  final GroupModel groupModel;

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Theme.of(context).appBarTheme.backgroundColor),
        child: Scaffold(
          appBar: AppBarMainWidget(
            title: widget.groupModel.name,
            onSearch: () {},
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<GroupDetailCubit>().init();
            },
            child: ListView(
              children: [
                SizedBox(
                  height: 8.h,
                ),
                const CreatePostGroupWidget(),
                SizedBox(
                  height: 12.h,
                ),
                BlocBuilder<GroupDetailCubit, GroupDetailState>(
                  builder: (context, state) {
                    return Column(
                      children: state.posts
                          .map(
                            (e) => PostCard(
                              model: e,
                            ),
                          )
                          .toList(),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
