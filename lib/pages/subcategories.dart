import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubCategories_Page extends StatefulWidget {
  const SubCategories_Page({Key? key}) : super(key: key);

  @override
  State<SubCategories_Page> createState() => _SubCategories_PageState();
}

class _SubCategories_PageState extends State<SubCategories_Page> {

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

                            Navigator.pop(context,sub_categories[index]);

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
