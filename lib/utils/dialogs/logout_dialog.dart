import 'package:flutter/widgets.dart';
import 'package:trulysocial/utils/dialogs/generic_dialog.dart';

Future<bool> showLogoutDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: "Logout",
    content: "Are you sure you want to logout?",
    optionsBuilder: () => {"Yes": 1, "No": 0},
  ).then((value) => value ?? false);
}
