import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:health_cure/features/authentication/services/authentication_service.dart';
import 'package:logger/logger.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService _authenticationService;
  AuthenticationBloc(this._authenticationService)
    : super(AuthenticationState.initial) {
    on<LoginWithPhoneNumberEvent>(_onLoginWithPhoneNumberEvent);
    on<VerifyOtpEvent>(_onVerifyOtpEventHandler);
    on<RegisterUserEvent>(_onRegisterUserEvent);
  }

  void _onLoginWithPhoneNumberEvent(
    LoginWithPhoneNumberEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(status: AuthenticationStatus.loginWithPhoneNumberLoading));
    try {
      final userExists = await _authenticationService.checkIfUserExists(
        phoneNumber: event.phoneNumber,
      );
      Logger().d(userExists);
      Logger().d(event.phoneNumber);
      if (userExists) {
        final user = await _authenticationService
            .signInUserWithPhoneNumberAndPassword(
              phoneNumber: event.phoneNumber,
              password: event.password,
            );
        if (user != null) {
          emit(state.copyWith(status: AuthenticationStatus.loginWithPhoneNumberSuccess));
        } else {
          emit(state.copyWith(status: AuthenticationStatus.loginWithPhoneNumberFailure, error: 'User not found'));
        }
      }else{
        // emit(state.copyWith(status: AuthenticationStatus.isNewUser));
        add(RegisterUserEvent(phoneNumber: event.phoneNumber, password: event.password));
      }
    } catch (e) {
      emit(state.copyWith(status: AuthenticationStatus.loginWithPhoneNumberFailure, error: e.toString()));
    }
  }

  FutureOr<void> _onRegisterUserEvent(
    RegisterUserEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(status: AuthenticationStatus.registerUserLoading));
    try {
      final result = await _authenticationService.sendOtpToPhoneNumber(
        phoneNumber: event.phoneNumber,
      );
      if (result.verificationId != null) {
        emit(state.copyWith(
          status: AuthenticationStatus.sendingOtpSuccess,
          verificationId: result.verificationId,
          credential: result.credential,
          phoneNumber: event.phoneNumber,
          password: event.password,
        ));
      } else if (result.credential == null) {
        emit(state.copyWith(status: AuthenticationStatus.sendingOtpFailure));
        // Handle auto-verification case
       
      // final user =   await _authenticationService.signInWithCredential(credential: result.credential!);
        
      //   if (user != null) {
      //     emit(state.copyWith(status: AuthenticationStatus.registerUserSuccess));
      //   } else {
      //     emit(state.copyWith(
      //       status: AuthenticationStatus.registerUserFailure,
      //       error: 'User not found',
      //     ));
      //   }
      } else if (result.error != null) {
        emit(state.copyWith(
          status: AuthenticationStatus.sendingOtpFailure,
          error: result.error.toString(),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: AuthenticationStatus.registerUserFailure,
        error: e.toString(),
      ));
    }
  }
  FutureOr<void> _onVerifyOtpEventHandler(
    VerifyOtpEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(status: AuthenticationStatus.otpVerificationLoading));
    final authResult = await _authenticationService.verifyOtp(
      verificationId: event.verificationId,
      otp: event.otp,
    );
    if (authResult != null) {
      await _authenticationService.signInWithCredential(credential: event.credential!);
        final user = await _authenticationService.createUser(
          phoneNumber: authResult.phoneNumber!,
          password: event.password!,
        );
        if(user != null){
          emit(state.copyWith(status: AuthenticationStatus.otpVerified));
        }else{
          emit(state.copyWith(status: AuthenticationStatus.otpVerificationFailure, error: 'OTP code is invalid'));
        }
    } else {
      emit(state.copyWith(status: AuthenticationStatus.otpVerificationFailure, error: 'OTP code is invalid'));
    }
  }
}
