import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kchat/models/messages_response.dart';


import 'package:kchat/models/usuario.dart';
import 'package:kchat/global/environment.dart';
import 'package:kchat/services/auth_service.dart';

class ChatService with ChangeNotifier {
  late Usuario userFor;

  Future<List<Msg>> getChat(String userID) async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/messages/$userID');
      final token = await AuthService.getToken() ?? '';

      final resp = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      });

      final messagesResponse = messagesResponseFromJson(resp.body);

      return messagesResponse.msg;
    } catch (e) {
      return [];
    }
  }
}
