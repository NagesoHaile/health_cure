import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_cure/features/authentication/models/user_model.dart';
import 'dart:async';

import 'package:logger/logger.dart';

class PhoneAuthResult {
  final String? verificationId;
  final PhoneAuthCredential? credential;
  final FirebaseAuthException? error;

  PhoneAuthResult({
    this.verificationId,
    this.credential,
    this.error,
  });
}

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Login with phone number
  Future<PhoneAuthResult> sendOtpToPhoneNumber({
    required String phoneNumber,
  }) async {
    try {
      Completer<PhoneAuthResult> completer = Completer();
      
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          if (!completer.isCompleted) {
            completer.complete(PhoneAuthResult(credential: credential));
          }
        },
        verificationFailed: (FirebaseAuthException error) {
          if (!completer.isCompleted) {
            completer.complete(PhoneAuthResult(error: error));
          }
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          if (!completer.isCompleted) {
            completer.complete(PhoneAuthResult(verificationId: verificationId));
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          if (!completer.isCompleted) {
            completer.complete(PhoneAuthResult(
              verificationId: verificationId,
              error: FirebaseAuthException(
                code: 'timeout',
                message: 'OTP code retrieval timed out',
              ),
            ));
          }
        },
      );

      return await completer.future;
    } catch (e) {
      Logger().e(e);
      throw Exception(e);
    }
  }

  // verify otp
  Future<User?> verifyOtp({
    required String verificationId,
    required String otp,
  }) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      return userCredential.user;
    } catch (e) {
      Logger().e(e);
      throw Exception(e);
    }
  }

  /// sign in user with phone number and password
  Future<UserModel?> signInUserWithPhoneNumberAndPassword({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final user = await getUser(phoneNumber: phoneNumber);
      if (user?.password != password) {
        throw Exception('Invalid password');
      }
      return user;
    } catch (e) {
      Logger().e(e);
      throw Exception(e);
    }
  }

  /// check if user exists in database
  Future<bool> checkIfUserExists({required String phoneNumber}) async {
    final querySnapshot =
        await _firestore
            .collection('users')
            .where('phone ', isEqualTo: phoneNumber)
            .get();
    return querySnapshot.docs.isNotEmpty;
  }

  /// create user in database
  Future<User?> createUser({
    required String phoneNumber,
    required String password,
  }) async {
    final User? user = _auth.currentUser;
    await _firestore.collection('users').doc(user?.uid).set({
      'phone ': phoneNumber,
      'password': password,
    });
    return user;
  }

  /// get user from database
  Future<UserModel?> getUser({required String phoneNumber}) async {
    final querySnapshot =
        await _firestore
            .collection('users')
            .where('phone ', isEqualTo: phoneNumber)
            .get();
    if (querySnapshot.docs.isNotEmpty) {
      Logger().d(querySnapshot.docs.first.data());
      final user = UserModel.fromJson(querySnapshot.docs.first.data());

      return user;
    }
    return null;
  }

  // check if user is logged in
  Future<bool> checkIfUserIsLoggedIn() async {
    final User? user = _auth.currentUser;
    return user != null;
  }

  // SIGNIN WITH CREDENTIAL
  Future<User?> signInWithCredential({
    required PhoneAuthCredential credential,
  }) async {
    final UserCredential userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user;
  }

  /// sign out user
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
