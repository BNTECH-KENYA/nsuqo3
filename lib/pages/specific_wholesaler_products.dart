import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/models/filters_params.dart';
import 'package:nsuqo/pages/filter_by.dart';
import 'package:nsuqo/pages/product_information/product_information.dart';
import 'package:nsuqo/pages/search_page.dart';
import 'package:nsuqo/pages/Login/sign_in.dart';
import 'package:share/share.dart';
import 'package:toast/toast.dart';

import '../models/filters.dart';
import '../models/products_model.dart';
import 'home/homepageproducts/widgets/products_tile.dart';
import 'edit_profile_retailer.dart';
import 'home/homepagecategories/home_page_categories.dart';
import 'messanger/messanger_retailer/messanger.dart';

class Wholesaler_Products extends StatefulWidget {
  const Wholesaler_Products({Key? key, required this.wholesaler_id, required this.wholesaler_name}) : super(key: key);
  final String  wholesaler_id,wholesaler_name;

  @override
  State<Wholesaler_Products> createState() => _Wholesaler_ProductsState();

}

class _Wholesaler_ProductsState extends State<Wholesaler_Products> {

  FirebaseFirestore db = FirebaseFirestore.instance;

  List<Item_Model> products = [];
  List<Item_Model> search_results = [ ];
  List<dynamic> filters = [];

  bool isLoading= true;

  String ? exchange_rate;


  Future<String> getexchangeratedata(email)
  async {
    final docref = db.collection("userdd").doc(email);
    await docref.get().then((res) {

      if(res.data() != null)
      {

        if(res.data()!['fname'] != "")
        {
          if(res.data()!['approved'] == "approved"){
            setState(
                    (){


                  exchange_rate = res.data()!.containsKey("exchange_rate")?  res.data()!["exchange_rate"]: "0";
                  isLoading = false;

                }
            );
            return exchange_rate;
          }

          return "0";
        }

        return "0";
      }

    });
    return "0";

  }


