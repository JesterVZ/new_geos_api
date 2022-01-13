import 'package:flutter/material.dart';
import 'package:geos_api/info.dart';
import 'package:geos_api/request.dart';
import 'package:geos_api/result_data.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'info_page.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePage();

}

class _HomePage extends State<HomePage>{
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final _channel = WebSocketChannel.connect(
    Uri.parse('wss://promo.dev.conres.ru:2450/'),
  );
  late Future<ResultData> resultData;
  late Info info;

  @override
  void initState() {
    super.initState();
    //resultData = fetchData("123456789000", "123456");
    _channel.sink.add(data)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Geos API"),),
      body: Column(
        children: [
          StreamBuilder(
            stream: _channel.stream,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return Text(snapshot.data.toString());
              } else {
                return const Text("error");
              }
            },
          )
        ],
      ),
    );
    /*
    return Scaffold(
      appBar: AppBar(title: const Text("Geos API"),),
      body: Column(
        children: [
          TextField(
            controller: loginController,
            obscureText: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Username',
            ),
          ),
          TextField(
            controller: passwordController,
            obscureText: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
          ElevatedButton(onPressed: (){
            resultData = fetchData(loginController.text, passwordController.text);
          }, child: const Text("Login")),

          FutureBuilder<ResultData>(
            future: resultData,
            builder: (context, snapshot){
              if(snapshot.hasData){
                info = snapshot.data!.data!;

                return Column(
                  children: [
                    Text("code_result: " + snapshot.data!.code_result.toString()),
                    Text("Message: " + snapshot.data!.code_msg!.msg.toString()),
                    Text("Custom fields: " + snapshot.data!.code_msg!.custom_fields!.length.toString()),
                    Text("Data: " + info.toString()),
                    ElevatedButton(onPressed: ShowFullInfo, child: const Text("show full info"))
                  ],
                );
              } else {
                return const Text("Error");
              }
            },
          )
        ],
      ),
    );
     */
  }
  void ShowFullInfo(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => InfoPage(info: info)));
  }

}