import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_firebase_admin/auth.dart';
import 'package:dart_firebase_admin/messaging.dart';
import 'package:dart_firebase_admin/dart_firebase_admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/common/utils/app_utils.dart';

import '../../firebase_options.dart';
import 'default_environment.dart';

@singleton
class FirebaseConfig {
  late FirebaseApp app;
  late DocumentReference userDoc;
  late Reference userStorage;
  late FirebaseAuth auth;
  late final GoogleSignIn googleSignIn;
  late final FirebaseMessaging firebaseMessaging;
  late final FirebaseAdminApp firebaseAdmin;
  late final Auth authAdnin;
  late final Messaging messaging;

  @postConstruct
  Future init() async {
    app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    firebaseMessaging = FirebaseMessaging.instance;
    auth = FirebaseAuth.instance;
    userDoc = FirebaseFirestore.instance
        .collection(DefaultEnvironment.environmentHome)
        .doc(DefaultEnvironment.environment);
    userStorage = FirebaseStorage.instance
        .ref(DefaultEnvironment.environmentHome)
        .child(DefaultEnvironment.environment);
    googleSignIn = GoogleSignIn();

    try {
      firebaseAdmin = FirebaseAdminApp.initializeApp(
        'learning-english-6441b',
        // Log-in using the newly downloaded file.
        Credential.fromServiceAccountParams(
          clientId: '113193798497615911356',
          email:
              "firebase-adminsdk-phfh4@learning-english-6441b.iam.gserviceaccount.com",
          privateKey:
              '-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQClZyfZCcLwy4Kv\nKZpq5pXYq5d0TGS6tmwrmFqoQRokDTDUSLbZyr+q7yZ3DpGYYTceT989ucMYFTjM\nxhIfp6kbagUktTmuOdBGh0evMnni6J2+ULRO86z7Kc4015/TO9Ehov0JG74+BjQM\nd7UswuU9BLoQBg9jyrJwb5gSFDJKmiwhOhFxp0R5Bhv1kSOW63O5iegIBr4pfROq\nuZ+D73/pRZkxG0xN1Ju5ASUZ1qWJUuq+JZLDVgcKgjBQ92jZUOhCDb8jnKOgDIaN\n/M2n45ueKpH2Yzfhm1yIecibRJOjkhQSGdSC4Ss3jWF3y/JuqwsnlSs0mNkGUEp4\nTzaebY9xAgMBAAECggEADCCNmK/kb213pfcjbF4YTRwVQGb15biu73bxHEmcEvOc\nPM+Ebi1O5nrSJt2JfRL3pk0BF1Bk7QGbugV1wIUCKAS0eG+iWVNbOw77iW1mgWWm\n/ZRP1amvgts0VF+3RxbckdF89iuAd25SzgbPrYbJ2Jj3OWojiIbZx9bVLAVeEJkY\nM6Vsu1g65R2wKPYWtsJiS1GFTznOB1oCn4+24aXj80nZjfktXrt474F2gA017/4i\n7VQ2X+0AUWxv5mUNf3K/yE0LqBfwKT0VlsrBZkDvU8WuESZsaa118Q1mwi1zg8aI\n4jOa2j2ArdPzl6Wyd+0CnfEZbJCIJehToU1wFw+mtwKBgQDovJrAz7dxKo7GZ09w\ntO822hIhJowZfAmwGJB1Tc29D8/kDV+Cxn1ivb8+f0MTOEcg/EM563KJBziBOma9\nk/EsfZ3jDGJ1nEjAFeRXSaF2X2UQ0+O/jL6IE13DWNWWuqkL36PuE+l88RhFqqWW\nibn+8WvifaOdEPyrEvjRnyITKwKBgQC175PIH4ykspRQDLC77pHC6sMB6K5rhkus\nKBssEUbLOyMoh8kZSI6h0LSUIXOD+WxXKTT6oyrSdeC3hSjSio0hAaUk4BSvne3f\ngU9gChhmG/cmoyas+sB0Jf8eCiVrI09BmdFpIoXq/jqDhqDESJNWRM5hOVFatSEp\niRfb02HJ0wKBgQCzEEFkrawu9pZpEh1t0tfl9PxT4yuRg/yULyIeDqGHn/3MMXnV\nzU+1Q9Y7iICb7gXT3CMBEiTKRvLzgnJ/066QE4oBoYqzgG381BseCXmf8J96xfwJ\naYlCetv+K4AR+0WK7CNdTparWXfaSgQjAY5IF4lw9keG1gYAvZUQ+wWlhwKBgQC1\n3GOWuaK2xyNl2SmY0eK2OkDv2YzwQm/GCNkQdbyUTerZCtJECbk5mwvGvqFfnKVl\ngvVITG3zro0QJXUm8AQeqCxR7gP/gBhVQEb9s1msR+wHnTJ92rEh6RFZD79TlxoU\ncxNWyoGe4r3O13ZAfmN46pJ5sPfXehNKF5XX0TaArQKBgQDlaZZHSTMV16JTfe/+\n/at9Pnuxf6S+h5T8/i9W8hyYHZXuf4dugHmkfEKcZTa9VY/U5o1lMU/3axd/HQAm\ngedfbzZcNklGZY514cQfCH9VMbGB/odE9gSSRdNlkzNxbQAHp+vA0n5fNBzyCtx/\nG7E9sY/M8DxBCYXstf0Pq37tOA==\n-----END PRIVATE KEY-----\n',
        ),
      );
      authAdnin = Auth(firebaseAdmin);
      messaging = Messaging(firebaseAdmin);
    } catch (e) {
      logger(e);
    }
  }

  Future<bool> singIn() async {
    try {
      // final token = getIt.getAsync<HiveConfig>().user?.token ?? '';
      // if (token.isNotEmpty) {
      //   final result = await auth.signInWithCustomToken(token);
      //   return result.user != null;
      // } else {
      //   return false;
      // }
      return true;
    } catch (e) {
      return false;
    }
  }
}
