import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxBool isLoading = false.obs;
  var text = 'sent mail'.obs;

  var verificationId = ''.obs;

  Future<User?> signIn(String mail, String password) async {
    var user =
        await _auth.signInWithEmailAndPassword(email: mail, password: password);

    return user.user;
  }

  signOut() async {
    return await _auth.signOut();
  }

  Future<User?> resetPassword(String mail) async {
    isLoading.value = true;

    try {
      await Future.delayed(const Duration(seconds: 3));
      await _auth.sendPasswordResetEmail(email: mail);
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e);
    }
    isLoading.value = false;
    return null;
  }

  Future<void> phoneAuthentication(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          if (e.code == 'invalid-phone-number') {
            Get.snackbar('Error',
                'the provided phone number is not valid (bunu ben yazdim)');
          } else {
            Get.snackbar(
                'Error', 'Something went wrong. Try again(bunu da ben yazdim)');
          }
        },
        codeSent: (verificationId, resendToken) {
          this.verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: ((verificationId) {
          this.verificationId.value = verificationId;
        }));
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
  }

  Future<User?> checkEmail(String mail) async {
    await _auth.fetchSignInMethodsForEmail(mail);
    return null;
  }

  Future<User?> createPerson(String name, String mail, String password) async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 3));

    var user = await _auth.createUserWithEmailAndPassword(
        email: mail, password: password);

    isLoading.value = false;

    await _firestore.collection(
        //here i am creating a new collection, at the same time i am adding data to firestrore
        'person').doc(user.user!.uid).set({
      'userName': name,
      'email': mail,
    });
    return user.user;
  }
}




