import 'package:flutter/material.dart';
import 'package:kchat/services/auth_service.dart';
import 'package:provider/provider.dart';

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
    
    final authenticated = await authService.isLoggedIn();
      print(authenticated);

    if (authenticated) {
      //TODO: Conectar al socket service
      Navigator.pushReplacementNamed(context, 'usuarios');
    } else {
      print('Sin token');
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}
