import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter_spinbox/cupertino.dart';
import 'builder.dart';

class Home extends StatefulWidget{
  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home>{
  late IOWebSocketChannel _channel;
  late bool _connected;
  late String _temp;
  late bool _isplay;
  late bool _isset_f;
  late bool _isset_l;

  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  List<String> list_sex = <String>['Male', 'Female', 'Other'];
  List<String> list_hand = <String>['Left', 'Right'];
  List<String> list_bone = <String>['Elbow', 'Arm'];
  late String dropdownValue = list.first;
  late String dropdownValue_Sex = list_sex.first;
  late String dropdownValue_Hand = list_hand.first;
  late String dropdownValue_Bone = list_bone.first;
  String? patient_name = "";
  String? patient_age = "";
  late double _speed = 0;
  late double _pos_first = 0;
  late double _pos_last = 0;
  late double _turn = 0;

  @override
  void initState() {
    _isplay = true;
    _connected = false;
    _isset_f = true;
    _isset_l = true;//initially connection status is "NO" so its FALSE
    Future.delayed(Duration.zero,() async {
      channelconnect(); //connect to WebSocket wth NodeMCU
    });

    super.initState();
  }

  channelconnect(){ //function to connect
    try{
      _channel = IOWebSocketChannel.connect("ws://192.168.0.1:81"); //channel IP : Port
      _channel.stream.listen((message) {
        print(message);
        setState(() {
          if(message == "connected"){
            _connected = true; //message is "connected" from NodeMCU
          }
          else if (message == "stopped"){
            _isplay = true;
            _isset_f = true;
            _isset_l = true;
          }
        });
      },
        onDone: () {
          //if WebSocket is disconnected
          print("Web socket is closed");
          setState(() {
            _connected = false;
            _isplay = true;
            _isset_f = true;
            _isset_l = true;
          });
        },
        onError: (error) {
          print(error.toString());
        },);
    }catch (_){
      print("error on connecting to websocket.");
    }
  }

  Future<void> sendcmd(String cmd) async {
    if(_connected == true){

      _channel.sink.add(cmd); //sending Command to NodeMCU

    }else{
      channelconnect();
      print("Websocket is not connected.");
    }
  }

  @override
  Widget build(BuildContext context) {
    Container_Sensor(String value,String field,IconData icon){
      return Container(
        width: 90,
        height: 115,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0),
          // border: Border.all(
          //   color: Colors.blue.withOpacity(0.5),
          //   width: 1,
          // ),

        ),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children:[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Container(
                      width: 70,
                      height: 60,
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(25),
                        shape:BoxShape.circle,
                        // gradient: LinearGradient(
                        //   begin: Alignment.topLeft,
                        //   end: Alignment.bottomRight,
                        //   colors: [
                        //     Colors.blue.withOpacity(0.8),
                        //     Colors.blue.withOpacity(0.6),
                        //     Colors.blue.withOpacity(0.5),
                        //   ],
                        // ),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                        // border:Border.all(
                        //   width: 5,
                        //   color: Colors.white.withOpacity(0.3)
                        // ),
                        color: Colors.white,
                      ),
                      child: Icon(icon,color: Colors.black.withOpacity(0.7),size: 30,)),
                  SizedBox(height: 5,),
                  Text(field,style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 12,fontWeight: FontWeight.bold),),
                   Text(value,style: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 15,fontWeight: FontWeight.bold),),

                ],
              ),

            ]
          ),
        )
      );
    }
    Container_Control_Device(String device_name,IconData icon,Color color){
      return Container(
        width: 100,
        height: 152,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              color.withOpacity(0.6),
              color.withOpacity(1),
            ],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 25, 15, 15),
          child: Column(
            children: [
              Container(
                  width: 90,
                  height: 70,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: color.withOpacity(0.4),
                        width: 5,
                      ),

                      color: Colors.white,
                      shape: BoxShape.circle
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(icon,size: 30,color: color.withOpacity(0.7),),
                  )),
              SizedBox(height: 9,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(device_name,style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 18)),
                ],
              ),
            ],),
        ),
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height:48,),
          Center(
            child: Material(
              borderRadius: BorderRadius.circular(15),
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                focusColor: Colors.black,
                onTap:() async{
                  await _showAlert();
                  setState(() {

                  });
                },
                child: Container(
                    width: 330,
                    height: 80,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                      // gradient: LinearGradient(
                      //   begin: Alignment.topLeft,
                      //   end: Alignment.bottomRight,
                      //   colors: [
                      //     Colors.blue.withOpacity(1),
                      //
                      //     Colors.pink.withOpacity(0.5),
                      //   ],
                      // ),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 15,),
                            // FloatingActionButton.small(onPressed: (){},child:Icon(Icons.manage_accounts,color: Colors.blue.withOpacity(0.5),),backgroundColor: Colors.white,),
                            CircleAvatar(backgroundColor: Colors.blue.withOpacity(0.5),radius: 25,child: Icon(Icons.manage_accounts,color: Colors.white,),),
                            SizedBox(width:10,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[

                                Text(patient_name.toString()==""?"Hide name":patient_name.toString(),style: TextStyle(color: Colors.black,fontSize: 10,fontWeight: FontWeight.bold),),
                                Text(dropdownValue_Sex,style: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 15,fontWeight: FontWeight.bold),),
                                Text(patient_age.toString()==""?"Hide":"${patient_age.toString()} years old",style: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 15,fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ],
                        ),

                      ],
                    )
                ),
              ),
            ),
          ),
          SizedBox(height: 5,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Material(
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () async{
                      if (_connected){
                      await _Dialog_Y_N();
                      setState(() {
                      });}
                    },
                    child: Container_Control_Device("STOP", Icons.stop,Colors.red)),
              ),

              Material(
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: (){
                      if (!_connected){
                        channelconnect();
                      }
                      else {
                        sendcmd("{\"NAME\":\"${patient_name.toString()}\",\"AGE\":\"${patient_age.toString()}\",\"SEX\":\"${dropdownValue_Sex}\",\"HAND\":\"${dropdownValue_Hand}\",\"BONE\":\"${dropdownValue_Bone}\",\"SPEED\":\"${_speed}\",\"NUM TURN\":\"${_turn.ceil()}\"}");
                      }
                    },
                    child: Container_Control_Device("RELOAD", Icons.downloading,Colors.green)),
              ),

              Material(
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap:(){
                      if (_connected) {
                        if (_isplay) {
                          sendcmd("{\"STATE\":\"play\",\"NAME\":\"${patient_name
                              .toString()}\",\"AGE\":\"${patient_age
                              .toString()}\",\"SEX\":\"${dropdownValue_Sex}\",\"HAND\":\"${dropdownValue_Hand}\",\"BONE\":\"${dropdownValue_Bone}\",\"SPEED\":\"${_speed}\",\"POS FIRST\":\"${_pos_first
                              .ceil()}\",\"POS LAST\":\"${_pos_last
                              .ceil()}\",\"NUM TURN\":\"${_turn.ceil()}\"}");
                        }
                        else {
                          sendcmd("{\"STATE\":\"pause\"}");
                        }
                        setState(() {
                          _isplay = !_isplay;
                        });
                      }
                    },
                    child: Container_Control_Device(_isplay?"PLAY":"PAUSE", _isplay?Icons.play_arrow:Icons.pause,_isplay?Colors.blue:Colors.yellow)),
              ),
            ],
          ),
          SizedBox(height: 5,),
          Container(
            width: 330,
            height: 55,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(child: Text(_connected?"CONNECTED":"DISCONNECTED",style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _connected?Colors.red:Colors.black,
            ),)),
          ),
          SizedBox(height: 5,),
              Container(
                width: 300,
                height: 255,
                decoration: BoxDecoration(
                  // border: Border.all(
                  //   color: Colors.blue.withOpacity(0.5)
                  // ),
                  border:Border.all(
                      color: Colors.black.withOpacity(0.1)
                  ),
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 15, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container_Sensor(dropdownValue_Hand, "Hand Type", Icons.front_hand),
                                Container_Sensor(dropdownValue_Bone, "Bone Type", MdiIcons.bone),
                                Container_Sensor(_speed.ceil().toString(), "Speed", MdiIcons.playSpeed),
                              ],),

                        Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                    onTap:(){
                                      if (!_isplay){
                                      if (_isset_f){
                                        sendcmd("{\"POS FIRST\":\"Set\"}");
                                        _isset_f = false;
                                      }}
                                    },
                                    child: Container_Sensor(_isset_f?"Not Set":"Setted", "Pos First", Icons.looks_one)),
                                GestureDetector(
                                    onTap:(){
                                      if (!_isplay){
                                      if (_isset_l){
                                        sendcmd("{\"POS LAST\":\"Set\"}");
                                        _isset_l = false;
                                      }}
                                    },
                                    child: Container_Sensor(_isset_l?"Not Set":"Setted", "Pos Last", Icons.looks_one)),
                                Container_Sensor(_turn.ceil().toString(), "Turn", Icons.autorenew_rounded),
                              ],),
                      ],
                    )
                ),
              ),
        ],
      ),
    );
  }

  Future _showAlert() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content:  StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Container(
          height: 340,
          child: Column(
            children: [
              Container(
                width: 330.0,
                height: 280.0,
                decoration:  BoxDecoration(
                  color:  Color(0xFFFFFF),
                  borderRadius: BorderRadius.circular(15),
                ),
                child:  SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // dialog top

                             Container(
                              padding:  EdgeInsets.fromLTRB(85, 0, 0, 0),
                              decoration:  BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Text('Setting', style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold,)
                              ),
                            ),
                      SizedBox(height: 15,),
                         Container(
                           height: 45,
                            child:  TextFormField(
                              maxLength: 200,
                              cursorColor: Colors.black,
                              controller: new TextEditingController.fromValue(new TextEditingValue(text: patient_name.toString(),selection: new TextSelection.collapsed(offset: patient_name.toString().length))),
                              onChanged: (value) {
                                setState(() {
                                  patient_name = value;
                                });
                              },
                              decoration:  InputDecoration(
                                  counterText: '',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
                                ),
                                filled: false,
                                // hintText: 'Enter name of patient',
                                hintStyle:  TextStyle(color: Colors.grey.shade500, fontSize: 12.0,

                                ),
                                border: OutlineInputBorder(),
                                labelText: 'Patient Name',
                                labelStyle: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 14)
                              ),
                            )),
                      SizedBox(height: 10,),
                      Container(
                        height: 45,
                          child:  TextFormField(
                            maxLength: 3,
                            cursorColor: Colors.black,
                            controller: new TextEditingController.fromValue(new TextEditingValue(text: patient_age.toString(),selection: new TextSelection.collapsed(offset: patient_age.toString().length))),
                            onChanged: (value) => patient_age = value,
                            decoration:  InputDecoration(
                                counterText: '',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
                                ),
                                filled: false,
                                // hintText: 'Enter name of patient',
                                hintStyle:  TextStyle(color: Colors.grey.shade500, fontSize: 12.0,

                                ),
                                border: OutlineInputBorder(),
                                labelText: 'Patient age',
                                labelStyle: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 14)
                            ),
                          )),
                      SizedBox(height: 10,),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.5)
                          )
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 10,),
                            Container(
                                width:85,
                                child: Text("Sex: ",style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 14))),
                            DropdownButton<String>(
                              value: dropdownValue_Sex,
                              icon: const Icon(Icons.arrow_drop_down),
                              elevation: 16,
                              style: const TextStyle(color: Colors.black),
                              underline: Container(
                                height: 2,
                                color: Colors.black.withOpacity(0.5),
                              ),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  dropdownValue_Sex = value!;
                                });
                              },
                              items: list_sex.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Container(
                                      width: 50,
                                      child: Text(value)),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),SizedBox(height: 10,),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.5)
                            )
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 10,),
                            Container(
                              width:85,
                                child: Text("Arm Type: ",style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 14))),
                            DropdownButton<String>(
                              value: dropdownValue_Hand,
                              icon: const Icon(Icons.arrow_drop_down),
                              elevation: 16,
                              style: const TextStyle(color: Colors.black),
                              underline: Container(
                                height: 2,
                                color: Colors.black.withOpacity(0.5),
                              ),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  dropdownValue_Hand = value!;
                                });
                              },
                              items: list_hand.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Container(
                                      width: 50,
                                      child: Text(value)),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: Colors.black.withOpacity(0.5)
                      )
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 10,),
                      Container(
                          width:85,
                          child: Text("Bone Type: ",style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 14),)),
                      DropdownButton<String>(
                        value: dropdownValue_Bone,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue_Bone = value!;
                          });
                        },
                        items: list_bone.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                                width: 50,
                                child: Text(value)),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                      SizedBox(height: 10,),
                      Container(
                        height: 45,
                        child: SpinBox(
                          min: 5,
                          max: 30,
                          value: _speed,
                          decimals: 0,
                          step: 5,
                          acceleration: 5,
                          onChanged: (value)=> _speed = value,
                          decoration: InputDecoration(labelText: 'Speed'),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        height: 45,
                        child: SpinBox(
                          min: 0,
                          max: 100,
                          value: _turn,
                          decimals: 0,
                          step: 1,
                          acceleration: 1,
                          onChanged: (value)=> _turn = value,
                          decoration: InputDecoration(labelText: 'Turn'),
                        ),
                      ),
                      SizedBox(height: 10,),
                      // dialog bottom

                    ],
                  ),
                ),
              ),
              SizedBox(height: 7,),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child:  Container(
                  padding: EdgeInsets.all(16.0),
                  decoration:  BoxDecoration(
                      color:  Color(0xFF33b17c),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child:  Text(
                    'CONFIRM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontFamily: 'helvetica_neue_light',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );
        }
      ),
    )
  );

  Future _Dialog_Y_N() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Container(
          height: 90,
          child: Column(
            children:[
              SizedBox(height: 10,),
              Text("Are you sure stop device?"),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: (){
                    Navigator.of(context).pop();
                  },
                    child: Text("No",style: TextStyle(color: Colors.black),),style: ElevatedButton.styleFrom(fixedSize: Size(100, 40),backgroundColor: Colors.white),),
                  ElevatedButton(
                    onPressed: (){
                      sendcmd("{\"STATE\":\"stop\"}");
                      setState(() {
                        _isplay = true;
                        _isset_f = true;
                        _isset_l = true;
                      });
                      Navigator.of(context).pop();
                  },
                    child: Text("Yes",style: TextStyle(color: Colors.red),),style: ElevatedButton.styleFrom(fixedSize: Size(100, 40),backgroundColor: Colors.white),),
                ],
              )
            ]
          )
      ),
    )
  );
}





