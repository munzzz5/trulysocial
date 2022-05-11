import 'package:flutter/material.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
              "We have already send a verification! Please check your email."),
          const Padding(padding: EdgeInsets.all(20)),
          ElevatedButton(
              onPressed: () {}, child: const Text("Re send Verification"))
        ],
      ),
    );
  }
}
