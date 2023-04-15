import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nsuqo/models/filters_params.dart';
import 'package:nsuqo/pages/filter_by.dart';
import 'package:nsuqo/pages/home/homepagecategories/home_page_categories.dart';
import 'package:nsuqo/pages/product_information/product_information.dart';
import 'package:nsuqo/pages/search_page.dart';
import 'package:nsuqo/pages/Login/sign_in.dart';
import 'package:nsuqo/pages/wholesalerslist/wholesalers.dart';
import 'package:share/share.dart';
import 'package:toast/toast.dart';

import '../../../models/filters.dart';
import '../../../models/products_model.dart';
import 'widgets/products_tile.dart';
import '../../Edit_Profile.dart';
import '../../account_approval_wholesaler.dart';
import '../../create_account_wholesaler.dart';
import '../../edit_profile_retailer.dart';
import '../../messanger/messanger_retailer/messanger.dart';

class Home_Page_Products extends StatefulWidget {

  const Home_Page_Products({Key? key,required this.brand, required this.subcategory, required this.category}) : super(key: key);
  final String  brand, subcategory, category;

  @override
  State<Home_Page_Products> createState() => _Home_Page_ProductsState();

}

class _Home_Page_ProductsState extends State<Home_Page_Products> {

  FirebaseFirestore db = FirebaseFirestore.instance;

  List<Item_Model> products = [];
  List<Item_Model> search_results = [ ];
  List<dynamic> filters = [];
  String ? user_email;
  String ? exchange_rate;
  bool isLoading= true;
  List<dynamic> whos_can_view = [];

  bool phones_and_tablets = false;
  bool consumer_electronic = false;
  bool computing = false;
  bool More = false;
  bool all_cat = true;

