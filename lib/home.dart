import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/model.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Welcome> welcomeData = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("API DEMO"),
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (context,snapshot) {
            if(snapshot.hasData){
              print("${welcomeData.length}");

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: welcomeData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                              children: [
                                Text("${welcomeData[index].id}"),
                                Text("${welcomeData[index].userId}"),
                                Text(welcomeData[index].title ),
                                Text(welcomeData[index].body),
                              ],
                          ),
                        );
                      },),
                  ),
                ],
              );
            }
            else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }


          }
        ),
      ),
    );
  }

  Future<List<Welcome>> getData() async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map<String, dynamic> index in data){
          welcomeData.add(Welcome.fromJson(index));
      }
      return welcomeData;
    }
    else{
      return welcomeData;
    }
  }

}
