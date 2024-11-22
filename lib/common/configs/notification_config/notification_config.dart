import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypton/crypton.dart';
import 'package:dart_firebase_admin/messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/common/configs/background_service_config.dart';
import 'package:pinpin/common/configs/default_environment.dart';
import 'package:pinpin/common/configs/firebase_config.dart';
import 'package:pinpin/common/service/key.dart';
import 'package:pinpin/common/utils/app_utils.dart';
import 'package:pinpin/data/models/notification_model.dart';
import 'package:pinpin/data/models/user_model.dart';

@singleton
class NotificationConfig {
  final FirebaseConfig _firebaseConfig;
  final KeyService keyService;
  // final UserRepository userRepository;

  NotificationConfig(this.keyService, {required FirebaseConfig firebaseConfig})
      : _firebaseConfig = firebaseConfig;

  @postConstruct
  Future init() async {
    _firebaseConfig.firebaseMessaging.requestPermission();
    FirebaseMessaging.onMessage.listen((mess) {
      onListen(mess, false);
    });
  }

  void sendToken() async {
    final doc = _firebaseConfig.userDoc
        .collection(_firebaseConfig.auth.currentUser?.uid ?? '')
        .doc(DefaultEnvironment.token);
    final token = await _firebaseConfig.firebaseMessaging.getToken();
    final PublicKey key = keyService.publicKey!;
    if (!isNullEmpty(token)) {
      try {
        if ((await doc.get()).exists) {
          await doc.update({
            DefaultEnvironment.tokens: FieldValue.arrayUnion([
              {
                DefaultEnvironment.token: token,
                DefaultEnvironment.key: key.toString(),
              }
            ]),
          });
        } else {
          await doc.set({
            DefaultEnvironment.tokens: [
              {
                DefaultEnvironment.token: token,
                DefaultEnvironment.key: key.toString(),
              }
            ],
          });
        }
      } catch (e) {
        logger(e);
      }
    }
  }

  Future<String?> getTokenFirebase() {
    return _firebaseConfig.firebaseMessaging.getToken();
  }

  Future<List<(String, String)>> getToken(String userId) async {
    try {
      final doc = _firebaseConfig.userDoc
          .collection(userId)
          .doc(DefaultEnvironment.token);
      final data = (await doc.get()).data();
      return data?[DefaultEnvironment.tokens]
              .map<(String, String)>((e) => (
                    e[DefaultEnvironment.token] as String,
                    e[DefaultEnvironment.key] as String
                  ))
              .toList() ??
          [];
    } catch (e) {
      logger(e);
      return [];
    }
  }

  sendMessenger(NotificationModel model,
      {String? token, String? publicKey}) async {
    if (!isNullEmpty(token)) {
      if (!isNullEmpty(publicKey)) {
        model = model.copyWith(
          token: RSAPublicKey.fromString(publicKey!).encrypt(model.token ?? ''),
          content:
              RSAPublicKey.fromString(publicKey).encrypt(model.content ?? ''),
          author: UserModel(
            uId: model.author?.uId,
            userName: model.author?.userName,
            avatar: model.author?.avatar,
          ),
          user: UserModel(
            uId: model.user?.uId,
            userName: model.user?.userName,
            avatar: model.user?.avatar,
          ),
        );
      }
      //
      await _firebaseConfig.messaging.send(TokenMessage(
        data: {
          'data': model.toString(),
        },
        notification: Notification(
          title: model.title,
          body: model.notification,
        ),
        token: token!,
      ));

      return;
    }
    //
    final tokens = await getToken(model.user?.uId ?? '');

    for (final token in tokens) {
      final model0 = model.copyWith(
        token: RSAPublicKey.fromString(token.$2).encrypt(model.token ?? ''),
        content: RSAPublicKey.fromString(token.$2).encrypt(model.content ?? ''),
        author: UserModel(
          uId: model.author?.uId,
          userName: model.author?.userName,
          avatar: model.author?.avatar,
        ),
        user: UserModel(
          uId: model.user?.uId,
          userName: model.user?.userName,
          avatar: model.user?.avatar,
        ),
      );
      //
      await _firebaseConfig.messaging.send(TokenMessage(
        data: {
          'data': model0.toString(),
        },
        notification: Notification(
          title: model0.title,
          body: model0.notification,
        ),
        token: token.$1,
      ));
    }
  }
}
