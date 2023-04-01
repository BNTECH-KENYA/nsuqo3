import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:nsuqo/pages/sub_categories.dart';
import 'package:nsuqo/pages/verify_email.dart';
import 'package:nsuqo/pages/wholesalerslist/wholesalers.dart';
import 'package:share/share.dart';
import 'package:upgrader/upgrader.dart';

import '../../../helpers/exit_pop.dart';
import '../../../helpers/update_pop.dart';
import 'widgets/cat_home_new_ui_look.dart';
import '../../account_approval.dart';
import '../../create_account_retailer.dart';
import '../../edit_profile_retailer.dart';
import '../../messanger/messanger_retailer/messanger.dart';

class Home_Categories extends StatefulWidget {

  const Home_Categories({Key? key}) : super(key: key);
  @override
  State<Home_Categories> createState() => _Home_CategoriesState();

}

class _Home_CategoriesState extends State<Home_Categories> {

  List<String> categories = ["Phones and Tablets", "Consumer Electronic", "Computing", "More"];
  FirebaseFirestore db = FirebaseFirestore.instance;

  String user_email = "Hello...";
  String business_name_disp= "";
  List<dynamic> categories_notify_new= [];

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
                user_email =  user.email!;
              }
          );
          getUserData(user_email);
        }
        else
        {

          Navigator.of(context).push(
              MaterialPageRoute
                (builder: (context)=>Verify_Email()));

        }
      }
      else{

      }
    });
  }

  Future<void> getUserData(user_email)
  async {
    final docref = db.collection("userdd").doc(user_email);
    await docref.get().then((res) {

      if(res.data() != null)
      {
        if(res.data()!['firstNameinput'] != "")
        {
          if(res.data()!['approved'] != "approved")
          {

            Navigator.of(context).push(
                MaterialPageRoute
                  (builder: (context)=>Account_Approval(email_val: user_email,)));
            //Account_Approval

          }
          else
          {



          }
        }
        else
        {

          Navigator.of(context).push(
              MaterialPageRoute
                (builder: (context)=>Create_Account_Retailer()));

        }

        setState(
                (){
              business_name_disp = res.data()!['companyNameinput'];
              categories_notify_new = res.data()!['categories'];
            }
        );
      }
      else
      {

        print("out");
        FirebaseAuth.instance.signOut();

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
   /*
    final newVersion = NewVersion(
        androidId:'com.nsuqo.opasso'
    );
    */

    Timer(const Duration (milliseconds: 800), (){
      checkForUpdate();
    });
    super.initState();
        () async {
      await checkAuth();
    }();
  }

/*
  Future<void> checkNewVersion(NewVersion newVersion) async {

      final status = await newVersion.getVersionStatus();

      if(status != null){
        print("status $status");

        if(status.canUpdate){
          newVersion.showUpdateDialog(context: context,
            versionStatus: status,
            dialogText:'New Version is available in the store (${status.storeVersion})',
            dialogTitle: 'Update is Available !',
          );
        }
      }

      else{

        print("status is empty");

      }
  }
 */

  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: ()=>showExitPopup(context),
      child: Scaffold(

        backgroundColor: HexColor("#1A434E"),

        body: UpgradeAlert(
          upgrader:Upgrader(
            shouldPopScope:()=> true,
            canDismissDialog:true,
            durationUntilAlertAgain:const Duration(days:1),
            dialogStyle:Platform.isIOS ? UpgradeDialogStyle.cupertino: UpgradeDialogStyle.material,),

          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left:0, right:0),
              child: Column(
                children: [

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

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

                                InkWell(
                                    onTap:(){

                                      Navigator.of(context).push(
                                          MaterialPageRoute
                                            (builder: (context)=>Edit_Retailer_Profile())
                                      );
                                    },
                                    child: Icon(Icons.person, color: Colors.grey[200],size: 32,)),

                              ],
                            )
                        ),

                        SizedBox(height:30),

                        Padding(
                          padding: const EdgeInsets.only(left:20.0),
                          child: Text("welcome Home", style: TextStyle(
                            color: HexColor("#FFFFFF"),
                            fontSize: 20
                          ),),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left:20.0),
                          child: Text("${business_name_disp}", style: TextStyle(
                              color: HexColor("#FFFFFF"),
                              fontSize: 14
                          ),),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height:50),

                  SizedBox(height:20),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height:MediaQuery.of(context).size.height-288,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft:Radius.circular(20),
                          topRight:Radius.circular(20))
                    ),
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
                        Padding(
                          padding: const EdgeInsets.only(left:10.0),
                          child: Container(
                            height:400,
                            width:MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                Row(
                                    children:[
                                      InkWell(
                                        onTap:(){

                                          Navigator.of(context).push(
                                              MaterialPageRoute
                                                (builder: (context)=>Sub_Categories(subcat:'Computing',)));

                                        },
                                        child: Cat_Home_New_UI(
                                          image_path: "assets/comps.jpeg",
                                          cat_name: "Computing",
                                          icon: Icons.computer,
                                          new_item: categories_notify_new.contains("Computing"),
                                          hexcolor: "#E5DEF6",),
                                      ),
                                      SizedBox(width:20),
                                      InkWell(
                                        onTap:(){

                                          Navigator.of(context).push(
                                              MaterialPageRoute
                                                (builder: (context)=>Sub_Categories(subcat: 'Consumer Electronic',)));


                                        },
                                        child: Cat_Home_New_UI(image_path: "assets/consumerelectronics.jpeg",
                                            cat_name: "Consumer Electronic",
                                            icon: Icons.cable,
                                             hexcolor: "#FAF3EB",
                                            new_item: categories_notify_new.contains("Consumer Electronic")
                                        ),
                                      ),
                                    ]
                                ),
                                SizedBox(height:20),

                                Row(
                                    children:[
                                      InkWell(
                                        onTap:(){


                                          Navigator.of(context).push(
                                              MaterialPageRoute
                                                (builder: (context)=>Sub_Categories(subcat: 'Phones and Tablets',)));

                                        },
                                        child: Cat_Home_New_UI(image_path: "assets/phonestabs.jpeg",
                                            cat_name: "Phones and Tablets",
                                            icon: Icons.phone_android,
                                            hexcolor: "#FAF3EB",
                                            new_item: categories_notify_new.contains("Phones and Tablets")
                                        ),
                                      ),
                                      SizedBox(width:20),
                                      InkWell(
                                        onTap:(){

                                          Navigator.of(context).push(
                                              MaterialPageRoute
                                                (builder: (context)=>Sub_Categories(subcat: 'More',)));

                                        },
                                        child: Cat_Home_New_UI(image_path: "assets/more.jpeg",
                                            cat_name: "More",
                                            icon: Icons.more_horiz,
                                            hexcolor: "#E5DEF6",
                                            new_item: categories_notify_new.contains("More")
                                        ),
                                      ),
                                    ]
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(top:0.0),
          child: BottomAppBar(
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
                                child: Icon(Icons.home_filled, color:HexColor("#1A434E"))),
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
      ),
    );
  }
}



