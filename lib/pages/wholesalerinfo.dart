import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
   String payment_details_terms="";
   String working_hours="0-0";
   bool isLoading = true;

  int imageindex = 0;

  FirebaseFirestore db = FirebaseFirestore.instance;

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
                  location = res.data()!['location'];
                  payment_details_terms = res.data()!['payment_detailsterms'];
                  market_coverage = res.data()!['market_coverage'];
                  distribution_category = res.data()!['distribution_category'];

              isLoading = false;

            }
        );


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
          color: Colors.deepOrange
      ),
      child: Center(child: CircularProgressIndicator(
        backgroundColor: Colors.white,
      ),),
    ): Scaffold(


      body:SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left:16.0, right:16.0),
            child: Column(
              children: [
                SizedBox(height:20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: ()
                        {
                          Navigator.pop(context);
                        },

                        child: Icon(Icons.arrow_back,  color:Colors.deepOrange, size:30)),
                    Text("${company_name}", style:TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    )),
                    Icon(Icons.cancel,  color:Colors.grey[100], size:30),
                  ],
                ),
                SizedBox(height: 20,),
                SingleChildScrollView(
                  child: Column(
                    children: [


                      SizedBox(height: 20,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              child: Icon(Icons.book, size: 40, color: Colors.deepOrange,),

                            ),

                            SizedBox(
                              width: 30,
                            ),

                            Container(
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text("About Us", style:TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                  )),

                                  SizedBox(height: 10,),

                                  Container(
                                    width: MediaQuery.of(context).size.width-122,
                                    child: Text("${business_description}", style:TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    )),
                                  ),

                                ],
                              ),


                            ),
                          ],
                        ),
                      ) ,

                      SizedBox(height: 20,),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              child: Icon(Icons.payment, size: 40, color: Colors.deepOrange,),

                            ),

                            SizedBox(
                              width: 30,
                            ),

                            Container(
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text("Payment Details And Terms", style:TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                  )),

                                  SizedBox(height: 10,),

                                  Container(
                                    width: MediaQuery.of(context).size.width-122,
                                    child: Text("${payment_details_terms}", style:TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 15,
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
                              width: 60,
                              child: Icon(Icons.bubble_chart_outlined, size: 40, color: Colors.deepOrange,),

                            ),

                            SizedBox(
                              width: 30,
                            ),

                            Container(
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Products", style:TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                  )),

                                  SizedBox(height: 10,),

                                  Container(
                                    width: MediaQuery.of(context).size.width-122,
                                    child: Text("${distribution_category}", style:TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 15,
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
                              width: 60,
                              child: Icon(Icons.access_time_filled_sharp, size: 40, color: Colors.deepOrange,),

                            ),

                            SizedBox(
                              width: 30,
                            ),

                            Container(
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Working Hours", style:TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                  )),

                                  SizedBox(height: 10,),

                                  Container(
                                    width: MediaQuery.of(context).size.width-122,
                                    child: Text("open: ${working_hours.split("-")[0]} \n close: ${working_hours.split("-")[1]}", style:TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 15,
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
                              width: 60,
                              child: Icon(Icons.call, size: 40, color: Colors.deepOrange,),

                            ),

                            SizedBox(
                              width: 30,
                            ),

                            Container(
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Contact us", style:TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                  )),

                                  SizedBox(height: 10,),

                                  Container(
                                    width: MediaQuery.of(context).size.width-122,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.email,color: Colors.grey[500], ),
                                            Text(" : ${email}", style:TextStyle(
                                              color: Colors.grey[500],
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            )),
                                          ],
                                        ),
                                        SizedBox(height: 7,),
                                        Row(
                                          children: [
                                            Icon(Icons.call,color: Colors.grey[500], ),
                                            Text(" : ${contact_details}", style:TextStyle(
                                              color: Colors.grey[500],
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            )),
                                          ],
                                        ),
                                        SizedBox(height: 7,),
                                        Row(
                                          children: [
                                            Icon(Icons.message,color: Colors.grey[500], ),
                                            Text(" : in app chat", style:TextStyle(
                                              color: Colors.grey[500],
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),


                                ],
                              ),


                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
      )


    );
  }
}
