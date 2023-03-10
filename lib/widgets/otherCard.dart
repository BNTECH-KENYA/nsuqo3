
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/messagemodel.dart';
import '../pages/product_information.dart';

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
          messageModel.product_id == "not"?Container(): SizedBox(height:15),

          messageModel.product_id == "not"?Container(): SizedBox(height:5),

          messageModel.product_id == "not"?Container():
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 45,

            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Card(
                color: Colors.grey[700],
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
                      Row(
                        children: [

                          messageModel.product_photo == "" ?

                          Image(

                            image: AssetImage(
                                "assets/comps.jpeg"
                            ),

                            width:50,
                            height:50,
                          )
                              :Image(

                            image: NetworkImage(
                                messageModel.product_photo
                            ),

                            width:50,
                            height:50,
                          ),

                          SizedBox(width:10),

                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width - 105,),
                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text("${messageModel.product_name}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[200],
                                    )),

                                SizedBox(height:20),

                                Text("${messageModel.product_description}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[200],
                                    )),

                                SizedBox(height:20),

                                Text("${messageModel.product_price}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[200],
                                    )),

                              ],
                            ),
                          ),
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
                            color: Colors.grey[200],
                          ),),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 45,

              ),
              child: Card(
                color: Colors.grey[700],
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
                                color: Colors.grey[200],
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
                            color: Colors.grey[200],
                          ),),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
