import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String text;
  const Logo({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: [
            const Image(image: AssetImage('assets/kchat-logo-image.png')),
            const SizedBox(height: 20),
            Text(
              text,
              style: TextStyle(fontSize: 30, color: Colors.cyan[400]),
            )
          ],
        ),
      ),
    );
  }
}
