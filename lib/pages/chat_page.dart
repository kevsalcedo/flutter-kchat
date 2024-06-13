import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kchat/models/messages_response.dart';
import 'package:kchat/services/auth_service.dart';
import 'package:kchat/services/chat_service.dart';
import 'package:kchat/services/socket_service.dart';

import 'dart:io';

import 'package:kchat/widgets/chat_message.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;

  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  bool _isWritting = false;

  List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);

    socketService.socket.on('private-msg', _listenMessage);

    _loadHistory(chatService.userFor.uid);
  }

  void _loadHistory(String userID) async {
    List<Msg> chat = await chatService.getChat(userID);

    final history = chat.map(
      (m) => ChatMessage(
        uid: m.from,
        text: m.msg,
        animationController: AnimationController(
            vsync: this, duration: Duration(milliseconds: 0))
          ..forward(),
      ),
    );
    setState(() {
      _messages.insertAll(0, history);
    });
  }

  void _listenMessage(dynamic payload) {
    ChatMessage message = ChatMessage(
      uid: payload['from'],
      text: payload['msg'],
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    );

    setState(() {
      _messages.insert(0, message);
    });

    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final userFor = chatService.userFor;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.cyan,
              child: Text(
                userFor.name.substring(0, 2),
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              userFor.name,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
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
      uid: authService.usuario!.uid,
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

    socketService.socket.emit('private-msg', {
      'from': authService.usuario!.uid,
      'for': chatService.userFor.uid,
      'msg': message,
    });
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }

    socketService.socket.off('private-msg');
    super.dispose();
  }
}
