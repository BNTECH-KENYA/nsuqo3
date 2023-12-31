/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../models/subsubcategory_model.dart';
import '../../home/homepageproducts/home_page_products.dart';
import '../../wholesalersproductlist/wholesalers_product_list.dart';
import '../wholesaler_specific_products.dart';

class Sub_Sub_Categories_on_wholesaleraccnt extends StatefulWidget {
  const Sub_Sub_Categories_on_wholesaleraccnt({Key? key,required this.cat, required this.subcat, required this.subsubcategory, required this.wholesalerid}) : super(key: key);
  final String cat,subcat, wholesalerid;
  final List<dynamic> subsubcategory;

  @override
  State<Sub_Sub_Categories_on_wholesaleraccnt> createState() => _Sub_Sub_Categories_on_wholesaleraccntState();
}

class _Sub_Sub_Categories_on_wholesaleraccntState extends State<Sub_Sub_Categories_on_wholesaleraccnt> {

  FirebaseFirestore db = FirebaseFirestore.instance;

  bool isLoading = true;

  List<SubSubCategoriesModel> subsubcategories = [];
  List<Color> colors_list=[

    Colors.grey[800]!, Colors.grey[700]!, Colors.black, Colors.grey[800]!,
    Colors.grey[700]!, Colors.black, Colors.grey[800]!, Colors.grey[700]!,
    Colors.grey[800]!, Colors.grey[700]!, Colors.black, Colors.grey[800]!,

  ];
  int color_increment = 0;
  Future <void> get_subsubcategories() async{

    final service_listings = db.collection("subsubcategories")
        .where("subcategoryname", isEqualTo: widget.subcat);

    await service_listings.get().then((ref) {
      setState(
              () {

            ref.docs.forEach((element) {

              if(color_increment == 11)
              {
                color_increment = 0;
              }

              print("${widget.subsubcategory.contains(element.data()['subsubcategoryname'])}");
              print("${widget.subsubcategory}");
              if(widget.subsubcategory.contains(element.data()['subsubcategoryname']))
                {


                  subsubcategories.add(
                      SubSubCategoriesModel(
                        sub_sub_category_name: element.data()['subsubcategoryname'],
                        sub_category_id: element.id,
                        color: colors_list[color_increment],)
                  );

                }



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

    ()async{

      await get_subsubcategories();

    }();
  }

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
                InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },

                    child: Icon(Icons.arrow_back, color: HexColor("#1A434E"), size: 30,)),
                SizedBox(height: 20,),
                Text("${widget.subcat}",style:TextStyle(
                    fontWeight: FontWeight.w600,
                    color: HexColor("#1A434E"),
                    fontSize:18
                )),
                SizedBox(height: 10,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: subsubcategories.length *65,
                  child: ListView.builder(
                      itemCount: subsubcategories.length,

                      itemBuilder:(BuildContext context, int index) {
                        return InkWell(
                          onTap: (){
                            Navigator.of(context).push(
                                MaterialPageRoute
                                  (builder: (context)=>Home_Page_Products_specific(
                                  subcategory: widget.subcat,
                                  category: widget.cat,
                                   subsubcategory: subsubcategories[index].sub_sub_category_name,
                                  wholesalerid: widget.wholesalerid,)));
                          },

                          child:Card(
                            color: Colors.grey[200],
                            child: Container(

                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child:
                              Padding(
                                padding: const EdgeInsets.only(left:0.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: subsubcategories[index].color,
                                      child: Text("${subsubcategories[index].sub_sub_category_name[0].toUpperCase()}${subsubcategories[index].sub_sub_category_name[1].toUpperCase()}",

                                        style: TextStyle(
                                            color: Colors.grey[200],
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                    title: Text("${subsubcategories[index].sub_sub_category_name}",
                                      style: TextStyle(
                                        color: HexColor("#1A434E"),

                                      ),
                                    ),
                                    trailing: Icon(Icons.arrow_forward_ios, size: 20, color: HexColor("#1A434E"),),
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

 */