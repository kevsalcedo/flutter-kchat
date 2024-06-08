import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kchat/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  bool _isWritting = false;

  List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              child: Text(
                'KS',
                style: TextStyle(fontSize: 18),
              ),
              backgroundColor: Colors.white,
              foregroundColor: Colors.cyan,
            ),
            SizedBox(width: 16),
            Text(
              'Kevin Salcedo',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )
          ],
        ),
        backgroundColor: Colors.cyan[400],
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemBuilder: (_, index) => _messages[index],
                itemCount: _messages.length,
                physics: const BouncingScrollPhysics(),
                reverse: true,
              ),
            ),
            const Divider(height: 1),
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (String message) {
                  setState(() {
                    if (message.trim().isNotEmpty) {
                      _isWritting = true;
                    } else {
                      _isWritting = false;
                    }
                  });
                },
                decoration:
                    const InputDecoration.collapsed(hintText: 'Message'),
                focusNode: _focusNode,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Platform.isIOS
                  ? CupertinoButton(
                      onPressed: _isWritting
                          ? () => _handleSubmit(_textController.text.trim())
                          : null,
                      child: Text(
                        'Send',
                        style: TextStyle(
                            color:
                                _isWritting ? Colors.cyan[700] : Colors.grey),
                      ),
                    )
                  : IconTheme(
                      data: IconThemeData(color: Colors.cyan[700]),
                      child: IconButton(
                        onPressed: _isWritting
                            ? () => _handleSubmit(_textController.text.trim())
                            : null,
                        icon: const Icon(Icons.send),
                        color: Colors.cyan[700],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  _handleSubmit(String message) {
    if (message.isEmpty) return;

    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      uid: '123',
      text: message,
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
      ),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _isWritting = false;
    });
  }

  @override
  void dispose() {
    // TODO: off del socket

    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
