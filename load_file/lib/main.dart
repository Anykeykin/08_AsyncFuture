import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'fetch_file.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Load file'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _controller = TextEditingController();
  String path = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  controller: _controller,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),borderRadius: BorderRadius.circular(10.0)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      labelStyle: TextStyle(
                          color: Colors.black
                      ),
                    suffixIcon: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          path = _controller.text;
                        });
                      },
                      child: Text('Найти'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        minimumSize: Size(100,60)
                      ),
                    )
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              FutureBuilder<String>(
                future: fetchFileFromAssets('assets/${path}.txt'),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState)
                  {
                    case ConnectionState.none:
                      print('none');
                      return Center(
                        child: Text('NONE'),
                      );
                    case ConnectionState.waiting:
                      print('wait');
                      return Center(child: CircularProgressIndicator());
                    case ConnectionState.done:
                      print('done');
                      if(snapshot.hasError) {
                        return SingleChildScrollView(child: Center(child: Text('Файл не найден')));
                      } else {
                        return SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text(snapshot.data)
                        );
                      }
                    default:
                      print('def');
                      return SingleChildScrollView(
                        child: Text('Default'),
                      );
                  }
                },
              ),
            ],
          ),
        ),
    );
  }
}

