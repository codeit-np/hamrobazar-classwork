import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/route_manager.dart';

import 'package:hamrobazar/views/home.dart';

import '../controller/auth.dart';
import '../service/authentication.dart';
import '../util/input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obsecure = true;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: key,
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FlutterLogo(
                      size: 80,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: AppInput.email,
                      validator: (value) => value!.isEmpty ? 'required' : null,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: 'Email address'),
                    ),
                    TextFormField(
                      controller: AppInput.password,
                      validator: (value) => value!.isEmpty ? 'required' : null,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        hintText: 'Password',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            obsecure = !obsecure;
                            setState(() {});
                          },
                          child: obsecure == true
                              ? const Icon(
                                  Icons.visibility_off,
                                )
                              : const Icon(
                                  Icons.visibility,
                                ),
                        ),
                      ),
                      obscureText: obsecure,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text("Forgot Password"),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: FilledButton(
                                onPressed: () async {
                                  if (key.currentState!.validate()) {
                                    Map data = {
                                      "email": AppInput.email.text,
                                      "password": AppInput.password.text
                                    };
                                    Loader.show(context,
                                        progressIndicator:
                                            const CircularProgressIndicator());
                                    await AuthService.login(data);
                                    await AuthController.getUserDetail();
                                    Loader.hide();
                                  }
                                },
                                child: const Text("LOGIN"))),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Are you new? Register"),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  right: 16,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: TextButton(
                      onPressed: () {
                        Get.offAll(() => const HomeView());
                      },
                      child: const Text("SKIP NOW"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
