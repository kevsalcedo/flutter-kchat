import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:kchat/services/auth_service.dart';
import 'package:kchat/services/chat_service.dart';
import 'package:kchat/services/users_service.dart';
import 'package:kchat/services/socket_service.dart';

import 'package:kchat/models/usuario.dart';

class UsuariosPage extends StatefulWidget {
  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final userService = new UsersService();

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<Usuario> usuarios = [];

  /* final usuarios = [
    Usuario(uid: "1", name: "Erick", email: "test1@email.com", online: true),
    Usuario(uid: "2", name: "Derek", email: "test2@email.com", online: false),
    Usuario(uid: "3", name: "Nani", email: "test3@email.com", online: true),
  ]; */

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final usuario = authService.usuario;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${usuario!.name} kchats!',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 1,
        backgroundColor: Colors.cyan[400],
        leading: IconButton(
          onPressed: () {
            socketService.disconnect();
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
          },
          icon: const Icon(
            Icons.exit_to_app,
            color: Colors.white,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: (socketService.serverStatus == ServerStatus.Online)
                ? const Icon(Icons.check_circle, color: Colors.white)
                : const Icon(Icons.offline_bolt, color: Colors.red),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: WaterDropHeader(
          complete: Icon(
            Icons.check,
            color: Colors.cyan[400],
          ),
          waterDropColor: Colors.cyan,
        ),
        onRefresh: _loadUsers,
        child: _listViewUsuarios(),
      ),
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => _usuarioListTile(usuarios[index]),
      itemCount: usuarios.length,
      separatorBuilder: (context, index) => const Divider(),
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.name),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        backgroundColor: Colors.cyan[200],
        foregroundColor: Colors.cyan[900],
        child: Text(usuario.name.substring(0, 2)),
      ),
      trailing: Container(
        width: 13,
        height: 13,
        decoration: BoxDecoration(
            color: usuario.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.userFor = usuario;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }

  _loadUsers() async {
    usuarios = await userService.getUsers();
    setState(() {});
    // monitor network fetch
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
