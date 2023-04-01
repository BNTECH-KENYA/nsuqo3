import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:nsuqo/pages/Login/sign_in.dart';
import 'package:nsuqo/pages/messanger/messanger_retailer/unreadretailer.dart';
import 'package:nsuqo/pages/wholesaler_home_new.dart';
import 'package:nsuqo/pages/wholesalerslist/wholesalers.dart';
import 'package:nsuqo/widgets/chat_stream.dart';
import 'package:share/share.dart';

import '../../../models/messanger.dart';
import '../../Edit_Profile.dart';
import '../../edit_profile_retailer.dart';
import '../../home/homepagecategories/home_page_categories.dart';

class Messanger extends StatefulWidget {

  const Messanger({Key? key}) : super(key: key);
  @override
  State<Messanger> createState() => _MessangerState();

}

class _MessangerState extends State<Messanger> {

  int unreadmessagesstate = 0;
  int unreadmessages = 0;
  bool isLoading = true;
  String user_email = "";
  bool isWholesaler = false;

  String search = "";

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

  int timecount = 0;
  Timer ? timer;

 void _startCountDown(){
   timer = Timer.periodic(Duration(seconds:1), (timer){

      if(timecount == 5){

        setState(() {
          unreadmessages = unreadmessagesstate;
          timecount = 0;
        });
      }
      timecount ++;

    });
 }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

        () async {
      await checkAuth();
    }();
    _startCountDown();

  }


  @override
  void dispose() {
    // TODO: implement dispose
    timer!.cancel();
    super.dispose();

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: HexColor("#1A434E"),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20,),
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
                      color: Colors.grey[200]
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
                    color: HexColor("#FFFFFF"),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0,top: 12.0, bottom: 4),
                    child: TextField(
                      //controller: search_controller,
                      onChanged: (val){

                        setState(
                            (){
                                search = val;
                            }
                        );
                      },
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(

                          hintText: 'Search by name',
                          hintStyle: TextStyle(

                            fontSize: 14,
                            color: HexColor("#3C3C43"),

                          ),
                          border: InputBorder.none,
                        prefix: Icon(Icons.search,color: Colors.grey[300], size: 20, ),
                      ),
                      cursorColor: HexColor("#3C3C43"),

                    ),

                  ),
                ),
              ),
            ),

     SizedBox(height: 20,),

     Container(
       decoration: BoxDecoration(

         borderRadius: BorderRadius.only(topLeft:Radius.circular(20), topRight:Radius.circular(20)),
         color: HexColor("#FFFFFF"),

       ),

       width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.height-238,

       child: Column(
         children: [
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
                         Container(
                           decoration:BoxDecoration(
                            color:HexColor("#1A434E"),
                             borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                           child: Padding(
                             padding: const EdgeInsets.only(top:4.0, bottom:4.0, left:8.0, right:8.0),
                             child: Text("All", style: TextStyle(
                               color: Colors.grey[200],
                               fontSize: 18,
                               fontWeight: FontWeight.w500,
                             ),),
                           ),
                         ),
                         SizedBox(height: 6,),

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
                               color: HexColor("#1A434E"),
                               fontSize: 18,
                               fontWeight: FontWeight.w500,
                             ),),
                             SizedBox(width: 5,),


                           ],
                         ),
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
             height: MediaQuery.of(context).size.height-354,
             child: Padding(
                 padding: const EdgeInsets.only(left:16.0, right: 16),
                 child:

                 StreamBuilder(
                     stream:
                     search == ""?
                     FirebaseFirestore
                         .instance
                         .collection("oneChatStream")
                         .where("participants", arrayContains: user_email)
                         .orderBy("msgtimestamp", descending: true)
                         .snapshots():
                     FirebaseFirestore
                         .instance
                         .collection("oneChatStream")
                         .where("participants", arrayContains: user_email)
                         .orderBy("msgtimestamp", descending: true)
                         .snapshots()
                     ,
                     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)  {
                       if(!snapshot.hasData)
                       {
                         return Center(
                           child: Card(
                             child: Container(
                               width: MediaQuery.of(context).size.width*0.6,
                               height: 100,
                               child: Center(
                                 child: Container(
                                     height: 80,
                                     child: CircularProgressIndicator(
                                       color: Colors.black,
                                     )
                                 ),
                               ),

                             ),

                           ),
                         );
                       }
                       else
                       {
                         unreadmessagesstate = 0;
                         return

                           search == ""?
                           ListView.builder(
                             itemCount: snapshot.data?.size,
                             itemBuilder: (context, index){

                               QueryDocumentSnapshot<Object?>? course = snapshot.data?.docs[index];


                               course?['sender_email'] == user_email? 0: unreadmessagesstate += int.parse(course!['unrdmessage']!.toString());

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

                               ),
                                 groupuid: course!.id, fun: (){
                                   unreadmessagesstate -1;

                                 },);
                             },
                           ):
                           ListView.builder(
                             itemCount: snapshot.data?.size,
                             itemBuilder: (context, index){

                               QueryDocumentSnapshot<Object?>? course = snapshot.data?.docs[index];
                               course?['sender_email'] == user_email? 0: unreadmessagesstate += int.parse(course!['unrdmessage']!.toString());

                               String name_search = user_email == course?['retailer_id'] ? course!['opponent_name'] :course?['sendername'];
                               return name_search.toLowerCase().contains(search.toLowerCase())?  Chat_Stream_Widget(messagermodel: MessangerModel(
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

                               ), groupuid: course!.id, fun: (){
                                 unreadmessagesstate -1;
                               },):Container();
                             },
                           )
                         ;
                       }

                     }
                 )
             ),
           )
         ],
       ),
     )
          ],
        ),

      ),

      bottomNavigationBar: BottomAppBar(
        color: HexColor("#F1F5FB"),
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
                        Icon(Icons.home_filled,color:HexColor("#444746")),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: HexColor("#1A434E"),
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
                          (builder: (context)=>WholeSalers()));

                  },

                  child: Container(
                    child: Column(
                      children: [
                        Icon(Icons.groups, color:HexColor("#444746")),
                        Text(
                          'Wholesalers',
                          style: TextStyle(
                            color: HexColor("#1A434E"),
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
                        Container(
                            width:55,
                            height: 30,
                            decoration: BoxDecoration(
                                color: HexColor("#E5DEF6"),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                            child: Icon(Icons.chat, color:HexColor("#1A434E"))),
                        Text(
                          'Messsanger',
                          style: TextStyle(
                            color: HexColor("#1A434E"),
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
                        Icon(Icons.share, color:HexColor("#444746")),
                        Text(
                          'share',
                          style: TextStyle(
                            color: HexColor("#1A434E"),
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
                        Icon(Icons.person, color:HexColor("#444746")),
                        Text(
                          'profile',
                          style: TextStyle(
                            color: HexColor("#1A434E"),
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

    );
  }
}
