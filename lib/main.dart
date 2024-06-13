import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:kchat/services/chat_service.dart';
import 'package:kchat/services/auth_service.dart';
import 'package:kchat/services/socket_service.dart';

import 'package:kchat/routes/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => SocketService()),
        ChangeNotifierProvider(create: (_) => ChatService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'kchat App',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}
