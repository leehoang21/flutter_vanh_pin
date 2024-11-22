import 'dart:ui';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pinpin/common/configs/default_environment.dart';
import 'package:pinpin/common/configs/local_storage/local_storage.dart';
import 'package:pinpin/common/di/di.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/common/service/key.dart';
import 'package:pinpin/common/utils/app_utils.dart';
import 'package:pinpin/data/models/notification_model.dart';

import '../../data/models/friend_model.dart';

// this will be used as notification channel id
const notificationChannelId = 'high_importance_channel';

// this will be used for notification id, So you can update your custom notification with this id.
const notificationId = 100;

saveNotification(NotificationModel data) async {
  final LocalStorage localStorage = LocalStorage();
  final String? uid = data.user?.uId;
  if (data.isMessage) {
    final String? messages = await localStorage
        .read('${DefaultEnvironment.notificationMessages}$uid');
    if (messages != null) {
      final List<NotificationModel> list = NotificationModel.fromList(messages);
      list.add(data);
      localStorage.write('${DefaultEnvironment.notificationMessages}$uid',
          NotificationModel.toList(list));
    }
  } else {
    final String? notifications =
        await localStorage.read('${DefaultEnvironment.notifications}$uid');
    if (notifications != null) {
      final List<NotificationModel> list =
          NotificationModel.fromList(notifications);
      list.add(data);
      localStorage.write('${DefaultEnvironment.notifications}$uid',
          NotificationModel.toList(list));
    }
  }
}

actionKey(NotificationModel data) {
  final KeyApp keyApp = KeyApp();
  if (data.type == NotificationType.removeGroupChatSuccess ||
      data.type == NotificationType.removeGroupSuccess) {
    keyApp.setKeyAes('', '', data.id ?? 'null');
    return;
  }
  if (!isNullEmpty(data.token)) {
    final key = KeyApp.fromKeyString(data.token ?? '');

    if (key.length == 2) {
      if (isNullEmpty(key[0]) || isNullEmpty(key[1])) {
        return;
      }
      keyApp.setKeyAes(key[0], key[1], data.id ?? 'null');
    }
  }
}

dynamic onListen(RemoteMessage message, bool isBackground) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    notificationChannelId, // id
    'MY FOREGROUND SERVICE', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max, // importance must be at low or higher level
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  //
  final KeyService keyService = KeyService(LocalStorage());
  await keyService.init();
  final data = ((message.data)['data'] as String?);
  if (isNullEmpty(data)) {
    return;
  }
  NotificationModel model = NotificationModel.fromString(data ?? '');
  model = model.copyWith(
    token: keyService.decrypteRsa(model.token ?? ''),
    content: keyService.decrypteRsa(model.content ?? ''),
  );
//
  actionKey(model);
  if (model.type == NotificationType.keyChat) {
    return;
  }

  saveNotification(model);
  final uid = await LocalStorage().read(DefaultEnvironment.uid);
  if (model.user?.uId != uid) return;

  if (!isBackground) {
    final AppService appService = getIt.get<AppService>();
    appService.addNotification(model);
    if (model.type == NotificationType.addFriendSuccess) {
      appService.setUser(appService.state.user!.copyWith(
        friends: [
          ...appService.state.user!.friends,
          FriendModel(
            user: model.author,
            status: FriendStatus.accepted,
            author: appService.state.user,
          ),
        ],
      ));
    }
  }
  if (isNullEmpty(model.message)) {
    return;
  }

  flutterLocalNotificationsPlugin.show(
    notificationId,
    model.title,
    model.message,
    NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        icon: '@mipmap/ic_launcher',
      ),
    ),
  );
}
