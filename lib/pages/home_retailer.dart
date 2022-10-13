import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nsuqo/pages/messanger.dart';
import 'package:nsuqo/pages/product_information.dart';
import 'package:nsuqo/pages/search_page.dart';
import 'package:nsuqo/pages/sign_in.dart';
import 'package:nsuqo/pages/single_category.dart';
import 'package:share/share.dart';

import '../models/filters_params.dart';
import '../models/products_model.dart';
import 'all_categories.dart';
import 'edit_profile_retailer.dart';
import 'home_page_categories.dart';

class Home_Ui_Retailer extends StatefulWidget {
  const Home_Ui_Retailer({Key? key}) : super(key: key);

  @override
  State<Home_Ui_Retailer> createState() => _Home_Ui_RetailerState();
}

class _Home_Ui_RetailerState extends State<Home_Ui_Retailer> {

  FirebaseFirestore db = FirebaseFirestore.instance;

  List<Item_Model> products = [];
  List<Item_Model> top_ranking = [];
  bool isLoading= false;

  Future<void> get_Products() async {

    // remember to change to required data
    final service_listings = db.collection("products");

    await service_listings.get().then((ref) {
      print("redata 1 &****************************${ref.docs}");
      setState(
              () {

            ref.docs.forEach((element) {
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
                    filters_params: element.data()['filters'].map((e) => Filters_Params_Model(
                        availability: e.availability,
                        warrant_period:e.warrant_period,
                        moq: e.moq,
                        partno: e.partno,
                        company_name: e.company_name,
                        location: e.location,
                        ram: e.ram,
                        processor: e.processor,
                        screen: e.screen,
                        brand: e.brand,
                        resolution: e.resolution,
                        storage: e.storage,
                        screensize: e.screensize,
                        partner: e.partner,
                        package: e.package,
                        size: e.size)),

                  )

              );

              if(element.data()['noofclicks'] != "0")
                {
                  top_ranking.add(
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
                        filters_params: element.data()['filters'].map((e) => Filters_Params_Model(
                            availability: e.availability,
                            warrant_period:e.warrant_period,
                            moq: e.moq,
                            partno: e.partno,
                            company_name: e.company_name,
                            location: e.location,
                            ram: e.ram,
                            processor: e.processor,
                            screen: e.screen,
                            brand: e.brand,
                            resolution: e.resolution,
                            storage: e.storage,
                            screensize: e.screensize,
                            partner: e.partner,
                            package: e.package,
                            size: e.size)),

                      )

                  );
                }

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
    return Scaffold(

      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width:  MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(height:20),
                    Container(
                      width: 202,
                      height:40,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text("Products",
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,

                                ),),
                              SizedBox(height: 6,),
                             Container(
                               width: 80,
                               margin: EdgeInsetsDirectional.only(start: 1.0,end:1.0),
                               height: 3.0,
                               color: Colors.grey[800],
                             )


                            ],
                          ),
                          SizedBox(width: 20,),
                          Column(
                            children: [
                              Text("WholeSalers",
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 18,
                                ),),

                              SizedBox(height: 3,),

                              Divider(
                                thickness: 2,
                              )
                            ],
                          ),
                        ],
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
                        child: Text("Super September Products", style:
                          TextStyle(
                            color: Colors.grey[500],

                          ),),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: CircleAvatar(radius: 20,
                        backgroundColor: Colors.grey[800],
                        child: Icon(Icons.search, size: 30, color: Colors.grey[200],),),
                      ),
                    ),
                  )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height-276,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left:8.0, right:8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "For Your Business",
                          style: TextStyle(
                            color: Colors.grey[850],
                            fontSize: 22,
                            fontWeight: FontWeight.bold

                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: double.infinity,
                          height: 60,
                          child: (
                          ListView(
                            scrollDirection: Axis.horizontal,
                            children: [

                              InkWell(
                                onTap:(){
                                  Navigator.of(context).push(
                                      MaterialPageRoute
                                        (builder: (context)=>All_Categories())

                                  );

                              },
                                child: Container(
                                    width:160,
                                    height: 60,
                                    child: Card(
                                      color: Colors.deepOrange,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 100,
                                            height: double.infinity,
                                            child: Center(
                                              child: Text("All Categories", style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500
                                              ),),
                                            ),
                                          ),
                                          Container(
                                              width: 52,
                                              height: double.infinity,
                                              child: Icon(Icons.category_outlined, size:35, color: Colors.white,)
                                          ),

                                        ],
                                      ),
                                    )
                                ),
                              ),
                              Container(
                                  width:160,
                                  height: 60,
                                  child: Card(
                                    color: Colors.deepPurpleAccent,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 100,
                                          height: double.infinity,
                                          child: Center(
                                            child: Text("Enquiries", style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500
                                            ),),
                                          ),
                                        ),
                                        Container(
                                            width: 52,
                                            height: double.infinity,
                                            child: Icon(Icons.read_more_outlined, size:35, color: Colors.white,)
                                        ),

                                      ],
                                    ),
                                  )
                              ),
                              Container(
                                  width:160,
                                  height: 60,
                                  child: Card(
                                      color: Colors.purple,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 100,
                                          height: double.infinity,
                                          child: Center(
                                            child: Text("Help Desk", style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500
                                            ),),
                                          ),
                                        ),
                                        Container(
                                          width: 52,
                                          height: double.infinity,
                                          child: Icon(Icons.question_mark, size:35, color: Colors.white,)
                                        ),

                                      ],
                                    ),
                                )
                              ),

                            ],
                          )
                          ),
                        ),

                        SizedBox(height: 30,),

                       InkWell(
                         onTap: (){

                         },

                         child: Container(
                           width: double.infinity,
                           child:Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text(
                                 "Top-ranking",
                                 style: TextStyle(
                                     color: Colors.grey[850],
                                     fontSize: 22,
                                     fontWeight: FontWeight.w600

                                 ),
                               ),

                               Icon(Icons.arrow_forward, size: 30,color: Colors.grey[800],),
                             ],
                           ),
                         ),
                       ),
                        SizedBox(height: 15,),
                        Container(
                          width: double.infinity,
                          height: 240,
                          child: ListView.builder(
                            itemCount: top_ranking.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {

                              return Padding(
                                padding: const EdgeInsets.only(right:20.0),
                                child: InkWell(
                                  onTap: ()
                                  {

                                    Navigator.of(context).push(
                                        MaterialPageRoute
                                          (builder: (context)=>Product_Information(document_id:top_ranking[index].itemId,))
                                    );
                                  },
                                  child: Container(
                                    child: Column(

                                      children: [
                                        top_ranking[index].photosLinks.length <0?

                                      Container(
                                      height: 170,
                                      width: 160,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage('assets/IMG-20220714-WA0003.jpg'),
                                              fit:BoxFit.cover
                                          )
                                      ),
                                    )
                                            :
                                        Container(
                                          height: 170,
                                          width: 160,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(top_ranking[index].photosLinks[0]),
                                                  fit:BoxFit.cover
                                              )
                                          ),
                                        ),

                                        Container(
                                          width: 160,
                                          child: Column(
                                            children: [
                                              SizedBox(height: 10,),
                                              Text("Most Popular", style:TextStyle(
                                                  color: Colors.grey[750],
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 17
                                              )),
                                              SizedBox(height: 8,),
                                              Text("${top_ranking[index].itemname} at ${top_ranking[index].itemprice} ",textAlign: TextAlign.center, style:TextStyle(
                                                color: Colors.grey[500],

                                              )),
                                            ],

                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          ),
                        ),SizedBox(height: 30,),

                       InkWell(
                         onTap: (){

                         },
                         child: Container(
                           width: double.infinity,
                           child:Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text(
                                 "New Arrivals",
                                 style: TextStyle(
                                     color: Colors.grey[850],
                                     fontSize: 22,
                                     fontWeight: FontWeight.w600

                                 ),
                               ),

                               Icon(Icons.arrow_forward, size: 30,color: Colors.grey[800],),
                             ],
                           ),
                         ),
                       ),
                        SizedBox(height: 15,),
                        Container(
                          width: double.infinity,
                          height: 240,
                          child: ListView.builder(
                                itemCount: products.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right:20.0),
                                    child: InkWell(
                                      onTap:(){

                                        Navigator.of(context).push(
                                            MaterialPageRoute
                                              (builder: (context)=>Product_Information(document_id:products[index].itemId,))
                                        );
                                      },
                                      child: Container(
                                        child: Column(

                                          children: [
                                            products[index].photosLinks.length <0?

                                            Container(
                                              height: 170,
                                              width: 160,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage('assets/IMG-20220714-WA0003.jpg'),
                                                      fit:BoxFit.cover
                                                  )
                                              ),
                                            )
                                                :
                                            Container(
                                              height: 170,
                                              width: 160,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(products[index].photosLinks[0]),
                                                      fit:BoxFit.cover
                                                  )
                                              ),
                                            ),

                                            Container(
                                              width: 160,
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 10,),
                                                  Text("Most Popular", style:TextStyle(
                                                      color: Colors.grey[750],
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 17
                                                  )),
                                                  SizedBox(height: 8,),
                                                  Text("${products[index].itemname} at ${products[index].itemprice} ",textAlign: TextAlign.center, style:TextStyle(
                                                    color: Colors.grey[500],

                                                  )),
                                                ],

                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
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

                    onTap: (){


                      Navigator.of(context).push(
                          MaterialPageRoute
                            (builder: (context)=>Home_Categories()));

                    },

                    child: Container(
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.deepOrange,
                              radius: 16,
                              child: Icon(Icons.home_filled, color:Colors.white)),
                          Text(
                            'Home',
                            style: TextStyle(
                              color: Colors.deepOrange,
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
                            'Messsanger',
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

                      await Share.share("Link to download app");
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
