import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/models/categories_model.dart';

class Select_Category extends StatefulWidget {
  const Select_Category({Key? key}) : super(key: key);

  @override
  State<Select_Category> createState() => _Select_CategoryState();
}

class _Select_CategoryState extends State<Select_Category> {

  FirebaseFirestore db = FirebaseFirestore.instance;

  bool isLoading = true;
  List<CategoriesModel> categories = [];

  Future <void> get_categories() async{

    final service_listings = db.collection("categories");

    await service_listings.get().then((ref) {
      setState(
              () {

            ref.docs.forEach((element) {

              categories.add(
                CategoriesModel(
                    category_name: element.data()['categoryname'],
                    category_id: element.id)
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

    () async{

      await get_categories();

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
          itemCount: categories.length,
          itemBuilder: (context, index){
            return InkWell(
              onTap:(){

                Navigator.pop(context,categories[index] );


              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.category_outlined, color:Colors.grey[800]),
                    title: Text("${categories[index].category_name}"),
                  ),
                ),
              ),
            );
          }
      ),

    );
  }
}
