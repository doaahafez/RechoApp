import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recho/routs/HomePage.dart';
import 'package:recho/routs/Register.dart';
import 'package:recho/widgets/Header_With_Gradient.dart';
import 'package:recho/widgets/Text_Field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

  class _LoginState extends State<Login> {

    final _formKey = GlobalKey<FormState>();
    final TextEditingController _phoneController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final List<String> sentences = [
  "مرحباً بك في تطبيق Recho",
  "اطلب طعامك المفضل بضغطة زر",
  "توصيل سريع لجميع المناطق",
  ];
    final List<List<Color>> gradients = [
  [Colors.green, Colors.blue],
  [Colors.orange, Colors.red],
  [Colors.purple, Colors.pink],
  ];
    int currentIndex = 0;
    late Timer _timer;

    Future<void> _login(String phoneNumber,String password) async {
      if (_formKey.currentState!.validate()) {
        try {
          String email = '$phoneNumber@recho.com';
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } catch (e) {
          print(e);
        }
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تأكد من إدخال جميع الحقول بشكل صحيح')),
        );
      }
    }
  @override
  void initState() {
  super.initState();
  _startTimer();
  }
  void _startTimer() {
  _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
  setState(() {
  currentIndex = (currentIndex + 1) % sentences.length;
  });
  });
  }

  @override
  void dispose() {
  _timer.cancel();
  super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const SizedBox(height: 20),
                const Text(
                  'Recho',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 10),
                HeaderWithGradient(
                  text: sentences[currentIndex],
                  gradientColors: gradients[currentIndex],
                ),
                const SizedBox(height: 30),
                // Login form can go here
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 5,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildTextField(
                          label: 'رقم الجوال',
                          hintText: 'أدخل رقم الجوال',
                          controller: _phoneController,
                          validator: (value) {
                            if (value == null || value.length !< 10) {
                              return 'رقم الجوال غير صحيح';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        buildTextField(
                          label: 'كلمة المرور',
                          hintText: 'أدخل كلمة المرور',
                          obscureText: true,
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.length < 8) {
                              return "كلمة المرور غير صحيحة";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                             _login(_phoneController.text, _passwordController.text);
                              },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const RegisterScreen()),
                            );
                          },
                          child: const Text(
                            'ليس لديك حساب؟ انشاء حساب',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,

                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}



