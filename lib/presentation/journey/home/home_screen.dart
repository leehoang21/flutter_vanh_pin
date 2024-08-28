import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pin/presentation/widgets/loading_widget/loader_widget.dart';
import '../../../common/constants/app_dimens.dart';
import '../../../common/di/di.dart';
import 'cubit/home_cubit.dart';
import 'home_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key ?? HomeConstants.key);

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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: AppDimens.height_20,
                      ),
                      const SizedBox(
                        height: 100,
                        width: 100,
                        child: LoaderWidget(),
                      ),
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
