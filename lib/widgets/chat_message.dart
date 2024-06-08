import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text, uid;
  final AnimationController animationController;
  const ChatMessage({
    super.key,
    required this.uid,
    required this.text,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(curve: Curves.linearToEaseOut, parent: animationController),
        child: Container(
          child: uid == '123' ? _myMessage() : _otherMessage(),
        ),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 5, left: 70, right: 8),
        decoration: BoxDecoration(
            color: Colors.cyan[400],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            )),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _otherMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 5, left: 8, right: 70),
        decoration: BoxDecoration(
            color: Colors.cyan[900],
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            )),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
