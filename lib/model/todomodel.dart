// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

List<Todomodel> todomodelFromJson(String str) =>
    List<Todomodel>.from(json.decode(str).map((x) => Todomodel.fromJson(x)));

String todomodelToJson(List<Todomodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Todomodel {
  String id;
  String userId;
  String task;
  bool isCompleted;
  int v;

  Todomodel({
    required this.id,
    required this.userId,
    required this.task,
    required this.isCompleted,
    required this.v,
  });

  factory Todomodel.fromJson(Map<String, dynamic> json) => Todomodel(
        id: json["_id"],
        userId: json["userId"],
        task: json["task"],
        isCompleted: json["isCompleted"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "task": task,
        "isCompleted" : isCompleted,
        "__v": v,
      };

  @override
  bool operator ==(covariant Todomodel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.userId == userId &&
      other.task == task &&
      other.isCompleted == isCompleted &&
      other.v == v;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      userId.hashCode ^
      task.hashCode ^
      isCompleted.hashCode ^
      v.hashCode;
  }
}
