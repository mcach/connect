import 'dart:async';

import 'package:connect/functions/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/appbar.dart';
import '../../constants.dart';
import '../../functions/alerts.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  bool isEmailVerified = false;
  Timer? timer;
  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    timer = Timer.periodic(
      const Duration(
        seconds: 3,
      ),
      (timer) {
        verifyEmail(timer, context);
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Widget drawVerificationNotSent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () async {
            try {
              await FirebaseAuth.instance.currentUser!.sendEmailVerification();
              showErrorSnackBar(resendVerification, context);
            } on FirebaseAuthException catch (e) {
              String errorMessage = defaultError;

              if (e.code == 'too-many-requests') {
                errorMessage = frequentRequestError;
              }
              showErrorSnackBar(errorMessage, context);
            }
          },
          child: const Text(
            verificationNotSent,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: drawAppBar(verificationTitle),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                const Text(
                  verificationMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 25),
                drawVerificationNotSent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
