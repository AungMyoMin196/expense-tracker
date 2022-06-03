import 'package:flutter/material.dart';

class UnknownError extends StatelessWidget {
  const UnknownError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/3_Something Went Wrong.png',
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
