import 'package:http/http.dart' as http;
import 'package:kchat/global/environment.dart';
import 'package:kchat/models/users_response.dart';

import 'package:kchat/models/usuario.dart';
import 'package:kchat/services/auth_service.dart';

class UsersService {
  Future<List<Usuario>> getUsers() async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/users');
      final token = await AuthService.getToken() ?? '';

      final resp = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      });

      final usuariosResponse = usersResponseFromJson(resp.body);

      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
