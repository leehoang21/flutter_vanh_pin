import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pin/presentation/widgets/card_widget/post_card.dart';
import 'package:flutter_pin/presentation/widgets/loading_widget/loader_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return SafeArea(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Theme.of(context).appBarTheme.backgroundColor),
        child: Scaffold(
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
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return state.when(
                      loading: () {
                        return Center(
                          child: SizedBox(
                            height: 100.h,
                            width: 100.h,
                            child: const LoaderWidget(),
                          ),
                        );
                      },
                      loaded: (posts) {
                        return Column(
                          children: posts
                              .map(
                                (e) => PostCard(
                                  model: e,
                                ),
                              )
                              .toList(),
                        );
                      },
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
