import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/pages/sign_in.dart';

import '../categories_grids.dart';
import '../models/filters_params.dart';
import '../models/products_model.dart';
import 'add_product.dart';
import 'messanger.dart';

class WholeSaler_Home_Page extends StatefulWidget {

  const WholeSaler_Home_Page({Key? key,}) : super(key: key);
  @override
  State<WholeSaler_Home_Page> createState() => _WholeSaler_Home_PageState();

}

class _WholeSaler_Home_PageState extends State<WholeSaler_Home_Page> {

  bool isLoading = true;
  late String user_email;

  FirebaseFirestore db = FirebaseFirestore.instance;

  List<Item_Model> products = [];
  List<String> categories = [];

  Future<void> get_Products() async {
    // remember to change to required data
    final service_listings = db.collection("products").where("wholesalerid", isEqualTo:user_email);

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

              if(!categories.contains(element.data()['category']))

                categories.add(element.data()['category']);

            });

            isLoading = false;
          }
      );
    });

  }

  Future<void> checkAuth()async {
    await FirebaseAuth.instance
        .authStateChanges()
        .listen((user)
    {
      if(user != null)
      {
        setState(
                (){

              user_email = user.email!;

            });
       // getUserData(user.email);

        get_Products();

      }
      else{
        setState(
                (){
              isLoading = false;
            }
        );

        Navigator.of(context).push(
            MaterialPageRoute
              (builder: (context)=>Sign_In()));

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

      appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title:Text(
            'My Store',
            style: TextStyle(
                color:Colors.white
            ),
          )
      ),

      body: isLoading? Container(
        width: MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
        ),

        child: Center(
          child: CircularProgressIndicator(),
        ),
      )
          :Row(
        children: [
          Container(
            width: 80,
            child: ListView.builder(
                  itemCount: categories.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {

                    return Column(

                      children: [
                        SizedBox(height: 20,),
                        if(categories[index] == "computing") Icon(Icons.computer, color: Colors.grey[800],size:30,)
                       else if(categories[index] == "Home & Office") Icon(Icons.desk, color: Colors.grey[800],size:30,)
                       else if(categories[index] == "Gaming") Icon(Icons.gamepad, color: Colors.grey[800],size:30,)
                       else if(categories[index] == "Phones & Tablets") Icon(Icons.phone_android, color: Colors.grey[800],size:30,)
                       else if(categories[index] == "Electronics") Icon(Icons.cable, color: Colors.grey[800],size:30,)
                       else Container(),
                        Text("${categories[index]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[800],

                          ),)
                      ],
                    );
                  }

            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width-80,
            child: ListView.builder(
            itemCount: categories.length+1,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {

              if(index == 0)
                {
                  return Padding(
                    padding: const EdgeInsets.only(left:8.0, right: 16.0, bottom: 8.0, top:20),
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(
                            MaterialPageRoute
                              (builder: (context)=>Add_Products(
                              user_email: user_email,
                              company_name: '',
                              location: '',)));
                      },
                      child: Container(
                        height: 40,
                        width: double.infinity,

                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey[500]!
                          ),

                          borderRadius:BorderRadius.all( Radius.circular(2), ),

                        ),

                        child: Center(

                          child: Text(
                            "Add New Product",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );

                }
              else
                {

                  return Categories_Grid(category:categories[index-1], items: products,);

                }
            }
            ),

          )
        ],
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
                            (builder: (context)=>Messanger())

                      );

                    },

                    child: Container(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Icon(Icons.chat, color:Colors.grey[500]),
                              Positioned(
                                  right: 0,
                                  child: CircleAvatar(
                                    radius: 6,
                                    backgroundColor: Colors.red,
                                    child: Text("3", style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                    ),),
                                  )
                              )
                            ],
                          ),
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
                      );                      //await Share.share("link to download app");
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
