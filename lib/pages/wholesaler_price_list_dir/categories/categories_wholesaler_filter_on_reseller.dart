import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:nsuqo/pages/retialers_who_can_view_products.dart';
import 'package:nsuqo/pages/select_type_of_adding_product.dart';
import 'package:nsuqo/pages/Login/sign_in.dart';
import 'package:nsuqo/pages/sub_categories.dart';
import 'package:nsuqo/pages/verify_email_wholesaler.dart';
import 'package:nsuqo/pages/wholesalersproductlist/wholesalers_product_list.dart';
import 'package:share/share.dart';

import '../../../../constants.dart';
import '../../../../helpers/update_pop.dart';
import '../../Edit_Profile.dart';
import '../../account_approval_wholesaler.dart';
import '../../create_account_wholesaler.dart';
import '../../home/homepagecategories/widgets/cat_home_new_ui_look.dart';
import '../../messanger/messanger_wholesaler/messangerwholesaler.dart';
import '../subcategories/sub_categories_wholesaler_filter_on_reseller.dart';

class Whole_Saler_categories_On_Resseler extends StatefulWidget {
  const Whole_Saler_categories_On_Resseler({Key? key, required this.wholesalerid}) : super(key: key);
  final String wholesalerid;
  @override
  State<Whole_Saler_categories_On_Resseler> createState() => _Whole_Saler_categories_On_ResselerState();

}

class _Whole_Saler_categories_On_ResselerState extends State<Whole_Saler_categories_On_Resseler> {

  List<dynamic> listcategories = [];
  List<dynamic> listsubcategories = [];
  List<dynamic> listsubsubcategories = [];

  bool isLoading = true;
  String user_email = "";
  String company_name = "";
  String location = "";

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> getuserdata()
  async {
    final docref = db.collection("userdd").doc(widget.wholesalerid);
    await docref.get().then((res) {

      if(res.data() != null)
      {

        if(res.data()!['fname'] != "")
        {
          if(res.data()!['approved'] == "approved"){
            setState(
                    (){

                  company_name = res.data()!['company_name'];
                  location = res.data()!['location'];
                  listcategories = res.data()!['listcategories'];
                  listsubcategories = res.data()!['listsubcategories'];
                  listsubsubcategories = res.data()!['listsubsubcategories'];
                  isLoading = false;

                }
            );
          }
          else
          {
            Navigator.of(context).push(
                MaterialPageRoute
                  (builder: (context)=>Account_Approval_WholeSaler(email_val: user_email,)));
          }
        }
        else
        {
          Navigator.of(context).push(
              MaterialPageRoute
                (builder: (context)=>Create_Account_WholeSaler()));
        }


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
        user.reload();
        if(user.emailVerified)
        {
          setState(
                  (){
                user_email = user.email!;

              });

          getuserdata();
        }
        else
        {
          Navigator.of(context).push(
              MaterialPageRoute
                (builder: (context)=>Verify_Email_WholeSaler()));
        }
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

  AppUpdateInfo ? _updateInfo;

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info){
      setState(
              (){
            _updateInfo = info;
          }
      );

      if(_updateInfo?.updateAvailability == UpdateAvailability.updateAvailable)
      {
        showUpdatePopup(context, (){
          InAppUpdate.performImmediateUpdate().catchError((e) => print(e));
        });

      }

    }).catchError(
            (e){

          print(e);

        }
    );
  }

  @override
  void initState() {
    // TODO: implement initState

    Timer(const Duration (milliseconds: 800), (){
      checkForUpdate();
    });

    super.initState();
        ()async{
      await checkAuth();

    }();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: HexColor("#1A434E"),

      body: SafeArea(
        child: ListView(

          children: [

            SizedBox(height:15),
            Container(
                width: MediaQuery.of(context).size.width,
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  /*
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/launch_image.png"),
                    ),
                   */
                    Container(),
             /*
                    InkWell(
                        onTap:(){

                          Navigator.of(context).push(
                              MaterialPageRoute
                                (builder: (context)=>Edit_Profile())
                          );

                        },
                        child: Icon(Icons.person, color: Colors.grey[200],size: 32,)

                    ),
              */

                  ],
                )
            ),
            SizedBox(height:30),

            Padding(
              padding: const EdgeInsets.only(left:20.0),
              child: Text("@${(widget.wholesalerid).split("@")[0]} Procuct Categories", style: TextStyle(
                  color: HexColor("#FFFFFF"),
                  fontSize: 20
              ),),
            ),

            SizedBox(height:20),


 Container(
   width: MediaQuery.of(context).size.width,
   height:MediaQuery.of(context).size.height,
   decoration: BoxDecoration(
       color: Colors.white,
       borderRadius: BorderRadius.only(
         topLeft:Radius.circular(20),
         topRight:Radius.circular(20))
   ),
   child: Padding(
     padding: const EdgeInsets.only(left:10.0),
     child: Column(
       children: [
         Container(
             width: MediaQuery.of(context).size.width,
             child:
             Padding(

               padding: const EdgeInsets.only(left:20.0, right:8.0, top:20.0),

               child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children:[

                     Text("Categories", style: TextStyle(
                         color: HexColor("#000000"),
                         fontWeight: FontWeight.w500,
                         fontSize: 18
                     ),),


                   ]
               ),
             )
         ),

         SizedBox(height:20),
         Container(
           height:400,
           width:MediaQuery.of(context).size.width,
           child: Column(
           children: [
             Row(
                 children:[
                   !listcategories.contains("Computing") ? Container() :InkWell(
                     onTap:(){

                       Navigator.of(context).push(
                           MaterialPageRoute
                             (builder: (context)=>
                               Sub_Categories_On_Resseler(subcat:'Computing', subcategories: listsubcategories, subsubcategories: listsubsubcategories,
                                 wholesalerid:widget.wholesalerid,)));


                     },
                     child: Cat_Home_New_UI(
                       image_path: "assets/comps.jpeg",
                       cat_name: "computing",
                       icon: Icons.computer, new_item: false,
                       hexcolor: "#E5DEF6" ,),
                   ),
                   SizedBox(width:20),
                   !listcategories.contains("Consumer Electronic") ? Container() : InkWell(
                     onTap:(){

                       Navigator.of(context).push(
                           MaterialPageRoute
                             (builder: (context)=>
                               Sub_Categories_On_Resseler(subcat:'Consumer Electronic', subcategories: listsubcategories, subsubcategories: listsubsubcategories,
                                 wholesalerid:widget.wholesalerid,)));


                     },
                     child: Cat_Home_New_UI(image_path: "assets/consumerelectronics.jpeg",
                       cat_name: "Consumer Electronic",
                       hexcolor: "#FAF3EB",
                       icon: Icons.cable,
                       new_item: false,

                     ),
                   ),
                 ]
             ),
             SizedBox(height:20),

             Row(
                 children:[
                   !listcategories.contains("Phones and Tablets") ? Container() : InkWell(
                     onTap:(){

                       Navigator.of(context).push(
                           MaterialPageRoute
                             (builder: (context)=>
                               Sub_Categories_On_Resseler(subcat:'Phones and Tablets', subcategories: listsubcategories, subsubcategories: listsubsubcategories,
                                 wholesalerid: widget.wholesalerid,)));


                     },
                     child: Cat_Home_New_UI(image_path: "assets/phonestabs.jpeg",
                       cat_name: "Phones and Tablets",
                       hexcolor: "#FAF3EB",
                       icon: Icons.phone_android,
                       new_item: false,
                     ),
                   ),
                   SizedBox(width:20),
                   !listcategories.contains("More") ? Container() :  InkWell(
                     onTap:(){

                       Navigator.of(context).push(
                           MaterialPageRoute
                             (builder: (context)=>
                               Sub_Categories_On_Resseler(subcat:'More', subcategories: listsubcategories, subsubcategories: listsubsubcategories,
                                 wholesalerid:widget.wholesalerid,)));


                     },
                     child: Cat_Home_New_UI(image_path: "assets/more.jpeg",
                       cat_name: "More",
                       icon: Icons.more_horiz,
                       hexcolor: "#E5DEF6",
                       new_item: false,
                     ),
                   ),
                 ]
             ),
           ],
           ),
         )
       ],
     ),
   ),
 )

          ],
        ),
      ),

    );
  }
}



























