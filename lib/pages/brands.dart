import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/products_model.dart';

class Brands extends StatefulWidget {
  const Brands({Key? key, required this.item_models}) : super(key: key);
  final List<Item_Model> item_models;

  @override
  State<Brands> createState() => _BrandsState();
}

class _BrandsState extends State<Brands> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        leading: Icon(Icons.arrow_back, color:Colors.white),
        title: Text("Brands:"),
      ),
      body:  ListView.builder(
          itemCount: widget.item_models.length,
          itemBuilder: (context, index){
            return widget.item_models[index].brand == ""? Container():  InkWell(
              onTap:(){

                Navigator.pop(context,widget.item_models[index].brand );

              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.star, color:Colors.grey[800]),
                    title: Text("${widget.item_models[index].brand}"),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
