import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FacebookAuth facebookAuth = FacebookAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  final RxBool _isSignedIn = false.obs;
  RxBool get isSignedIn => _isSignedIn;

  final RxBool _hasError = false.obs;
  RxBool get hasError => _hasError;

  RxString? _errorCode;
  RxString? get errorCode => _errorCode;

  RxString? _provider;
  RxString? get provider => _provider;

  RxString? _uid;
  RxString? get uid => _uid;

  RxString? _name;
  RxString? get name => _name;

  RxString? _email;
  RxString? get email => _email;

  RxString? _imgUrl;
  RxString? get imgUrl => _imgUrl;

  Future<void> checkUserSignOrNot() async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    _isSignedIn.value = storage.getBool('signedIn') ?? false;
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      try {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        final User userDetails =
            (await firebaseAuth.signInWithCredential(credential)).user!;

        if (userDetails.displayName != null) {
          _name = RxString(userDetails.displayName!);
        }
        if (userDetails.email != null) {
          _name = RxString(userDetails.email!);
        }
        if (userDetails.photoURL != null) {
          _name = RxString(userDetails.photoURL!);
        }
        _name = RxString(userDetails.uid);
        _provider!.value = 'GOOGLE';
        update();
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'account-exists-different-credential':
            _errorCode!.value = 'You already have an account with us';
            _hasError.value = true;
            update();
            break;
          case 'null':
            _errorCode!.value = 'some unexpected error while trying to sign in';
            _hasError.value = true;
            update();
            break;
          default:
            _errorCode = RxString(e.toString());
            _hasError.value = true;
            update();
        }
        log(e.toString());
      }
    } else {
      _hasError.value = true;
      update();
    }
  }

  Future<bool> userExist() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(_uid!.value)
        .get();
    if (snap.exists) {
      log('user exist');
      return true;
    } else {
      log('new user');
      return false;
    }
  }

  Future<void> signOut() async {
    await googleSignIn.signOut();
    await firebaseAuth.signOut();
    _isSignedIn.value = false;
    update();
    clearStorageDatas();
  }

  Future<void> clearStorageDatas() async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    storage.clear();
  }
}