/*
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_version/new_version.dart';
import 'package:nsuqo/pages/create_account_retailer.dart';
import 'package:nsuqo/pages/search_page.dart';
import 'package:nsuqo/pages/sign_in.dart';
import 'package:nsuqo/pages/sub_categories.dart';
import 'package:nsuqo/pages/verify_email.dart';
import 'package:nsuqo/pages/wholesalers.dart';
import 'package:share/share.dart';
import 'package:upgrader/upgrader.dart';
import 'dart:io';

import '../helpers/exit_pop.dart';
import '../widgets/cat_new_ui.dart';
import '../widgets/cat_new_ui_cc.dart';
import 'account_approval.dart';
import 'all_categories.dart';
import 'edit_profile_retailer.dart';
import 'messanger.dart';

class Home_Categories extends StatefulWidget {
  const Home_Categories({Key? key,}) : super(key: key);

  @override
  State<Home_Categories> createState() => _Home_CategoriesState();

}

class _Home_CategoriesState extends State<Home_Categories> {

  List<String> categories = ["Phones and Tablets", "Consumer Electronic", "Computing", "More"];
  FirebaseFirestore db = FirebaseFirestore.instance;

  String user_email = "Hello...";
  String business_name_disp= "";

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
                  user_email =  user.email!;
                }
            );
            getUserData(user_email);
          }
        else
          {

            Navigator.of(context).push(
                MaterialPageRoute
                  (builder: (context)=>Verify_Email()));

          }
      }
      else{



      }
    });

  }

  Future<void> getUserData(user_email)
  async {
    final docref = db.collection("userdd").doc(user_email);
    await docref.get().then((res) {

      if(res.data() != null)
      {
        if(res.data()!['firstNameinput'] != "")
          {
            if(res.data()!['approved'] != "approved")
            {

              Navigator.of(context).push(
                  MaterialPageRoute
                    (builder: (context)=>Account_Approval(email_val: user_email,)));
              //Account_Approval

            }
            else
            {



            }
          }
        else
          {

          }

        setState(
            (){
              business_name_disp = res.data()!['companyNameinput'];
            }
        );
      }
      else
      {

        print("out");
        FirebaseAuth.instance.signOut();

      }

    });

  }

  @override
  void initState() {
    // TODO: implement initState
    final newVersion = NewVersion(
      androidId:'com.nsuqo.opasso'
    );

    Timer(const Duration (milliseconds: 800), (){
      checkNewVersion(newVersion);
    });
    super.initState();
        () async {
      await checkAuth();
    }();
  }

  Future<void> checkNewVersion(NewVersion newVersion) async {

  /*
      final status = await newVersion.getVersionStatus();
      if(status != null){
        print("status $status");
        if(status.canUpdate){

          newVersion.showUpdateDialog(context: context,
            versionStatus: status,
            dialogText:'New Version is available in the store (${status.storeVersion})',
            dialogTitle: 'Update is Available !',
          );

        }
      }
      else{

        print("status is empty");

      }
   */
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>showExitPopup(context),
      child: Scaffold(

      backgroundColor: Colors.deepOrange,

      body: UpgradeAlert(
            upgrader:Upgrader(
              shouldPopScope:()=> true,
              canDismissDialog:true,
              durationUntilAlertAgain:const Duration(days:1),
              dialogStyle:Platform.isIOS ? UpgradeDialogStyle.cupertino: UpgradeDialogStyle.material,

            ),

     child: SafeArea(

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
                                        (builder: (context)=>WholeSalers()));

                                },
                                child: Cat_New_Ui_cc(cat_name: "Wholesalers PriceList",)),
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
                  child:Container(

                    width: MediaQuery.of(context).size.width,
                    child:
                    Padding(
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
                              Text("Hello ${business_name_disp}", style: TextStyle(
                                  color:Colors.white,
                                  fontWeight: FontWeight.bold
                              ),),
                            ],
                          ),
                          InkWell(
                              onTap:() async {

                                await FirebaseAuth.instance.signOut();
                                Navigator.of(context).push(
                                    MaterialPageRoute
                                      (builder: (context)=>Sign_In())
                                );

                              },
                              child: Text("Logout", style: TextStyle(color: Colors.white),))
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        )
      )),

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

 */