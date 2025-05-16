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
  signInWithGoogleLoading,
  signInWithGoogleSuccess,
  signInWithGoogleFailure,
}

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final String error;
  final String? verificationId;
  final String? otp;
  final String? phoneNumber;
  final PhoneAuthCredential? credential;
  final User? user;
  const AuthenticationState({
    required this.status,
    required this.error,
    required this.verificationId,
    required this.otp,
    required this.phoneNumber,
    required this.credential,
    required this.user,
  });

  static const initial = AuthenticationState(
    status: AuthenticationStatus.initial,
    error: '',
    verificationId: null,
    otp: null,
    phoneNumber: null,
    credential: null,
    user: null,
  );
  AuthenticationState copyWith({
    AuthenticationStatus? status,
    String? error,
    String? verificationId,
    String? otp,
    String? phoneNumber,  
    PhoneAuthCredential? credential,
    User? user,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      error: error ?? this.error,
      verificationId: verificationId ?? this.verificationId,
      otp: otp ?? this.otp,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      credential: credential ?? this.credential,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
    status,
    error,
    verificationId,
    otp,
    phoneNumber,
    credential,
    user,
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
