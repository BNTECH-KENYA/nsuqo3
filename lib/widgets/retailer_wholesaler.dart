import 'dart:io';
import 'package:flutter/material.dart';

import '../pages/create_account_retailer.dart';
import '../pages/create_account_wholesaler.dart';
import '../pages/sign_up_retailer.dart';
import '../pages/sign_up_wholesaler.dart';

Future<bool> Retailer_Wholesaler(context) async{
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text("Choose Account Type?"),

                SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute
                                (builder: (context)=>Sign_Up_Wholesaler()));
                        },
                        child: Text("Wholesaler"),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green.shade800),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute
                                  (builder: (context)=>Sign_Up_Retailer()));
                          },
                          child: Text("Retailer", style: TextStyle(color: Colors.green)),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        );
      });
}