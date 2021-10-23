import 'package:flutter/material.dart';
import 'package:todolist/pages/add.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:todolist/pages/update_todolist.dart';

class Todolist extends StatefulWidget {
  // const Todolist({ Key? key }) : super(key: key);

  @override
  _TodolistState createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  List todolistitems = ['A', 'B', 'C', 'D'];

  @override //run ทุกครั้งที่หน้านี้เปิดขึ้นมา
  void initState() {
    // TODO: implement initState
    super.initState();
    getTodolist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddPage()))
              .then((value) {
            setState(() {
              getTodolist();
            });
          });
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              setState(() {
                getTodolist();
              });
            },
            icon: Icon(Icons.refresh, color: Colors.white))
      ], title: Text('All todolist')),
      body: todolistCreate(),
    );
  }

  Widget todolistCreate() {
    return ListView.builder(
        itemCount: todolistitems.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
            title: Text("${todolistitems[index]['title']}"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdatePage(
                          todolistitems[index]['id'],
                          todolistitems[index]['title'],
                          todolistitems[index]['detail']))).then((value) {
                setState(() {
                  print(value);
                  if (value == 'delete') {
                    final snackBar = SnackBar(
                      content: const Text('ลบรายการเรียบร้อยแล้ว'),
                    );

                    // Find the ScaffoldMessenger in the widget tree
                    // and use it to show a SnackBar.
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  getTodolist();
                });
              }); //.then คือหลังคลิกเข้าไปในที่นี้คือหน้า update แล้ว back กลับมาจะให้ทำอะไร set state คือเปรียบเสมือนการ refresh หน้า
            },
          )); // wrap listtile ด้วย Card
        });
  }

  Future<void> getTodolist() async {
    // void คือไม่ได้ return ค่าอะไร
    List alltodo = [];
    var url = Uri.http('192.168.1.44:8000', '/api/all-todolist');
    var response = await http.get(url);
    // var result = json.decode(response.body);
    // var result = utf8.decode(response.bodyBytes);
    List<dynamic> result = json.decode(utf8.decode(response.bodyBytes));
    print(result);
    setState(() {
      todolistitems = result;
      // todolistitems = jsonDecode(result);
    });
  }
}
