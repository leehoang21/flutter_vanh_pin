import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinpin/common/configs/default_environment.dart';
import 'package:pinpin/common/configs/local_storage/local_storage.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/data/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import '../../common/configs/biometric/biometric_config.dart';
import '../../common/configs/firebase_config.dart';
import '../../common/configs/dio/dio_config.dart';
import '../../common/constants/string_constants.dart';
import '../../common/exception/app_error.dart';
import '../../common/service/key.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../common/utils/app_utils.dart' as utils;
import '../mapper/auth_mapper.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final FirebaseConfig config;
  final DioApiClient dioApiClient;
  final AppService appService;
  final LocalStorage localStorage;
  final BiometricConfig biometricConfig;

  AuthRepositoryImpl(
    this.config,
    this.dioApiClient,
    this.appService,
    this.localStorage,
    this.biometricConfig,
  );

  @override
  Future<AppError?> signOut() async {
    try {
      await config.googleSignIn.signOut();
    } catch (_) {}
    try {
      await config.auth.signOut();
      return null;
    } catch (e) {
      return AppError(message: e.toString());
    }
  }

  @override
  Future<AppError?> loginWithPassword({
    required String email,
    required String pass,
  }) async {
    try {
      pass = utils.hash(pass);
      final credential = EmailAuthProvider.credential(
        email: email,
        password: pass,
      );
      await config.auth.signInWithCredential(credential);
      appService.setCredential(credential);
    } on FirebaseException catch (e) {
      return AppError(message: e.message ?? e.code);
    } catch (e) {
      return AppError(message: StringConstants.passwordOrEmailIncorrect);
    }
    return null;
  }

  @override
  Future<AppError?> updatePassword({
    required String email,
    required String password,
    required String newPass,
    required String oldPass,
  }) async {
    try {
      final userCredential = await config.auth.signInWithEmailAndPassword(
        email: email,
        password: oldPass,
      );
      await userCredential.user?.updatePassword(newPass);
    } on FirebaseException catch (e) {
      return AppError(message: e.message ?? e.code);
    } catch (e) {
      return AppError(message: e.toString());
    }
    return null;
  }

  @override
  Future<Either<UserModel, AppError>> loginWithGoogle() async {
    try {
      //nếu chưa login thì login rồi lấy token
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser =
          await config.googleSignIn.signIn();

      // Obtain the auth details from the request
      final token = await googleUser?.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: token?.accessToken,
        idToken: token?.idToken,
      );

      // Once signed in, return the UserCredential
      final user = await FirebaseAuth.instance.signInWithCredential(credential);
      appService.setCredential(credential);
      return Left(AuthMapper.convertUserCredentialToUserModel(user.user!));
    } on FirebaseException catch (e) {
      return Right(AppError(message: e.message ?? e.code));
    } catch (e) {
      return Right(AppError(message: e.toString()));
    }
  }

  @override
  Future<AppError?> loginWithBiometric() async {
    try {
      final credential = await biometricConfig.credential;
      await FirebaseAuth.instance.signInWithCredential(credential!);
      return null;
    } on FirebaseException catch (e) {
      return AppError(message: e.message ?? e.code);
    } catch (e) {
      return AppError(message: e.toString());
    }
  }

  @override
  Future<AppError?> register({
    required UserModel user,
    required String password,
  }) async {
    try {
      password = utils.hash(password);

      await config.auth.createUserWithEmailAndPassword(
        email: user.email ?? 'h@gmail.com',
        password: password,
      );
    } on FirebaseException catch (e) {
      return AppError(message: e.message ?? e.code);
    } catch (e) {
      return AppError(message: e.toString());
    }
    return null;
  }

  @override
  Future<Either<UserModel, AppError>> loginWithToken(String token) async {
    try {
      utils.logger(token);
      final user = await config.auth.signInWithCustomToken(token);

      return Left(AuthMapper.convertUserCredentialToUserModel(user.user!));
    } on FirebaseException catch (e) {
      return Right(AppError(message: e.message ?? e.code));
    } catch (e) {
      return Right(AppError(message: e.toString()));
    }
  }

  @override
  Future<bool> checkGoogleAuthenticator(String token) async {
    try {
      KeyApp keyApp = KeyApp();
      final key = await keyApp.getKeyAes(config.auth.currentUser?.uid ?? '');
      final result = await dioApiClient.get(
        url: StringConstants.urlCheckAuthenticator,
        formData: {
          'Pin': token,
          'SecretCode': key!.$1.base64.substring(16, 32),
        },
      );
      return result == 'True';
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> logout() {
    return config.auth.signOut();
  }

  @override
  Future<String?> getJWT() async {
    try {
      return config.authAdnin.createCustomToken(
        config.auth.currentUser?.uid ?? '',
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> registerGoogleAuthenticator(bool isAuthenticator) async {
    try {
      DocumentReference<Map<String, dynamic>> doc = config.userDoc
          .collection(config.auth.currentUser?.uid ?? '')
          .doc(DefaultEnvironment.user);
      final param = {
        'isAuthenticator': isAuthenticator,
      };
      await doc.update(param);
      appService.setUser(appService.state.user!.copyWith(
        isAuthenticator: isAuthenticator,
      ));
      //
      if (isAuthenticator) {
        KeyApp keyApp = KeyApp();
        final key = await keyApp.getKeyAes(config.auth.currentUser?.uid ?? '');
        final param = {
          'AppName': StringConstants.appTitle,
          "AppInfo": appService.state.user!.userName,
          'SecretCode': key!.$1.base64.substring(16, 32),
        };
        final result = await dioApiClient.get<String>(
          url: StringConstants.urlCreateAuthenticator,
          formData: param,
        );
        return result;
      }
    } catch (_) {}
    return null;
  }

  @override
  Future<AppError?> changePassword(String pass) async {
    try {
      await config.auth.currentUser?.updatePassword(pass);
      return null;
    } on FirebaseException catch (e) {
      return AppError(message: e.message ?? e.code);
    } catch (e) {
      return AppError(message: e.toString());
    }
  }
}
