import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/products_model.dart';

class Product_Tile extends StatelessWidget {

  const Product_Tile({Key? key, required this.item_model}) : super(key: key);
  final Item_Model item_model;

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
            radius: 30,
            backgroundImage: NetworkImage(item_model.photosLinks[0]),
          ),
          title: Text("${item_model.itemname}",
              style:TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              )),
          subtitle: Text("${item_model.availability} at ${item_model.itemprice}  usd",
              style:TextStyle(
                  fontSize: 13
              )),
          trailing: Text("part no:1234"),
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


