import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../models/products_model.dart';
import '../../../../services/api_client.dart';
import '../../../../widgets/cutom_drop_down.dart';

class Product_Tile extends StatefulWidget {

  const Product_Tile({Key? key, required this.item_model, required this.exchange_rate}) : super(key: key);
  final Item_Model item_model;
  final String exchange_rate;

  @override
  State<Product_Tile> createState() => _Product_TileState();
}

class _Product_TileState extends State<Product_Tile> {

  List<String> currencies1= ["USD","KES"];
  String ? newcurrency;

   String from = "KES";
   String to = "USD";

  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    (){
      setState(
          (){
            from =  widget.item_model.itemprice.contains("_")?
            widget.item_model.itemprice.split("_")[1]:
            "NOT SET";
            to = widget.item_model.itemprice.contains("_")?
            widget.item_model.itemprice.split("_")[1] == "KES"? "USD":"KES":"NOT SET";
            widget.item_model.itemprice.contains("_")?
            newcurrency = widget.item_model.itemprice.split("_")[0]:widget.item_model.itemprice ;
          }
      );
    }();
  }

  Widget build(BuildContext context) {
    /*
                  FirebaseFirestore
                      .instance
                      .collection("contributionsupdate")
                      .where("groupid", isEqualTo:course!.id.toString() ).snapshots();

                   */

    // TODO: implement build


    return Container(
      width:MediaQuery.of(context).size.width * 0.45,
      height:150,
      decoration: BoxDecoration(

        color:HexColor("#FFFFFF")

      ),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          widget.item_model.photosLinks.length == 0 ? Image(

              height: 50,
              width: MediaQuery.of(context).size.width * 0.45,
              image: AssetImage("assets/computing.jpeg")

          ):
            Image(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.45,
                image: NetworkImage(widget.item_model.photosLinks[0],)),

            Text("${widget.item_model.itemname}", style: TextStyle(
              color: HexColor("#1A434E"),
              fontSize: 14,
              fontWeight: FontWeight.w500
            ),),
            SizedBox(height:6),
            Text("PartNo ${widget.item_model.partno}", style: TextStyle(
              color:HexColor("#1A434E"),
              fontSize: 10,
              fontWeight: FontWeight.w400
            ),),

            SizedBox(height:5),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Text("Price ${  widget.item_model.itemprice.split("_")[1] == "USD"?
                widget.item_model.itemprice.split("_")[0]:(double.parse(widget.item_model.itemprice.split("_")[0])/double.parse(widget.exchange_rate)).toStringAsFixed(3)
                } usd", style: TextStyle(
                  color:HexColor("#1A434E"),
                  fontSize: 14,
                  fontWeight: FontWeight.w500
                ),),

              ],
            ),

            Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Container(
                  width:50,
                  height:50,
                  decoration: BoxDecoration(
                    color: HexColor("#1A434E"),
                    borderRadius: BorderRadius.only(

                      topLeft: Radius.elliptical(10, 10),
                      topRight: Radius.circular(10),
                      bottomRight: Radius.elliptical(10, 10),

                    )
                  ),
                  child: Center(
                      child: Text("view", style: TextStyle(
                        color: HexColor("#FFFFFF"),
                        fontSize: 7.55,
                      ),)
                  ),
                ),

                Row(
                  children: [
                    Text("${
                        widget.item_model.itemprice.split("_")[1] == "USD"?
                    (double.parse(widget.item_model.itemprice.split("_")[0])*double.parse(widget.exchange_rate)).toStringAsFixed(3)
                    :widget.item_model.itemprice.split("_")[0]}", style: TextStyle(
                      color: HexColor("#1A434E"),
                      fontSize: 20.03,
                      fontWeight: FontWeight.w500

                    ),),

                    Text("KES", style: TextStyle(
                        color: HexColor("#1A434E"),
                        fontSize: 18.03,
                        fontWeight: FontWeight.w500
                    ),),

                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
/*
    return Card(
      color:Colors.grey[900],
      child: Column(
        children: [
          ListTile(
            leading: widget.item_model.photosLinks.length >0?
      Container(
      width:50,
        height:100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
           image: NetworkImage(widget.item_model.photosLinks[0],),
            fit: BoxFit.cover
          )
        ),
      ):Container(
              width:50,
              height:100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[700],
              ),
            ),
            title: Column(
              children: [
                SizedBox(height:20),
                Text("${widget.item_model.itemname}",
                    style:TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      color: Colors.grey[200]
                    )),
              ],
            ),
            subtitle: !widget.item_model.itemprice.contains("_")? Container() :Container(
              width: MediaQuery.of(context).size.width-200,
              child:
              Column(
                children: [

                  Column(
                    children: [
                      SizedBox(height:5),
                      Text(
                          "Price at $from ${ newcurrency!.contains("_")?newcurrency!.split("_")[0]:newcurrency!}"
                              " or ${widget.item_model.itemprice.split("_")[1] == "USD"?
                          " \n KES " +(double.parse(widget.item_model.itemprice.split("_")[0])*double.parse(widget.exchange_rate)).toStringAsFixed(3) :
    (double.parse(widget.item_model.itemprice.split("_")[0]) / double.parse(widget.exchange_rate)).toStringAsFixed(3)+" _USD"}"
                          "\n conversion rate at ${widget.exchange_rate}",
                          style:TextStyle(
                              fontSize: 13,
                              color: Colors.grey[400]
                          )),
                    ],
                  ),

                ],
              ),
            ),
            trailing: Text("${widget.item_model.partno}", style: TextStyle(
              fontSize: 8,
              color:Colors.grey[400]
            ),),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1,
            ),
          ),

        ],
      ),
    );
 */
  }
}


