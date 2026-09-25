import 'package:flutter/material.dart';

class NavigationTextButton extends StatelessWidget {
  const new({super.key, required this.text, required this.destination});
  final String text;
  final Widget destination;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return destination;
            },
          ),
        );
      },

      style: TextButton.styleFrom(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        fixedSize: Size(200, 30),
      ),
      child: Text(text),
    );
  }
}
