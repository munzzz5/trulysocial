import 'package:flutter/material.dart';
import 'package:trulysocial/services/auth/auth_exceptions.dart';
import 'package:trulysocial/services/auth/auth_service.dart';
import 'package:trulysocial/utils/constants/routes.dart';
import 'package:trulysocial/utils/dialogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Truly Social Login")),
      body: Column(
        children: [
          TextField(
            controller: _email,
            decoration: const InputDecoration(hintText: "Enter Your Email"),
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
          ),
          const Padding(
            padding: EdgeInsets.all(10),
          ),
          TextField(
            controller: _password,
            decoration: const InputDecoration(hintText: "Enter Your Password"),
            enableSuggestions: false,
            obscureText: true,
            autocorrect: false,
          ),
          const Padding(
            padding: EdgeInsets.all(10),
          ),
          ElevatedButton(
            onPressed: () async {
              String email = _email.text;
              String password = _password.text;
              try {
                await AuthService.firebase()
                    .logIn(email: email, password: password);
                final user = AuthService.firebase().currentUser;
                if (user!.isEmailVerified) {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(homePageRoute, (route) => false);
                } else {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(verifyRoute, (route) => false);
                }
              } on UserNotFoundAuthException {
                await showErrorDialog(context, "User Not Found");
              } on WrongPasswordAuthException {
                await showErrorDialog(context, "Wrong Password");
              } on GenericAuthException {
                await showErrorDialog(context, "Error: Authentication Error");
              }
            },
            child: const Text("Login"),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(registerRoute, (route) => false);
              },
              child: const Text("Go to Register")),
        ],
      ),
    );
  }
}
