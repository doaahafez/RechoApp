import 'package:flutter/material.dart';
import 'package:recho/routs/HomePage.dart';
import 'package:recho/routs/WalletScreen.dart';
import 'package:recho/routs/ProfileForm.dart';
import 'package:recho/routs/MyProfile.dart';
import 'package:recho/routs/Register.dart';
import 'package:recho/routs/login.dart';

import 'CallLogScreen.dart';
import 'dart:async';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startTimer();
  }

  double _progressValue = 0.0;
    late Timer _timer;
    final int _duration = 3;

    void _startTimer() {
      const interval = Duration(milliseconds: 100);
      final int totalTicks = _duration * 10;
      int ticks = 0;

      _timer = Timer.periodic(interval, (Timer timer) {
        setState(() {
          if (ticks >= totalTicks) {
            _progressValue = 1.0;
            _timer.cancel();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
          } else {
            _progressValue = ticks / totalTicks;
            ticks++;
          }
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo or Image
              Image.asset(
                'assets/logo-preview.png', // Replace with your logo path
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 20),
              // App Name or Slogan
              Text(
                'مرحبًا بك في تطبيق Recho', // Replace with your text
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,

                ),
                textAlign: TextAlign.center,
              ),
             //  const SizedBox(height: 20),
             // Stack(
             //   children: [
             //     Center(
             //       child:
             //       CircularProgressIndicator(
             //         value: _progressValue,
             //         strokeWidth: 6.0,
             //         backgroundColor: Colors.grey[200],
             //         color: Colors.blue[500],
             //       ),
             //     ),
             //     // Center(
             //     //   child: Text("recho",
             //     //       style: const TextStyle(
             //     //         fontSize: 24,
             //     //         fontWeight: FontWeight.bold,
             //     //         color: Colors.white,
             //     //       )
             //     //   ),
             //     //
             //     // )
             //   ],
             // )
            ],
    )
    )
      )
    );
  }
}
// MaterialButton(
//   color: Colors.white,
//   textColor: Colors.blue,
//   onPressed: () {
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => RegisterScreen()));
//   },
//   child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 30.0),
//       child: Text(
//         "انشاء حساب جديد",
//         style: TextStyle(fontSize: 20),
//       )),
// ),
