import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nsuqo/pages/chat_page/chat_page.dart';
import 'package:nsuqo/pages/specific_wholesaler_products.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/wholesalers_model.dart';

class WholeSaler_Info extends StatefulWidget {
  const WholeSaler_Info({Key? key, required this.wholesalerid}) : super(key: key);
  final String wholesalerid;

  @override
  State<WholeSaler_Info> createState() => _WholeSaler_InfoState();
}

class _WholeSaler_InfoState extends State<WholeSaler_Info> {

   String wholesalerid ="";
   String business_description ="";
   String company_name ="";
   String contact_details ="";
   String distribution_category ="";
   String email="";
   String location="";
   String market_coverage="";
   List<dynamic> payment_details_terms=[];
   String working_hours="0-0";
   bool isLoading = true;

   late String user_email;
   String email_reciever = "";
   String sender_name = "";
   bool isWholesaler = false;

   String product_name ="";
   String product_description ="";
   String product_price = "";
   String product_id = "";
   String retailer_id = "";
   String opponent_name ="";
   List photosLinks = [];

  int imageindex = 0;

  FirebaseFirestore db = FirebaseFirestore.instance;

   Future<void> getUserData(user_email)
   async {

     final docref = db.collection("userdd").doc(user_email);
     await docref.get().then((res) {

       if(res.data() != null)
       {
         if(res.data()!['accounttype'] =="wholesaler")
         {
           setState(
                   (){
                 isWholesaler = true;
                 sender_name = res.data()!['company_name'];
                 email_reciever = retailer_id;
               }
           );

         }
         else
         {
           setState(
                   (){

                 retailer_id= res.id;

                 sender_name = "${res.data()!['firstNameinput']} ${res.data()!['lastNameInput']}";
               }
           );

         }

       }
       else
       {
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
         setState(
                 (){
               user_email =  user.email!;
             }
         );

         getUserData(user_email);
       }
       else{


       }
     });

   }


  Future<void> getWholeSalerinfo()
  async {
    final docref = db.collection("userdd").doc(widget.wholesalerid);
    await docref.get().then((res) {

      if(res.data() != null)
      {
        setState(
                (){
                  working_hours = res.data()!['working_hours'];
                  email = res.data()!['email'];
                  business_description = res.data()!['business_description'];
                  wholesalerid = res.id;
                  contact_details = res.data()!['contact_details'];
                  company_name = res.data()!['company_name'];
                  opponent_name = res.data()!['company_name'];
                  location = res.data()!['location'];
                  payment_details_terms = res.data()!['payment_detailsterms'];
                  market_coverage = res.data()!['market_coverage'];
                  distribution_category = res.data()!['distribution_category'];

              isLoading = false;

            }
        );

         checkAuth();

      }

    });

  }

