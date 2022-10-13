import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/products_model.dart';

class Resolution extends StatefulWidget {
  const Resolution({Key? key, required this.item_models}) : super(key: key);
  final List<Item_Model> item_models;

  @override
  State<Resolution> createState() => _ResolutionState();
}

class _ResolutionState extends State<Resolution> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        leading: Icon(Icons.arrow_back, color:Colors.white),
        title: Text("Resolution:"),
      ),
      body:  ListView.builder(
          itemCount: widget.item_models.length,
          itemBuilder: (context, index){
            return widget.item_models[index].resolution == ""? Container():  InkWell(
              onTap:(){

                Navigator.pop(context,widget.item_models[index].resolution );

              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.star, color:Colors.grey[800]),
                    title: Text("${widget.item_models[index].resolution}"),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
