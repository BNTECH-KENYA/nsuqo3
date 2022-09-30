import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Single_Message extends StatefulWidget {
  const Single_Message({Key? key}) : super(key: key);

  @override
  State<Single_Message> createState() => _Single_MessageState();
}

class _Single_MessageState extends State<Single_Message> {

  List<Color> colors_list=[

    Colors.deepOrange, Colors.blue, Colors.deepPurpleAccent, Colors.lightGreen,
    Colors.pinkAccent, Colors.yellowAccent,Colors.purple, Colors.greenAccent,
    Colors.orange, Colors.teal, Colors.brown, Colors.limeAccent

  ];

  int color_count = 1;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.only(left:16.0, right:16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.arrow_back_ios, size:30, color: Colors.grey[800],),
                          SizedBox(width: 10,),
                          Text(
                            "Brian Ngatia",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800]
                          ),

                          ),
                        ],
                      ),

                      Icon(Icons.delete, size:30, color: Colors.grey[800],),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height-120,
                child:Stack(
                  children: [

                    ListView(
                      children: [

                      ],
                    ),


                  ],
                )
              )
            ],
          )),
    );
  }
}
