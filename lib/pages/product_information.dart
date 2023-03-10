import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/pages/chat_page.dart';
import 'package:nsuqo/pages/home_page_categories.dart';
import 'package:nsuqo/pages/messangerwholesaler.dart';
import 'package:nsuqo/pages/wholesaler_categories.new_edition.dart';
import 'package:nsuqo/pages/wholesaler_home_new.dart';
import 'package:nsuqo/pages/wholesalerinfo.dart';

import 'edit_item.dart';

class Product_Information extends StatefulWidget {
  const Product_Information({Key? key, required this.document_id}) : super(key: key);
  final String document_id;
  @override
  State<Product_Information> createState() => _Product_InformationState();
}

class _Product_InformationState extends State<Product_Information> {

 late String user_email;
 String email_reciever = "";
 String sender_name = "";
 bool isWholesaler = false;
 bool isLoading = true;

  String product_name ="";
  String product_description ="";
  String product_price = "";
  String product_id = "";
  String retailer_id = "";
  String wholesaler_id ="";
  String company_name ="";
  String location ="";
  String doc_id ="";
  String opponent_name ="";
  List photosLinks = [];

 int imageindex = 0;

 FirebaseFirestore db = FirebaseFirestore.instance;

 Future<void> getProductDeatil()
 async {
   final docref = db.collection("products").doc(widget.document_id);
   await docref.get().then((res) async {

     if(res.data() != null)
     {
       setState(
               (){
             product_name=  res.data()!['productname'];
             product_description=  res.data()!['productdescription'];
             photosLinks=  res.data()!['photosLinks'];
             product_price=  res.data()!['productprice'];
             wholesaler_id=  res.data()!['wholesalerid'];
             company_name=  res.data()!['company_name'];
             location=  res.data()!['location'];
             doc_id=  res.id;
             product_id=  res.id;
             if(!isWholesaler)
               {
                 opponent_name = company_name;
                 email_reciever = wholesaler_id;
               }
           }
       );
       await getexchangeratedata(wholesaler_id);
     }
   });
 }


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
         getProductDeatil();

       }
       else
       {
         setState(
                 (){

                   retailer_id= res.id;

                   sender_name = "${res.data()!['firstNameinput']} ${res.data()!['lastNameinput']}";
             }
         );

         getProductDeatil();
       }

     }
     else
     {
       print("out");
       FirebaseAuth.instance.signOut();
       getProductDeatil();
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

String ? exchange_rate;

 Future<void> getexchangeratedata(email)
 async {

   final docref = db.collection("userdd").doc(email);
   await docref.get().then((res) {
     if (res.data() != null) {
       if (res.data()!['fname'] != "") {
         if (res.data()!['approved'] == "approved") {
           setState(
                   () {

                 exchange_rate = res.data()!.containsKey("exchange_rate") ? res
                     .data()!["exchange_rate"] : "0";
                 isLoading = false;

                   }
           );

         }
       }
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
    ) :Scaffold(

      backgroundColor: Colors.black,
      body:SafeArea(

        child:Container(
          width: MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  photosLinks.length == 0 ?
                  Container(
                      height: 280,
                      width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius:BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15), ),
                            image: DecorationImage(
                              image: AssetImage("assets/computing.jpeg"),
                              fit:BoxFit.contain,

                            )
                        ),


                    ):
                  Container(
                    height: 280,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius:BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15), ),
                        image: DecorationImage(
                          image: NetworkImage(photosLinks[imageindex]),
                          fit:BoxFit.contain,

                        )
                    ),


                  )
                    ,
                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      child: ListView.builder(

                            itemCount: photosLinks.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {

                              return InkWell(
                                onTap:(){

                                  setState(
                                      (){
                                        imageindex = index;

                                      }
                                  );
                                },

                                child: Padding(
                                  padding: const EdgeInsets.only(right:20.0),
                                  child: Container(
                                    height: 70,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        borderRadius:BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15), ),
                                        image: DecorationImage(
                                          image: NetworkImage(photosLinks[index]),
                                          fit:BoxFit.contain,

                                        )
                                    ),

                                  ),
                                ),
                              );
                            }
                      ),
                    ),

                    SizedBox(height: 10,),

                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Text("${product_name}", style:TextStyle(

                          fontWeight: FontWeight.w600,
                          color:Colors.grey[300],
                        fontSize:18

                      )),
                    ),

                    SizedBox(height: 10,),

                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Text("About :", style:TextStyle(
                          fontWeight: FontWeight.w400,
                          color:Colors.grey[300],
                          fontSize:18
                      )),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width-10 ,
                            child: Padding(
                              padding: const EdgeInsets.only(left:16.0),
                              child: Text("${product_description}",

                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color:Colors.grey[600],

                                ),
                              ),
                            ),
                          ),
                        
                        ],
                      ),
                    ),

                    SizedBox(height: 10,),

                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Text("Purchase a Maximum of 10 products at a Go",   style: TextStyle(

                        fontWeight: FontWeight.w600,
                        color:Colors.grey[600],

                      ),),
                    ),

                    SizedBox(height: 30,),

                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Text("Wholesale Price",   style: TextStyle(

                        fontWeight: FontWeight.w600,
                        color:Colors.grey[600],

                      ),),
                    ),

                    SizedBox(height:10),

                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:16.0),
                          child:product_price.contains("_")?
                          Text("${product_price.split("_")[1]} ${  product_price.split("_")[0]}",

                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color:Colors.grey[600],
                              fontSize: 18
                            ),
                          ):  Text("NOT SET ${product_price}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color:Colors.grey[600],
                                fontSize: 18
                            ),
                          ),
                        ),

                        SizedBox(width:10),

                        Text("Equal To",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color:Colors.grey[600],
                              fontSize: 18
                          ),
                        ),

                        SizedBox(width:10),
                        Padding(
                          padding: const EdgeInsets.only(left:16.0),
                          child:product_price.contains("_")?
                          product_price.split("_")[1] == "USD"?
                          Text("kES ${
                              (double.parse( product_price.split("_")[0])*double.parse(exchange_rate!)).toStringAsFixed(3)
                                  }",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color:Colors.grey[600],
                              fontSize: 18
                            ),
                          ):Text("KES ${
                                      (double.parse( product_price.split("_")[0])*double.parse(exchange_rate!)).toStringAsFixed(3)
                                  }",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color:Colors.grey[600],
                                        fontSize: 18
                                    ),
                                  ) : Text("NOT SET ${product_price}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color:Colors.grey[600],
                                fontSize: 18
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height:50),

                    Padding(
                      padding: const EdgeInsets.only(left:16.0),
                      child:
                      Text("Exchange Rate ${exchange_rate}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color:Colors.grey[600],
                            fontSize: 18
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              isWholesaler?
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.black
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left:16.0, right:16.0, bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        InkWell(
                          onTap: (){

                              Navigator.of(context).push(
                                  MaterialPageRoute
                                    (builder: (context)=>Messanger_WholeSaler(
                                    )));


                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width *0.45,
                            height: 55,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey[800]!,

                                ),
                                borderRadius:BorderRadius.all( Radius.circular(30), ),
                                color: Colors.white
                            ),
                            child: Center(
                              child: Text("Chats",
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).push(
                                MaterialPageRoute
                                  (builder: (context)=>Edit_Item(
                                  doc_ic: doc_id,
                                  user_email: wholesaler_id,
                                  company_name: company_name,
                                  location: location,

                                )));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width *0.45,
                            height: 55,
                            decoration: BoxDecoration(
                                borderRadius:BorderRadius.all( Radius.circular(30), ),
                                color: Colors.grey[700]
                            ),
                            child: Center(
                              child: Text("Edit Product",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                            ),

                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ):Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.black
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left:16.0, right:16.0, bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        InkWell(
                          onTap: (){
                            Navigator.of(context).push(
                                MaterialPageRoute
                                  (builder: (context)=>Chat_Page(
                                  wholesaler_id: wholesaler_id,
                                  retailer_id:retailer_id ,
                                  email_reciever:email_reciever ,
                                  email_user: user_email,
                                  sender_name:sender_name,
                                  opponent_name: opponent_name,
                                  auth_email:user_email,
                                  product_id: product_id,
                                  product_name: product_name,
                                  product_photo: photosLinks.length >0 ?photosLinks[0]:"",
                                  product_description: product_description,
                                  product_price: product_price,
                                )));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width *0.45,
                            height: 55,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey[700]!,

                              ),
                                borderRadius:BorderRadius.all( Radius.circular(30), ),
                                color: Colors.white
                            ),
                            child: Center(
                              child: Text("Chat Now",
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w700
                                  ),
                              ),
                            ),

                          ),
                        ),

                        InkWell(
                          onTap: (){

                            Navigator.of(context).push(
                                MaterialPageRoute
                                  (builder: (context)=>WholeSaler_Info(wholesalerid: wholesaler_id,)));

                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width *0.45,
                            height: 55,
                            decoration: BoxDecoration(
                                borderRadius:BorderRadius.all( Radius.circular(30), ),
                                color: Colors.grey[800]
                            ),
                            child: Center(
                              child: Text("View Wholesaler",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                            ),

                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                    top: 10,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(left:16.0, right:16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap:(){

                                  Navigator.pop(context);

                                      },
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey.withOpacity(0.5),
                                  radius: 20,
                                  child: Icon(Icons.arrow_back,color: Colors.white,),
                                ),
                              ),
                              SizedBox(width: 10,),

                            ],
                          ),
                          isWholesaler? InkWell(
                            onTap:(){

                              Navigator.of(context).push(
                                  MaterialPageRoute
                                    (builder: (context)=>(
                                  Whole_Saler_categories()
                                  )));
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey.withOpacity(0.5),
                              radius: 20,
                              child: Icon(Icons.home,color: Colors.white,),
                            ),
                          ): InkWell(
                            onTap:(){

                              Navigator.of(context).push(
                                  MaterialPageRoute
                                    (builder: (context)=>(
                                  Home_Categories()
                                  )));
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey.withOpacity(0.5),
                              radius: 20,
                              child: Icon(Icons.home,color: Colors.white,),
                            ),
                          ),

                        ],
                      ),
                    ),
                  )

              )
            ],
          ),
        )
      ),

    );
  }
}
