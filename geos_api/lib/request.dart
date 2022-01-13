
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:geos_api/result_data.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'consts.dart';

Future<String> getCookies(String username, String password) async{
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

  if(response.statusCode == 200){
    String result = '{"cmd":"connect","cookie":"' + ;
  }
}

Future<ResultData> fetchData(String username, String password) async{
  String uri = protocol + domain + '/lk/index.php?route=common/login/api';

  //String uri = protocol + domain + '/worker/index.php?route=common/login/api_login';

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

  print(await cookieJar.loadForRequest(Uri.parse(uri)));

  final _channel = WebSocketChannel.connect(
    Uri.parse('wss://promo.dev.conres.ru:2450/'),
  );

  _channel.stream.listen((event) {
    print(event);
  },
  onError: (error) => print(error));
  //String uriInfo = protocol + domain + '/worker/index.php?route=common/login/api_get_info';

  //final responseInfo = await dio.post(uriInfo);

  if(response.statusCode == 200){
    return ResultData.fromMap(response.data);
  } else {
    throw Exception('error');
  }

}
