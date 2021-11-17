// To parse this JSON data, do
//
//     final likePostResponse = likePostResponseFromJson(jsonString);

import 'dart:convert';

LikePostResponse likePostResponseFromJson(String str) => LikePostResponse.fromJson(json.decode(str));

String likePostResponseToJson(LikePostResponse data) => json.encode(data.toJson());

class LikePostResponse {
  LikePostResponse({
    this.data,
    this.status,
  });

  Data ?data;
  String ?status;

  factory LikePostResponse.fromJson(Map<String, dynamic> json) => LikePostResponse(
    data: Data.fromJson(json["data"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
    "status": status,
  };
}

class Data {
  Data({
    this.id,
    this.mtime,
    this.dtime,
    this.postid,
    this.commentid,
    this.action,
    this.userid,
    this.ownerid,
  });

  String ?id;
  int ?mtime;
  int ?dtime;
  String ?postid;
  String ?commentid;
  String ?action;
  String ?userid;
  String ?ownerid;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    mtime: json["mtime"],
    dtime: json["dtime"],
    postid: json["postid"],
    commentid: json["commentid"],
    action: json["action"],
    userid: json["userid"],
    ownerid: json["ownerid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mtime": mtime,
    "dtime": dtime,
    "postid": postid,
    "commentid": commentid,
    "action": action,
    "userid": userid,
    "ownerid": ownerid,
  };
}
