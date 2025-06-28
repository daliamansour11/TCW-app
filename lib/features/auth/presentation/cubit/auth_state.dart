part of 'auth_cubit.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoggedIn extends AuthState {
  const AuthLoggedIn(this.user);
  final UserModel user;
}

class AuthRegistered extends AuthState {
  const AuthRegistered(this.user);
  final UserModel user;
}

class AuthLoggedOut extends AuthState {}

class AuthError extends AuthState {
  const AuthError(this.message);
  final String message;
}

class AuthPasswordResetTokenSent extends AuthState {
  const AuthPasswordResetTokenSent(this.message);
  final String message;
}

class AuthOTPRemainingTime extends AuthState {
  const AuthOTPRemainingTime(this.seconds);
  final int seconds;
}

class AuthTokenVerified extends AuthState {
  const AuthTokenVerified(this.message);
  final String message;
}

class AuthPasswordResetSuccess extends AuthState {
  const AuthPasswordResetSuccess(this.message);
  final String message;
}

// Edit  Personal Details
class  AuthUserEdit extends AuthState {}
