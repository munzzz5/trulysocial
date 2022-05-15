import 'package:flutter/material.dart';
import 'package:trulysocial/services/auth/auth_service.dart';
import 'package:trulysocial/utils/constants/routes.dart';
import 'package:trulysocial/views/Home/home_page.dart';
import 'package:trulysocial/views/login_view.dart';
import 'package:trulysocial/views/register_view.dart';
import 'package:trulysocial/views/socialWork/create_update_social_work.dart';
import 'package:trulysocial/views/verify_email_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        verifyRoute: (context) => const VerifyEmailView(),
        registerRoute: (context) => const RegisterView(),
        loginRoute: (context) => const LoginView(),
        homePageRoute: (context) => const HomePage(),
        createSocialWorkRoute: (context) => const CreateSocialWorkView(),
      },
      home: const InitialPage(),
    );
  }
}

class InitialPage extends StatelessWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: ((context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null && user.isEmailVerified) {
              return const HomePage();
            } else if (user != null && !user.isEmailVerified) {
              return const VerifyEmailView();
            } else {
              return const LoginView();
            }
          default:
            return const Center(child: CircularProgressIndicator());
        }
      }),
      future: AuthService.firebase().initialize(),
    );
  }
}
