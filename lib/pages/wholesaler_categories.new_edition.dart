import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/pages/create_account_retailer.dart';
import 'package:nsuqo/pages/search_page.dart';
import 'package:nsuqo/pages/sign_in.dart';
import 'package:nsuqo/pages/sub_categories.dart';
import 'package:nsuqo/pages/verify_email.dart';
import 'package:nsuqo/pages/verify_email_wholesaler.dart';
import 'package:nsuqo/pages/wholesalers.dart';
import 'package:share/share.dart';

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

                                  },
                                  child: Cat_New_Ui_cc()),
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
                                Text("Hello ${company_name}", style: TextStyle(
                                    color:Colors.white,
                                    fontWeight: FontWeight.bold
                                ),)
                              ],
                            ),

                            InkWell(
                                onTap:()async{

                                  await Share.share("https://play.google.com/store/apps/details?id=com.nsuqo.opasso");


                                },
                                child: Icon(Icons.share, color: Colors.white,))

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
                            (builder: (context)=>Add_Products(
                            user_email: user_email,
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
