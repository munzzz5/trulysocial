import 'package:flutter/material.dart';
import 'package:trulysocial/services/auth/auth_exceptions.dart';
import 'package:trulysocial/services/auth/auth_service.dart';
import 'package:trulysocial/utils/constants/routes.dart';
import 'package:trulysocial/utils/dialogs/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _name;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _name = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up Now!")),
      body: Column(
        children: [
          TextField(
            controller: _name,
            decoration: const InputDecoration(hintText: "Enter Your Name"),
            enableSuggestions: false,
            autocorrect: false,
          ),
          const Padding(padding: EdgeInsets.all(10)),
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "Enter Email"),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: "Enter Password"),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          ElevatedButton(
            onPressed: () async {
              String name = _name.text;
              String email = _email.text.toLowerCase().replaceAll(" ", "");
              String password = _password.text;
              try {
                await AuthService.firebase()
                    .signUp(email: email, password: password, name: name);
                await AuthService.firebase().sendEmailVerification();
                Navigator.of(context).pushNamed(verifyRoute);
              } on EmailUsedAuthException {
                await showErrorDialog(context, "Email is already used");
              } on WeakPasswordAuthException {
                await showErrorDialog(context, "Password is too weak");
              } on InvalidEmailAuthException {
                await showErrorDialog(context, "Invalid Email address");
              } on GenericAuthException {
                await showErrorDialog(context, "Error: Authentication Error");
              }
            },
            child: const Text("Sign Up!"),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
              child: const Text("Go to Login"))
        ],
      ),
    );
  }
}
