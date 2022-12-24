import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/pages/product_information.dart';

import '../models/filters_params.dart';
import '../models/products_model.dart';
import '../widgets/products_tile.dart';
import 'add_product_from_catalogue.dart';

class Catalogue_Page extends StatefulWidget {
  const Catalogue_Page({Key? key}) : super(key: key);

  @override
  State<Catalogue_Page> createState() => _Catalogue_PageState();

}

class _Catalogue_PageState extends State<Catalogue_Page> {

  List<Item_Model> products = [];
  List<Item_Model> search_results = [];
  List<dynamic> filters = [];
  FirebaseFirestore db = FirebaseFirestore.instance;
  String ? user_email;
  bool isLoading= true;
  List<dynamic> whos_can_view = [];
  List<String> categories = ["Phones and Tablets", "Consumer Electronic", "Computing", "More"];

  bool phones_and_tablets = false;
  bool consumer_electronic = false;
  bool computing = false;
  bool More = false;
  bool all_cat = true;
  Future<void> get_Products() async {

    // remember to change to required data
    final service_listings = db.collection("catalogue");

    await service_listings.get().then((ref) {
      print("redata 1 &****************************${ref.docs}");
      setState(
              () {

            ref.docs.forEach((element) {
              print(element.data()['productname']);

              if(whos_can_view.contains(element.data()['wholesalerid']))
              {
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
                      partno: element.data()['partno'],
                      moq: element.data()['moq'],
                      searchalgopartnoname: "${ element.data()['partno']}${element.data()['productname']}",
                      company_name: element.data()['company_name'],
                      location: element.data()['location'],
                      ram: element.data()['ram'],
                      brand:element.data()['brand'],
                      storage: element.data()['storage'],
                      screen: element.data()['screen'],
                      processor: element.data()['processor'],
                      screensize: element.data()['screensize'],
                      resolution: element.data()['resolution'],
                      package: element.data()['package'],
                      partner: element.data()['partner'],
                      subcategory: element.data()['subcategory'],
                      subsubcategory: element.data()['subsubcategory'],
                      filters_params: Filters_Params_Model(
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
                      partno: element.data()['partno'],
                      moq: element.data()['moq'],
                      searchalgopartnoname: "${ element.data()['partno']}${element.data()['productname']}",
                      company_name: element.data()['company_name'],
                      location: element.data()['location'],
                      ram: element.data()['ram'],
                      brand:element.data()['brand'],
                      storage: element.data()['storage'],
                      screen: element.data()['screen'],
                      processor: element.data()['processor'],
                      screensize: element.data()['screensize'],
                      resolution: element.data()['resolution'],
                      package: element.data()['package'],
                      partner: element.data()['partner'],
                      subcategory: element.data()['subcategory'],
                      subsubcategory: element.data()['subsubcategory'],
                      filters_params: Filters_Params_Model(
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

                    )

                );
              }



            });

            isLoading = false;
          }
      );
    });

  }


  String ? location;
  String ? company_name;

  bool isWholesaler = false;
  Future<void> getUserData(user_email)
  async {
    final docref = db.collection("userdd").doc(user_email);
    await docref.get().then((res) async {

      if(res.data() != null)
      {
        if(res.data()!['accounttype'] =="wholesaler")
        {
          setState(
                  (){

                   location = res.data()!['location'];
                   company_name = res.data()!['company_name'];
                isLoading = false;
                isWholesaler = true;
              }
          );

        }
        else
        {

          whos_can_view = res.data()!['wholesaler_limit_list'];
          await get_Products();

          setState(
                  (){
                isLoading = false;
              }
          );
        }
      }
      else
      {
        setState(
                (){
              isLoading = false;
            }
        );
        print("out");
        FirebaseAuth.instance.signOut();

      }

    });

  }

