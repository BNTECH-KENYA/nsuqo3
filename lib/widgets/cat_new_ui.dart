import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cat_New_Ui extends StatelessWidget {
  const Cat_New_Ui({Key? key, required this.category, required this.imagepath}) : super(key: key);
  final String category,imagepath;


  @override
  Widget build(BuildContext context) {
    return CircleAvatar(

      radius: 55,
      backgroundColor: Colors.white,

      child:
      Center(
        child:
        SizedBox(
          height: 80,
          width: 80,
          child: Column(
            children: [
              SizedBox(height: 10,),
              Image(
                height: 35,
                  width: 35,
                  fit: BoxFit.contain,
                  image: AssetImage("${imagepath}")),
              Text("${category}",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
                fontSize: 13
              ),)
            ],
          ),
        ),
      ),

    );
  }
}


/*

border design

  decoration: BoxDecoration(
          borderRadius:BorderRadius.only(topLeft: Radius.circular(90),topRight: Radius.circular(70),
            bottomLeft: Radius.circular(70),bottomRight: Radius.circular(70), ),
          color: Colors.white,

      ),

 */