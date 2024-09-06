import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_pin/data/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import '../../common/configs/firebase_config.dart';
import '../../common/constants/string_constants.dart';
import '../../common/exception/app_error.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../common/utils/app_utils.dart' as utils;
import '../mapper/auth_mapper.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final FirebaseConfig config;
  AuthRepositoryImpl(
    this.config,
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

      return Left(AuthMapper.convertUserCredentialToUserModel(user.user!));
    } on FirebaseException catch (e) {
      return Right(AppError(message: e.message ?? e.code));
    } catch (e) {
      return Right(AppError(message: e.toString()));
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
}
