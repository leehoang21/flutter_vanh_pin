import 'dart:async';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/common/service/key.dart';
import '../../domain/use_cases/notification_use_case.dart';
import '../../presentation/bloc/base_bloc/base_bloc.dart';

class NotificationMessageService extends BaseBloc<int> {
  NotificationMessageService(
      this.notificationUseCase, this.keyService, this.appService)
      : super(0);

  final NotificationUseCase notificationUseCase;
  final KeyService keyService;
  final AppService appService;
  StreamSubscription? notificationSubscription;

  @override
  onInit() {
    _get();
    super.onInit();
  }

  _get() async {
    notificationSubscription?.cancel();
    notificationSubscription = notificationUseCase.listenChat().listen((event) {
      if (event.isRight) return;
      final notifications = event.left;

      for (var i = 0; i < notifications.length; i++) {
        if (notifications[i].token == keyService.publicKey.toString()) {
          final item = notifications[i];

          final List<String> privateKey =
              keyService.decrypteRsa(item.content ?? '').split(',,,');
          final key = privateKey[0];
          final iv = privateKey[1];
          final KeyApp keyApp = KeyApp();
          keyApp.setKeyAes(key, iv, item.id ?? '');
        }
        //
      }
    });
  }
}
