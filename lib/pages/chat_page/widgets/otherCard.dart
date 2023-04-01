
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../models/messagemodel.dart';
import '../../product_information/product_information.dart';

class ReplCard extends StatelessWidget {

  const ReplCard({Key? key, required this.messageModel}) : super(key: key);
  final MesssageModel messageModel;

  @override
  Widget build(BuildContext context) {

    return InkWell(

      onTap:(){
        if(messageModel.product_id == "not")
        {

        }
        else
        {

          Navigator.of(context).push(
              MaterialPageRoute
                (builder: (context)=>(
                  Product_Information(document_id:messageModel.product_id , )
              )));

        }
      },
      child: Column(
        children: [

          SizedBox(height:10),

          Text(messageModel.time_ui, style: TextStyle(
            fontSize: 13,
            color: HexColor("#001E2F"),
          ),),

          messageModel.product_id == "not"?Container(): SizedBox(height:15),

          messageModel.product_id == "not"?Container(): SizedBox(height:5),

          messageModel.product_id == "not"?Container():
          ConstrainedBox(

            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 45,

            ),

            child: Row(
              children: [
                Container(
                 child: Column(
                   children: [
                     Container(),
                     SizedBox(height:150),
                     CircleAvatar(
                        radius: 24,
                        backgroundColor: HexColor("#1A434E"),
                        child: Text("${messageModel.name[0].toUpperCase()}", style: TextStyle(
                            color: HexColor("#FFFFFF"),
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                        ),),
                      ),
                   ],
                 ),
                ),

                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width -100,

                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Card(
                      color: HexColor("#FFFFFF"),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                      ),
                      //color: Color(0xffdcf8c6),
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Stack(
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10,
                                right: 60,
                                top: 5,
                                bottom: 20
                            ),
                            child:
                            Column(
                              children: [

                                messageModel.product_photo == "" ?

                                Image(

                                  image: AssetImage(
                                      "assets/comps.jpeg"
                                  ),

                                  height: 150,
                                  width:MediaQuery.of(context).size.width * 0.45,
                                )
                                    :Image(

                                  image: NetworkImage(
                                      messageModel.product_photo
                                  ),

                                  height: 150,
                                  width:MediaQuery.of(context).size.width * 0.45,
                                ),

                                SizedBox(width:10),

                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minWidth:MediaQuery.of(context).size.width * 0.45,
                                    maxWidth: MediaQuery.of(context).size.width * 0.45,
                                  ),
                                  child: Column(

                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      Text("${messageModel.product_name}",
                                          style: TextStyle(
                                            fontSize: 16,
                                              color: HexColor("#001E2F")
                                          )),

                                      SizedBox(height:5),

                                      Text("at ${messageModel.product_price}",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: HexColor("#001E2F"),
                                          )),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 45,

              ),
              child: Row(
                children: [
                  SizedBox(width: 20,),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: HexColor("#1A434E"),
                    child: Text("${messageModel.name[0].toUpperCase()}", style: TextStyle(
                        color: HexColor("#FFFFFF"),
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),),
                  ),

                  Card(
                    color: HexColor("#FFFFFF"),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                    ),
                    //color: Color(0xffdcf8c6),
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10,
                              right: 60,
                              top: 5,
                              bottom: 20
                          ),
                          child: Column(
                            children: [
                              Text("${messageModel.message}",
                                  style: TextStyle(
                                      fontSize: 16,
                                    color: HexColor("#001E2F")
                                  )),

                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 4,
                          right: 10,

                          child: Row(
                            children: [
                              Text(messageModel.time_ui, style: TextStyle(
                                fontSize: 13,
                                color:  HexColor("#001E2F"),
                              ),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
