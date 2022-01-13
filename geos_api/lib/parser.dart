import 'package:dio/dio.dart';

class Parser{
  Map<String, dynamic> parseCookies(List<String> data){
    Map<String, dynamic> map = <String, dynamic>{};
    for(int i = 0; i < data.length; i++){
      String text = data[i];
      List<String> parts = text.split('=');
      if(!map.containsKey(parts[0])){
        for(int j = 1; j < parts.length; j++){
          if(map[parts[0]] != null){
            map[parts[0]] += parts[j];
          } else {
            map[parts[0]] = parts[j];
          }
        }
      }

    }
    return map;
  }
}