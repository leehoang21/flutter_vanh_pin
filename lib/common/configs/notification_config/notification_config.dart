import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/common/configs/default_environment.dart';
import 'package:pinpin/common/configs/dio/dio_config.dart';
import 'package:pinpin/common/configs/firebase_config.dart';
import 'package:pinpin/common/constants/string_constants.dart';
import 'package:pinpin/common/di/di.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/common/utils/app_utils.dart';
import 'package:pinpin/data/models/notification_model.dart';
import 'package:pinpin/presentation/routers/app_router.dart';

import '../../exception/app_error.dart';

@singleton
class NotificationConfig {
  final FirebaseConfig _firebaseConfig;
  final DioApiClient _dioApiClient;
  final AppService _appService;
  // final UserRepository userRepository;

  NotificationConfig(this._dioApiClient, this._appService,
      {required FirebaseConfig firebaseConfig})
      : _firebaseConfig = firebaseConfig;

  @postConstruct
  Future init() async {
    _firebaseConfig.firebaseMessaging.requestPermission();
    FirebaseMessaging.onMessage.listen((mess) {
      logger(mess.notification?.title.toString());
    });
  }

  void sendToken() async {
    final doc = _firebaseConfig.userDoc
        .collection(_firebaseConfig.auth.currentUser?.uid ?? '')
        .doc(DefaultEnvironment.token);
    final token = await _firebaseConfig.firebaseMessaging.getToken();
    logger(token);
    if (!isNullEmpty(token)) {
      try {
        await doc.set({token ?? 'w': token});
      } catch (e) {
        logger(e);
      }
    }
  }

  Future update(String device) async {
    if (_firebaseConfig.auth.currentUser == null) return null;
    try {
      DocumentReference<Map<String, dynamic>> doc = _firebaseConfig.userDoc
          .collection(_firebaseConfig.auth.currentUser?.uid ?? '')
          .doc(DefaultEnvironment.user);
      await doc.update({
        'devices': FieldValue.arrayUnion([device]),
      });
      _appService.setUser(_appService.state.user!
          .copyWith(devices: [..._appService.state.user!.devices, device]));
    } catch (e) {
      return AppError(message: e.toString());
    }
  }

  Future<List<String>> getToken(String userId) async {
    try {
      final doc = _firebaseConfig.userDoc
          .collection(userId)
          .doc(DefaultEnvironment.token);
      final data = (await doc.get()).data();
      return data?.values.map((e) => e.toString()).toList() ?? [];
    } catch (e) {
      logger(e);
      return [];
    }
  }

  onListen(RemoteMessage message) async {
    logger('notification:${message.notification?.title}');
    final model =
        NotificationModel.fromString(((message.data)['data'] as String?) ?? '');
    if (model.type == NotificationType.key) {
      getIt
          .get<AppRouter>()
          .navigatorKey
          .currentContext!
          .router
          .pushAndPopUntil(
            const MainRoute(),
            predicate: (route) => false,
          );
    }
  }

  sendMessenger(NotificationModel model) {
    const token =
        'ya29.a0AcM612zo9uPS7Sxbjb_-k7YZaCxsUW3efMweYol6I5TwJpB0O9-uePnjR1z7rAtVDPT2ReqSemlyBWzIwdTSY-lBHR8hBjD1LUS9uEGmkI0FgSpmaimsrqxB3ny0mlHNBa9H4DEjxCULmuFt2dJv9UJkEHzSJTo5l_Vsz-iZaCgYKAY8SARASFQHGX2MiIhqhzeOxhMgjlBaWCRPt7Q0175';
    _dioApiClient.post(
      url: StringConstants.urlNotificationAdmin,
      token: token,
      formData: {
        "message": {
          "data": {"data": model.toString()},
          "token": model.token,
          "notification": {
            "title": model.type?.title,
            "body": model.notification,
          }
        }
      },
    );
  }
}
