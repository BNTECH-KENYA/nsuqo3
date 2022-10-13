import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/pages/search_page.dart';
import 'package:nsuqo/pages/sign_in.dart';
import 'package:nsuqo/pages/sub_categories.dart';
import 'package:nsuqo/pages/wholesalers.dart';
import 'package:share/share.dart';

import '../helpers/exit_pop.dart';
import 'all_categories.dart';
import 'edit_profile_retailer.dart';
import 'messanger.dart';

class Home_Categories extends StatefulWidget {
  const Home_Categories({Key? key}) : super(key: key);

  @override
  State<Home_Categories> createState() => _Home_CategoriesState();
}

class _Home_CategoriesState extends State<Home_Categories> {



  List<String> categories = ["Phones and Tablets", "Consumer Electronic", "Computing", "More"];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>showExitPopup(context),
      child: Scaffold(

        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height-189,
            width:  MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  height: 150-83,
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
                            InkWell(
                              onTap:(){
                                Navigator.of(context).push(
                                    MaterialPageRoute
                                      (builder: (context)=>WholeSalers()));

                              },
                              child: Column(
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
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5,),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height-276,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left:16.0, right:16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(height: 0,),

                          Text("Categories",style:TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize:18
                          )),

                          SizedBox(height: 30,),

                          Container(

                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,

                            child: GridView.builder(
                              itemCount: categories.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.9,
                              ),
                              itemBuilder:(context,index) {

                                return  InkWell(
                                  onTap: (){

                                    if(categories[index] == "Computing")
                                      {

                                        Navigator.of(context).push(
                                            MaterialPageRoute
                                              (builder: (context)=>Sub_Categories(subcat:'Computing',)));

                                      }
                                    else if(categories[index] == "Phones and Tablets")
                                      {

                                        Navigator.of(context).push(
                                            MaterialPageRoute
                                              (builder: (context)=>Sub_Categories(subcat: 'Phones and Tablets',)));

                                      }
                                    else if(categories[index] == "Consumer Electronic")
                                      {

                                        Navigator.of(context).push(
                                            MaterialPageRoute
                                              (builder: (context)=>Sub_Categories(subcat: 'Consumer Electronic',)));

                                      }
                                    else if(categories[index] == "More")
                                      {
                                        Navigator.of(context).push(
                                            MaterialPageRoute
                                              (builder: (context)=>Sub_Categories(subcat: 'More',)));

                                      }

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(

                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                              radius: 30,
                                              backgroundColor: Colors.grey[300],
                                              child: CircleAvatar(
                                                radius: 28,
                                                backgroundColor: Colors.white,
                                                 child:(categories[index] == "Computing") ? Icon(Icons.computer, color: Colors.deepOrange,size:30,)
                                                     :(categories[index] == "More") ? Icon(Icons.more, color: Colors.deepPurpleAccent,size:30,)
                                                     :(categories[index] == "Gaming") ? Icon(Icons.gamepad, color: Colors.purple,size:30,)
                                                     :(categories[index] == "Phones and Tablets") ? Icon(Icons.phone_android, color: Colors.blue,size:30,)
                                                     :(categories[index] == "Consumer Electronic") ? Icon(Icons.cable, color: Colors.green,size:30,)
                                                     :(categories[index] == "Fashion") ? Icon(Icons.man_rounded, color: Colors.amber,size:30,):Container()

                                              ),

                                          ),
                                          SizedBox(height: 10,),
                                          Text("${categories[index]}", textAlign: TextAlign.center, style: TextStyle(

                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[600],

                                          ),)
                                        ],
                                      ),
                                    ),
                                  ),
                                );

                              })
                              ,
                          )

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
                        //await Share.share("link to download app");
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
