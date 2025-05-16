part of 'authentication_bloc.dart';

class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class LoginWithPhoneNumberEvent extends AuthenticationEvent {
  final String phoneNumber;
  final String password;
  const LoginWithPhoneNumberEvent({required this.phoneNumber, required this.password});
} 

class RegisterUserEvent extends AuthenticationEvent {
  final String phoneNumber;
  final String password;
  const RegisterUserEvent({required this.phoneNumber, required this.password});
}

class VerifyOtpEvent extends AuthenticationEvent {
  final String verificationId;
  final String otp;
  final String? phoneNumber;
  final PhoneAuthCredential? credential;
  final String? password;
  const VerifyOtpEvent({required this.verificationId, required this.otp, this.phoneNumber, this.credential, this.password});
}


