import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState(){
    return _LoginPage();
  }

}

class _LoginPage extends State<LoginPage>{
  late String errormsg, username, password;
  late bool error, showprogress;


  startLogin() async {
    String apiurl ="http://192.168.1.70/simas/login.php";
    var response=await http.post(Uri.parse(apiurl), body:{
      'username': username,
      'password': password
    });

    if(response.statusCode==200){
      var jsondata=jsonDecode(response.body);
      if (jsondata['error']){
        setState(() {
          showprogress=false;
          error=true;
          errormsg=jsondata["message"];
        });

      }else{
        if(jsondata["success"]){
          setState(() {
            error=false;
            showprogress=false;
          });


        }else{
          showprogress = false;
          error = true;
          errormsg="Something went wrong";
        }
      }
    }else{
      setState(() {
        showprogress = false;
        error=true;
        errormsg="Erorr during Connecting to server...";
      });
    }
  }

  @override
  void initState(){
    username ="";
    password ="";
    errormsg ="";
    error = false;
    showprogress = false;

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }















}