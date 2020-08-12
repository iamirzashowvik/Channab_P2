// To parse this JSON data, do
//
//     final activeStatus = activeStatusFromJson(jsonString);

import 'dart:convert';

ActiveStatus activeStatusFromJson(String str) =>
    ActiveStatus.fromJson(json.decode(str));

String activeStatusToJson(ActiveStatus data) => json.encode(data.toJson());

class ActiveStatus {
  ActiveStatus({
    this.status,
    this.msg,
  });

  int status;
  String msg;

  factory ActiveStatus.fromJson(Map<String, dynamic> json) => ActiveStatus(
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
      };
}
