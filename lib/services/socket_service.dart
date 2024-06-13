import 'package:flutter/material.dart';
import 'package:kchat/global/environment.dart';
import 'package:kchat/services/auth_service.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting,
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket socket;

  ServerStatus get serverStatus => _serverStatus;

  void connect() async {
    final token = await AuthService.getToken();

    // Dart client
    socket = IO.io(
        Environment.socketUrl,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect()
            .enableForceNew()
            //.disableAutoConnect()  // disable auto-connection
            .setExtraHeaders({'x-token': token}) // optional
            .build());

    socket.onConnect((_) {
      print('Connected');
      socket.emit('mensaje', 'onConnect :)');
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    socket.onDisconnect((_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }

  void disconnect() {
    socket.disconnect();
  }
}
