import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

// ignore: must_be_immutable
class PhoneDeneme extends StatelessWidget {
  PhoneDeneme({super.key});

  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                  label: Text('insert phone number'),
                  prefixIcon: Icon(Icons.numbers)),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      authController.phoneAuthentication(_controller.text);
                    }
                  },
                  child: Text('SIGNED')),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  
                }, 
                child: const Text('ben yazdim, gelen smsi veriyom')),
            )
          ],
        ),
      ),
    );
  }
}
