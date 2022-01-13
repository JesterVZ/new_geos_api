import 'dart:convert';

import 'package:geos_api/info.dart';

class ResultData {
  int? code_result;
  Message? code_msg;
  Info? data;

  ResultData(
      {this.code_result, this.code_msg, this.data});

  factory ResultData.fromJson(String source) => ResultData.fromMap(json.decode(source));

  factory ResultData.fromMap(Map<String, dynamic> map){
    return ResultData(
        code_result: map['code_result'],
        code_msg: map['code_msg'] != null ? Message.fromMap(map['code_msg']) : null,
        data: map['data']['info'] != null ? Info.fromMap(map['data']) : null);

  }
}

class Message {
  String? msg;
  List<dynamic>? custom_fields;
  Message({this.msg, this.custom_fields});

  factory Message.fromMap(Map<String, dynamic> map){
    return Message(
        msg: map['msg'],
        custom_fields: map['custom_fields']
    );
  }
}

