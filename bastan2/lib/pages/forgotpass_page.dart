import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/auth_controller.dart';
import '../controllers/regist_controller.dart';

// ignore: must_be_immutable
class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final _forgotPasswordController = TextEditingController();
  RegisterController controller = Get.put(RegisterController());
  AuthController authController = Get.put(AuthController());

  // Step 1: Declare a RxBool variable to control visibility
  // final RxBool isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'reset your password via mail',
              style: TextStyle(
                fontSize: 28,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextFormField(
              style: const TextStyle(fontSize: 25),
              controller: _forgotPasswordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            width: 200,
            child: Obx(() {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                onPressed: () {
                  authController.isLoading.value = true;

                  if (_forgotPasswordController.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                              title: Text('please insert an email'),
                              content: Text('I cannot read any address'),
                            )).whenComplete(() {
                      authController.isLoading.value = false;
                    });
                  } else {
                    AuthController()
                        .resetPassword(_forgotPasswordController.text)
                        .then((value) {
                      Navigator.pushNamed(context, '/login');
                    }).whenComplete(() {
                      authController.isLoading.value = false;
                    });
                  }
                },
                child: authController.isLoading.value
                    ? const CircularProgressIndicator() // Show CircularProgressIndicator when isLoading is true
                    : Text(authController.text.toString(),
                        style: const TextStyle(
                            fontSize: 27, color: Colors.black87)),
              );
            }),
          ),
        ],
      ),
    );
  }
}
