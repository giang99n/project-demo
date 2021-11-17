// To parse this JSON data, do
//
//     final postResponse = postResponseFromJson(jsonString);

import 'dart:convert';

PostResponse postResponseFromJson(String str) => PostResponse.fromJson(json.decode(str));

String postResponseToJson(PostResponse data) => json.encode(data.toJson());

class PostResponse {
  PostResponse({
    this.data,
    this.status,
  });

  Data? data;
  String? status;

  factory PostResponse.fromJson(Map<String, dynamic> json) => PostResponse(
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
    this.userid,
    this.title,
    this.text,
    this.images,
    this.videos,
    this.like,
    this.comment,
    this.share,
    this.price,
    this.type,
    this.name,
    this.rankname,
    this.job,
    this.avatar,
    this.location,
    this.deal,
    this.category,
    this.reportNumber,
  });

  String? id;
  int? mtime;
  int? dtime;
  String? userid;
  String? title;
  String? text;
  dynamic? images;
  dynamic? videos;
  int? like;
  int ?comment;
  int ?share;
  String? price;
  String? type;
  String? name;
  String ?rankname;
  String? job;
  String? avatar;
  Location? location;
  bool? deal;
  String? category;
  int? reportNumber;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    mtime: json["mtime"],
    dtime: json["dtime"],
    userid: json["userid"],
    title: json["title"],
    text: json["text"],
    images: json["images"],
    videos: json["videos"],
    like: json["like"],
    comment: json["comment"],
    share: json["share"],
    price: json["price"],
    type: json["type"],
    name: json["name"],
    rankname: json["rankname"],
    job: json["job"],
    avatar: json["avatar"],
    location: Location.fromJson(json["location"]),
    deal: json["deal"],
    category: json["category"],
    reportNumber: json["report_number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mtime": mtime,
    "dtime": dtime,
    "userid": userid,
    "title": title,
    "text": text,
    "images": images,
    "videos": videos,
    "like": like,
    "comment": comment,
    "share": share,
    "price": price,
    "type": type,
    "name": name,
    "rankname": rankname,
    "job": job,
    "avatar": avatar,
    "location": location!.toJson(),
    "deal": deal,
    "category": category,
    "report_number": reportNumber,
  };
}

class Location {
  Location({
    this.address,
    this.type,
    this.coordinates,
  });

  String? address;
  String? type;
  List<double>? coordinates;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    address: json["address"],
    type: json["type"],
    coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "type": type,
    "coordinates": List<dynamic>.from(coordinates!.map((x) => x)),
  };
}
