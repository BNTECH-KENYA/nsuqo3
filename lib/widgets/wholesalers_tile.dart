import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/models/wholesalers_model.dart';

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
                  fontWeight: FontWeight.bold
              )),

          subtitle: Text("located in ${wholesaler_model.location}",
              style:TextStyle(
                  fontSize: 13
              )),

          trailing: Icon(Icons.read_more_sharp, color:Colors.grey[600]),

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


