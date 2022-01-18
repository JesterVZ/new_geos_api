
import 'dart:async';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:geos_api/result_data.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'consts.dart';

Future<SecureSocket> connectToSocket(dynamic host, int port) async{
  SecureSocket s = await SecureSocket.connect(host, port, onBadCertificate: (X509Certificate cert) => true );
  return s;
}
Future<String> connectToDefaultSocket (dynamic host, int port, String _request) async{
  Completer<String> _completer = Completer<String>();
  var _secureResponse;
  Socket _socket = await Socket.connect(host, port);
  _socket.listen((data) {
    _secureResponse =  new String.fromCharCodes(data).trim();
    _completer.complete(_secureResponse);
  },
  onError: ((error, StackTrace trace) {
    _secureResponse = "Server error";
    print("(2) $_secureResponse");
    _completer.completeError(_secureResponse);
  }),
  onDone: (){
    _socket.destroy();
  },
  cancelOnError: false);

  _socket.write('$_request\r\n');
  return _completer.future;
}

Future<String> fetchData(String username, String password) async{
  String uri = protocol + domain + '/lk/index.php?route=common/login/api';

  var dio = Dio(BaseOptions(
    connectTimeout: 30000,
    contentType: Headers.jsonContentType,
  ));
  var formData = FormData.fromMap({
    'user_lk_type_id': '2',
    'username': username,
    'password': password
  });

  var cookieJar=CookieJar();
  dio.interceptors.add(CookieManager(cookieJar));

  final response = await dio.post(uri, data: formData);
  final cookies = await cookieJar.loadForRequest(Uri.parse(uri));

  String pf = cookies[2].value;
  String pa = cookies[3].value;
  String pc = cookies[4].value;
  String pp = cookies[5].value;
  String pd = cookies[5].value;

  if(response.statusCode == 200){
    String result = '{"cmd":"connect","cookie":"pf=' + pf + '; pp=' + pp + '; pd=' + pd + '; pa=' + pa + '; pc=' + pc + '"}';
    return result;
  } else {
    return "";
  }

}
