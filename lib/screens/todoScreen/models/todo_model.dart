import 'package:flutter/material.dart';


class TodoModel{

  /// a constructor is needed to enable us pass in data to this class
  late var ID;
  late var title;
  late var description;
  late var date;
  late var time;

TodoModel({required this.ID, required this.title, required this.description, required this.date, required this.time});

TodoModel.fromjson( Map<dynamic,dynamic>json){
  ID= json["ID"];
 title =  json["title"];
 description = json["description"];
 date = json["date"];
 time = json["time"];
}
}