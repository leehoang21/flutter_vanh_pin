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
              '-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCbpp9PGAOzmRH/\nkWP1UWughWPgaYmAoFDg1JcvNWQQtLBZmYiqzmGrNawaA/VelOlZiBXf2Cq/gOAf\n6LT0AurFDjLhW+MF3GnjYVwXvwLAHX2n3fYGDagPHRUWP+VafBurhfeFYBPnro8B\njCAzj1SUF7Nb382bCbNtHGLYxq8ICoXMtFNxYwnM14mfqqGF5XBjH0UzPBns3J8g\nbAWLL5DP8JcMS/xfaek6t0oL19rNgiO5jw3oDOPkfdN8git+n5TMTxFqErVC3TMP\n0vxC8ZtnnQIhr4+JhcbggSakv5flYWYaIEVUC+oY1wP/cCcyY4K59dMad+2CnOOq\nLjVFZzFtAgMBAAECggEAJbTKZIJ8iRJElC0gMjJYeJE/1gIzC3wqw6B0hHzyYgKn\nsvj47OnkqrFsoPvDAffghK4tIGYxSuWZRdmdlnwra/PJ2yKjn0ybQThZcy40aB5s\nzZD9c890nj6tGE//y3kDyfxA72hMQiSdI6KSvXLUKjEIo/HWUN/bfcvx3TJaff+P\n2Z/Z1Yxbgb2BxEK+3NpNM/WAbGpGaXAVxiwR4RukDC6jEr1LQN5OBkU5S4Gtaygq\nUzSDXalh8AXBhZ76PQ0VCfpG0gSH4T7KpL+p22oNAIyRtUyKwhgSa8NbsyM9iYzh\nnAcEd0u8ScPmJwQ9aRmCvH7e77BcXesNgjFHGyWcUQKBgQDLRYf76UOG9AXxqeJo\nLREI4oLdN8nKCZV1MfVBJku4en+NeWVH1VqJOOHOsKRk8pXm/6qiUKx8tKNR9HYC\neMgSHRA5EOcmoXcDgcrx/ZbTI7xxIX+OKmNDhqpDiFTC9URWYf0RKmm5Z+FelW90\n5u7XXLzk4Zp8MsDk9aOGHkkZfQKBgQDEBsj1OZnHqFf06i0ZJfxfXw9o15oklNn4\nzKQNduOPc/FH/I1uTSwVMPl7tyDiytlhMLOnakvB/7KvbrMPtekVwMnCPZlqnplI\nYdc4iRaFCBLSr9eTlZUo2X+QeddBbauAIltmA+PyB9UcoSWehC8KnuzCLS+Y3pOT\ndK/xj0N6sQKBgAo0UWFKEoPB2FKLbrxAFuzVQjCMzmqAFKqveVpt67s1GxYlE/qJ\nMWRWIK/ZmkcfDntsNkqzthUElHZWyV3SZmjSYLAcsx3zWSAp8eA4FMxArQMY5Whj\npFwNdJqzS14GJgoYHTYxZOFT37J52gCKX08cbrcmxDSb76cO1ciz2IOZAoGAexkT\nq0MfucySZ3+DEI7VHALzB1CVQLGk6+N+heIJ5vTVKPKE0iZuL2SQ1sraQPFHbwwJ\nVXGf31S2HgqzMYN3uqxVRsAuDlFISrb+U0drN+EpCNtZ0hkWEQ/8Vnrc3P6EuzNY\nGAkLZNrcTl035YJ2lAHXBd0gTaxAGlIlhtkDdBECgYEAyj16ZByvSewIHMaTwR7L\nHI5VcmYHL+2LvkLcD12KYHhe5ojkfVEf9ZXhe426nisvRny9lScHRaLDkTmBulmN\n5wjpElcByOJYZjseM00pPkcBA/9Xexu1eNFhQcu+DkItvU2NZqEOiXJDPya9hBDn\nv0MbrkHNzi1uOks+UOCHBZI=\n-----END PRIVATE KEY-----\n',
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
