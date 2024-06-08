
class Usuario {
  bool online;
  String email, name, uid;

  Usuario({
    required this.uid,
    required this.name,
    required this.email,
    required this.online,
  });
  
  /* factory Usuario.fromMap(Map<String, dynamic> obj) => Usuario(
        uid:obj.containsKey('uid') ? obj['uid'] : 'no-uid',
        name:obj.containsKey('name') ? obj['name'] : 'no-name',
        email:obj.containsKey('email') ? obj['email'] : 'no-email',
        online:obj.containsKey('online') ? obj['online'] : 'no-online',
      ); */
}