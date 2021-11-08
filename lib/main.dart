import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map data;
  List usersData;
  getUsers() async {
    http.Response response = await http.get('http://localhost:4000/api/users');
    var data = json.decode(response.body);
    setState(() {
      usersData = data['users'];
    });
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de Usuarios"),
          backgroundColor: Colors.green,
        ),
        body: ListView.builder(
          itemCount: usersData == null ? 0 : usersData.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          usersData[index]['_id'],
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          usersData[index]['primerNombre'],
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          usersData[index]['segundoNombre'],
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.orange,
                          ),
                        ),
                        Text(
                          usersData[index]['avatar'],
                          style: TextStyle(
                            fontSize: 8.0,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    )));
          },
        ));
  }
}
