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

                            backgroundColor: Colors.deepOrange,
                            child:Text(retailer_model.retailer_name[0], style: TextStyle(color: Colors.white),)
                        ),
                        SizedBox(width: 10,),
                        Container(
                          width: MediaQuery.of(context).size.width-90,
                          height: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(retailer_model.retailer_name),
                              Text(retailer_model.retailer_email),
                              Text(retailer_model.company_name),
                              Text(retailer_model.retailer_phonenumber),
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