   @override
   void initState() {
     // TODO: implement initState
     super.initState();
         () async {
       await getWholeSalerinfo();
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
    ): Scaffold(
      backgroundColor: Colors.white,
      body:
      Padding(
        padding: const EdgeInsets.only(left:0, right:0),
        child: SingleChildScrollView(
          child: Column(
            children: [
             Container(

                      decoration:BoxDecoration(
                        color: HexColor("#1A434E"),

                      ),
             child: Padding(
               padding: const EdgeInsets.only(left:8.0, right:8.0),
               child: Column(
                     children:[
                       SizedBox(height:90),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           InkWell(
                               onTap: ()
                               {
                                 Navigator.pop(context);
                               },

                               child: Icon(Icons.arrow_back,  color:Colors.grey[200], size:30)),
                           Text("${company_name}", style:TextStyle(
                             color:Colors.grey[200],
                             fontSize: 20,
                             fontWeight: FontWeight.bold,
                           )),
                           //Icon(Icons.cancel,  color:Colors.grey[100], size:30),
                         ],
                       ),
                       SizedBox(height: 10,),
                     ]
                 ),
             ),
             ),
              SingleChildScrollView(
                child: Column(
                  children: [


                    SizedBox(height: 20,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            child: Icon(Icons.book, size: 25, color:HexColor("#1A434E"),),

                          ),

                          SizedBox(
                            width: 30,
                          ),

                          Container(
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text("About Us", style:TextStyle(
                                  color:HexColor("#1A434E"),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                )),

                                SizedBox(height: 10,),

                                Container(
                                  width: MediaQuery.of(context).size.width-122,
                                  child: Text("${business_description}", style:TextStyle(
                                    color: HexColor("#1A434E"),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  )),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20,),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            child: Icon(Icons.payment, size: 25, color: HexColor("#1A434E"),),

                          ),

                          SizedBox(
                            width: 30,
                          ),

                          Container(
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text("Payment Details And Terms", style:TextStyle(
                                  color: HexColor("#1A434E"),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                )),

                                SizedBox(height: 10,),

                                payment_details_terms.length == 1?   Container(
                                  width: MediaQuery.of(context).size.width-122,
                                  child: Text("${payment_details_terms[0]}", style:TextStyle(
                                    color: HexColor("#1A434E"),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  )),
                                ):
                                payment_details_terms.length == 2?   Container(
                                  width: MediaQuery.of(context).size.width-122,
                                  child: Text("${payment_details_terms[0]}\n ${payment_details_terms[1]}", style:TextStyle(
                                    color:HexColor("#1A434E"),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  )),
                                ):
                                payment_details_terms.length == 3?   Container(
                                  width: MediaQuery.of(context).size.width-122,
                                  child: Text("${payment_details_terms[0]}\n ${payment_details_terms[1]} \n  ${payment_details_terms[2]}", style:TextStyle(
                                    color: HexColor("#1A434E"),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  )),
                                ):Container() ,

                              ],
                            ),

                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            child: Icon(Icons.bubble_chart_outlined, size: 25, color: HexColor("#1A434E"),),

                          ),

                          SizedBox(
                            width: 30,
                          ),

                          InkWell(
                            onTap:(){
                              Navigator.of(context).push(
                                  MaterialPageRoute
                                  (builder: (context)=>Wholesaler_Products(
                                    wholesaler_name: company_name,
                                    wholesaler_id: wholesalerid,)));
                            },
                            child: Container(

                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("View Our Products", style:TextStyle(
                                      color: HexColor("#1A434E"),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  )),

                                  SizedBox(height: 10,),

                                  Container(
                                    width: MediaQuery.of(context).size.width-122,
                                    child: Text("${distribution_category}", style:TextStyle(
                                      color: HexColor("#1A434E"),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    )),
                                  ),

                                ],
                              ),


                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            child: Icon(Icons.access_time_filled_sharp, size: 25, color: HexColor("#1A434E"),),

                          ),

                          SizedBox(
                            width: 30,
                          ),

                          Container(
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Working Hours", style:TextStyle(
                                  color: HexColor("#1A434E"),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                )),

                                SizedBox(height: 10,),

                                Container(
                                  width: MediaQuery.of(context).size.width-122,
                                  child: Text("open: ${working_hours.split("-")[0]} \n close: ${working_hours.split("-")[1]}", style:TextStyle(
                                    color: HexColor("#1A434E"),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  )),
                                ),

                              ],
                            ),


                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            child: Icon(Icons.location_on, size: 25, color: HexColor("#1A434E"),),

                          ),

                          SizedBox(
                            width: 30,
                          ),

                          Container(
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Location", style:TextStyle(
                                  color: HexColor("#1A434E"),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                )),

                                SizedBox(height: 10,),

                                Container(
                                  width: MediaQuery.of(context).size.width-122,
                                  child: Text("located in:${location}", style:TextStyle(
                                    color: HexColor("#1A434E"),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  )),
                                ),

                              ],
                            ),


                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20,),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            child: Icon(Icons.call, size: 25, color: HexColor("#1A434E"),),

                          ),

                          SizedBox(
                            width: 30,
                          ),

                          Container(
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Contact us", style:TextStyle(
                                  color: HexColor("#1A434E"),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                )),

                                SizedBox(height: 10,),

                                Container(
                                  width: MediaQuery.of(context).size.width-122,
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap:() async {
                                          final Email email_data = Email(
                                            body: 'Email body',
                                            subject: 'Email subject',
                                            recipients: ['${email}'],
                                            attachmentPaths: ['/path/to/attachment.zip'],
                                            isHTML: false,
                                          );

                                          await FlutterEmailSender.send(email_data);
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.email,color: HexColor("#1A434E"), ),
                                            Text(" : ${email}", style:TextStyle(
                                              color: HexColor("#1A434E"),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            )),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 7,),
                                      InkWell(
                                        onTap:() async {


                                          await FlutterPhoneDirectCaller.callNumber(contact_details);

                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.call,color: HexColor("#1A434E"), ),
                                            Text(" : ${contact_details}", style:TextStyle(
                                              color: HexColor("#1A434E"),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            )),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 7,),
                                      InkWell(
                                        onTap:() async {


                                        if(user_email == ''){

                                          //toast please try again or


                                        }
                                        else
                                          {

                                            Navigator.of(context).push(
                                                MaterialPageRoute
                                                  (builder: (context)=>Chat_Page(
                                                  product_name: product_name,
                                                  product_photo: photosLinks[0],
                                                  product_description: product_description,
                                                  product_price: product_price,
                                                  wholesaler_id: widget.wholesalerid,
                                                  retailer_id:retailer_id ,
                                                  email_reciever:email_reciever ,
                                                  email_user: user_email,
                                                  sender_name:sender_name,
                                                  opponent_name: opponent_name,
                                                  auth_email:user_email, product_id: "not",)));

                                          }

                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.message,color: HexColor("#1A434E"), ),
                                            Text(" : Leave a message", style:TextStyle(
                                              color: HexColor("#1A434E"),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            )),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 7,),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )


    );
  }
}
