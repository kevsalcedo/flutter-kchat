// To parse this JSON data, do
//
//     final messagesResponse = messagesResponseFromJson(jsonString);

import 'dart:convert';

MessagesResponse messagesResponseFromJson(String str) => MessagesResponse.fromJson(json.decode(str));

String messagesResponseToJson(MessagesResponse data) => json.encode(data.toJson());

class MessagesResponse {
    bool ok;
    List<Msg> msg;

    MessagesResponse({
        required this.ok,
        required this.msg,
    });

    MessagesResponse copyWith({
        bool? ok,
        List<Msg>? msg,
    }) => 
        MessagesResponse(
            ok: ok ?? this.ok,
            msg: msg ?? this.msg,
        );

    factory MessagesResponse.fromJson(Map<String, dynamic> json) => MessagesResponse(
        ok: json["ok"],
        msg: List<Msg>.from(json["msg"].map((x) => Msg.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
    };
}

class Msg {
    String from;
    String msgFor;
    String msg;
    DateTime createdAt;
    DateTime updatedAt;

    Msg({
        required this.from,
        required this.msgFor,
        required this.msg,
        required this.createdAt,
        required this.updatedAt,
    });

    Msg copyWith({
        String? from,
        String? msgFor,
        String? msg,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Msg(
            from: from ?? this.from,
            msgFor: msgFor ?? this.msgFor,
            msg: msg ?? this.msg,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Msg.fromJson(Map<String, dynamic> json) => Msg(
        from: json["from"],
        msgFor: json["for"],
        msg: json["msg"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "from": from,
        "for": msgFor,
        "msg": msg,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
