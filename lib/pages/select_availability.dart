import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Availability extends StatelessWidget {
  const Availability({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Product Available", style:TextStyle(
            color:Colors.white
        )),
      ),

      body: Column(
        children: [
          InkWell(
            onTap: (){
              Navigator.pop(context,"available");
            },

            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.check_circle_outline, color:Colors.grey[800]),
                  title: Text("available ", ),
                ),
              ),
            ),
          ),



          InkWell(
            onTap:(){

              Navigator.pop(context,"not available");
                  },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.cancel_outlined, color:Colors.grey[800]),
                  title: Text("not available "),
                ),
              ),
            ),
          ),          InkWell(
            onTap:(){

              Navigator.pop(context,"Out Of Stock");
                  },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.cancel_outlined, color:Colors.grey[800]),
                  title: Text("Out Of Stock "),
                ),
              ),
            ),
          ),          InkWell(
            onTap:(){

              Navigator.pop(context,"Expected");
                  },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.escalator, color:Colors.grey[800]),
                  title: Text("Expected"),
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
}
