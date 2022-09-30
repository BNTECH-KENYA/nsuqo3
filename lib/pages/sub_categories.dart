import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page_products.dart';

class Sub_Categories extends StatefulWidget {
  const Sub_Categories({Key? key, required this.subcat}) : super(key: key);
  final String subcat;

  @override
  State<Sub_Categories> createState() => _Sub_CategoriesState();
}

class _Sub_CategoriesState extends State<Sub_Categories> {




  List<String> sub_categories = ["ACCER","Lenovo","Dell","Hp","Canon","HoneyWell"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left:16.0, right:16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30,),
                Icon(Icons.arrow_back, color: Colors.grey[800], size: 30,),
                SizedBox(height: 20,),
                Text("Computing",style:TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                    fontSize:18
                )),
                SizedBox(height: 10,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: sub_categories.length *45,
                  child: ListView.builder(
                      itemCount: sub_categories.length,

                      itemBuilder:(BuildContext context, int index) {
                        return InkWell(
                          onTap: (){
                            Navigator.of(context).push(
                                MaterialPageRoute
                                  (builder: (context)=>Home_Page_Products( subcategory: sub_categories[index],)));
                          },

                          child: Card(
                            color: Colors.white,
                            child: Container(

                              width: MediaQuery.of(context).size.width,
                              height: 35,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left:16.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text("${sub_categories[index]}",
                                      style: TextStyle(
                                        color: Colors.grey[600],

                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            ),
                          ),
                        );
                      }),
                )

              ],
              
            ),
          )),

    );
  }
}
