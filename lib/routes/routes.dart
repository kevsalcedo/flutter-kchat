

import 'package:flutter/material.dart';
import 'package:kchat/pages/chat_page.dart';
import 'package:kchat/pages/loading_page.dart';
import 'package:kchat/pages/login_page.dart';
import 'package:kchat/pages/register_page.dart';
import 'package:kchat/pages/usuarios_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usuarios': (_) => UsuariosPage(),
  'chat': (_) => ChatPage(),
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
  'loading': (_) => LoadingPage(),
};