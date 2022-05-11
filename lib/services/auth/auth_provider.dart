import 'package:trulysocial/services/auth/auth_user.dart';

abstract class AuthProvider {
  AuthUser? get currentUser;
  Future<void> initialize();
  Future<AuthUser> logIn({required String email, required String password});
  Future<AuthUser> signUp(
      {required String email, required String password, required String name});
  Future<void> logOut();
  Future<void> sendEmailVerification();
}
