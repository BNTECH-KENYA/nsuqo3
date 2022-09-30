import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/pages/search_page.dart';
import 'package:nsuqo/pages/sign_in.dart';
import 'package:nsuqo/pages/sub_categories.dart';

import '../helpers/exit_pop.dart';
import 'Edit_Profile.dart';
import 'add_product.dart';
import 'messanger.dart';

class Whole_Saler_categories extends StatefulWidget {
  const Whole_Saler_categories({Key? key}) : super(key: key);

  @override
  State<Whole_Saler_categories> createState() => _Whole_Saler_categoriesState();
}

class _Whole_Saler_categoriesState extends State<Whole_Saler_categories> {

  List<String> categories = ["Home & Office", "Phones & Tablets", "Computing", "Electronics", "Fashion", "Gaming"];

  bool isLoading = true;
  String user_email = "";

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
              isLoading = false;
            });
        // getUserData(user.email);


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
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          SizedBox(height:20),
                          Padding(
                            padding: const EdgeInsets.only(left:16.0, right:16.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height:40,
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text("Categories",
                                        style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,

                                        ),),
                                      SizedBox(height: 6,),



                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
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

                              SizedBox(height: 20,),

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
                                                  (builder: (context)=>Sub_Categories(subcat: 'Computing',)));

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
                                                          :(categories[index] == "Home & Office") ? Icon(Icons.desk, color: Colors.deepPurpleAccent,size:30,)
                                                          :(categories[index] == "Gaming") ? Icon(Icons.gamepad, color: Colors.purple,size:30,)
                                                          :(categories[index] == "Phones & Tablets") ? Icon(Icons.phone_android, color: Colors.blue,size:30,)
                                                          :(categories[index] == "Electronics") ? Icon(Icons.cable, color: Colors.green,size:30,)
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

                Positioned(
                  bottom: 0,
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute
                            (builder: (context)=>Add_Products(user_email: user_email,)));
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

                        Navigator.of(context).push(
                            MaterialPageRoute
                              (builder: (context)=>Edit_Profile())

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