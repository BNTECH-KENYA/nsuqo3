import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/pages/filter_by.dart';
import 'package:nsuqo/pages/product_information.dart';
import 'package:nsuqo/pages/search_page.dart';
import 'package:nsuqo/pages/sign_in.dart';

import '../models/products_model.dart';
import '../widgets/products_tile.dart';
import 'messanger.dart';

class Home_Page_Products extends StatefulWidget {
  const Home_Page_Products({Key? key, required this.subcategory}) : super(key: key);
  final String subcategory;

  @override
  State<Home_Page_Products> createState() => _Home_Page_ProductsState();
}

class _Home_Page_ProductsState extends State<Home_Page_Products> {

  FirebaseFirestore db = FirebaseFirestore.instance;

  List<Item_Model> products = [];
  List<Item_Model> search_results = [ ];

  bool isLoading= true;

  Future<void> get_Products() async {

    // remember to change to required data
    final service_listings = db.collection("products").where("subcategory", isEqualTo: widget.subcategory);

    await service_listings.get().then((ref) {
      print("redata 1 &****************************${ref.docs}");
      setState(
              () {

            ref.docs.forEach((element) {
              print(element.data()['productname']);

              products.add(
                  Item_Model(

                    availability:element.data()['availability'],
                    itemname: element.data()['productname'],
                    itemId: element.id,
                    itemprice: element.data()['productprice'],
                    itemdescription: element.data()['productdescription'],
                    category: element.data()['category'],
                    photosLinks:element.data()['photosLinks'],
                    wholesalerid: element.data()['wholesalerid'],
                    warrant_period: element.data()['warrantperiod'],
                    no_of_clicks: element.data()['noofclicks'],

                  )

              );
              search_results.add(
                  Item_Model(

                    availability:element.data()['availability'],
                    itemname: element.data()['productname'],
                    itemId: element.id,
                    itemprice: element.data()['productprice'],
                    itemdescription: element.data()['productdescription'],
                    category: element.data()['category'],
                    photosLinks:element.data()['photosLinks'],
                    wholesalerid: element.data()['wholesalerid'],
                    warrant_period: element.data()['warrantperiod'],
                    no_of_clicks: element.data()['noofclicks'],

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
        () async {
      await get_Products();
    }();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading? Container(
      width: MediaQuery.of(context).size.width,
      height:MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          borderRadius:BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15), ),
          color: Colors.deepOrange
      ),
      child: Center(child: CircularProgressIndicator(
        backgroundColor: Colors.white,
      ),),
    ) :Scaffold(

      body:  SafeArea(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height:20),
            Padding(
              padding: const EdgeInsets.only(left:16.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height:40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                            onTap:(){
                              Navigator.of(context).push(
                                  MaterialPageRoute
                                    (builder: (context)=>Filter_By()));

              },
                            child: Icon(Icons.menu, color:Colors.grey[800], size:30)),
                        SizedBox(width: 30,),
                        Text("${widget.subcategory}",
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 20,
                            fontWeight: FontWeight.w500,

                          ),),
                      ],
                    ),
                    SizedBox(height: 6,),
                    Container(
                      width: 80,
                      margin: EdgeInsetsDirectional.only(start: 1.0,end:1.0),
                      height: 0.0,
                      color: Colors.grey[800],
                    )


                  ],
                ),
              ),
            ),
            SizedBox(height: 5,),
            InkWell(
              onTap: (){

                Navigator.of(context).push(
                    MaterialPageRoute
                      (builder: (context)=>Search_Page())

                );
              },
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: TextField(

                    onChanged: (val){


                    },
                    decoration: InputDecoration(
                      hintText: "Search by name or PART no:",
                      hintStyle: TextStyle(
                        color: Colors.grey[500],

                      ),

                    ),
                  ),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: CircleAvatar(radius: 20,
                    backgroundColor: Colors.grey[800],
                    child: Icon(Icons.search, size: 30, color: Colors.grey[200],),),
                ),
              ),
            ),

          SizedBox(height: 20),

            Container(
              width: MediaQuery.of(context).size.width,
              height:MediaQuery.of(context).size.height-247,
              child: ListView.builder(
                        itemCount: search_results.length,
                        itemBuilder: (context, index){

                          return InkWell(
                              onTap:(){

                                Navigator.of(context).push(
                                    MaterialPageRoute
                                      (builder: (context)=>Product_Information(document_id: search_results[index].itemId,)));
                              },
                              child: Product_Tile(item_model: search_results[index],));

                        },
                      ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: BottomAppBar(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Container(
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(

                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).push(
                          MaterialPageRoute
                            (builder: (context)=>Sign_In())

                      );
                      //await Share.share("link to download app");
                    },

                    child: Container(
                      child: Column(
                        children: [
                          Icon(Icons.home, color:Colors.grey[500]),
                          Text(
                            'Home',
                            style: TextStyle(
                              color:Colors.grey[500],
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  InkWell(

                    onTap: (){

                      Navigator.of(context).push(
                          MaterialPageRoute
                            (builder: (context)=>Messanger()));
                    },

                    child: Container(
                      child: Column(
                        children: [
                          Icon(Icons.chat, color:Colors.grey[500]),
                          Text(
                            'Chats',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  InkWell(

                    onTap: (){

                    },

                    child: Container(
                      child: Column(
                        children: [
                          Icon(Icons.share, color:Colors.grey[500]),
                          Text(
                            'share',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  InkWell(

                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).push(
                          MaterialPageRoute
                            (builder: (context)=>Sign_In())

                      );
                      //await Share.share("link to download app");
                    },

                    child: Container(
                      child: Column(
                        children: [
                          Icon(Icons.person, color:Colors.grey[500]),
                          Text(
                            'profile',
                            style: TextStyle(
                              color:Colors.grey[500],
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}
