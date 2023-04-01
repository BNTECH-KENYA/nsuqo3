import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../models/products_model.dart';
import '../../../../services/api_client.dart';
import '../../../../widgets/cutom_drop_down.dart';

class Wholesaler_Product_Tile extends StatefulWidget {

  const Wholesaler_Product_Tile({Key? key, required this.item_model, required this.exchange_rate}) : super(key: key);
  final Item_Model item_model;
  final String exchange_rate;

  @override
  State<Wholesaler_Product_Tile> createState() => _Wholesaler_Product_TileState();

}


class _Wholesaler_Product_TileState extends State<Wholesaler_Product_Tile> {

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

    return Padding(

      padding: const EdgeInsets.only(bottom:0, top:20),

      child: Container(

        width: MediaQuery.of(context).size.width,

        decoration: BoxDecoration(
          color: Colors.white,
        ),

        child: Card(
          child: ListTile(
            leading:
            widget.item_model.photosLinks.length >0?
            Image(
                image:
                NetworkImage("${widget.item_model.photosLinks[0]}"))
                :
            Image(
                image:
                AssetImage("assets/computing.jpeg")),
            title: Text("${widget.item_model.itemname}", style: TextStyle(
              color:HexColor("#1A434E"),
              fontWeight: FontWeight.w500
            ),),
            subtitle: !widget.item_model.itemprice.contains("_")? Container() :Container(
              width: MediaQuery.of(context).size.width-200,
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                              color: HexColor("#1A434E")
                          )),
                    ],
                  ),

                ],
              ),
            ),
            trailing:  Text("${widget.item_model.partno}", style: TextStyle(
              fontSize: 8,
              color:HexColor("#1A434E")
          ),),
          ),
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


