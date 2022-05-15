import 'package:flutter/material.dart';

class CreateSocialWorkView extends StatefulWidget {
  const CreateSocialWorkView({Key? key}) : super(key: key);

  @override
  State<CreateSocialWorkView> createState() => _CreateSocialWorkViewState();
}

class _CreateSocialWorkViewState extends State<CreateSocialWorkView> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.topCenter,
      widthFactor: 0.5,
      heightFactor: 0.5,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
