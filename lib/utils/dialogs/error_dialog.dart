import 'package:flutter/widgets.dart';
import 'package:trulysocial/utils/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(BuildContext context, String text) {
  return showGenericDialog(
      context: context,
      title: "An Error Occured",
      content: text,
      optionsBuilder: () => {"Ok": null});
}
