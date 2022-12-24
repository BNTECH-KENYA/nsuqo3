import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cat_New_Ui_cc extends StatelessWidget {
  const Cat_New_Ui_cc({Key? key, required this.cat_name}) : super(key: key);
  final String cat_name;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(

      radius: 65,

      child:
      Center(
        child:
        SizedBox(
          height: 80,
          width: 80,
          child: Column(
            children: [
              SizedBox(height: 10,),
              Icon(Icons.category_outlined,size: 42, color: Colors.grey[200],),
              Text(cat_name, style: TextStyle(
                color: Colors.grey[200],
                fontWeight: FontWeight.bold,
                fontSize:12,

              ),)
            ],
          ),
        ),
      ),

    );
  }
}
