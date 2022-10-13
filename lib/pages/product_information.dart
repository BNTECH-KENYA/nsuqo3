import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/pages/chat_page.dart';
import 'package:nsuqo/pages/wholesalerinfo.dart';

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
  String opponent_name ="";
  List photosLinks = [];

 int imageindex = 0;

 FirebaseFirestore db = FirebaseFirestore.instance;

 Future<void> getProductDeatil()
 async {
   final docref = db.collection("products").doc(widget.document_id);
   await docref.get().then((res) {

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
             product_id=  res.id;
             isLoading = false;
             if(!isWholesaler)
               {
                 opponent_name = company_name;
                 email_reciever = wholesaler_id;
               }
           }
       );


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

                   sender_name = "${res.data()!['firstNameinput']} ${res.data()!['lastNameInput']}";
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
         color: Colors.deepOrange
      ),
      child: Center(child: CircularProgressIndicator(
        backgroundColor: Colors.white,
      ),),
    ) :Scaffold(

      backgroundColor: Colors.white,
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
                  photosLinks.length == 0 ?  Container(
                      height: 280,
                      width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius:BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15), ),

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

                    SizedBox(height: 20,),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width-60 ,
                            child: Padding(
                              padding: const EdgeInsets.only(left:16.0),
                              child: Text("Best selling ${product_name} with ${product_description}",

                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color:Colors.grey[600],

                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            child:Icon(Icons.heart_broken, size: 30,color:Colors.grey[800])
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.only(left:16.0),
                      child: Text("KES ${product_price}",

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
                      color: Colors.white
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left:16.0, right:16.0, bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Container(
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

                        Container(
                          width: MediaQuery.of(context).size.width *0.45,
                          height: 55,
                          decoration: BoxDecoration(
                              borderRadius:BorderRadius.all( Radius.circular(30), ),
                              color: Colors.deepOrange
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
                    color: Colors.white
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
                                  auth_email:user_email,)));
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
                                color: Colors.deepOrange
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
                              Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0, right: 12.0,top: 12.0, bottom: 4),
                                  child: TextField(

                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.search, color: Colors.white,),
                                        hintText: 'Search',
                                        hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,

                                        ),
                                        border: InputBorder.none
                                    ),
                                    cursorColor: Colors.grey[500],

                                  ),

                                ),
                              ),
                            ],
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(0.5),
                            radius: 20,
                            child: Icon(Icons.home,color: Colors.white,),
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
