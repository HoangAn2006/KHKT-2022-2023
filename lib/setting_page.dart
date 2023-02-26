import 'package:flutter/material.dart';

class Setting extends StatefulWidget{
  @override
  SettingState createState() => SettingState();
}

class SettingState extends State<Setting>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Center(
              child: Container(
                height: 660,
                decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //   begin: Alignment.topRight,
                  //   end: Alignment.bottomLeft,
                  //   colors: [
                  //     Colors.black,Colors.blue.withOpacity(0.7),
                  //     Colors.pink.withOpacity(0.7),Colors.black,
                  //     // Colors.black,
                  //
                  //     // Colors.orange,
                  //
                  //   ],
                  // ),
                    color: Colors.white.withOpacity(1)), //Color(0xC9DFDFE8)),
                child: Column(
                  children: [
                    Container(height: 35,
                      decoration: BoxDecoration(color: Colors.black),),
                    Container(
                      width: 360,
                      height: 625,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.pink.withOpacity(0.7),
                            Colors.blue.withOpacity(0.7),
                            // Colors.black,

                            // Colors.orange,

                          ],
                        ),
                        // border: Border.all(
                        //   color: Colors.white,
                        //   width: 2,
                        // ),
                        color: Colors.blue.withOpacity(0),
                        // borderRadius: BorderRadius.circular(20)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                        child: Column(children: [

                          SingleChildScrollView(
                            child: Column(

                              children: [
                                Container(
                                    width: 360,
                                    height: 60,
                                    decoration: BoxDecoration(

                                      // border: Border.all(
                                      //   color: Colors.white,
                                      //   width: 1,
                                      // ),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.grey.withOpacity(0.7),
                                          Colors.grey.withOpacity(0.5),


                                        ],
                                      ),

                                      color: Colors.blue,
                                      // borderRadius: BorderRadius.circular(15),

                                    ),
                                    child:
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.chevron_left,color: Colors.white,size: 40,),
                                              Text("Setting",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 23),),
                                            ],
                                          ),
                                        ),

                                      ],
                                    )

                                ),

                                Container(
                                  height: 50,
                                  width: 360,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.3)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 15, 200, 0),
                                    child: Text("Settings",style: TextStyle(color: Colors.black.withOpacity(0.6),fontWeight: FontWeight.bold,fontSize: 16),),
                                  ),
                                ),

                                //   height: 60,child: Padding(
                                //   padding: const EdgeInsevar set = ts.all(8.0),

                                Container(
                                  height: 50,
                                  width: 360,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black26,
                                        width: 1,
                                      ),
                                      color: Colors.white
                                  ),
                                  child: Row(
                                    children: [SizedBox(width:15),
                                      Text("  Notification Setting",style: TextStyle(color: Colors.black.withOpacity(0.3),fontWeight: FontWeight.bold,fontSize: 17),),
                                      SizedBox(width: 137,),
                                      Icon(Icons.chevron_right,color: Colors.black.withOpacity(0.5),size: 40,),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 360,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black26,
                                        width: 1,
                                      ),
                                      color: Colors.white
                                  ),
                                  child: Row(
                                    children: [SizedBox(width:15),
                                      Text("  Language",style: TextStyle(color: Colors.black.withOpacity(0.3),fontWeight: FontWeight.bold,fontSize: 17),),
                                      SizedBox(width: 211,),
                                      Icon(Icons.chevron_right,color: Colors.black.withOpacity(0.5),size: 40,),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 360,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.3)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 15, 200, 0),
                                    child: Text("Support",style: TextStyle(color: Colors.black.withOpacity(0.6),fontWeight: FontWeight.bold,fontSize: 16),),
                                  ),
                                ),

                                //   height: 60,child: Padding(
                                //   padding: const EdgeInsevar set = ts.all(8.0),

                                Container(
                                  height: 50,
                                  width: 360,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black26,
                                        width: 1,
                                      ),
                                      color: Colors.white
                                  ),
                                  child: Row(
                                    children: [SizedBox(width:15),
                                      Text("  Helps",style: TextStyle(color: Colors.black.withOpacity(0.3),fontWeight: FontWeight.bold,fontSize: 17),),
                                      SizedBox(width: 242,),
                                      Icon(Icons.chevron_right,color: Colors.black.withOpacity(0.5),size: 40,),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 360,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black26,
                                        width: 1,
                                      ),
                                      color: Colors.white
                                  ),
                                  child: Row(
                                    children: [SizedBox(width:15),
                                      Text("  About",style: TextStyle(color: Colors.black.withOpacity(0.3),fontWeight: FontWeight.bold,fontSize: 17),),
                                      SizedBox(width: 240,),
                                      Icon(Icons.chevron_right,color: Colors.black.withOpacity(0.5),size: 40,),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
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

}