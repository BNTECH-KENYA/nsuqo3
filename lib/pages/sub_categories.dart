import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/pages/sub_sub_categories.dart';

import '../models/filters_params.dart';
import '../models/subcategory_model.dart';
import 'home_page_products.dart';

class Sub_Categories extends StatefulWidget {
  const Sub_Categories({Key? key, required this.subcat}) : super(key: key);
  final String subcat;

  @override
  State<Sub_Categories> createState() => _Sub_CategoriesState();
}

class _Sub_CategoriesState extends State<Sub_Categories> {

  FirebaseFirestore db = FirebaseFirestore.instance;

  bool isLoading = true;

  List<SubCategoriesModel> subcategories = [];

  Future <void> get_subcategories() async{

    final service_listings = db.collection("subcategories")
        .where("categoryname", isEqualTo: widget.subcat);

    await service_listings.get().then((ref) {
      setState(
              () {

            ref.docs.forEach((element) {
              subcategories.add(
                  SubCategoriesModel(
                      sub_category_name: element.data()['subcategoryname'],
                      filters_params_model: Filters_Params_Model(
                          availability: element.data()['filters_params']['availability'],
                          warrant_period:element.data()['filters_params']['warrant_period'],
                          moq: element.data()['filters_params']['moq'],
                          partno:element.data()['filters_params']['partno'],
                          company_name: element.data()['filters_params']['company_name'],
                          location: element.data()['filters_params']['location'],
                          ram: element.data()['filters_params']['ram'],
                          processor:element.data()['filters_params']['processor'],
                          screen: element.data()['filters_params']['screen'],
                          brand: element.data()['filters_params']['brand'],
                          resolution: element.data()['filters_params']['resolution'],
                          storage: element.data()['filters_params']['storage'],
                          screensize: element.data()['filters_params']['screensize'],
                          partner: element.data()['filters_params']['partner'],
                          package: element.data()['filters_params']['package'],
                          size: element.data()['filters_params']['size']),
                          sub_category_id: element.id,


                  )
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

      await get_subcategories();

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
                  height: subcategories.length *45,
                  child: ListView.builder(
                      itemCount: subcategories.length,

                      itemBuilder:(BuildContext context, int index) {
                        return InkWell(
                          onTap: (){
                            Navigator.of(context).push(
                                MaterialPageRoute
                                  (builder: (context)=>Sub_Sub_Categories(  subcat: subcategories[index].sub_category_name, cat: widget.subcat,)));
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
                                    child: Text("${subcategories[index].sub_category_name}",
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
