import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/products_model.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key, required this.item_models}) : super(key: key);
  final List<Item_Model> item_models;

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Icon(Icons.arrow_back, color:Colors.white),
        title: Text("Screen:"),
      ),
      body:  ListView.builder(
          itemCount: widget.item_models.length,
          itemBuilder: (context, index){
            return widget.item_models[index].screen == ""? Container():  InkWell(
              onTap:(){

                Navigator.pop(context,widget.item_models[index].screen );

              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.star, color:Colors.grey[800]),
                    title: Text("${widget.item_models[index].screen}"),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
