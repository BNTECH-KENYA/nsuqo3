import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../models/messagemodel.dart';
import '../../product_information/product_information.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({Key? key, required this.messageModel}) : super(key: key);
  final MesssageModel messageModel;
  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){

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
          messageModel.product_id == "not"?Container():     SizedBox(height:10),
          messageModel.product_id == "not"?Container():
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 45,

            ),
            child: Align(
                alignment: Alignment.centerRight,
              child: Card(
                color: HexColor("#F5F5F5"),
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

                            height: 200,
                            width:MediaQuery.of(context).size.width * 0.7,
                            image: AssetImage(
                                "assets/comps.jpeg"
                            ),

                          ) :Image(

                            image: NetworkImage(
                                messageModel.product_photo
                            ),

                            height: 200,
                            width:MediaQuery.of(context).size.width * 0.7,
                          ),

                          SizedBox(width:10),

                          ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width * 0.7,),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${messageModel.product_name}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: HexColor("#001E2F"),
                                      fontWeight: FontWeight.w400
                                    )),

                                SizedBox(height:5),

                                Text("at ${messageModel.product_price}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: HexColor("#74777F"),
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

            alignment: Alignment.centerRight,
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 45,
                ),

              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
                ),
                color: HexColor("#1A434E"),
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
                          Text(messageModel.message,
                          style: TextStyle(
                            fontSize: 16,
                            color:HexColor("#FFFFFF")
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
                              color:HexColor("#FFFFFF")
                          ),),
                        ],
                      ),

                    ) ,
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
