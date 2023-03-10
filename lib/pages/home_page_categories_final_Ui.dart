/*
import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_version/new_version.dart';
import 'package:nsuqo/pages/sub_categories.dart';
import 'package:nsuqo/pages/verify_email.dart';
import 'package:nsuqo/pages/wholesalers.dart';
import 'package:share/share.dart';
import 'package:upgrader/upgrader.dart';

import '../helpers/exit_pop.dart';
import '../widgets/cat_home_new_ui_look.dart';
import 'account_approval.dart';
import 'edit_profile_retailer.dart';
import 'messanger.dart';

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

        backgroundColor: Colors.black,
        body:
        UpgradeAlert(
        upgrader:Upgrader(
        shouldPopScope:()=> true,
    canDismissDialog:true,
    durationUntilAlertAgain:const Duration(days:1),
    dialogStyle:Platform.isIOS ? UpgradeDialogStyle.cupertino: UpgradeDialogStyle.material,),

    child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left:24.0, right:24.0),
              child: Column(
                children: [
                  SizedBox(height:15),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        CircleAvatar(
                          backgroundImage: AssetImage("assets/launch_image.png"),
                        ),
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
                  SizedBox(height:50),
                  Text("welcome Home", style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    color: Colors.grey[200]
                  ),),
                  Text("${business_name_disp}", style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.bodyLarge,
                color: Colors.grey[200]
            ),),
                  SizedBox(height:70),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    decoration: BoxDecoration(
                      color: Colors.grey[400]
                    ),
                  ),
                  SizedBox(height:20),

                Container(
                  width: MediaQuery.of(context).size.width,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text("Categories", style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.subtitle1,
                          color: Colors.grey[200]
                      ),),
                      InkWell(
                        onTap:(){

                          Navigator.of(context).push(
                              MaterialPageRoute
                                (builder: (context)=>WholeSalers()));

                        },
                        child: Text("Wholesalers", style: GoogleFonts.lato(
                            textStyle: Theme.of(context).textTheme.subtitle2,
                            color: Colors.grey[400]
                        ),),
                      ),
                    ]
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
                            InkWell(
                              onTap:(){

                                Navigator.of(context).push(
                                    MaterialPageRoute
                                      (builder: (context)=>Sub_Categories(subcat:'Computing',)));

                              },
                              child: Cat_Home_New_UI(
                                image_path: "assets/comps.jpeg",
                                cat_name: "computing",
                                icon: Icons.computer,),
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


                    },

                    child: Container(
                      child: Column(
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.grey[500],
                              radius: 16,
                              child: Icon(Icons.home_filled, color:Colors.black)),
                          Text(
                            'Home',
                            style: TextStyle(
                              color: Colors.white,
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