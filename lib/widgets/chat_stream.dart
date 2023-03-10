import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/models/messanger.dart';

import '../pages/chat_page.dart';

class Chat_Stream_Widget extends StatelessWidget {
  const Chat_Stream_Widget({Key? key,
    required this.messagermodel,
    required this.groupuid,
    required this.fun,
  }) : super(key: key);

  final MessangerModel messagermodel;
  final String groupuid;
  final Function fun;

  @override
  Widget build(BuildContext context) {


    FirebaseFirestore db = FirebaseFirestore.instance;

    Future<void> update_chat_Stream( )

    async {

      final stream = <String, dynamic>{

        "unrdmessage":0,

      };

      await db.collection("oneChatStream").doc(groupuid).update(stream);

      fun();

    }

    return     Padding(
      padding: const EdgeInsets.only(bottom:16.0),
      child: InkWell(
        onTap: () async {

          if(messagermodel.sender_email != messagermodel.auth_email)
            {
             await update_chat_Stream();
              }

          Navigator.of(context).push(
              MaterialPageRoute
                (builder: (context)=>Chat_Page(
                product_name: "not",
                product_photo: "",
                product_description: "not",
                product_price: "not",
                wholesaler_id: messagermodel.wholesaler_id_mm,
                retailer_id:messagermodel.retailer_id_mm ,
                email_reciever:messagermodel.reciever_email,
                email_user: messagermodel.sender_email,
                sender_name:messagermodel.sender_name,
                opponent_name:messagermodel.opponent_name,
                auth_email: messagermodel.auth_email, product_id: "not",

              )));

        },
        child: Container(
            width: MediaQuery.of(context).size.width,
            child:Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  child: Stack(
                    children: [

                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[800],
                        child: Text("${messagermodel.sender_name[0].toUpperCase()}", style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                        ),),
                      ),

                     messagermodel.unreadmsg < 1 ? Container() :Positioned(
                          right: 10,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.blue,
                            child: Text("${messagermodel.unreadmsg}", style: TextStyle(
                                color: Colors.white
                            ),),
                          )),
                    ],
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height:10),

                      Container(
                        width:MediaQuery.of(context).size.width-102,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${messagermodel.sender_name}", style: TextStyle(
                              color: Colors.grey[200],
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),),
                            Text("${messagermodel.timstamp}", style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),),

                          ],
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(messagermodel.sender_email, style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),),

                      SizedBox(height: 15,),

                      Container(
                        width: MediaQuery.of(context).size.width-102,
                        child: Text("${messagermodel.ltsmessage}", style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),),
                      ),

                    ],
                  ),
                )
              ],
            )
        ),
      ),
    );
  }
}
