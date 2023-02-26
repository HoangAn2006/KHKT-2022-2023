import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;
import 'dart:convert';
import 'dart:async';
import 'package:esp_smartconfig/esp_smartconfig.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:network_info_plus/network_info_plus.dart';

class WConfig extends StatefulWidget{
  @override
  WConfigState createState() => WConfigState();
}

class WConfigState extends State<WConfig>{
  String wifiName = "null";
  String wifiBSSID = "null";
  String? _pass_config = "";
  bool _showpass_config = true;

  @override
  void initState(){
    super.initState();
    setNetwork();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Center(
              child: Container(
                height: 660,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(1)), //Color(0xC9DFDFE8)),
                child: Column(
                  children: [
                    Container(height: 35,
                      decoration: BoxDecoration(color: Colors.black),),
                    SizedBox(height: 15,),
                    Container(
                      width: 330,
                      height: 595,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.pink.withOpacity(0.7),
                              Colors.blue.withOpacity(0.7),
                            ],
                          ),
                          color: Colors.blue.withOpacity(0),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                        child: Column(children: [

                          SizedBox(height: 20,),
                          SingleChildScrollView(
                            child: Column(

                              children: [
                                Container(
                                    width: 330,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: Offset(0, 2), // changes position of shadow
                                        ),
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),

                                    ),
                                    child:
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      child: Image(image:AssetImage("assets/yhwifi.png")),
                                    )
                                ),
                                Container(
                                  height: 40,
                                ),
                                //   height: 60,child: Padding(
                                //   padding: const EdgeInsevar set = ts.all(8.0),
                                Container(
                                  width: 330,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black.withOpacity(0.2),
                                      width: 1,
                                    ),
                                    color: Colors.blue.withOpacity(0),
                                    borderRadius: BorderRadius.circular(15),

                                  ),
                                  child:
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
                                    child: Row(
                                      children: [
                                        Container(
                                            width: 80,
                                            child: Text("SSID ",style: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 17,fontWeight: FontWeight.bold),)),
                                        Container(width: 17,child: Text(":",style: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 17,fontWeight: FontWeight.bold),)),
                                        Text(wifiName,style: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 17,fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width:double.infinity,
                                  height: 10,
                                ),
                                Container(
                                  width: 330,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black.withOpacity(0.2),
                                      width: 1,
                                    ),
                                    color: Colors.white.withOpacity(0),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child:
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
                                    child: Row(
                                      children: [
                                        Container(
                                            width: 100,
                                            child: Text("BSSID",style: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 17,fontWeight: FontWeight.bold),)),
                                        Container(width: 17,child: Text(":",style: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 17,fontWeight: FontWeight.bold),)),
                                        Text(wifiBSSID,style: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 13,fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width:double.infinity,
                                  height: 10,
                                ),
                                Container(
                                  width: 330,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black.withOpacity(0.2),
                                      width: 1,
                                    ),
                                    color: Colors.white.withOpacity(0),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child:
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
                                    child: Row(
                                      children: [
                                        Container(
                                            width: 80,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                              child: Text("PASS",style: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 15,fontWeight: FontWeight.bold),),
                                            )),
                                        Container(child: Text(":",style: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 17,fontWeight: FontWeight.bold),)),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                                          child: SizedBox(
                                            width:160,
                                            child: TextFormField(
                                              cursorColor: Colors.black.withOpacity(0.5),
                                              style: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 17,fontWeight: FontWeight.bold),
                                              controller: new TextEditingController.fromValue(new TextEditingValue(text: _pass_config.toString(),selection: new TextSelection.collapsed(offset: _pass_config.toString().length))),
                                              onChanged: (value) => _pass_config = value,
                                              decoration: const InputDecoration(
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Color(0xFFFF00)),
                                                ),
                                                enabledBorder: const OutlineInputBorder(
                                                  // width: 0.0 produces a thin "hairline" border
                                                  borderSide: const BorderSide(color: Colors.white),
                                                ),
                                                // border: OutlineInputBorder(),
                                                // labelText: '',
                                                // labelStyle: TextStyle(color: Colors.pink)
                                              ),
                                              obscureText:_showpass_config,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: (){
                                            setState(() {
                                              _showpass_config = !_showpass_config;
                                            });
                                          },
                                          color: Colors.black.withOpacity(0.7),
                                          icon: Icon(!_showpass_config?Icons.remove_red_eye:Icons.remove_red_eye_outlined),),

                                      ],
                                    ),
                                  ),

                                ),
                                Container(height: 40,),
                                Material(
                                  borderRadius: BorderRadius.circular(20),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap:(){
                                      Connect();
                                    },
                                    child: Container(
                                      width: 150,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.grey.withOpacity(0.4),
                                            Colors.grey.withOpacity(0.7),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                      ),
                                      child:Center(child: Text("CONNECT",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
                                    ),
                                  ),
                                ),
                                SizedBox(height:10),

                                      Material(
                                        borderRadius: BorderRadius.circular(20),
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(20),
                                          onTap:(){
                                            setNetwork();
                                          },
                                          child: Container(
                                            width: 150,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.grey.withOpacity(0.4),
                                                  Colors.grey.withOpacity(0.7),
                                                ],
                                              ),
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.white,
                                            ),
                                            child:Center(child:
                                            // Icon(Icons.refresh,color: Colors.white,size: 40,),
                                              Text("RESET",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],),
                      ),
                    ),
                  ],
                ),
              )
          ),
        )
    );
  }
  Future<void> setNetwork() async {
    try {
      var result = await Permission.location.status;
      if (result.isGranted){
        if (await Permission.location.serviceStatus.isEnabled){
          ScaffoldMessenger.of(context).clearSnackBars();

          NetworkInfo _wifiInfo = NetworkInfo();
          var Name = await _wifiInfo.getWifiName();
          var BSSID = await _wifiInfo.getWifiBSSID();
          print(Name);
          print(BSSID);
          setState((){
            wifiName = Name.toString();
            wifiName = wifiName.substring(1,wifiName.length-1);
            wifiBSSID = BSSID.toString();
          }
          );
        }

        else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Please turn on service location!"),
          ));
          return setNetwork();
        }}
      else if (!result.isGranted){
        await Permission.location.request();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please turn on GPS!"),
        ));
        return setNetwork();
      }

    }
    on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("No connect wifi!"),
      ));
    }
  }

  Future<void> Connect() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center (child:CircularProgressIndicator()));

    final provisioner = Provisioner.espTouch();
    try {
      await provisioner.start(ProvisioningRequest.fromStrings(
        ssid: wifiName,
        bssid: wifiBSSID,
        password: _pass_config.toString(),
      ));
      await Future.delayed(Duration(seconds: 20));
      Navigator.of(context).pop();
    } catch (e, s) {
      Navigator.of(context).pop();
      _showMyDialog("ERROR! Please connect again!");

    }
    provisioner.listen((response) {
      _showMyDialog("Device [$response] is connected wifi!");
    });
    provisioner.stop();
  }

  Future<void> _showMyDialog(String print) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notification!'),
          content: SingleChildScrollView(
            child: Text(
                print
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}