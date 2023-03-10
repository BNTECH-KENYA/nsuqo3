import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cat_Home_New_UI extends StatelessWidget {
  const Cat_Home_New_UI({Key? key, required this.image_path,
    required this.cat_name,
    required this.icon,
   required this.new_item
  }) : super(key: key);

  final image_path,cat_name;
  final icon;
  final new_item;
  @override
  Widget build(BuildContext context) {
    return  Container(
      width:MediaQuery.of(context).size.width * 0.4,

      height:180,
      decoration: BoxDecoration(

      color: Colors.grey[900],
        borderRadius: BorderRadius.all(Radius.circular(20))

      ),
      child: Column(

          children:[
            SizedBox(height: 20,),
      /*
            Image(
                height: 70,
                width: 70,
                fit: BoxFit.contain,
                image: AssetImage("${image_path}")),
       */
            Icon(icon, size: 40,color: Colors.grey[300],),
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
                          color: Colors.grey[300],
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