/*

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/pages/create_account_retailer.dart';
import 'package:nsuqo/pages/retialers_who_can_view_products.dart';
import 'package:nsuqo/pages/search_page.dart';
import 'package:nsuqo/pages/select_type_of_adding_product.dart';
import 'package:nsuqo/pages/sign_in.dart';
import 'package:nsuqo/pages/sub_categories.dart';
import 'package:nsuqo/pages/verify_email.dart';
import 'package:nsuqo/pages/verify_email_wholesaler.dart';
import 'package:nsuqo/pages/wholesalers.dart';
import 'package:nsuqo/pages/wholesalers_product_list.dart';
import 'package:share/share.dart';

import '../constants.dart';
import '../helpers/exit_pop.dart';
import '../widgets/cat_new_ui.dart';
import '../widgets/cat_new_ui_cc.dart';
import 'Edit_Profile.dart';
import 'account_approval.dart';
import 'account_approval_wholesaler.dart';
import 'add_product.dart';
import 'all_categories.dart';
import 'create_account_wholesaler.dart';
import 'edit_profile_retailer.dart';
import 'messanger.dart';
import 'messangerwholesaler.dart';

class Whole_Saler_categories extends StatefulWidget {
  const Whole_Saler_categories({Key? key,}) : super(key: key);

  @override
  State<Whole_Saler_categories> createState() => _Whole_Saler_categoriesState();

}

class _Whole_Saler_categoriesState extends State<Whole_Saler_categories> {

  List<String> categories = ["Phones and Tablets", "Consumer Electronic", "Computing", "More"];

  bool isLoading = true;
  String user_email = "";
  String company_name = "";
  String location = "";

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> getuserdata()
  async {
    final docref = db.collection("userdd").doc(user_email);
    await docref.get().then((res) {

      if(res.data() != null)
      {

        if(res.data()!['fname'] != "")
        {
          if(res.data()!['approved'] == "approved"){
            setState(
                    (){

                  company_name = res.data()!['company_name'];
                  location = res.data()!['location'];
                  isLoading = false;

                }
            );
          }
          else
          {
            Navigator.of(context).push(
                MaterialPageRoute
                  (builder: (context)=>Account_Approval_WholeSaler(email_val: user_email,)));
          }
        }
        else
        {
          Navigator.of(context).push(
              MaterialPageRoute
                (builder: (context)=>Create_Account_WholeSaler()));
        }


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
        user.reload();
        if(user.emailVerified)
        {
          setState(
                  (){
                user_email = user.email!;

              });

          getuserdata();
        }
        else
        {
          Navigator.of(context).push(
              MaterialPageRoute
                (builder: (context)=>Verify_Email_WholeSaler()));
        }
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
    return WillPopScope(
      onWillPop: ()=>showExitPopup(context),
      child: Scaffold(

      backgroundColor: pcolor,

      body: SafeArea(

          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [

                SingleChildScrollView(

                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*0.25,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 330,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 50,

                              child: InkWell(
                                onTap: (){

                                  Navigator.of(context).push(
                                      MaterialPageRoute
                                        (builder: (context)=>Sub_Categories(subcat:'Computing',)));
                                },
                                child: Cat_New_Ui( imagepath: 'assets/comps.jpeg', category: 'Computing', ),
                              ),
                            ),

                            Positioned(
                              left: 50,
                              bottom: 0,
                              child: InkWell(
                                  onTap: (){

                                    Navigator.of(context).push(
                                        MaterialPageRoute
                                          (builder: (context)=>Sub_Categories(subcat: 'Consumer Electronic',)));
                                  },
                                  child: Cat_New_Ui( category: 'Consumer Electronic', imagepath: 'assets/consumerelectronics.jpeg', )),
                            ),


                            Positioned(
                              right: 50,

                              child: InkWell(
                                  onTap: (){

                                    Navigator.of(context).push(
                                        MaterialPageRoute
                                          (builder: (context)=>Sub_Categories(subcat: 'Phones and Tablets',)));
                                  },
                                  child: Cat_New_Ui( category: 'Phones and Tablets', imagepath: 'assets/phonestabs.jpeg',)),
                            ),
                            Center(
                              child: InkWell(
                                  onTap: (){

                                    Navigator.of(context).push(
                                        MaterialPageRoute
                                          (builder: (context)=>Wholesaler_Product_List(wholesaler_id: user_email,)));
                                   // Wholesaler_Product_List
                                  },
                                  child: Cat_New_Ui_cc(cat_name: 'PriceList',)),
                            ),
                            Positioned(
                              right: 50,
                              bottom: 0,

                              child: InkWell(
                                  onTap: (){

                                    Navigator.of(context).push(
                                        MaterialPageRoute
                                          (builder: (context)=>Sub_Categories(subcat: 'More',)));
                                  },
                                  child: Cat_New_Ui( category: 'More', imagepath: 'assets/more.jpeg',)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                Positioned(
                    top: 10,
                    left: 10,
                    child: Container(

                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(right:20.0),
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [

                                CircleAvatar(

                                    child: Icon(Icons.person_outline_sharp, color: Colors.white,)

                                ),

                                SizedBox(width: 10,),

                                Container(
                                  width:MediaQuery.of(context).size.width*0.5,
                                  child: Text("Hello ${company_name}", style: TextStyle(
                                      color:Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),),
                                ),

                              ],
                            ),

                            InkWell(
                                onTap:()async{

                                  await FirebaseAuth.instance.signOut();
                                  Navigator.of(context).push(
                                      MaterialPageRoute
                                        (builder: (context)=>Sign_In())
                                  );

                                },
                                child: Text("Logout", style:TextStyle(color: Colors.white)))

                          ],
                        ),
                      ),
                    )),


                Positioned(
                  bottom: 0,
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute
                            (builder: (context)=>Type_Of_Adding_Product(
                            email: user_email,
                            company_name:company_name,
                            location: location ,)));

                    },

                    child: Padding(
                      padding: const EdgeInsets.only(left:16.0, right:16.0),
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width-32,

                        decoration: BoxDecoration(

                            borderRadius:BorderRadius.all( Radius.circular(2), ),

                            color: Colors.deepOrange
                        ),

                        child: Center(

                          child: Text(
                            "Add New Product",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )

      ),

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: BottomAppBar(
            color: pcolor,
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
                              (builder: (context)=>Messanger_WholeSaler()));
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
                        await Share.share("https://play.google.com/store/apps/details?id=com.nsuqo.opasso");

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
                              (builder: (context)=>Edit_Profile())

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

                    InkWell(

                      onTap: () async {

                        Navigator.of(context).push(
                            MaterialPageRoute
                              (builder: (context)=>Retailers_who_can_view(wholesaler_id: user_email,))

                        );
                      },

                      child: Container(
                        child: Column(
                          children: [
                            Icon(Icons.remove_red_eye, color:Colors.grey[500]),
                            Text(
                              'Hide Products',
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

 */