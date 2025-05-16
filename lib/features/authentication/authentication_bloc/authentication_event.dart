part of 'authentication_bloc.dart';

class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class LoginWithPhoneNumberEvent extends AuthenticationEvent {
  final String phoneNumber;
  const LoginWithPhoneNumberEvent({required this.phoneNumber});
} 

class RegisterUserEvent extends AuthenticationEvent {
  final String phoneNumber;
  const RegisterUserEvent({required this.phoneNumber});
}

class VerifyOtpEvent extends AuthenticationEvent {
  final String verificationId;
  final String otp;
  final String? phoneNumber;
  final PhoneAuthCredential? credential;
  const VerifyOtpEvent({required this.verificationId, required this.otp, this.phoneNumber, this.credential});
}

class SignInWithGoogleEvent extends AuthenticationEvent {
  const SignInWithGoogleEvent();
}