  Future<void> checkAuth()async {
    await FirebaseAuth.instance
        .authStateChanges()
        .listen((user)
    {
      if(user != null)
      {
        getUserData(user.email);

      }
      else{
        setState(
                (){
              isLoading = false;
            }
        );

      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
        ()async{
      await checkAuth();
    }();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(width: 10,),
                  InkWell(
                      onTap:(){

                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back,color: Colors.grey[700] )),
                  SizedBox(width: 20,),
                  Text("Products List", style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 18,
                  ),),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0, right:8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  child:


                  ListView(
                    scrollDirection: Axis.horizontal,
                    children: [

                      InkWell(
                        onTap:(){

                          setState(

                                  (){
                                search_results = [];
                                all_cat = true;
                                phones_and_tablets = false;
                                consumer_electronic = false;
                                computing = false;
                                More = false;
                                products.forEach((element) {
                                  search_results.add(
                                      element
                                  );
                                });

                              }
                          );


                        },
                        child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              color: all_cat?  Colors.deepOrange :Colors.white,
                              borderRadius:BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color:all_cat?Colors.deepOrange: Colors.grey[500]! ),
                            ),
                            child:
                            Row(
                              children: [
                                SizedBox(width: 10,),
                                all_cat ?
                                Text("All",style: TextStyle( color: Colors.white), ):
                                Text("All",style: TextStyle( color: Colors.deepOrange), ),
                                SizedBox(width: 10,)
                              ],
                            )

                        ),
                      ),

                      SizedBox(width: 10,),

                      InkWell(
                        onTap:(){


                          setState(
                                  (){
                                search_results = [];
                                all_cat = false;
                                phones_and_tablets = true;
                                consumer_electronic = false;
                                computing = false;
                                More = false;
                                products.forEach((element) {
                                  if(element.category == "Phones and Tablets")
                                  {
                                    search_results.add(
                                        element
                                    );
                                  }

                                });
                              }
                          );

                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: phones_and_tablets? Colors.deepOrange:Colors.white,
                              borderRadius:BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color:phones_and_tablets?Colors.deepOrange: Colors.grey[500]! ),

                            ),
                            child:
                            Padding(
                              padding: const EdgeInsets.only(left:10.0, right:10.0, top:4.5),
                              child:phones_and_tablets?
                              Text("Phones and Tablets",style: TextStyle( color: Colors.white) )

                                  :
                              Text("Phones and Tablets",style: TextStyle( color: Colors.deepOrange), ),
                            )
                        ),
                      ),

                      SizedBox( width: 10,),

                      InkWell(
                        onTap:(){

                          setState(
                                  (){
                                search_results = [];
                                all_cat = false;
                                phones_and_tablets = false;
                                consumer_electronic = true;
                                computing = false;
                                More = false;
                                products.forEach((element) {
                                  if(element.category == "Consumer Electronic")
                                  {
                                    search_results.add(
                                        element
                                    );
                                  }

                                });
                              }
                          );
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: consumer_electronic? Colors.deepOrange:Colors.white,
                              borderRadius:BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color:consumer_electronic?Colors.deepOrange: Colors.grey[500]! ),
                            ),
                            child:
                            Padding(
                              padding: const EdgeInsets.only(left:10.0, right:10.0, top:4.5),                           child:consumer_electronic?
                            Text("Consumer Electronic",style: TextStyle( color: Colors.white) )
                                :
                            Text("Consumer Electronic",style: TextStyle( color: Colors.deepOrange), ),
                            )
                        ),
                      ),

                      SizedBox( width: 10,),

                      InkWell(
                        onTap:(){

                          setState(
                                  (){
                                search_results = [];
                                all_cat = false;
                                phones_and_tablets = false;
                                consumer_electronic = false;
                                computing = true;
                                More = false;
                                products.forEach((element) {
                                  if(element.category == "Computing")
                                  {
                                    search_results.add(
                                        element
                                    );
                                  }

                                });
                              }
                          );
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: computing? Colors.deepOrange:Colors.white,
                              borderRadius:BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color:computing?Colors.deepOrange: Colors.grey[500]! ),


                            ),
                            child:
                            Padding(
                              padding: const EdgeInsets.only(left:10.0, right:10.0, top:4.5),

                              child:computing?
                              Text("Computing",style: TextStyle( color: Colors.white) )
                                  :
                              Text("Computing",style: TextStyle( color: Colors.deepOrange), ),
                            )
                        ),
                      ),

                      SizedBox( width: 10,),

                      InkWell(
                        onTap:(){

                          setState(
                                  (){
                                search_results = [];
                                all_cat = false;
                                phones_and_tablets = false;
                                consumer_electronic = false;
                                computing = false;
                                More = true;
                                products.forEach((element) {
                                  if(element.category == "More")
                                  {
                                    search_results.add(
                                        element
                                    );
                                  }

                                });
                              }
                          );
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: More? Colors.deepOrange:Colors.white,
                              borderRadius:BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color:More?Colors.deepOrange: Colors.grey[500]! ),

                            ),
                            child:
                            Padding(
                              padding: const EdgeInsets.only(left:10.0, right:10.0, top:4.5),
                              child:More?
                              Text("More",style: TextStyle( color: Colors.white) )
                                  :
                              Text("More",style: TextStyle( color: Colors.deepOrange), ),
                            )
                        ),
                      ),

                    ],
                  ),
                ),
              ),

              SizedBox(height: 20,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height-164,
                child:ListView.builder(
                  itemCount: search_results.length,
                  itemBuilder: (context, index){

                    return InkWell(
                        onTap:(){
                          Navigator.of(context).push(
                              MaterialPageRoute
                                (builder: (context)=>Add_Products_Catalogue(
                                location: location!,
                                user_email: user_email!,
                                company_name: company_name!,
                                item_Model: search_results[index],)));
                        },
                        child: Product_Tile(item_model: search_results[index],));

                  },
                ),
              )

            ],
          ),
        )

    );
  }
}
