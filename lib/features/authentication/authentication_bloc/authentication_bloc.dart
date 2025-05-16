import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:health_cure/core/database/local_storage.dart';
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
    on<SignInWithGoogleEvent>(_onSignInWithGoogleEvent);
  }

  void _onLoginWithPhoneNumberEvent(
    LoginWithPhoneNumberEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(
      state.copyWith(status: AuthenticationStatus.loginWithPhoneNumberLoading),
    );
    try {
      emit(state.copyWith(status: AuthenticationStatus.sendingOtpLoading));
      final result = await _authenticationService.sendOtpToPhoneNumber(
        phoneNumber: event.phoneNumber,
      );
      if (result.verificationId != null) {
        emit(state.copyWith(
          status: AuthenticationStatus.sendingOtpSuccess,
          verificationId: result.verificationId,
          credential: result.credential,
          phoneNumber: event.phoneNumber
        ));
      } else {
        emit(state.copyWith(status: AuthenticationStatus.sendingOtpFailure));
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthenticationStatus.loginWithPhoneNumberFailure,
          error: e.toString(),
        ),
      );
    }
  }

  FutureOr<void> _onVerifyOtpEventHandler(
    VerifyOtpEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(status: AuthenticationStatus.otpVerificationLoading));
    try {
      final authResult = await _authenticationService.verifyOtp(
        verificationId: event.verificationId,
        otp: event.otp,
      );
      if (authResult != null) {
        await _authenticationService.signInWithCredential(
          credential: event.credential!,
        );
        emit(state.copyWith(status: AuthenticationStatus.otpVerified));
      } else {
        emit(
          state.copyWith(
            status: AuthenticationStatus.otpVerificationFailure,
            error: 'OTP code is invalid',
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      Logger().e(e.code);
      emit(
        state.copyWith(
          status: AuthenticationStatus.otpVerificationFailure,
          error: e.message,
        ),
      );
    } catch (e) {
      Logger().e(e);
      emit(
        state.copyWith(
          status: AuthenticationStatus.otpVerificationFailure,
          error: e.toString(),
        ),
      );
    }
  }

  FutureOr<void> _onSignInWithGoogleEvent(
    SignInWithGoogleEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(status: AuthenticationStatus.signInWithGoogleLoading));
    try {
      final user = await _authenticationService.signInWithGoogle();
      if (user != null) {
        emit(state.copyWith(
          status: AuthenticationStatus.signInWithGoogleSuccess,
          user: user
        ));
        LocalStorage.instance.setBool('user_logged_in', true);
      } else {
        emit(state.copyWith(
          status: AuthenticationStatus.signInWithGoogleFailure,
          error: 'User not found'
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: AuthenticationStatus.signInWithGoogleFailure,
        error: e.toString()
      ));
    }
  }
}
