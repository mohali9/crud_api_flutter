import 'package:flutter/material.dart';
import 'package:flutter_api/homescreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './main.dart';

class Edit extends StatefulWidget {

  // variabel
  final String title, description, file, image;
  final int id;
  

  Edit({this.id, this.title, this.description, this.file, this.image});

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  // controller
  TextEditingController controllertitle;
  TextEditingController controllerdescription;
  TextEditingController controllerfile;
  TextEditingController controllerimage;

  void edit() async {
    try {
      var url = "http://fd70a5b2.ngrok.io/api/indexapiupdate";
      final response = await http.post(url, body: {
        "id": widget.id,
        "title": controllertitle.text,
        "description": controllerdescription.text,
        "file": controllerfile.text,
        "image": controllerimage.text
      });
      if (response.statusCode==200) {
        dynamic responsejson=json.decode(response.body);
        if (responsejson['status']=='success') {
          Navigator.pop(context);
        }
      }
    } catch (error, stacktrace) {
      print('$error, $stacktrace');
    }
    // var id = int.parse(widget.dataJSON[widget.index]['id']);
    // print('id');
  }

  @override
  void initState() {
    controllertitle =
        new TextEditingController(text: widget.title);
    controllerdescription = new TextEditingController(
        text: widget.description);
    controllerfile =
        new TextEditingController(text: widget.file);
    controllerimage =
        new TextEditingController(text: widget.image);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Form Edit"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new TextField(
                  controller: controllertitle,
                  decoration:
                      InputDecoration(hintText: 'Title', labelText: 'Title'),
                ),
                new TextField(
                  controller: controllerdescription,
                  decoration: InputDecoration(
                      hintText: 'Description', labelText: 'Description'),
                ),
                new TextField(
                  controller: controllerfile,
                  decoration:
                      InputDecoration(hintText: 'File', labelText: 'File'),
                ),
                new TextField(
                  controller: controllerimage,
                  decoration:
                      InputDecoration(hintText: 'Image', labelText: 'Image'),
                ),
                new RaisedButton(
                  child: new Text("EDIT DATA"),
                  color: Colors.blueAccent,
                  onPressed: () {
                    edit();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new HomeScreen()));
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
