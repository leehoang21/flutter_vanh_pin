import 'dart:async';
import 'package:pinpin/data/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../bloc/base_bloc/base_bloc.dart';

part 'notification_cubit.freezed.dart';
part 'notification_state.dart';

@injectable
class NotificationCubit extends BaseBloc<NotificationState> {
  NotificationCubit()
      : super(
          NotificationState.loaded(
            [
              NotificationData(
                author: UserModel(
                  background:
                      'https://cellphones.com.vn/sforum/wp-content/uploads/2024/02/anh-thien-nhien-1.jpg',
                  avatar:
                      'https://cellphones.com.vn/sforum/wp-content/uploads/2024/02/anh-thien-nhien-1.jpg',
                  userName: 'Nguyen Van A',
                  email: 'H@gmail.com',
                  phoneNumber: '0123456789',
                  address: 'Ha Noi',
                  birthday: DateTime(1999, 12, 12),
                  education: 'University',
                  job: 'Developer',
                ),
                time: DateTime.now().subtract(const Duration(minutes: 10)),
                title: 'like your post',
              ),
              NotificationData(
                author: UserModel(
                  background:
                      'https://cellphones.com.vn/sforum/wp-content/uploads/2024/02/anh-thien-nhien-1.jpg',
                  avatar:
                      'https://cellphones.com.vn/sforum/wp-content/uploads/2024/02/anh-thien-nhien-1.jpg',
                  userName: 'Nguyen Van A',
                  email: 'H@gmail.com',
                  phoneNumber: '0123456789',
                  address: 'Ha Noi',
                  birthday: DateTime(1999, 12, 12),
                  education: 'University',
                  job: 'Developer',
                ),
                time: DateTime.now().subtract(const Duration(minutes: 10)),
                title: 'like your post',
              )
            ],
          ),
        );

  @override
  Future onInit() async {
    super.onInit();
  }
}
