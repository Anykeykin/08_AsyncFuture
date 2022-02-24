import 'package:catch_error/fetch_file.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catch error'),
      ),
      body: FutureBuilder<String>(
        future: fetchFileFromAssets('assets/somefile.txt'),
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
                return SingleChildScrollView(child: Text(snapshot.data));
              }
            default:
              print('def');
              return SingleChildScrollView(
                child: Text('Default'),
              );
          }
        },
      ),
    );
  }
}
