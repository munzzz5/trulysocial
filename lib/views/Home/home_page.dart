import 'package:flutter/material.dart';
import 'package:trulysocial/enums/menu_action.dart';
import 'package:trulysocial/services/auth/auth_service.dart';
import 'package:trulysocial/services/auth/firebase_auth_provider.dart';
import 'package:trulysocial/services/cloud/cloud_social_work.dart';
import 'package:trulysocial/services/cloud/firebase_cloud_storage.dart';
import 'package:trulysocial/utils/constants/routes.dart';
import 'package:trulysocial/utils/dialogs/error_dialog.dart';
import 'package:trulysocial/utils/dialogs/logout_dialog.dart';
import 'package:trulysocial/views/socialWork/social_work_list_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final FirebaseCloudStorage _firebaseCloudStorage;
  @override
  void initState() {
    _firebaseCloudStorage = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  createSocialWorkRoute,
                );
              },
              icon: const Icon(Icons.add)),
          PopupMenuButton(itemBuilder: (context) {
            return const [
              PopupMenuItem<MenuAction>(
                  value: MenuAction.logout, child: Text("Logout"))
            ];
          }, onSelected: (value) async {
            switch (value) {
              case MenuAction.logout:
                if (await showLogoutDialog(context)) {
                  try {
                    await AuthService.firebase().logOut();

                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
                      (Route<dynamic> route) => false,
                    );
                  } catch (e) {
                    showErrorDialog(context, e.toString());
                  }
                }
                break;
              default:
                break;
            }
          }),
        ],
      ),
      body: StreamBuilder(
          stream: _firebaseCloudStorage.allSocialWorks(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                if (snapshot.hasData) {
                  final allWorks = snapshot.data as Iterable<SocialWork>;
                  return SocialWorkListView(
                      works: allWorks,
                      onTap: (work) {
                        Navigator.of(context).pushNamed(
                          createSocialWorkRoute,
                          arguments: work,
                        );
                      });
                } else {
                  return Center(
                    child: Column(
                      children: const <Widget>[
                        Text(
                          "No Works around you, Add one now!",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  );
                }

              case ConnectionState.waiting:
                return Column(
                  children: const [
                    Text("Loading..."),
                    CircularProgressIndicator(),
                  ],
                );
              default:
                return const CircularProgressIndicator();
            }
          }),
    );
  }
}
