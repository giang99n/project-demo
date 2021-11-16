// To parse this JSON data, do
//
//     final homeGetPostResponse = homeGetPostResponseFromJson(jsonString);

import 'dart:convert';

HomeGetPostResponse homeGetPostResponseFromJson(String str) => HomeGetPostResponse.fromJson(json.decode(str));

String homeGetPostResponseToJson(HomeGetPostResponse data) => json.encode(data.toJson());

class HomeGetPostResponse {
  HomeGetPostResponse({
    this.data,
    this.status,
  });

  List<Datum>? data;
  String? status;

  factory HomeGetPostResponse.fromJson(Map<String, dynamic> json) => HomeGetPostResponse(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "status": status,
  };
}

class Datum {
  Datum({
    this.id,
    this.mtime,
    this.userid,
    this.title,
    this.text,
    this.images,
    this.videos,
    this.tags,
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
    this.heart,
  });

  String? id;
  int? mtime;
  String? userid;
  String? title;
  String? text;
  List<String>? images;
  List<dynamic>? videos;
  dynamic? tags;
  int? like;
  int? comment;
  int? share;
  String? price;
  String? type;
  String? name;
  String? rankname;
  String? job;
  String? avatar;
  Location? location;
  bool? deal;
  bool? heart;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    mtime: json["mtime"],
    userid: json["userid"],
    title: json["title"],
    text: json["text"],
    images: List<String>.from(json["images"].map((x) => x)),
    videos: List<dynamic>.from(json["videos"].map((x) => x)),
    tags: json["tags"],
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
    heart: json["heart"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mtime": mtime,
    "userid": userid,
    "title": title,
    "text": text,
    "images": List<dynamic>.from(images!.map((x) => x)),
    "videos": List<dynamic>.from(videos!.map((x) => x)),
    "tags": tags,
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
    "heart": heart,
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
