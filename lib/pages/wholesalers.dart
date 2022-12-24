import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/pages/products_listing.dart';
import 'package:nsuqo/pages/wholesalerinfo.dart';
import 'package:share/share.dart';

import '../helpers/exit_pop.dart';
import '../models/wholesalers_model.dart';
import '../widgets/products_tile.dart';
import '../widgets/wholesalers_tile.dart';
import 'edit_profile_retailer.dart';
import 'home_page_categories.dart';
import 'home_page_products.dart';
import 'messanger.dart';

class WholeSalers extends StatefulWidget {
  const WholeSalers({Key? key}) : super(key: key);

  @override
  State<WholeSalers> createState() => _WholeSalersState();
}

class _WholeSalersState extends State<WholeSalers> {

  List<Color> colors_list=[

    Colors.deepOrange, Colors.blue, Colors.deepPurpleAccent, Colors.lightGreen,
    Colors.pinkAccent, Colors.yellowAccent,Colors.purple, Colors.greenAccent,
    Colors.orange, Colors.teal, Colors.brown, Colors.limeAccent

  ];
  List<Wholesalers_Model> wholesalers_list = [];
  List<Wholesalers_Model> search_results = [];

  List<String> wholesalers =[
    "Jane","Joy","Brian","John","RoseMary","Ian","Naomi","Kelvin","Alfred","Susan","Simon"
  ];

  bool isLoading = true;
  int color_count = 0;

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> getWholesalers() async {

    // remember to change to required data
    final service_listings = db.collection("userdd").where("accounttype", isEqualTo: "wholesaler")
        .where("approved", isEqualTo: "approved");

    await service_listings.get().then((ref) {
      print("redata 1 &****************************${ref.docs}");
      setState(
              () {

            ref.docs.forEach((element) {
              if(color_count == (colors_list.length-1))
                {
                  color_count=0;
                }
              wholesalers_list.add(
                  Wholesalers_Model(
                      working_hours:element.data()['working_hours'],
                      email: element.data()['email'],
                      business_description: element.data()['business_description'],
                      wholesalerid: element.id,
                      contact_details: element.data()['contact_details'],
                      company_name: element.data()['company_name'],
                      location: element.data()['location'],
                      payment_details_terms:element.data()['payment_detailsterms'],
                      market_coverage: element.data()['market_coverage'],
                      distribution_category: element.data()['distribution_category'],
                      bgcolor: colors_list[color_count]

                    //element.data()['availability'],


                  )

              );
              search_results.add(
                  Wholesalers_Model(
                      working_hours:element.data()['working_hours'],
                      email: element.data()['email'],
                      business_description: element.data()['business_description'],
                      wholesalerid: element.id,
                      contact_details: element.data()['contact_details'],
                      company_name: element.data()['company_name'],
                      location: element.data()['location'],
                      payment_details_terms:element.data()['payment_detailsterms'],
                      market_coverage: element.data()['market_coverage'],
                      distribution_category: element.data()['distribution_category'],
                      bgcolor: colors_list[color_count]

                    //element.data()['availability'],
                  )

              );
              color_count++;

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
      await getWholesalers();
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
    ): WillPopScope(
      onWillPop: ()=>showExitPopup(context),
      child: Scaffold(

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
                        width: 206,
                        height:40,
                        child: Row(
                          children: [
                            InkWell(
                              onTap:(){

                                Navigator.of(context).push(
                                    MaterialPageRoute
                                      (builder: (context)=>Home_Categories()));
                              },

                              child: Column(
                                children: [
                                  Text("Products",
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 18,
                                    ),),
                                  SizedBox(height: 6,),

                                ],
                              ),
                            ),
                            SizedBox(width: 20,),
                            Column(
                              children: [
                                Text("WholeSalers",
                                  style: TextStyle(

                                    color: Colors.grey[800],
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),),

                                SizedBox(height: 3,),

                                Container(
                                  width: 100,
                                  margin: EdgeInsetsDirectional.only(start: 1.0,end:1.0),
                                  height: 3.0,
                                  color: Colors.grey[800],
                                )
                              ],
                            ),
                          ],
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
                                  wholesalers_list.forEach((element) {

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
                                  wholesalers_list.forEach((element) {

                                    if(element.company_name.contains(val))
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
                          hintText: "Search by name",
                          hintStyle: TextStyle(
                            color: Colors.grey[500],

                          ),

                        ),
                      ),
                    ),),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height-276,
                  child: Padding(
                    padding: const EdgeInsets.only(left:16.0, right:16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          "wholesalers",
                          style: TextStyle(
                              color: Colors.grey[850],
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),

                        SizedBox(height: 15,),

                        Container(
                          width: MediaQuery.of(context).size.width,
                          height:MediaQuery.of(context).size.height-314,
                          child: ListView.builder(
                            itemCount: search_results.length,
                            itemBuilder: (context, index){
                              return InkWell(
                                  onTap: (){

                                    print(index);
                                    Navigator.of(context).push(
                                        MaterialPageRoute
                                          (builder: (context)=>Product_List(wholesaler_id: search_results[index].wholesalerid)));
                                  },

                                  child: Wholesaler_Tile( wholesaler_model:search_results[index] ));

                            },
                          ),
                        ),

                      ],
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
      ),
    );
  }
}
