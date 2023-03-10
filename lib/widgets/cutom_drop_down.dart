import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../services/api_client.dart';

Widget customDropDrown(
    List<String> items,
    String value,
    void onChange(val, new_val),
    String amounttoconvert,
    String from,
    String to,
    String exchange_rate,
    BuildContext context
    )

{
  return Container(
      padding:EdgeInsets.symmetric(vertical:4.0, horizontal:18.0),
      decoration:BoxDecoration(
          color:Colors.white,
          borderRadius:BorderRadius.circular(8.0)
      ),
      child:DropdownButton<String>(
        value:value,
        onChanged:(String? val)
        async {
            if(val == "KES"){

              if(exchange_rate == "0")
              {
                Toast.show("Exchange rate no set".toString(), context,duration:Toast.LENGTH_SHORT,
                    gravity: Toast.BOTTOM);

              }
              else if((amounttoconvert.split("_")[1]) == "KES")
                {

                }
              else{
                String result =  (double.parse(amounttoconvert.split("_")[0])*double.parse(exchange_rate)).toStringAsFixed(3);
                onChange(val, "${result}_KES");
              }

            }
            else if(val == "USD"){

              if(exchange_rate == "0")
                {

                  Toast.show("Exchange rate no set".toString(), context,duration:Toast.LENGTH_SHORT,
                      gravity: Toast.BOTTOM);

                }
              else if((amounttoconvert.split("_")[1]) == "USD")
              {

              }
              else{
                String result =   (double.parse(amounttoconvert.split("_")[0]) / double.parse(exchange_rate)).toStringAsFixed(3);
                onChange(val, "${result}_USD");
              }
            }

          //onChange(val, result);

        },

        items: items.map<DropdownMenuItem<String>>((String val)
        {
          print(items);
          print(amounttoconvert);
          print(val);
          return DropdownMenuItem<String>(
            child:Text(val, style: TextStyle(
              fontSize: 11
            ),),
            value:val,
          );
        }).toList(),
      )
  );
}