import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/models/wholesalers_model.dart';

import '../pages/products_listing.dart';
import '../pages/wholesalerinfo.dart';

class Wholesaler_Tile extends StatelessWidget {

  const Wholesaler_Tile({Key? key, required this.wholesaler_model}) : super(key: key);
  final Wholesalers_Model wholesaler_model;

  @override
  Widget build(BuildContext context) {
    /*
                  FirebaseFirestore
                      .instance
                      .collection("contributionsupdate")
                      .where("groupid", isEqualTo:course!.id.toString() ).snapshots();

                   */

    // TODO: implement build

    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 23,
            backgroundColor:wholesaler_model.bgcolor,
            child: Text("${wholesaler_model.company_name[0]}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),),
          ),
          title: Text("${wholesaler_model.company_name}",
              style:TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                color: Colors.white,
              )),

          subtitle: Text("located in ${wholesaler_model.location}",
              style:TextStyle(
                  fontSize: 13,
                color: Colors.white,
              )),



        ),

        Padding(
          padding: const EdgeInsets.only(left:20.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height:40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                InkWell(
                  onTap:(){
                    Navigator.of(context).push(
                        MaterialPageRoute
                          (builder: (context)=>WholeSaler_Info( wholesalerid:wholesaler_model.wholesalerid,)));


                  },
                  child: Container(
                    width:MediaQuery.of(context).size.width *0.4,
                    decoration:BoxDecoration(
                      color:wholesaler_model.bgcolor,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Center(
                      child: Text("View Information", style: TextStyle(
                        color: Colors.white,
                        fontSize: 12
                      ),),
                    ),
                  ),
                ),

                InkWell(
                  onTap:(){
                    Navigator.of(context).push(
                        MaterialPageRoute
                          (builder: (context)=>Product_List( wholesaler_id:wholesaler_model.wholesalerid,)));

                  },
                  child: Container(
                    width:MediaQuery.of(context).size.width *0.4,
                    decoration:BoxDecoration(
                      color:wholesaler_model.bgcolor,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Center(
                      child: Text("View Products", style: TextStyle(
                        color: Colors.white,
                        fontSize: 12
                      ),),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(right: 20, left: 80),
          child: Divider(
            thickness: 1,
          ),
        ),

      ],
    );
  }
}


