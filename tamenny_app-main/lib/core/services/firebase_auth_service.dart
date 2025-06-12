import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:tamenny_app/core/errors/custom_exception.dart';

class FirebaseAuthService {
  Future<bool> checkPassword(String enteredPassword) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return false; // No user is logged in.
    }

    try {
      // Reauthenticate the user with their current password
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: enteredPassword,
      );

      // Sign in with the credentials to verify the password
      await user.reauthenticateWithCredential(credential);
      return true; // Password is correct
    } catch (e) {
      return false; // Password is incorrect or reauthentication failed
    }
  }

  Future forgotPassword({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future deleteUser() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }

  Future<User> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log("Exception in FirebaseAuthService.createUserWithEmailAndPassword: ${e.toString()} and code is ${e.code}");
      if (e.code == 'weak-password') {
        throw CustomException(message: 'The password is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(
            message: 'This email is already registered. Please sign in.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(
            message: 'Please check your internet connection.');
      } else {
        throw CustomException(
            message: 'Something went wrong. Please try again.');
      }
    } catch (e) {
      log("Exception in FirebaseAuthService.createUserWithEmailAndPassword: ${e.toString()}");

      throw CustomException(message: 'Something went wrong. Please try again.');
    }
  }

  Future<User> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log("Exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()} and code is ${e.code}");
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        throw CustomException(message: 'Incorrect email or password.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(
            message: 'Please check your internet connection.');
      } else {
        throw CustomException(
            message: 'Something went wrong. Please try again.');
      }
    } catch (e) {
      log("Exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()}");

      throw CustomException(message: 'Something went wrong. Please try again.');
    }
  }

  Future<User> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        throw CustomException(message: 'Google Sign-In was cancelled.');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        throw CustomException(message: 'Failed to get Google credentials.');
      }

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user == null) {
        throw CustomException(message: 'Failed to sign in with Google.');
      }

      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      log("Exception in FirebaseAuthService.signInWithGoogle: ${e.toString()} and code is ${e.code}");
      if (e.code == 'account-exists-with-different-credential') {
        throw CustomException(
            message: 'An account already exists with the same email address.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(
            message: 'Please check your internet connection.');
      } else {
        throw CustomException(
            message: 'Failed to sign in with Google. Please try again.');
      }
    } catch (e) {
      log("Exception in FirebaseAuthService.signInWithGoogle: ${e.toString()}");
      if (e is CustomException) {
        rethrow;
      }
      throw CustomException(
          message: 'Failed to sign in with Google. Please try again.');
    }
  }

  Future<User> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    // Once signed in, return the UserCredential
    return (await FirebaseAuth.instance.signInWithCredential(
      facebookAuthCredential,
    ))
        .user!;
  }

  bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }
}
