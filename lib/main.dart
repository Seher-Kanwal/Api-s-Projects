import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Model/hellno.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Hellno> hellno = [];

  Future<List<Hellno>> getuserdata() async {
    final response = await http.get(
        Uri.parse('https://webhook.site/c0543d64-8510-46c0-9909-f7bd407fa222'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        hellno.add(Hellno.fromJson(i));
      }
      return hellno;
    } else {
      return hellno;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Hayyyee',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'API Integration',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          //  brightness: Brightness.light,
          backgroundColor: Colors.blue,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
          ),
          elevation: 0,
          shadowColor: Colors.black45,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FutureBuilder(
                  //in case of object we have to pass object Futurebuilder<object name>
                  future: getuserdata(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: hellno.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('ID:  '+ hellno[index].id.toString()),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Title:  '+hellno[index].title.toString()),
                              ),
                              Card(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image: NetworkImage(
                                      hellno[index].url.toString(),
                                    ),
                                    fit: BoxFit.cover,
                                  )),

                                  //   child: NetworkImage(hellno[index].url.toString()),
                                ),
                              ),


                            ],
                          ),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
