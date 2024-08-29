import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pin/data/models/user_model.dart';
import 'package:flutter_pin/presentation/widgets/card_widget/post_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/di/di.dart';
import 'cubit/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<HomeCubit>(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return SafeArea(
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light.copyWith(
                  statusBarColor:
                      Theme.of(context).appBarTheme.backgroundColor),
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
                      for (var i = 0; i < 10; i++)
                        PostCard(
                          model: PostCardModel(
                            image:
                                'https://cellphones.com.vn/sforum/wp-content/uploads/2024/02/anh-thien-nhien-1.jpg',
                            author: const UserModel(
                              avatar:
                                  'https://cellphones.com.vn/sforum/wp-content/uploads/2024/02/anh-thien-nhien-1.jpg',
                              userName: 'Nguyen Van A',
                            ),
                            group: const UserModel(
                              avatar:
                                  'https://cellphones.com.vn/sforum/wp-content/uploads/2024/02/anh-thien-nhien-1.jpg',
                              userName: 'Group A',
                            ),
                            time: DateTime.now()
                                .subtract(const Duration(minutes: 10)),
                            content:
                                'Trang Web phối màu online của adobe, điều chỉnh màu, lấy màu từ ảnh (hay hơn nữa là chọn màu từ điểm ảnh mà bạn chọn).',
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
