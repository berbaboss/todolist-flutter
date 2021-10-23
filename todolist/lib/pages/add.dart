import 'dart:convert';
// http method package
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class AddPage extends StatefulWidget {
  const AddPage({ Key? key }) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('เพิ่มรายการใหม่'),),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextField(
                    controller: todo_title,
                    decoration: InputDecoration(
                        labelText: 'รายการที่ต้องทำ', 
                        border: OutlineInputBorder()),
                  ),
            SizedBox(height: 30,),
            TextField(
                    minLines: 4,
                    maxLines: 8,
                    controller: todo_detail,
                    decoration: InputDecoration(
                        labelText: 'รายละเอียดที่ต้องทำ', 
                        border: OutlineInputBorder()),
                  ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
              child: ElevatedButton(
                      onPressed: () {
                        print('-------');
                        print('title : ${todo_title.text}');
                        print('detail : ${todo_detail.text}');
                        postTodo();
                        setState(() {
                          todo_title.clear();
                          todo_detail.clear();
                        });
                      }, 
                      child: Text("เพิ่มรายการ"), 
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(50, 20, 50, 20)),
                        textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20))),),
            ),
          ],
        ),
      ),
    
      
    );
  }
  Future postTodo() async{
    // var url = Uri.https('1b68-2001-fb1-10-1456-a003-7fbc-ce34-77eb.ngrok.io','/api/post-todolist');     //บนเว็ปใช่ https ถ้าเป็น local ใช้ http   forword port จาก ngrok http 8000
    var url = Uri.http('192.168.1.44:8000', '/api/post-todolist'); 
    Map<String,String> header = {"Content-type":"application/json"};      //header ของ post request (บังคับ) Map เป็นประเภท header
    String jsondata = '{"title":"${todo_title.text}", "detail":"${todo_detail.text}"}';     //date ที่จะส่งขึ้นไป
    var response = await http.post(url, headers: header, body: jsondata);
    print('------result------');
    print(response.body);
  }
}