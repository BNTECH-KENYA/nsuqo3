import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/retailers_model.dart';

class Retailers_view_products extends StatelessWidget {
  const Retailers_view_products({Key? key, required this.retailer_model}) : super(key: key);
  final Retailers_Model retailer_model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 150,

        child: Card(
          color: Colors.grey[900],
          shadowColor: Colors.white,
          child: Stack(

            children: [
              Positioned(
                bottom: 10,
                right: 10,
                child:
                retailer_model.can_view ? CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.check, color: Colors.white),
                ): Container(),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                child:
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,

                      children:[

                        CircleAvatar(

                          radius: 30,
                            backgroundColor: Colors.grey[700],
                            child:Text(retailer_model.retailer_name[0],
                              style: TextStyle(color: Colors.white),)
                        ),
                        SizedBox(width: 10,),
                        Container(
                          width: MediaQuery.of(context).size.width-110,
                          height: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height:20),
                              Text(retailer_model.retailer_name, style: TextStyle(
                                color:Colors.grey[200]
                              ),),
                              Text(retailer_model.retailer_email, style: TextStyle(
                                  color:Colors.grey[200]
                              ),),
                              Text(retailer_model.company_name,  style: TextStyle(
                                  color:Colors.grey[200]
                              )),
                              Text(retailer_model.retailer_phonenumber, style: TextStyle(
                                  color:Colors.grey[200]
                              )),
                            ],
                          ),
                        )

                      ]
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
