// ignore_for_file: avoid_print

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_project_ver_1/core/common/continue_info.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/presintation/pages/trainer_dashboard.dart';

// ignore: must_be_immutable
class EmailVerificationPage extends StatefulWidget {
  String role;
  EmailVerificationPage({super.key, required this.role});

  @override
  State<EmailVerificationPage> createState() =>
      _EmailVerificationPageState();
}

class _EmailVerificationPageState
    extends State<EmailVerificationPage> {
  bool isVerified = false;
  Timer? _timer;
  // this method to refresh after verify the email ,
  //  ,Note that i have a timer that its 10 seconds and that means
  // even if you verify the mail in the second 1 , you will wait for 9 seconds to see the ok button
 void _startEmailCheck() {
  _timer = Timer.periodic(const Duration(seconds: 20), (timer) async {
    try {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && user.emailVerified) {
        setState(() {
          isVerified = true;
        });
        timer.cancel(); // Stop checking once verified
      }
    } catch (e) {
      print('Email check failed: $e');
      // Next 20 seconds later it will automatically retry.
    }
  });
}


  @override
  void initState() {
    super.initState();
    _startEmailCheck();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _navigateToDashboard() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if(widget.role=="Trainer"){Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => TrainerDashboardPage(trainerId: user.uid,),));}
     else {Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) => ContinueInfo(
                role: widget.role,
                userId: user.uid,
                email: user.email.toString(),
              ),
        ),
      );}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Email Verification")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.email, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              "We have sent a verification link to your email./n please confirm email and then press OK",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            isVerified
                ? ElevatedButton(
                  onPressed: _navigateToDashboard,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 14,
                    ),
                  ),
                  child: Text(
                    "OK",
                    style: const TextStyle(fontSize: 16),
                  ),
                )
                : Text("waiting for verification"),
          ],
        ),
      ),
    );
  }
}

/**
 import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_project_ver_1/features/auth/presintation/pages/auth_choice_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/pages/center_dashboard_page.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  Timer? _timer;
  bool isVerified = false;
  bool showCheckMessage = false;

  @override
  void initState() {
    super.initState();
    _startCheckingEmailVerification();
  }

  void _startCheckingEmailVerification() {
    _timer = Timer.periodic(const Duration(seconds: 20), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;

      if (user != null && user.emailVerified) {
        timer.cancel();
        setState(() {
          isVerified = true;
        });

        // Navigate to dashboard
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => CenterDashboard(centerId: user.uid),
          ),
        );
      } else {
        setState(() {
          showCheckMessage = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Email Verification")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.email, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              "We’ve sent a verification link to your email.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),

            // Show this if still not verified
            if (showCheckMessage)
              const Text(
                "Please confirm your email to continue...",
                style: TextStyle(color: Colors.red),
              ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.currentUser?.sendEmailVerification();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Verification email re-sent")),
                );
              },
              child: const Text("Resend Verification Email"),
            ),

            const SizedBox(height: 10),

            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const AuthChoicePage()),
                );
              },
              child: const Text("Back to login"),
            ),
          ],
        ),
      ),
    );
  }
}


 */