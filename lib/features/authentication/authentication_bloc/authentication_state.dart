part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  initial,
  sendingOtpLoading,
  sendingOtpSuccess,
  sendingOtpFailure,
  otpVerificationLoading,
  otpVerified,
  otpVerificationFailure,
  registerUserLoading,
  registerUserSuccess,
  registerUserFailure,
  loginWithPhoneNumberLoading,
  loginWithPhoneNumberSuccess,
  loginWithPhoneNumberFailure,
  isNewUser,
}

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final String error;
  final String? verificationId;
  final String? otp;
  final String? phoneNumber;
  final String? password;
  final PhoneAuthCredential? credential;
  const AuthenticationState({
    required this.status,
    required this.error,
    required this.verificationId,
    required this.otp,
    required this.phoneNumber,
    required this.password,
    required this.credential,
  });

  static const initial = AuthenticationState(
    status: AuthenticationStatus.initial,
    error: '',
    verificationId: null,
    otp: null,
    phoneNumber: null,
    password: null,
    credential: null,
  );
  AuthenticationState copyWith({
    AuthenticationStatus? status,
    String? error,
    String? verificationId,
    String? otp,
    String? phoneNumber,  
    String? password,
    PhoneAuthCredential? credential,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      error: error ?? this.error,
      verificationId: verificationId ?? this.verificationId,
      otp: otp ?? this.otp,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      credential: credential ?? this.credential,
    );
  }

  @override
  List<Object?> get props => [
    status,
    error,
    verificationId,
    otp,
    phoneNumber,
    password,
    credential,
  ];
}
// class AuthenticationInitial extends AuthenticationState {}

// class SendingOtpLoading extends AuthenticationState {}

// class SendingOtpSuccess extends AuthenticationState {}

// class SendingOtpFailure extends AuthenticationState {
//   final String error;
//   const SendingOtpFailure(this.error);

//   @override
//   List<Object> get props => [error];
// }

// class RegisterUserLoading extends AuthenticationState {}      

// class RegisterUserSuccess extends AuthenticationState {}

// class RegisterUserFailure extends AuthenticationState {
//   final String error;
//   const RegisterUserFailure(this.error);

//   @override
//   List<Object> get props => [error];
// }

// class LoginWithPhoneNumberLoading extends AuthenticationState {}

// class LoginWithPhoneNumberSuccess extends AuthenticationState {}

// class LoginWithPhoneNumberFailure extends AuthenticationState {
//   final String error;
//   const LoginWithPhoneNumberFailure(this.error);

//   @override
//   List<Object> get props => [error];  
// }

// class VerifyOtpLoading extends AuthenticationState {}

// class VerifyOtpSuccess extends AuthenticationState {}

// class VerifyOtpFailure extends AuthenticationState {
//   final String error;
//   const VerifyOtpFailure(this.error);

//   @override
//   List<Object> get props => [error];
// }
