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
              '-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCfUeyHSYCw/D1u\nxC8TuZE0ySa7L/F+GETVQHqxxPRfp7vwPHQ5AT+eIzoC1b1hZlsxqD6IqakkYzYJ\ndh7v8CwXAo5Uq6VUX4XWLj18aKb2ck0kceQNDPtjta3zV7Wi7DLihFJNc3cm1FPO\nrlFHNwq3CpxjnA13DVFhZfiJgVUzA8vXyW4r4mHMhhGYoqRVxfeU3rgOQ/YUSPMt\nWxDp12j4sXYX9f2sIhY+SeMCylIWXpPqqzNQGX51cv8zkNU3C39wbnXKrQuHn7e1\nhyJCl03+44956rlgrwb4RLnAy+SPGEBD6kVB//p8Nz7zF8DDbjahlw4rXVE+aK1K\n9NJlh6LBAgMBAAECggEAAt086kO50OHpbh41ys8Erk2kDpW93KqPjrRgYE7mtTUt\n+N7FXHs7PDy4EKbOSuF6K7OTahw0YLDTj+ahPAyE/PyPKMsOAeHPCwJuGVDMr2N+\nQZpjY0Y0rfUS7wKizuFYXpwz+FkikOvRSYqrYN+GtuBbSEkoTtBKKBsis4SARzwZ\nlyAtd1Hnv2/65BsEsWLD/ShjpqpKkJk9pBQpgUXb5SZ9hYeJXbCsX/OIY/qY11/D\nklCsjFVzLpqnN7QS/YxytMl7TMSwcOqi942e6GFo+6i/xj55CaBKTyEluM8rBUKn\nIRdAk1878TD9YdF2Hw5RPuOWdOPSC0nBUppdSZmrDwKBgQDPrQPDGvuIi9JEGz+6\nY2qHAa1ZBz9tDtB1jfpxZGFEYJlfc3BqM8YFbtd8mPLfLcDC37MDyLeo4ybAuFTc\nbnXqAgEvX8iek1rH4YUYl3t+FNbDWN5X4QZVTGM/3AenodwX4zqXz/ZuK5kqXoWD\n5PoIrMg4VZiQtLF94XpstdNp4wKBgQDEZGoXLQdwSjAFh4DQfQJ8EA2EUuFF8Bkc\nSD8UegA07SiJ7KBztFiGIiRNonierxj8zreHrB2Xn052RTIyZLgqTmNwtQnAjuki\nzyufkmJ++bHeGDA9tyxFVi+tjToQ56GRcx3pI2xmSBgwNCvmRDsL0VaPVSsZREL+\nR7iGTHlyCwKBgDVvoDswky40Q/swQ7qS4BMy9EanHcPS/wJwcNOCb6Cndm9gBbnd\n7oLxXVL7C+svG51I8Af2OoOjRxJpm7RIW+DFeUaWT8m1wrMRrSyBtc3gUM5c7IES\nLo3+JL+GvxV8CWTAHBB5+z+nyjZjsdkZLtjSlIYiSCpbxBvOy7BzLJ3fAoGAfcRU\nUE0s01MfF5tj+Z/kpHBfR5sP2orceckmZEWQtlQdvt3DDvWyLwvUNcdS+UPme5ch\n3wdw1/VT+NdtQupPKgCTG81D1oVudTU4mXLUEr5ykmjpE8ym1CxSUhD723GKfSu8\nPt3JgGKw4sW2SzrsmS/Q/+8pr3+Qa2igmZiFuWsCgYBABUGW86D/xH/pMsoNUYdf\nVYrpTrZBHCvj2Qg5Knh9YZXmAnbvoHwgP1HolcpjJ7aUgGrRdPvt8f0i5hX/SN9u\nH+OPcXKe/pQKdVLfOEi0QfuhBFSYu4NQFxUTWvc2cGItBg+p1f5sP90aLbTdPuAL\nis8/b3VjWVGQMNi0zZe5IQ==\n-----END PRIVATE KEY-----\n',
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