  Future<void> get_Products() async {

    // remember to change to required data
    final service_listings = db.collection("products")
        .where("wholesalerid", isEqualTo: widget.wholesaler_id);

    await service_listings.get().then((ref) async {
      print("redata 1 &****************************${ref.docs}");
      exchange_rate = await getexchangeratedata(widget.wholesaler_id);
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
                    brandname: element.data()['brandname'],
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
                        size: element.data()['filters_params']['size']), exchange_rate: exchange_rate!,

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
                    brandname: element.data()['brandname'],

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
                        size: element.data()['filters_params']['size']), exchange_rate: exchange_rate!,

                  )

              );

            });

            isLoading = false;
          }
      );
    });

  }

  List<Item_Model> filtered = [ ];

  Future <void> get_filtered_products(filters) async {

   setState(
       (){
         products.forEach((element) {
           search_results.add(element);
         });
       }
   );


    for( List<dynamic> param in filters)
      {

        search_results.forEach((element) {


          if(param[0] == "price" )
            {

              if(int.parse(element.itemprice) >= int.parse(param[1].split("-")[0]) && int.parse(element.itemprice) <= int.parse(param[1].split("-")[1]))
              {
                filtered.add(element);
              }
            }

          else if(  param[0] == "moq" )
            {
              if(int.parse(element.moq) >= int.parse(param[1].split["-"][0]) && int.parse(element.moq) <= int.parse(param[1].split["-"][1]))
              {
                filtered.add(element);
              }
            }
          else if(  param[0] == "warrant" )
            {
              if(int.parse(element.warrant_period) >= int.parse(param[1].split["-"][0]) && int.parse(element.warrant_period)  <= int.parse(param[1].split["-"][1]))
              {
                filtered.add(element);
              }
            }
          else if(  param[0] == "distributor" )
            {
              if(element.company_name == param[1])
              {
                filtered.add(element);
              }
            }

          else if(  param[0] == "partno" )
            {
              if(element.partno == param[1])
              {
                filtered.add(element);
              }
            }
          else if(  param[0] == "ram" )
            {
              if(element.ram == param[1])
              {
                filtered.add(element);
              }
            }

          else if(  param[0] == "processor" )
            {
              if(element.processor == param[1])
              {
                filtered.add(element);
              }
            }

          else if(  param[0] == "screensize" )
            {
              if(element.screensize == param[1])
              {
                filtered.add(element);
              }
            }

          else if(  param[0] == "resolution" )
            {
              if(element.resolution == param[1])
              {
                filtered.add(element);
              }
            }

          else if(  param[0] == "storage" )
            {
              if(element.storage == param[1])
              {
                filtered.add(element);
              }
            }

          else if(  param[0] == "brand" )
            {
              if(element.brand == param[1])
              {
                filtered.add(element);
              }
            }

          else if(  param[0] == "screen" )
            {
              if(element.screen == param[1])
              {
                filtered.add(element);
              }
            }

          else if(  param[0] == "partner" )
            {
              if(element.partner == param[1])
              {
                filtered.add(element);
              }
            }

          else if(  param[0] == "package" )
            {
              if(element.package == param[1])
              {
                filtered.add(element);
              }
            }

          else if(  param[0] == "location" )
            {
              if(element.location == param[1])
              {
                filtered.add(element);
              }
            }
          else if(  param[0] == "available" )
            {
              if(element.availability == param[1])
              {
                filtered.add(element);
              }
            }

          else if(  param[0] == "available" )
            {
              if( param[1]) {

                if (element.availability == "available") {
                  filtered.add(element);

                }

              }
              else{

                if (element.availability != "available") {
                  filtered.add(element);

                }

              }
            }

        });

        setState(
            (){
              search_results = filtered;
              filtered = [];
            }
        );


      }


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
          color: Colors.black
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

                            onTap:() async {
                         Navigator.pop(context);

              }, child: Icon(Icons.arrow_back, color:Colors.grey[800], size:30)),
                        SizedBox(width: 30,),
                        Text("${widget.wholesaler_name}",
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

            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: TextField(

                  onChanged: (val){

                    if(val.isEmpty)
                      {

                        setState(
                            (){
                              search_results = [];
                              products.forEach((element) {

                                search_results.add(element);

                              });

                            }
                        );
                      }
                    else
                      {
                        setState(
                            (){
                              search_results = [];
                              products.forEach((element) {

                                if(element.searchalgopartnoname.contains(val))
                                {
                                  search_results.add(element);
                                }
                              });
                            }
                        );
                      }


                  },
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search,color:Colors.grey[500]),
                    hintText: "Search by name or PART no:",
                    hintStyle: TextStyle(
                      color: Colors.grey[500],

                    ),

                  ),
                ),
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child:   InkWell(

                    onTap:() async {


                      if(products.length<1)
                        {
                          Toast.show("No Products to filter".toString(), context,duration:Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                        }
                      else
                        {
                          filters = await Navigator.of(context).push(
                              MaterialPageRoute
                                (builder: (context)=>Filter_By( item_model: products, filters_params: products[0].filters_params,)));

                          if(filters != null)
                          {
                            get_filtered_products(filters);
                          }
                        }
                    },
                    child: Icon(Icons.filter_list_rounded, color:Colors.grey[800], size:30)),
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
                              child: Product_Tile(item_model: search_results[index], exchange_rate: search_results[index].exchange_rate,));

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

                      Navigator.of(context).push(
                          MaterialPageRoute
                            (builder: (context)=>Home_Categories()));
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
                    onTap: () async {


                      await Share.share("link to download app");

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

                      Navigator.of(context).push(
                          MaterialPageRoute
                            (builder: (context)=>Edit_Retailer_Profile())
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


/*

  Future<void> get_filtered_products(Filters_Model filters_cc) async {

    // remember to change to required data
    Query<Map<String, dynamic>> filtered_call = db.collection("products").where("subcategory", isEqualTo: widget.subcategory);

    if(
    filters_cc.available == true
        &&
        filters_cc.price[2]=="true"
        &&
        filters_cc.distributor[1] == "true"
        &&
        filters_cc.moq[2] == "true"
    &&
    filters_cc.warant[1] == "true"
    &&
    filters_cc.partno[1]== "true"
        &&
    filters_cc.location[1]== "true"
    ) {
      setState(
          (){
            search_results = [];
            products.forEach((element) {
              if(element.availability == "available "
                  && int.parse(element.itemprice) <= int.parse(filters_cc.price[1])
                  && int.parse(element.itemprice) >= int.parse(filters_cc.price[0])
                  && int.parse(element.moq) >= int.parse(filters_cc.moq[0])
                  && int.parse(element.moq) <= int.parse(filters_cc.moq[1])
                  && element.company_name == filters_cc.distributor[0]
                  && element.partno == filters_cc.partno[0]
                  && element.warrant_period == filters_cc.warant[0]
                  && element.location == filters_cc.location[0]
              )
              {
                search_results.add(element);
              }
            });
          }
      );


      /*
       filtered_call = db

          .collection("products")
          .where("subcategory", isEqualTo: widget.subcategory)
          .where("price", isGreaterThanOrEqualTo: filters_cc.price[0])
          .where("price", isLessThanOrEqualTo: filters_cc.price[1])
          .where("availability", isEqualTo: "available")
          .where("company_name", isEqualTo: filters_cc.distributor[0])
          .where("moq", isGreaterThanOrEqualTo: filters_cc.moq[0])
          .where("moq", isLessThanOrEqualTo: filters_cc.moq[1])
          .where("warrantperiod", isEqualTo: filters_cc.warant[0])
          .where("location", isEqualTo: filters_cc.location[0]);
       */
    }
    else if(

    filters_cc.available == true
        &&
        filters_cc.price[2]=="true"
        &&
        filters_cc.distributor[1] == "true"
        &&
        filters_cc.moq[2] == "true"
        &&
        filters_cc.warant[1] == "true"
        &&
        filters_cc.partno[1]== "true"
        &&
        filters_cc.location[1]== "false"
    )
    {

    setState(
        (){

          search_results = [];
          products.forEach((element) {

            if(element.availability == "available"
                && int.parse(element.itemprice) <= int.parse(filters_cc.price[1])
                && int.parse(element.itemprice) >= int.parse(filters_cc.price[0])
                && int.parse(element.moq) >= int.parse(filters_cc.moq[0])
                && int.parse(element.moq) <= int.parse(filters_cc.moq[1])
                && element.company_name == filters_cc.distributor[0]
                && element.partno == filters_cc.partno[0]
                && element.warrant_period == filters_cc.warant[0]
            )
            {
              search_results.add(element);
            }
          });
        }
    );

     /* filtered_call = db

          .collection("products")
          .where("subcategory", isEqualTo: widget.subcategory)
          .where("price", isGreaterThanOrEqualTo: filters_cc.price[0])
          .where("price", isLessThanOrEqualTo: filters_cc.price[1])
          .where("availability", isEqualTo: "available")
          .where("company_name", isEqualTo: filters_cc.distributor[0])
          .where("moq", isGreaterThanOrEqualTo: filters_cc.moq[0])
          .where("moq", isLessThanOrEqualTo: filters_cc.moq[1])
          .where("warrantperiod", isEqualTo: filters_cc.warant[0]);

      */

    }
    else if(

    filters_cc.available == true
        &&
        filters_cc.price[2]=="true"
        &&
        filters_cc.distributor[1] == "true"
        &&
        filters_cc.moq[2] == "true"
        &&
        filters_cc.warant[1] == "true"
        &&
        filters_cc.partno[1]== "false"
        &&
        filters_cc.location[1]== "false"
    )
    {

      setState(
              (){
            search_results = [];
            products.forEach((element) {
              if(element.availability == "available "
                  && int.parse(element.itemprice) <= int.parse(filters_cc.price[1])
                  && int.parse(element.itemprice) >= int.parse(filters_cc.price[0])
                  && int.parse(element.moq) >= int.parse(filters_cc.moq[0])
                  && int.parse(element.moq) <= int.parse(filters_cc.moq[1])
                  && element.company_name == filters_cc.distributor[0]
                  && element.warrant_period == filters_cc.warant[0]
              )
              {
                search_results.add(element);
              }
            });
          }
      );
     /*

      filtered_call = db

          .collection("products")
          .where("subcategory", isEqualTo: widget.subcategory)
          .where("price", isGreaterThanOrEqualTo: filters_cc.price[0])
          .where("price", isLessThanOrEqualTo: filters_cc.price[1])
          .where("availability", isEqualTo: "available")
          .where("company_name", isEqualTo: filters_cc.distributor[0])
          .where("moq", isGreaterThanOrEqualTo: filters_cc.moq[0])
          .where("moq", isLessThanOrEqualTo: filters_cc.moq[1]);
      */

    }else if(

    filters_cc.available == true
        &&
        filters_cc.price[2]=="true"
        &&
        filters_cc.distributor[1] == "true"
        &&
        filters_cc.moq[2] == "true"
        &&
        filters_cc.warant[1] == "false"
        &&
        filters_cc.partno[1]== "false"
        &&
        filters_cc.location[1]== "false"
    )
    {

      setState(
              (){
            search_results = [];
            products.forEach((element) {
              if(element.availability == "available "
                  && int.parse(element.itemprice) <= int.parse(filters_cc.price[1])
                  && int.parse(element.itemprice) >= int.parse(filters_cc.price[0])
                  && int.parse(element.moq) >= int.parse(filters_cc.moq[0])
                  && int.parse(element.moq) <= int.parse(filters_cc.moq[1])
                  && element.company_name == filters_cc.distributor[0]
              )
              {
                search_results.add(element);
              }
            });
          }
      );
     /*

      filtered_call = db

          .collection("products")
          .where("subcategory", isEqualTo: widget.subcategory)
          .where("price", isGreaterThanOrEqualTo: filters_cc.price[0])
          .where("price", isLessThanOrEqualTo: filters_cc.price[1])
          .where("availability", isEqualTo: "available")
          .where("company_name", isEqualTo: filters_cc.distributor[0])
          .where("moq", isGreaterThanOrEqualTo: filters_cc.moq[0])
          .where("moq", isLessThanOrEqualTo: filters_cc.moq[1]);
      */

    }  else if(

    filters_cc.available == true
        &&
        filters_cc.price[2]=="true"
        &&
        filters_cc.distributor[1] == "true"
        &&
        filters_cc.moq[2] == "false"
        &&
        filters_cc.warant[1] == "false"
        &&
        filters_cc.partno[1]== "false"
        &&
        filters_cc.location[1]== "false"
    )
    {

      setState(
              (){
            search_results = [];
            products.forEach((element) {
              if(element.availability == "available "
                  && int.parse(element.itemprice) <= int.parse(filters_cc.price[1])
                  && int.parse(element.itemprice) >= int.parse(filters_cc.price[0])
                  && element.company_name == filters_cc.distributor[0]
              )
              {
                search_results.add(element);
              }
            });
          }
      );

   /*
      filtered_call = db

          .collection("products")
          .where("subcategory", isEqualTo: widget.subcategory)
          .where("price", isGreaterThanOrEqualTo: filters_cc.price[0])
          .where("price", isLessThanOrEqualTo: filters_cc.price[1])
          .where("availability", isEqualTo: "available")
          .where("company_name", isEqualTo: filters_cc.distributor[0]);
    */

    }
    else if(

    filters_cc.available == true
        &&
        filters_cc.price[2]=="true"
        &&
        filters_cc.distributor[1] == "false"
        &&
        filters_cc.moq[2] == "false"
        &&
        filters_cc.warant[1] == "false"
        &&
        filters_cc.partno[1]== "false"
        &&
        filters_cc.location[1]== "false"
    )
    {


      setState(
              (){
            search_results = [];
            products.forEach((element) {
              if(element.availability == "available "
                  && int.parse(element.itemprice) <= int.parse(filters_cc.price[1])
                  && int.parse(element.itemprice) >= int.parse(filters_cc.price[0])
              )
              {
                search_results.add(element);
              }
            });
          }
      );
      /*
      filtered_call = db

          .collection("products")
          .where("subcategory", isEqualTo: widget.subcategory)
          .where("price", isGreaterThanOrEqualTo: filters_cc.price[0])
          .where("price", isLessThanOrEqualTo: filters_cc.price[1])
          .where("availability", isEqualTo: "available");
       */

    }  else if(

    filters_cc.available == true
        &&
        filters_cc.price[2]=="false"
        &&
        filters_cc.distributor[1] == "false"
        &&
        filters_cc.moq[2] == "false"
        &&
        filters_cc.warant[1] == "false"
        &&
        filters_cc.partno[1]== "false"
        &&
        filters_cc.location[1]== "false"
    )
    {
      setState(
              (){
            search_results = [];
            products.forEach((element) {
              if(element.availability == "available "
              )
              {
                search_results.add(element);
              }
            });
          }
      );

      /*
      filtered_call = db

          .collection("products")
          .where("subcategory", isEqualTo: widget.subcategory)
          .where("availability", isEqualTo: "available");
       */

    } else if(

    filters_cc.available == false
        &&
        filters_cc.price[2]=="true"
        &&
        filters_cc.distributor[1] == "false"
        &&
        filters_cc.moq[2] == "false"
        &&
        filters_cc.warant[1] == "false"
        &&
        filters_cc.partno[1]== "false"
        &&
        filters_cc.location[1]== "false"
    )
    {

      setState(
              (){
            search_results = [];
            products.forEach((element) {
              if( int.parse(element.itemprice) <= int.parse(filters_cc.price[1])
                  && int.parse(element.itemprice) >= int.parse(filters_cc.price[0])
              )
              {
                search_results.add(element);
              }
            });
          }
      );
    /*
      filtered_call = db

          .collection("products")
          .where("subcategory", isEqualTo: widget.subcategory)
          .where("price", isGreaterThanOrEqualTo: filters_cc.price[0])
          .where("price", isLessThanOrEqualTo: filters_cc.price[1]);
     */

    }
    else if(

    filters_cc.available == false
        &&
        filters_cc.price[2]=="false"
        &&
        filters_cc.distributor[1] == "true"
        &&
        filters_cc.moq[2] == "false"
        &&
        filters_cc.warant[1] == "false"
        &&
        filters_cc.partno[1]== "false"
        &&
        filters_cc.location[1]== "false"
    )
    {

      setState(
              (){
            search_results = [];
            products.forEach((element) {
              if(
                   element.company_name == filters_cc.distributor[0]

              )
              {
                search_results.add(element);
              }
            });
          }
      );
/*

      filtered_call = db

          .collection("products")
          .where("subcategory", isEqualTo: widget.subcategory)
          .where("company_name", isEqualTo: filters_cc.distributor[0]);
 */

    }    else if(

    filters_cc.available == false
        &&
        filters_cc.price[2]=="false"
        &&
        filters_cc.distributor[1] == "false"
        &&
        filters_cc.moq[2] == "true"
        &&
        filters_cc.warant[1] == "false"
        &&
        filters_cc.partno[1]== "false"
        &&
        filters_cc.location[1]== "false"
    )
    {

      setState(
              (){
            search_results = [];
            products.forEach((element) {
              if( int.parse(element.moq) >= int.parse(filters_cc.moq[0])
                  && int.parse(element.moq) <= int.parse(filters_cc.moq[1])
              )
              {
                search_results.add(element);
              }
            });
          }
      );
      /*
      filtered_call = db

          .collection("products")
          .where("subcategory", isEqualTo: widget.subcategory)
          .where("company_name", isEqualTo: filters_cc.distributor[0]);
       */

    }   else if(

    filters_cc.available == false
        &&
        filters_cc.price[2]=="false"
        &&
        filters_cc.distributor[1] == "false"
        &&
        filters_cc.moq[2] == "false"
        &&
        filters_cc.warant[1] == "true"
        &&
        filters_cc.partno[1]== "false"
        &&
        filters_cc.location[1]== "false"
    )
    {

      setState(
              (){
            search_results = [];
            products.forEach((element) {
              if( element.warrant_period == filters_cc.warant[0]
              )
              {
                search_results.add(element);
              }
            });
          }
      );
/*

      filtered_call = db

          .collection("products")
          .where("subcategory", isEqualTo: widget.subcategory)
          .where("company_name", isEqualTo: filters_cc.distributor[0]);

 */
    }  else if(

    filters_cc.available == false
        &&
        filters_cc.price[2]=="false"
        &&
        filters_cc.distributor[1] == "false"
        &&
        filters_cc.moq[2] == "false"
        &&
        filters_cc.warant[1] == "false"
        &&
        filters_cc.partno[1]== "true"
        &&
        filters_cc.location[1]== "false"
    )
    {

      setState(
              (){
            search_results = [];
            products.forEach((element) {
              if(
                  element.partno == filters_cc.partno[0]
              )
              {
                search_results.add(element);
              }
            });
          }
      );
     /*
      filtered_call = db

          .collection("products")
          .where("subcategory", isEqualTo: widget.subcategory)
          .where("company_name", isEqualTo: filters_cc.distributor[0]);
      */

    }  else if(

    filters_cc.available == false
        &&
        filters_cc.price[2]=="false"
        &&
        filters_cc.distributor[1] == "false"
        &&
        filters_cc.moq[2] == "false"
        &&
        filters_cc.warant[1] == "false"
        &&
        filters_cc.partno[1]== "false"
        &&
        filters_cc.location[1]== "true"
    )
    {

      setState(
              (){
            search_results = [];
            products.forEach((element) {
              if(
              element.location == filters_cc.location[0]
              )
              {
                search_results.add(element);
              }
            });
          }
      );

  /*
      filtered_call = db

          .collection("products")
          .where("subcategory", isEqualTo: widget.subcategory)
          .where("company_name", isEqualTo: filters_cc.distributor[0]);
   */

    }  else if(

    filters_cc.available == false
        &&
        filters_cc.price[2]=="false"
        &&
        filters_cc.distributor[1] == "false"
        &&
        filters_cc.moq[2] == "false"
        &&
        filters_cc.warant[1] == "true"
        &&
        filters_cc.partno[1]== "true"
        &&
        filters_cc.location[1]== "false"
    )
    {


      setState(
              (){
            search_results = [];
            products.forEach((element) {
              if(element.partno == filters_cc.partno[0]
                  && element.warrant_period == filters_cc.warant[0]
              )
              {
                search_results.add(element);
              }
            });
          }
      );

/*
      filtered_call = db

          .collection("products")
          .where("subcategory", isEqualTo: widget.subcategory)
          .where("company_name", isEqualTo: filters_cc.distributor[0]);
 */

    }  else if(

    filters_cc.available == false
        &&
        filters_cc.price[2]=="false"
        &&
        filters_cc.distributor[1] == "false"
        &&
        filters_cc.moq[2] == "false"
        &&
        filters_cc.warant[1] == "false"
        &&
        filters_cc.partno[1]== "true"
        &&
        filters_cc.location[1]== "true"
    )
    {

      setState(
              (){
            search_results = [];
            products.forEach((element) {
              if( element.partno == filters_cc.partno[0]
                  && element.warrant_period == filters_cc.warant[0]
              )
              {
                search_results.add(element);
              }
            });
          }
      );

/*
      filtered_call = db

          .collection("products")
          .where("subcategory", isEqualTo: widget.subcategory)
          .where("company_name", isEqualTo: filters_cc.distributor[0]);
 */

    }


    else if(

    filters_cc.available == false
        &&
        filters_cc.price[2]=="false"
        &&
        filters_cc.distributor[1] == "false"
        &&
        filters_cc.moq[2] == "false"
        &&
        filters_cc.warant[1] == "true"
        &&
        filters_cc.partno[1]== "false"
        &&
        filters_cc.location[1]== "true"
    )
    {

      setState(
              (){
            search_results = [];
            products.forEach((element) {
              if(
                   element.warrant_period == filters_cc.warant[0]
                  && element.location == filters_cc.location[0]
              )
              {
                search_results.add(element);
              }
            });
          }
      );

    }







  }

 */