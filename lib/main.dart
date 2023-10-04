import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var nameEditingController = TextEditingController();
  var emailEditingController = TextEditingController();
  var phoneEditingController = TextEditingController();
  var addressEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title:Text("Hello Upload")),
    body: SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            TextField(decoration: InputDecoration(hintText: "Enter name"), controller: nameEditingController,),
            TextField(decoration: InputDecoration(hintText: "Enter email"), controller: emailEditingController,
            keyboardType: TextInputType.emailAddress,),
            TextField(decoration: InputDecoration(hintText: "Enter phone",), controller: phoneEditingController,
                keyboardType: TextInputType.phone),
            TextField(decoration: InputDecoration(hintText: "Enter address"), controller: addressEditingController,),
            ElevatedButton(onPressed: (){

              createEmployee(nameEditingController.text, emailEditingController.text, addressEditingController.text,
                  phoneEditingController.text).then((value) => print(jsonEncode(value.body)));
            }, child: Text("Add Employee"))
          ],
        ),
      ),
    ),
    );
  }

  Future<http.Response> createEmployee(String name, String email, String address, String phonenumber) {
    return http.post(
      Uri.parse('https://api.sheety.co/4db58997dd33ab7eaa3d621c48bdea06/employees/sheet1'),
      // To edit the headers.. If you need to manage authentication
      // Normally we need to modify and add Authorization and token
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'sheet1': {
          "name":name,
          "email":email,
          "address":address,
          "phonenumber":phonenumber
        },
      }),
    );
  }
}
