import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nsuqo/pages/productListing/products_listing.dart';
import 'package:nsuqo/pages/wholesalerinfo.dart';
import 'package:share/share.dart';

import '../../helpers/exit_pop.dart';
import '../../models/wholesalers_model.dart';
import '../home/homepageproducts/widgets/products_tile.dart';
import 'widget/wholesalers_tile.dart';
import '../edit_profile_retailer.dart';
import '../home/homepagecategories/home_page_categories.dart';
import '../home/homepageproducts/home_page_products.dart';
import '../messanger/messanger_retailer/messanger.dart';

class WholeSalers extends StatefulWidget {
  const WholeSalers({Key? key}) : super(key: key);

  @override
  State<WholeSalers> createState() => _WholeSalersState();
}

class _WholeSalersState extends State<WholeSalers> {

  List<Color> colors_list=[

    Colors.grey[800]!, Colors.grey[700]!, Colors.grey[900]!, Colors.grey[800]!,
    Colors.grey[700]!, Colors.grey[900]!, Colors.grey[800]!, Colors.grey[700]!,
    Colors.grey[800]!, Colors.grey[700]!, Colors.grey[900]!, Colors.grey[800]!,

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
          color: Colors.black
      ),
      child: Center(child: CircularProgressIndicator(
        backgroundColor: Colors.white,
      ),),
    ): WillPopScope(
      onWillPop: ()=>showExitPopup(context),
      child: Scaffold(
        backgroundColor: HexColor("#1A434E"),
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width:  MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      SizedBox(height:40),
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("WholeSalers",
                              style: TextStyle(

                                color: HexColor("#FFFFFF"),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),),

                            SizedBox(height: 10,),

                          ],
                        ),
                      ),

                      SizedBox(height: 5,),

                      Container(
                        decoration: BoxDecoration(

                          color: HexColor("#325863"),
                          borderRadius: BorderRadius.all(Radius.circular(50))

                        ),
                        child: ListTile(
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
                            suffixIcon: Icon(Icons.search,color:HexColor("#FFFFFF"),),
                            hintText: "Search by name",
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: HexColor("#FFFFFF"),

                            ),

                          ),
                        ),
                    ),),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height-263,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft:Radius.circular(10),
                        topRight: Radius.circular(10)
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left:16.0, right:16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(height: 15,),

                        Container(
                          width: MediaQuery.of(context).size.width,
                          height:MediaQuery.of(context).size.height-278,
                          child: ListView.builder(
                            itemCount: search_results.length,
                            itemBuilder: (context, index){
                              return Wholesaler_Tile( wholesaler_model:search_results[index] );

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
                         child: Icon(Icons.groups, color:HexColor("#1A434E"))),
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
                          Icon(Icons.chat, color:HexColor("#444746")),
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
      ),
    );
  }
}
