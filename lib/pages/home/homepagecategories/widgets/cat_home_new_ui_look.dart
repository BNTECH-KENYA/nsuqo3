import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Cat_Home_New_UI extends StatelessWidget {
  const Cat_Home_New_UI({Key? key, required this.image_path,
    required this.cat_name,
    required this.icon,
   required this.new_item,
   required this.hexcolor
  }) : super(key: key);

  final image_path,cat_name;
  final icon;
  final new_item;
  final hexcolor;
  @override
  Widget build(BuildContext context) {
    return  Container(
      width:MediaQuery.of(context).size.width * 0.45,
      height:180,
      decoration: BoxDecoration(

      color: HexColor(hexcolor),
        borderRadius: BorderRadius.all(Radius.circular(20))

      ),
      child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

          children:[
            SizedBox(height: 20,),
      /*
            Image(
                height: 70,
                width: 70,
                fit: BoxFit.contain,
                image: AssetImage("${image_path}")),
       */
            Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  //color: Colors.white
                ),
                child: Card(

                    child:Icon(icon, size: 40,color: Colors.grey[700],)

                )),

            SizedBox(height: 50,),

            Padding(
              padding: const EdgeInsets.only(right:8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Text("${cat_name}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: HexColor("#1A434E"),
                          fontWeight: FontWeight.w500,
                          fontSize: 13
                      ),),
                  ),

                  new_item ?    Container(
                      width: 30,
                      height: 30,
                      child:
                      Stack(
                        children: [
                           Icon(Icons.notifications, color:Colors.blue[300]),
                          Positioned(
                              top:0,
                              right:10,
                              child: CircleAvatar(
                                radius: 5,
                            backgroundColor: Colors.deepOrange,
                            child: Text("1", style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 4
                            ),),
                          ))
                        ],
                      )):Container()
                ],
              ),
            ),

          ]
      ),
    );
  }
}
