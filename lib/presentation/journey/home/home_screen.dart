import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinpin/common/constants/string_constants.dart';
import 'package:pinpin/common/extension/string_extension.dart';
import 'package:pinpin/presentation/themes/themes.dart';
import 'package:pinpin/presentation/widgets/card_widget/post_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/post_model.dart';
import '../../widgets/appbar_widget/appbar_main_widget.dart';
import '../../widgets/card_widget/user_card.dart';
import 'cubit/home_cubit.dart';
import 'widget/create_post_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMainWidget(
        title: StringConstants.appTitle.tr,
        onSearch: () {},
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<HomeCubit>().onInit();
        },
        child: ListView(
          children: [
            SizedBox(
              height: 8.h,
            ),
            const CreatePostWidget(),
            SizedBox(
              height: 12.h,
            ),
            if (context.watch<HomeCubit>().state.users.isNotEmpty)
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Text(
                      'Suggestion to make friends'.tr,
                      style: ThemeText.body1,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  SizedBox(
                    height: 150.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: context.watch<HomeCubit>().state.users.map((e) {
                        return UserCard(model: e);
                      }).toList(),
                    ),
                  )
                ],
              ),
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Text(
                'Posts'.tr,
                style: ThemeText.body1,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return Column(
                    children: convertMaptoListAndSoft(state.posts)
                        .map(
                          (e) => PostCard(
                            model: e,
                          ),
                        )
                        .toList());
              },
            )
          ],
        ),
      ),
    );
  }

  List<PostModel> convertMaptoListAndSoft(Map<int, List<PostModel>> data) {
    final posts = <PostModel>[];
    if (data.isEmpty) return [];
    for (final list in data.values) {
      posts.addAll(list);
    }
    posts.sort(
      (a, b) {
        return b.time.compareTo(a.time);
      },
    );
    return posts;
  }
}
