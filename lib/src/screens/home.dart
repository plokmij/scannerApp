import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class Home extends StatefulWidget{
  HomeState createState(){
    return HomeState();
  }
}


class HomeState extends State<Home> {
  String result = "Hey There !";
  Future _scanQBarCode() async{
    try{
      String qrResult =await BarcodeScanner.scan();
      setState(() {
        result =qrResult; 
      });
    } on PlatformException catch (e){
      if(e.code ==BarcodeScanner.CameraAccessDenied){
        setState(() {
          result = "Camera Permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error";
        });
      }
    } on FormatException{
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch(ex){
      setState(() {
       print("Unknown error $ex") ;
      });
    }
  }
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff214489),
        title: Text("Scanner"),
      ),
      body: Center(child:Text(result, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),), ),
      floatingActionButton: FloatingActionButton.extended(
        icon:Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: () {
          _scanQBarCode();
        },
        backgroundColor: Color(0xff214489),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}