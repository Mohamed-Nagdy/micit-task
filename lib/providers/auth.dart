import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../presentation/screens/users/screens/users_list.dart';
import '../presentation/utils/toast_utils.dart';

class AuthNotifier extends StateNotifier<User?> with ToastUtils {
  AuthNotifier() : super(null);

  void initUser(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      state = user;
      if (state != null) {
        context.goNamed(UsersList.routeName);
      }
    });
  }

  Future<bool> googleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    state = userCredential.user;
    if (state != null) {
      return true;
    }
    showToast(message: 'Error Login with google', toastType: ToastType.error);
    return false;
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  return AuthNotifier();
});
