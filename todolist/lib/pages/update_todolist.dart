import 'dart:convert';
// http method package
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class UpdatePage extends StatefulWidget {
  final v1, v2, v3; //ข้อมูลที่จะส่งเข้ามา
  const UpdatePage(this.v1, this.v2, this.v3);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  var _v1, _v2, _v3;
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _v1 = widget.v1; //id
    _v2 = widget.v2; //title
    _v3 = widget.v3; //detail
    todo_title.text = _v2;
    todo_detail.text = _v3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไข'),
        actions: [
          IconButton(
              onPressed: () {
                print("Deleted ID: $_v1");
                deleteTodo();
                Navigator.pop(context,
                    'delete'); //คำสั่งในการ back อัตโนมัติ  และส่งข้อความ delete ไป
              },
              icon: Icon(Icons.delete, color: Colors.white))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextField(
              controller: todo_title,
              decoration: InputDecoration(
                  labelText: 'รายการที่ต้องทำ', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              minLines: 4,
              maxLines: 8,
              controller: todo_detail,
              decoration: InputDecoration(
                  labelText: 'รายละเอียดที่ต้องทำ',
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
              child: ElevatedButton(
                onPressed: () {
                  print('-------');
                  print('title : ${todo_title.text}');
                  print('detail : ${todo_detail.text}');
                  updateTodo();
                  final snackBar = SnackBar(
                    content: const Text('อัพเดทรายการเรียบร้อยแล้ว'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Text("แก้ไข"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.fromLTRB(50, 20, 50, 20)),
                    textStyle:
                        MaterialStateProperty.all(TextStyle(fontSize: 20))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future updateTodo() async {
    // var url = Uri.https('1b68-2001-fb1-10-1456-a003-7fbc-ce34-77eb.ngrok.io','/api/post-todolist');     //บนเว็ปใช่ https ถ้าเป็น local ใช้ http   forward port จาก ngrok http 8000
    var url = Uri.http('192.168.1.44:8000', '/api/update-todolist/$_v1');
    Map<String, String> header = {
      "Content-type": "application/json"
    }; //header ของ post request (บังคับ) Map เป็นประเภท header // header ส่วนมากใส่ authen token
    String jsondata =
        '{"title":"${todo_title.text}", "detail":"${todo_detail.text}"}'; //data ที่จะส่งขึ้นไป
    var response = await http.put(url, headers: header, body: jsondata);
    print('------result------');
    print(response.body);
  }

  Future deleteTodo() async {
    var url = Uri.http('192.168.1.44:8000', '/api/delete-todolist/$_v1');
    Map<String, String> header = {"Content-type": "application/json"};
    var response = await http.delete(url, headers: header);
    print('------result------');
    print(response.body);
  }
}
