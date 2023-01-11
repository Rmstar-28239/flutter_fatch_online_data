import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String url="https://jsonplaceholder.typicode.com/posts";

 Future<List<User>> getdata() async
 {
   var data=await http.get(Uri.parse(url));
   var resposedata=json.decode(data.body);
   List<User> datalist=[];
   for(var single in resposedata)
     {
       User user=new User(
           single["id"],
           single["userId"],
           single["title"],
           single["body"]
       );
      datalist.add(user);
     }
   return datalist;
 }
 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     this.getdata();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Fetch data"),
        ),
        body: Container(
          child: FutureBuilder(
            future: getdata(),
            builder: (context, snapshot) {
              if(snapshot.data==null)
                {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else
                {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                      itemBuilder: (context,index) {
                       return ListTile(
                          title: Text(snapshot.data![index].title),
                          subtitle: Text(snapshot.data![index].body),
                          contentPadding: EdgeInsets.only(bottom: 20.0),
                        );
                      },
                  );
                }
            },
          ),

        ),
      ),
    );
  }
}
class User
{
  final int id;
  final int userId;
  final String title;
  final String body;

  User(this.id, this.userId, this.title, this.body);
}
