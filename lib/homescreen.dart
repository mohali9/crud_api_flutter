import 'package:flutter/material.dart';
import 'package:flutter_api/ceate.dart';
import 'package:flutter_api/splashscreen.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import './edit.dart';

class HomeScreen extends StatefulWidget {
// variabel
  final List dataJSON;
  final int i;
  HomeScreen({this.i, this.dataJSON});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // variabel
  List dataJSON;

  Future<Null> ambildata() async {
    try {
      final hasil = await http.get('http://fd70a5b2.ngrok.io/api/indexapi');
      // print(hasil.body);
      // var json1 = json.decode(hasil.body);
      this.setState(() {
        dataJSON = json.decode(hasil.body);
        // dataJSON = json1["meetings"];
      });
      print(hasil.body);
    } catch (error, stacktrace) {
      print('$error, $stacktrace');
    }
  }

  @override
  void initState() {
    this.ambildata();
    super.initState();
  }

  // HAPUS DATA
//============================================================//
  void delete(dataJSON,i) {
    try {
      var url = "http://fd70a5b2.ngrok.io/api/indexapidelete";
      http.post(url, body: {'id': dataJSON[i]['id']});
      // var id = widget.dataJSON[widget.index]['id'];
      // var url = "http://4a4afc58.ngrok.io/api/indexapidelete/$id";
      // http.post(url, body: ['id']);
      // print(id);
    } catch (error, stacktrace) {
      print('$error, $stacktrace');
    }
  }

  void confirm(title) {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text("Anda yakin menghapus '$title'"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text(
            "OK DELETE!",
            style: new TextStyle(color: Colors.white),
          ),
          color: Colors.red,
          onPressed: () {
            delete(dataJSON,['i']);
            Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new HomeScreen(),
            ));
          },
        ),
        new RaisedButton(
          child: new Text("CANCEL", style: new TextStyle(color: Colors.white)),
          color: Colors.orange,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(context: context, child: alertDialog);
  }
// END HAPUS

  // void delete() {
  //   int id = 14;
  //   String myUrl = "http://4a4afc58.ngrok.io/api/indexapidelete$id";
  //   http.post(myUrl, headers: {
  //     'Accept': 'application/json',
  //     'Authorization':
  //         'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6Ijc1ZmE0MjA0ZmY0MDFlZDkxMzEwYzcwMDA5Y2EyNWQ0ZjkzMjI2YWZhNGM5ZDM3M2ZhMzdjMDZmMzliMjZmNTQxMjg5YzQxNWU1ZmE4OTc3In0.eyJhdWQiOiIzIiwianRpIjoiNzVmYTQyMDRmZjQwMWVkOTEzMTBjNzAwMDljYTI1ZDRmOTMyMjZhZmE0YzlkMzczZmEzN2MwNmYzOWIyNmY1NDEyODljNDE1ZTVmYTg5NzciLCJpYXQiOjE1NzA0NDMzMDYsIm5iZiI6MTU3MDQ0MzMwNiwiZXhwIjoxNjAyMDY1NzA2LCJzdWIiOiIyOCIsInNjb3BlcyI6W119.RiVZxRFCGTULnz5ccWER4mrRxKHOeUoWIZzRShvciituA3ZT3SXt_ET25Ruc8Dw3gXtWy--v-TzoyVwp38hrwGfZADsES5xHRlNQlc_ZNHS9tpaM43d_WqmS1eqrdr1FVm69xigSykC0pk9pyjdReliC7X8K6E3YUxDKRqbh-ny67Eu9zcQT6uVUfaSZeozUTniLtVqRr0ON8Adtc2iKinC_bDrWvpbkO4bpupSg3_Xcnwv3OU7hDzXkIV8xwkZ__Px-ayZdknVM9fPCS0lPlUhIr29_KhovsMUMidqKcBHxGnxzrcdXGD2bybODcW0UqM8-Px45bmjbDqwEJMDSQmoQ3LXnpTS8aZ--ugj2DIklESRlCEMKOQLghZAcTPgVnoaklBVmxcgT7nRVfbuohRHg_Gf7d-iHJ6GfJi1G0BWPHtGNkEDXwvV9f7rLfrqQdFdlm8cbknDqpDly2RS0W56fZhzSWJoGZsX8-RYv3x4wxHsug-QsMQWci3Y-swhU9e414M6xQKxOwQfMUvwtHcAJSO825nHbgv9T3GUtuBJdN_LrfyDsXS6_PKLRrhqGV-D-1_Wl_31bkNlLHz0ii8GlrfvD4HUZ5hJ8EmyRhaycCexgQ_MyMOOxAQkcB57CE5nhQM3q7lNNdH5oajOIVqFY7RVZTWe3FD4XvuKVMb4'
  //   }).then((response) {
  //     print('Response status : ${response.statusCode}');
  //     print('Response body : ${response.body}');
  //   });
  // }

//============================================================//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("HomeScreen"),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => Create(),
        )),
      ),
      body: new ListView.builder(
        itemCount: dataJSON == null ? 0 : dataJSON.length,
        itemBuilder: (context, i) {
          return new Container(
            padding: new EdgeInsets.all(10.0),
            child: new Card(
              child: new Container(
                padding: new EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      dataJSON[i]['title'],
                      style: new TextStyle(
                          fontSize: 20.0, color: Colors.blue[700]),
                    ),
                    new Padding(
                      padding: EdgeInsets.all(05.0),
                    ),
                    new Text(
                      dataJSON[i]['description'],
                      style: new TextStyle(
                          fontSize: 15.0, color: Colors.green[600]),
                    ),
                    new Padding(
                      padding: EdgeInsets.all(10.0),
                    ),
                    new Row(
                      children: <Widget>[
                        new RaisedButton(
                          child: new Text("Edit"),
                          color: Colors.green,
                          onPressed: () => Navigator.of(context).push(
                            new MaterialPageRoute(
                              builder: (BuildContext context) => new Edit(
                                id: dataJSON[i]['id'],
                                title: dataJSON[i]['title'],
                                description: dataJSON[i]['description'],
                                file: dataJSON[i]['file'],
                                image: dataJSON[i]['image'],
                                // dataJSON: dataJSON,
                                // index: i,
                              ),
                            ),
                          ),
                        ),
                        new Padding(
                          padding: EdgeInsets.all(05.0),
                        ),
                        new RaisedButton(
                          child: new Text("Delete"),
                          color: Colors.red,
                          onPressed: () async {
                            confirm(dataJSON[i]['title']);
                            print('Hapus');
                          },
                        ),
                        new Padding(
                          padding: EdgeInsets.all(05.0),
                        ),
                        new RaisedButton(
                          child: new Text('Logout'),
                          onPressed: () async {
                            // hapus data login
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            preferences.clear();
                            Navigator.of(context)
                                .pushReplacementNamed('/Login');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
