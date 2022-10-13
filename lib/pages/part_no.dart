import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/products_model.dart';

class Part_No extends StatefulWidget {
  const Part_No({Key? key, required this.item_models}) : super(key: key);
  final List<Item_Model> item_models;

  @override
  State<Part_No> createState() => _Part_NoState();
}

class _Part_NoState extends State<Part_No> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        leading: Icon(Icons.star, color:Colors.white),
        title: Text("Part No:"),
      ),
      body:  ListView.builder(
          itemCount: widget.item_models.length,
          itemBuilder: (context, index){
            return InkWell(
              onTap:(){

                Navigator.pop(context,widget.item_models[index].partno );

              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.star, color:Colors.grey[800]),
                    title: Text("${widget.item_models[index].partno}"),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
