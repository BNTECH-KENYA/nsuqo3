import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/pages/create_account_retailer.dart';
import 'package:nsuqo/pages/search_page.dart';
import 'package:nsuqo/pages/sign_in.dart';
import 'package:nsuqo/pages/sub_categories.dart';
import 'package:nsuqo/pages/verify_email.dart';
import 'package:nsuqo/pages/wholesalers.dart';
import 'package:share/share.dart';

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
    super.initState();
        () async {
      await checkAuth();
    }();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>showExitPopup(context),
      child: Scaffold(

      backgroundColor: Colors.deepOrange,

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
                                child: Cat_New_Ui( imagepath: 'assets/computing.jpeg', category: 'Computing', ),
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
                                  child: Cat_New_Ui( category: 'Consumer Electronic', imagepath: 'assets/electronics.jpeg', )),
                            ),

                            Positioned(
                              right: 50,

                              child: InkWell(
                                  onTap: (){

                                    Navigator.of(context).push(
                                        MaterialPageRoute
                                          (builder: (context)=>Sub_Categories(subcat: 'Phones and Tablets',)));
                                  },
                                  child: Cat_New_Ui( category: 'Phones and Tablets', imagepath: 'assets/androidandphones.jpeg',)),
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

                                  await Share.share("https://play.google.com/store/apps/details?id=com.nsuqo.opasso");

                                },
                                child: Icon(Icons.share, color: Colors.white,))
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          )
      ),
    ),
    );
  }
}
