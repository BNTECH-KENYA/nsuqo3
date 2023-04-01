import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/pages/product_information/product_information.dart';

import 'models/products_model.dart';

class Categories_Grid extends StatelessWidget {
  const Categories_Grid({Key? key, required this.category, required this.items}) : super(key: key);

  final List<Item_Model> items;
  final String category;

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left:8.0, right:8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category,
                  style: TextStyle(
                      color: Colors.grey[850],
                      fontSize: 18,
                      fontWeight: FontWeight.w600

                  ),
                ),

                Icon(Icons.arrow_forward_ios, size: 25,color: Colors.grey[800],),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 280,
            child: GridView.builder(
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.7,
                ),
                itemBuilder:(context,index) {

                    return InkWell(
                      onTap:(){

                        Navigator.of(context).push(
                            MaterialPageRoute
                              (builder: (context)=>Product_Information(document_id:items[index].itemId,))
                        );
                      },
                      child: Container(
                      height:110,
                      child: Stack(
                      children: [
                      Padding(
                      padding: const EdgeInsets.only(left:8.0, right:8.0),
                      child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                      borderRadius:BorderRadius.all( Radius.circular(2), ),
                      image: DecorationImage(
                      image: NetworkImage(items[index].photosLinks[0]),
                      fit:BoxFit.cover,

                      )
                      ),

                      ),
                      ),
                      Positioned(
                      top: 80,
    child: SizedBox(
    width: 90,
    child: Text("${items[index].itemname} ${items[index].itemdescription}",textAlign: TextAlign.center, style:TextStyle(
    color: Colors.grey[600],
    fontSize: 10
    )),
    ),
    ),

    ],
    ),
    ),
                    );
                }
              ),
          ),
        ],
      ),
    );
  }
}
