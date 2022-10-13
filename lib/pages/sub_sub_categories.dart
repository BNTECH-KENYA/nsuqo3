import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/subsubcategory_model.dart';
import 'home_page_products.dart';

class Sub_Sub_Categories extends StatefulWidget {
  const Sub_Sub_Categories({Key? key,required this.cat, required this.subcat}) : super(key: key);
  final String cat,subcat;

  @override
  State<Sub_Sub_Categories> createState() => _Sub_Sub_CategoriesState();
}

class _Sub_Sub_CategoriesState extends State<Sub_Sub_Categories> {

  FirebaseFirestore db = FirebaseFirestore.instance;

  bool isLoading = true;

  List<SubSubCategoriesModel> subsubcategories = [];

  Future <void> get_subsubcategories() async{

    final service_listings = db.collection("subsubcategories")
        .where("subcategoryname", isEqualTo: widget.subcat);

    await service_listings.get().then((ref) {
      setState(
              () {

            ref.docs.forEach((element) {
              subsubcategories.add(
                  SubSubCategoriesModel(
                      sub_sub_category_name: element.data()['subsubcategoryname'],
                      sub_category_id: element.id,)
              );


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

                    child: Icon(Icons.arrow_back, color: Colors.grey[800], size: 30,)),
                SizedBox(height: 20,),
                Text("${widget.subcat}",style:TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                    fontSize:18
                )),
                SizedBox(height: 10,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: subsubcategories.length *45,
                  child: ListView.builder(
                      itemCount: subsubcategories.length,

                      itemBuilder:(BuildContext context, int index) {
                        return InkWell(
                          onTap: (){
                            Navigator.of(context).push(
                                MaterialPageRoute
                                  (builder: (context)=>Home_Page_Products(
                                  subcategory: widget.subcat,
                                  category: widget.cat,
                                   subsubcategory: subsubcategories[index].sub_sub_category_name,)));
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
                                    child: Text("${subsubcategories[index].sub_sub_category_name}",
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
