import 'package:flutter/material.dart';
import 'package:geos_api/info.dart';
import 'package:geos_api/request.dart';
import 'package:geos_api/result_data.dart';
import 'package:web_socket_channel/io.dart';
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
  final channel = IOWebSocketChannel.connect(
    Uri.parse('wss://demo.piesocket.com/v3/channel_1?api_key=oCdCMcMPQpbvNjUIzqtvF1d2X2okWpDQj4AwARJuAgtjhzKxVEjQU6IdCjwm&notify_self'),
  );
  
  late Future<String> resultData;
  late Info info;
  String _message = "";
  
  @override
  void initState() {
    super.initState();
    resultData = fetchData("123456789000", "123456");

  }

  @override
  Widget build(BuildContext context) {
    channel.stream.listen((message) {
      setState(() {
        _message = message.toString();
      });
      print('message = $message');
      //channel.sink.add('received!');
      channel.sink.close();
    });
    return Scaffold(
      appBar: AppBar(title: const Text("Geos API"),),
      body: Column(
        children: [
          FutureBuilder<String>(
            future: resultData,
            builder: (context, snapshot){
              if(snapshot.hasData){
                //_channel.sink.add(snapshot.data.toString());
                return Column(
                  children: [
                    Text("Cookies: " + snapshot.data.toString()),
                    ElevatedButton(onPressed: ShowFullInfo, child: const Text("show full info"))
                  ],
                );
              } else {
                return const Text("Error");
              }
            },
          ),
          Text('$_message')

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