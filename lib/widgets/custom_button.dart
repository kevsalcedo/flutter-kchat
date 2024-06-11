import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  //final Color color;
  final Function()? onPressed;

  const CustomButton({
    super.key,
    required this.text,
    //required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      elevation: 2,
      highlightElevation: 5,
      color: Colors.cyan[400],
      shape: const StadiumBorder(),
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
