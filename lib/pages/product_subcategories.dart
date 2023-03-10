import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/models/categories_model.dart';
import 'package:nsuqo/models/filters_params.dart';
import 'package:nsuqo/models/subcategory_model.dart';

class Select_Sub_Category extends StatefulWidget {
  const Select_Sub_Category({Key? key, required this.categoryId}) : super(key: key);
  final String categoryId;

  @override
  State<Select_Sub_Category> createState() => _Select_Sub_CategoryState();
}

class _Select_Sub_CategoryState extends State<Select_Sub_Category> {

  FirebaseFirestore db = FirebaseFirestore.instance;

  bool isLoading = true;

  List<SubCategoriesModel> subcategories = [];
  List<Color> colors_list=[

    Colors.deepOrange, Colors.blue, Colors.deepPurpleAccent, Colors.lightGreen,
    Colors.pinkAccent, Colors.yellowAccent,Colors.purple, Colors.greenAccent,
    Colors.orange, Colors.teal, Colors.brown, Colors.limeAccent

  ];

  int color_increment =0;

  Future <void> get_subcategories() async{

    final service_listings = db.collection("subcategories")
        .where("categoryid", isEqualTo: widget.categoryId);

    await service_listings.get().then((ref) {
      setState(
              () {

            ref.docs.forEach((element) {

              if(color_increment == 11)
                {
                  color_increment = 0;
                }
              subcategories.add(
                  SubCategoriesModel(
                      sub_category_name: element.data()['subcategoryname'],
                      sub_category_id: element.id,
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
                      color: colors_list[color_increment]),

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

      await get_subcategories();

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
        title: Text("Select Product Category", style:TextStyle(
            color:Colors.white
        )),

      ),
      body: ListView.builder(
          itemCount: subcategories.length,
          itemBuilder: (context, index){
            return InkWell(
              onTap:(){

                Navigator.pop(context,subcategories[index] );


              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.category_outlined, color:Colors.grey[800]),
                    title: Text("${subcategories[index].sub_category_name}"),
                  ),
                ),
              ),
            );
          }
      ),

    );
  }
}
