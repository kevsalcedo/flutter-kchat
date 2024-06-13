import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:kchat/services/auth_service.dart';
import 'package:kchat/services/socket_service.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot) {
          return Center(
            child: CircularProgressIndicator(color: Colors.cyan,),
          );
        },
        future: checkLoginState(context),
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
        final socketService = Provider.of<SocketService>(context, listen: false);

    
    final authenticated = await authService.isLoggedIn();
      print(authenticated);

    if (authenticated) {
      socketService.connect();
      Navigator.pushReplacementNamed(context, 'usuarios');
    } else {
      print('Sin token');
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}