  Future<String> getexchangeratedata(email, element)
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
                        exchange_rate: exchange_rate!,
                        brandname: element.data()['brandname'],

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
                            size: element.data()['filters_params']['size']),
                        exchange_rate: exchange_rate!,

                      )

                  );
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
        .where("category", isEqualTo: widget.category)
        .where("subcategory", isEqualTo: widget.subcategory)
        .where("brandname", isEqualTo: widget.brand);

    await service_listings.get().then((ref) async {
      print("redata 1 &****************************${ref.docs}");


      setState(
              () {

            ref.docs.forEach((element) async {
              print(element.data()['productname']);

              if(whos_can_view.contains(element.data()['wholesalerid']))
                {
                 // exchange_rate = await getexchangeratedata(user_email);

                await  getexchangeratedata(element.data()['wholesalerid'], element);
                }



            });

            isLoading = false;
          }
      );
    });

  }


  Future<void> get_Products2(useremail) async {

    // remember to change to required data
    final service_listings = db.collection("products")
        .where("wholesalerid", isEqualTo: useremail)
        .where("category", isEqualTo: widget.category)
        .where("subcategory", isEqualTo: widget.subcategory)
        .where("brandname", isEqualTo: widget.brand);

    await service_listings.get().then((ref) async {
      print("redata 1 &****************************${ref.docs}");

            ref.docs.forEach((element) async {
              print(element.data()['productname']);

              await  getexchangeratedata(element.data()['wholesalerid'], element);


            });

      setState(
              () {
            isLoading = false;
          }
      );
    });

  }

  List<Item_Model> filtered = [ ];

  Future <void> get_filtered_products(filters) async {


   setState(
       (){
         filtered = [];

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

              if(int.parse(
                  element.itemprice.split("_")[0]
              ) >= int.parse(param[1].split("-")[0]) && int.parse(element.itemprice) <= int.parse(param[1].split("-")[1]))
              {
                if(filtered.contains(element))
                  {

                  }
                else
                  {
                    filtered.add(element);
                  }

              }
            }

          else if(  param[0] == "moq" )
            {
              if(int.parse(element.moq) >= int.parse(param[1].split["-"][0]) && int.parse(element.moq) <= int.parse(param[1].split["-"][1]))
              {
                if(!filtered.contains(element))
                {
                  filtered.add(element);
                }

              }
            }
          else if(  param[0] == "warrant" )
            {
              if(int.parse(element.warrant_period) >= int.parse(param[1].split["-"][0]) && int.parse(element.warrant_period)  <= int.parse(param[1].split["-"][1]))
              {
                if(!filtered.contains(element))
                {
                  filtered.add(element);
                }
              }
            }
          else if(  param[0] == "distributor" )
            {
              if(element.company_name == param[1])
              {
                if(!filtered.contains(element))
                {
                  filtered.add(element);
                }
              }
            }

          else if(  param[0] == "partno" )
            {
              if(element.partno == param[1])
              {
                if(!filtered.contains(element))
                {
                  filtered.add(element);
                }
              }
            }
          else if(  param[0] == "ram" )
            {
              if(element.ram == param[1])
              {
                if(!filtered.contains(element))
                {
                  filtered.add(element);
                }
              }
            }

          else if(  param[0] == "processor" )
            {
              if(element.processor == param[1])
              {
                if(!filtered.contains(element))
                {
                  filtered.add(element);
                }
              }
            }

          else if(  param[0] == "screensize" )
            {
              if(element.screensize == param[1])
              {  if(!filtered.contains(element))
              {
                filtered.add(element);
              }
              }
            }

          else if(  param[0] == "resolution" )
            {
              if(element.resolution == param[1])
              {
                if(!filtered.contains(element))
                {
                  filtered.add(element);
                }
              }
            }

          else if(  param[0] == "storage" )
            {
              if(element.storage == param[1])
              {
                if(!filtered.contains(element))
                {
                  filtered.add(element);
                }
              }
            }

          else if(  param[0] == "brand" )
            {
              if(element.brand == param[1])
              {
                if(!filtered.contains(element))
                {
                  filtered.add(element);
                }
              }
            }

          else if(  param[0] == "screen" )
            {
              if(element.screen == param[1])
              {
                if(!filtered.contains(element))
                {
                  filtered.add(element);
                }
              }
            }

          else if(  param[0] == "partner" )
            {
              if(element.partner == param[1])
              {
                if(!filtered.contains(element))
                {
                  filtered.add(element);
                }
              }
            }

          else if(  param[0] == "package" )
            {
              if(element.package == param[1])
              {
                if(!filtered.contains(element))
                {
                  filtered.add(element);
                }
              }
            }

          else if(  param[0] == "location" )
            {
              if(element.location == param[1])
              {
                if(!filtered.contains(element))
                {
                  filtered.add(element);
                }
              }
            }
          else if(  param[0] == "available" )
            {
              if(element.availability == param[1])
              {
                if(!filtered.contains(element))
                {
                  print(filtered.contains(element));
                  print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
                  filtered.add(element);
                }
              }
            }

/*
          else if(  param[0] == "available" )
            {
              if( param[1]) {

                if (element.availability == "available") {

                  if(!filtered.contains(element))
                  {
                    filtered.add(element);
                  }

                }

              }
              else{

                if (element.availability != "available") {

                  if(!filtered.contains(element))
                  {
                    filtered.add(element);
                  }

                }

              }
            }
 */

        });

        setState(
            (){
              search_results = [];
              search_results = filtered;
              filtered = [];
            }
        );


      }
  }


  bool isWholesaler = false;

  Future<void> getUserData(user_email)
  async {
    final docref = db.collection("userdd").doc(user_email);
    await docref.get().then((res) async {

      if(res.data() != null)
      {
        if(res.data()!['accounttype'] =="wholesaler")
        {


         await get_Products2(user_email);

          setState(
                  (){
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
        () async {
      await checkAuth();
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
      backgroundColor: Colors.black,
      body:  SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,

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

                    }, child: Icon(Icons.arrow_back_ios, color:Colors.grey[200], size:30)),
                              SizedBox(width: 30,),

                            ],
                          ),

                          SizedBox(height: 6,),
                          Container(
                            width: 80,
                            margin: EdgeInsetsDirectional.only(start: 1.0,end:1.0),
                            height: 0.0,
                            color: Colors.grey[200],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left:20.0),
                    child: Text("${widget.subcategory}",
                      style: TextStyle(
                        color: HexColor("#FFFFFF"),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),),
                  ),
                  SizedBox(height: 10,),

                  Padding(
                    padding: const EdgeInsets.only(left:20.0),
                    child: Row(
                      children: [
                        Container(
                          width: (MediaQuery.of(context).size.width) - 120,
                          height: 42,
                          decoration: BoxDecoration(
                            color:HexColor("#FFFFFF"),
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child:TextField(

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
                                              if(element.searchalgopartnoname.toLowerCase().contains(val.toLowerCase()))
                                              {
                                                search_results.add(element);
                                              }
                                            });
                                          }
                                      );
                                    }


                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.search,
                                      color:HexColor("#838383")),
                                  hintText: "Search by name or PART no:",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: HexColor("#212121"),
                                  ),

                                ),
                              ),


                        ),

                        SizedBox(width: 15,),

                        InkWell(

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
                            child: Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: HexColor("#1A434E")
                                ),
                                child:
                                Icon(Icons.filter_list_rounded, color:HexColor("#FFFFFF"), size:30))),
                      ],
                    ),
                  ),

                SizedBox(height: 20),

                  SizedBox(
                    height: 30,
                  ),

             /*
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
                                  color: all_cat?  Colors.grey[800] :Colors.white,
                                  borderRadius:BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(color:all_cat?Colors.grey[700]!: Colors.grey[500]! ),
                                ),
                                child:
                                Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    all_cat ?
                                    Text("All",style: TextStyle( color: Colors.white), ):
                                    Text("All",style: TextStyle( color: Colors.black), ),
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
                                  color: phones_and_tablets? Colors.grey[800]!:Colors.white,
                                  borderRadius:BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(color:phones_and_tablets?Colors.grey[700]!: Colors.grey[500]! ),

                                ),
                                child:
                                Padding(
                                  padding: const EdgeInsets.only(left:10.0, right:10.0, top:4.5),
                                  child:phones_and_tablets?
                                  Text("Phones and Tablets",style: TextStyle( color: Colors.white) )

                                      :
                                  Text("Phones and Tablets",style: TextStyle( color: Colors.black), ),
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
                                  color: consumer_electronic? Colors.grey[800]!:Colors.white,
                                  borderRadius:BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(color:consumer_electronic?Colors.grey[700]!: Colors.grey[500]! ),
                                ),
                                child:
                                Padding(
                                  padding: const EdgeInsets.only(left:10.0, right:10.0, top:4.5),                           child:consumer_electronic?
                                Text("Consumer Electronic",style: TextStyle( color: Colors.white) )
                                    :
                                Text("Consumer Electronic",style: TextStyle( color: Colors.black), ),
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
                                  color: computing? Colors.grey[800]!:Colors.white,
                                  borderRadius:BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(color:computing?Colors.grey[700]!: Colors.grey[500]! ),


                                ),
                                child:
                                Padding(
                                  padding: const EdgeInsets.only(left:10.0, right:10.0, top:4.5),

                                  child:computing?
                                  Text("Computing",style: TextStyle( color: Colors.white) )
                                      :
                                  Text("Computing",style: TextStyle( color: Colors.black), ),
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
                                  color: More? Colors.grey[800]!:Colors.white,
                                  borderRadius:BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(color:More?Colors.grey[700]!: Colors.grey[500]! ),

                                ),
                                child:
                                Padding(
                                  padding: const EdgeInsets.only(left:10.0, right:10.0, top:4.5),
                                  child:More?
                                  Text("More",style: TextStyle( color: Colors.white) )
                                      :
                                  Text("More",style: TextStyle( color: Colors.black), ),
                                )
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                    SizedBox(
                    height:20,
                  ),
              */



                  Container(
                    width: MediaQuery.of(context).size.width,
                    height:MediaQuery.of(context).size.height-291,
                    decoration: BoxDecoration(
                      color: HexColor("#FFFFFF"),
                      borderRadius: BorderRadius.only(topLeft:Radius.circular(20),
                          topRight: Radius.circular(20))
                    ),
                    child:
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        itemCount: search_results.length,
                        itemBuilder: (context, index) => InkWell(
                            onTap:(){

                              Navigator.of(context).push(
                                  MaterialPageRoute
                                    (builder: (context)=>Product_Information(document_id: search_results[index].itemId,)));
                            },
                            child: Product_Tile(item_model: search_results[index], exchange_rate: search_results[index].exchange_rate,)),

                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.7

                        ),
                      ),
                    ),

             /*

                    ListView.builder(

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
              */
                  ),
                ],
              ),
            ),

          ],
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: HexColor("#F1F5FB"),
        child: Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Container(
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(

                  onTap: (){

                    Navigator.of(context).push(
                        MaterialPageRoute
                          (builder: (context)=>Home_Categories()));
                  },

                  child: Container(
                    child: Column(
                      children: [
                        Icon(Icons.home_filled,color:HexColor("#444746")),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: HexColor("#1A434E"),
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
                          (builder: (context)=>WholeSalers()));

                  },

                  child: Container(
                    child: Column(
                      children: [
                        Icon(Icons.groups, color:HexColor("#444746")),
                        Text(
                          'Wholesalers',
                          style: TextStyle(
                            color: HexColor("#1A434E"),
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
                        Container(
                            width:55,
                            height: 30,
                            decoration: BoxDecoration(
                                color: HexColor("#E5DEF6"),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                            child: Icon(Icons.chat, color:HexColor("#1A434E"))),
                        Text(
                          'Messsanger',
                          style: TextStyle(
                            color: HexColor("#1A434E"),
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                InkWell(

                  onTap: () async {
                    await Share.share("https://play.google.com/store/apps/details?id=com.nsuqo.opasso");

                  },

                  child: Container(
                    child: Column(
                      children: [
                        Icon(Icons.share, color:HexColor("#444746")),
                        Text(
                          'share',
                          style: TextStyle(
                            color: HexColor("#1A434E"),
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
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Icon(Icons.person, color:HexColor("#444746")),
                        Text(
                          'profile',
                          style: TextStyle(
                            color: HexColor("#1A434E"),
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