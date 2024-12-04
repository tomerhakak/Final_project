import 'package:CheckIt/Services/DatabaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxBool loading = false.obs;
  RxBool isLoggedIn = false.obs;
  RxMap<String, dynamic> data = RxMap<String, dynamic>();
  RxString uid = ''.obs;

  UserController() {
    _auth.authStateChanges().listen((User? user) async {
      if (user == null) {
        isLoggedIn.value = false;
        data.value = {};
        Get.offNamed('/login');
      } else {
        uid.value = user.uid;
        var userData = await DatabaseService.fetchUserData(uid.value);
        isLoggedIn.value = true;
        if (userData != null) {
          data.value = userData;
        } else {
          await DatabaseService.updateUserData(uid.value, data.value);
        }
        Get.offNamed('/home');
      }
    });
  }

  Future<UserCredential?> signInWithGoogle(Map<String, dynamic>? data) async {
    loading.value = true;

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      loading.value = false;
      return null;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      if (data != null) {
        await DatabaseService.updateUserData(uid.value, data);
        this.data.value = data;
      }

      loading.value = false;
      Get.offNamed('/home');
      return userCredential;
    } catch (e) {
      loading.value = false;
      Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.BOTTOM);
      return null;
    }
  }

  void createUserWithEmailAndPassword(
      String email, String password, Map<String, dynamic> data) async {
    loading.value = true;

    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await DatabaseService.updateUserData(uid.value, data);
      this.data.value = data;
      loading.value = false;
      Get.offNamed('/home');
    } on FirebaseAuthException catch (e) {
      loading.value = false;
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
            msg: 'The password provided is too weak.',
            gravity: ToastGravity.BOTTOM);
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: 'The account already exists for that email.',
            gravity: ToastGravity.BOTTOM);
      } else if (e.code == 'invalid-email') {
        Fluttertoast.showToast(
            msg: "The email is badly formatted.", gravity: ToastGravity.BOTTOM);
      } else {
        Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.BOTTOM);
      }
    } catch (e) {
      loading.value = false;
      Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.BOTTOM);
    }
  }

  void signInWithPassword(String email, String password) async {
    loading.value = true;
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);

      loading.value = false;
    } on FirebaseAuthException catch (e) {
      loading.value = false;
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: "No user found for that email.", gravity: ToastGravity.BOTTOM);
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: "Wrong password provided for that user.",
            gravity: ToastGravity.BOTTOM);
      } else if (e.code == 'invalid-email') {
        Fluttertoast.showToast(
            msg: "The email is badly formatted.", gravity: ToastGravity.BOTTOM);
      } else {
        Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.BOTTOM);
      }
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(
          msg: "נשלח לך אימייל עם הוראות לשחזור סיסמה.",
          gravity: ToastGravity.BOTTOM);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: "לא נמצא משתמש עם האימייל הזה.", gravity: ToastGravity.BOTTOM);
      } else {
        Fluttertoast.showToast(
            msg: "שגיאה בשחזור הסיסמה: ${e.message}",
            gravity: ToastGravity.BOTTOM);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "שגיאה בשחזור הסיסמה: ${e.toString()}",
          gravity: ToastGravity.BOTTOM);
    }
  }
}
