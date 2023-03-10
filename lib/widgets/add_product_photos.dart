import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Product_Photos extends StatelessWidget {
  const Product_Photos({Key? key, required this.path,required this.fun }) : super(key: key);
  final String path;
  final Function fun;

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Stack(
        children: [
          Container(
            height: 280,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.grey[500]!
                ),

                borderRadius:BorderRadius.all( Radius.circular(2), ),
                image: DecorationImage(
                  image: FileImage(File(path)),
                  fit:BoxFit.contain,

                )
            ),


          ),
          Positioned(
            bottom: 10,
            right: 10,
            child:
            InkWell(
                onTap:(){

                  fun();

                },
                child: Icon(Icons.remove_circle, size: 30, color:Colors.white)),)
        ],
      ),
    );
  }
}
