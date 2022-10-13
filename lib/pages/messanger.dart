import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nsuqo/pages/sign_in.dart';
import 'package:nsuqo/pages/unreadretailer.dart';
import 'package:nsuqo/pages/wholesaler_home_new.dart';
import 'package:nsuqo/widgets/chat_stream.dart';
import 'package:share/share.dart';

import '../models/messanger.dart';
import 'Edit_Profile.dart';
import 'edit_profile_retailer.dart';
import 'home_page_categories.dart';

class Messanger extends StatefulWidget {
  const Messanger({Key? key}) : super(key: key);

  @override
  State<Messanger> createState() => _MessangerState();

}

class _MessangerState extends State<Messanger> {

  int unreadmessages = 0;
  bool isLoading = true;
  String user_email = "";
  bool isWholesaler = false;

  List<MessangerModel> chat_streams = [];


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
              }
          );

        }
        else
        {

          setState(
                  (){
                    isWholesaler = true;
              }
          );

        }



      }
      else
      {
        setState(
                (){
              isLoading = false;
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.height,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.only(left:16.0, right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Messanges",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800]
                    ),

                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child:  Padding(
                  padding: const EdgeInsets.only(left:16.0, right: 16.0),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0,top: 12.0, bottom: 4),
                    child: TextField(

                      decoration: InputDecoration(

                          hintText: 'Search',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],

                          ),
                          border: InputBorder.none,
                        prefix: Icon(Icons.search,color: Colors.black, size: 20, ),
                      ),
                      cursorColor: Colors.grey[500],

                    ),

                  ),
                ),
              ),
            ),
            
            SizedBox(height: 15,),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left:16.0, right: 16),
                child: Row(
                  children: [
                    Text("${unreadmessages} new message(s)", style: TextStyle(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w500
                    ),),
                    SizedBox(width: 20,),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30,),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left:16.0, right: 16),
                child: Row(
                  children: [
                    InkWell(
                      onTap:(){


                      },
                      child: Column(
                        children: [
                          Text("All", style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),),
                          SizedBox(height: 6,),
                          Container(
                            width: 30,
                            margin: EdgeInsetsDirectional.only(start: 1.0,end:1.0),
                            height: 3.0,
                            color: Colors.grey[800],
                          )
                        ],
                      ),
                    ),

                    SizedBox(width: 20,),

                    InkWell(
                      onTap:(){

                        Navigator.of(context).push(
                            MaterialPageRoute
                              (builder: (context)=>Unread_Messanger_Retailer()));

                      },
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Unread", style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),),
                              SizedBox(width: 5,),
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.red,
                                child: Text("${unreadmessages}", style: TextStyle(
                                    color: Colors.white
                                ),),
                              )

                            ],
                          ),
                          SizedBox(height: 6,),
                          Container(
                            width: 30,
                            margin: EdgeInsetsDirectional.only(start: 1.0,end:1.0),
                            height: 3.0,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),

            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height-392,
              child: Padding(
                padding: const EdgeInsets.only(left:16.0, right: 16),
                child:StreamBuilder(
                    stream: FirebaseFirestore
                        .instance
                        .collection("oneChatStream")
                        .where("participants", arrayContains: user_email)
                        .orderBy("msgtimestamp", descending: true)
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)  {
                      if(!snapshot.hasData)
                      {
                        return Center(
                          child: Card(
                            color: Colors.deepOrange,
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.6,
                              height: 100,
                              child: Center(
                                child: Container(
                                  height: 80,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                ),
                              ),

                            ),

                          ),
                        );
                      }
                      else
                      {

                        return  ListView.builder(
                          itemCount: snapshot.data?.size,
                          itemBuilder: (context, index){

                            QueryDocumentSnapshot<Object?>? course = snapshot.data?.docs[index];

                            return Chat_Stream_Widget(messagermodel: MessangerModel(
                              unreadmsg:course?['sender_email'] == user_email? 0 : course?['unrdmessage'],
                              sender_name: user_email == course?['retailer_id'] ? course!['opponent_name'] :course?['sendername'],
                              timstamp: (DateFormat('dd/MMM/yyy').format(DateTime.parse((course?['msgtimestamp']).toDate().toString())))
                                  ==
                                  (DateFormat('dd/MMM/yyy').format(DateTime.now()))?
                              (DateFormat('hh:mm a').format(DateTime.parse((course?['msgtimestamp']).toDate().toString()))):

                              (DateFormat('dd/MMM/yyy hh:mm a').format(DateTime.parse((course?['msgtimestamp']).toDate().toString()))),
                              ltsmessage: course?['ltsmessage'],
                              wholesaler_id_mm: course?['wholesaler_id'],
                              retailer_id_mm: course?['retailer_id'],
                              reciever_email: course?['email_user'],
                              sender_email: course?['sender_email'],
                              opponent_name: course?['opponent_name'],
                              auth_email: user_email,
                            ), groupuid: course!.id);
                          },
                        );
                      }

                    }
                )
              ),
            )
          ],
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

                      Navigator.of(context).push(
                          MaterialPageRoute
                            (builder: (context)=>Home_Categories()));
                    },

                    child: Container(
                      child: Column(
                        children: [
                          Icon(Icons.home_filled, color:Colors.grey[500]),
                          Text(
                            'Home',
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
                          Stack(
                            children: [
                              Icon(Icons.chat, color:Colors.deepOrange),
                              Positioned(
                                  right: 0,
                                  child: CircleAvatar(
                                    radius: 6,
                                    backgroundColor: Colors.red,
                                    child: Text("3", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                    ),),
                                  )
                              )
                            ],
                          ),
                          Text(
                            'Messsanger',
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

                    onTap: () async {
                      await Share.share("link to download app");
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

    );
  }
}
