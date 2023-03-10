import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/models/categories_model.dart';
import 'package:nsuqo/models/filters_params.dart';
import 'package:nsuqo/models/subcategory_model.dart';

import '../models/subsubcategory_model.dart';

class Select_Sub_Sub_Category extends StatefulWidget {
  const Select_Sub_Sub_Category({Key? key, required this.subcategoryId}) : super(key: key);
  final String subcategoryId;

  @override
  State<Select_Sub_Sub_Category> createState() => _Select_Sub_Sub_CategoryState();
}

class _Select_Sub_Sub_CategoryState extends State<Select_Sub_Sub_Category> {

  FirebaseFirestore db = FirebaseFirestore.instance;

  bool isLoading = true;

  List<SubSubCategoriesModel> subsubcategories = [];

  List<Color> colors_list=[

    Colors.deepOrange, Colors.blue, Colors.deepPurpleAccent, Colors.lightGreen,
    Colors.pinkAccent, Colors.yellowAccent,Colors.purple, Colors.greenAccent,
    Colors.orange, Colors.teal, Colors.brown, Colors.limeAccent

  ];
  int color_increment = 0;


  Future <void> get_subsubcategories() async{

    final service_listings = db.collection("subsubcategories")
        .where("subcategoryid", isEqualTo: widget.subcategoryId);

    await service_listings.get().then((ref) {
      setState(
              () {

                ref.docs.forEach((element) {

                  if(color_increment == 11)
                  {
                    color_increment = 0;
                  }

                  subsubcategories.add(
                      SubSubCategoriesModel(
                        sub_sub_category_name: element.data()['subsubcategoryname'],
                        sub_category_id: element.id,
                        color: colors_list[color_increment],)
                  );


                  color_increment++;
                });

            isLoading = false;
          }
      );
    });

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

        () async{

      await get_subsubcategories();

    }();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: InkWell(
            onTap:(){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white,)),
        title: Text("Select Product Sub Sub Category", style:TextStyle(
            color:Colors.white
        )),

      ),
      body: ListView.builder(
          itemCount: subsubcategories.length,
          itemBuilder: (context, index){
            return InkWell(
              onTap:(){

                Navigator.pop(context,subsubcategories[index] );

              },

              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.category_outlined, color:Colors.grey[800]),
                    title: Text("${subsubcategories[index].sub_sub_category_name}"),
                  ),
                ),
              ),

            );

          }
      ),

    );
  }
}
