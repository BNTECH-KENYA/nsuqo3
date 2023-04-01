import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nsuqo/pages/Login/sign_in.dart';

import '../../widgets/retailer_wholesaler.dart';
import '../home/homepagecategories/home_page_categories.dart';
import '../home/homepagecategories/wholesaler/wholesaler_categories.new_edition.dart';

class Welcome_Page extends StatefulWidget {
  const Welcome_Page({Key? key}) : super(key: key);

  @override
  State<Welcome_Page> createState() => _Welcome_PageState();
}

class _Welcome_PageState extends State<Welcome_Page> {

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> getUserData(user_email)
  async {
    final docref = db.collection("userdd").doc(user_email);
    await docref.get().then((res) {

      if(res.data() != null)
      {
        if(res.data()!['accounttype'] =="wholesaler")
        {
          Navigator.of(context).push(
              MaterialPageRoute
                (builder: (context)=>Whole_Saler_categories()));

          setState(
                  (){
               // isLoading = false;
              }
          );

        }
        else
        {
          Navigator.of(context).push(
              MaterialPageRoute
                (builder: (context)=>Home_Categories()));
          setState(
                  (){
               // isLoading = false;

              }
          );

        }



      }
      else
      {
        setState(
                (){
             // isLoading = false;
            }
        );
        print("out");
        FirebaseAuth.instance.signOut();

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
        getUserData(user.email);

      }
      else{
        setState(
                (){
             // isLoading = false;
            }
        );

      }
    });


  }




  @override
  void initState() {
    // TODO: implement initState
        ()async{

      await checkAuth();

    }();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:HexColor("#1A434E"),
      body:SafeArea(
        child:
        Container(
          width:MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                width:MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height,

                child:Center(
                  child:Image(
                    width:300,
                    height: 300,
                    image: AssetImage("assets/Rectangle 174.png"),

                  )
                )
              ),

              Positioned(
                  bottom: 10,

                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:8.0, right:8.0),
                        child:
                        InkWell(
                          onTap:(){

                            Navigator.of(context).push(
                                MaterialPageRoute
                                  (builder: (context)=>Sign_In()));

                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width-30,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: HexColor("#FFFFFF"),

                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),

                            child: Center(
                              child: Text("Login",style: TextStyle(
                                color: HexColor("#FFFFFF")
                              ), ),
                            ),

                          ),
                        ),
                      ),
                      SizedBox(height:20),
                      InkWell(
                        onTap:() async {


                          await  Retailer_Wholesaler(context);

                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width-30,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:HexColor("#1A434E")
                            ),

                              color:HexColor("#FFFFFF"),

                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Center(
                            child: Text("Register", style: TextStyle(
                               color:HexColor("#1A434E")
                            ),),
                          ),

                        ),
                      ),
                    ],
                  ))
            ],
          ),
        )
      )
    );
  }
}
