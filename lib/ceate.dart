import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  TextEditingController controllertitle = new TextEditingController();
  TextEditingController controllerdescription = new TextEditingController();
  TextEditingController controllerfile = new TextEditingController();
  TextEditingController controllerimage = new TextEditingController();

  void create() {
    try {
      var url = "http://fd70a5b2.ngrok.io/api/indexapicreate";
      http.post(url, body: {
        "title": controllertitle.text,
        "description": controllerdescription.text,
        "file": controllerfile.text,
        "image": controllerimage.text,
      });
    } catch (error, stacktrace) {
      print('$error, $stacktrace');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("Create Data")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new TextField(
                  controller: controllertitle,
                  decoration: new InputDecoration(
                      hintText: "Title", labelText: "Title"),
                ),
                new TextField(
                  controller: controllerdescription,
                  decoration: new InputDecoration(
                      hintText: "Decription", labelText: "Decription"),
                ),
                new TextField(
                  controller: controllerfile,
                  decoration:
                      new InputDecoration(hintText: "File", labelText: "File"),
                ),
                new TextField(
                  controller: controllerimage,
                  decoration: new InputDecoration(
                      hintText: "Image", labelText: "Image"),
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                new RaisedButton(
                  child: new Text("Create Data"),
                  color: Colors.orange,
                  onPressed: () {
                    create();
                    Navigator.pop(context);
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
