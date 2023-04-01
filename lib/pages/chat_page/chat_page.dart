import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:nsuqo/models/messagemodel.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:toast/toast.dart';
import 'package:workmanager/workmanager.dart';

import '../../widgets/date_chat_widget.dart';
import 'widgets/otherCard.dart';
import 'widgets/owncontributor.dart';

class Chat_Page extends StatefulWidget {

  const Chat_Page({Key? key,
    required this.wholesaler_id,
    required this.email_reciever,
    required this.email_user,
    required this.retailer_id,
    required this.sender_name,
    required this.opponent_name,
    required this.auth_email,
    required this.product_id,
    required this.product_name,
    required this.product_photo,
    required this.product_description,
    required this.product_price,

  }) : super(key: key);

  final product_id,wholesaler_id,email_reciever,email_user, retailer_id, sender_name, opponent_name,auth_email
  ,product_name,product_photo,product_description,product_price;


  @override
  State<Chat_Page> createState() => _Chat_PageState();
}

class _Chat_PageState extends State<Chat_Page> {

  final itemController = ItemScrollController();
  final itemPositionsListener  = ItemPositionsListener.create();

  ScrollController _scrollController = ScrollController();
   dot_notation_remover () {

    String chatStreamId = "";

     List<String> email_splits = "${widget.wholesaler_id+widget.retailer_id}".split(".");

     email_splits.forEach((element) {


       setState(
           (){
             chatStreamId = "${chatStreamId}${element}";
           }
       );

     });
     return chatStreamId;
  }


  bool isLoading = true;
  TextEditingController _message = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  Future<String> add_Chat_Data( enquiry)



  async {
    setState(
            (){
              isLoading = true;
        }
    );

    String documentid = "";

    final chatdetails = <String, dynamic>{

      "timestamp":FieldValue.serverTimestamp(),
      "wholesaler_id":widget.wholesaler_id,
      "groupuid":dot_notation_remover(),
      "sender_email": widget.auth_email,
      "wholesaler_name": "Brian",
      "retailer_name": "Jane",
      "company_name":"BNTECH",
      "message":enquiry,
      "product_id":widget.product_id,
      "product_photo":widget.product_photo,
      "product_description":widget.product_description,
      "product_price":widget.product_price,

    };

    await db.collection("allenquiries").add(chatdetails).then(
            (DocumentReference doc) async {
          documentid = doc.id;
       update_chat_Stream( enquiry );

        }
    );

    return documentid;

  }


  Future<void> update_chat_Stream( enquiry )

  async {

    final stream = <String, dynamic>{

      "ltsmessage":enquiry,
      "unrdmessage":FieldValue.increment(1),
      "msgtimestamp":FieldValue.serverTimestamp(),
      "wholesaler_id":widget.wholesaler_id,
      "retailer_id":widget.retailer_id,
      "sender_email":widget.auth_email,

    };

    await db.collection("oneChatStream").doc(dot_notation_remover()).update(stream);

    setState(
            (){
          isLoading = false;
          _message.text = "";
        }
    );

  }
  
  
  bool chatstreamexists = false;


  Future<void> add_chatsream_id( )

  async {

    final streamid = <String, dynamic>{
      
      "chatstreamidarray": "${dot_notation_remover()}",
      
    };

    await db.collection("stream_ids").doc("${dot_notation_remover()}").set(streamid);

    await add_chatsream();

  }
  


  Future<void> add_chatsream( )

  async {

    final stream = <String, dynamic>{

     "ltsmessage":"",
     "unrdmessage":0,
     "msgtimestamp":FieldValue.serverTimestamp(),
     "sendername":widget.sender_name,
     "email_user":widget.email_reciever,
     "sender_email":widget.email_user,
      "wholesaler_id":widget.wholesaler_id,
      "retailer_id":widget.retailer_id,
      "participants":[widget.email_reciever,widget.email_user],
       "opponent_name":widget.opponent_name,

    };
    await db.collection("oneChatStream").doc( dot_notation_remover()).set(stream);

    setState(
            (){
          isLoading = false;
        }
    );
  }
  
  Future <void> check_chat_stream_id()async {

    bool document_found = false;

    await db.collection("oneChatStream").get().then((value) async => {

      value.docs.forEach((element)=>{

        if(element.id == "dot_notation_remover()")
          {
            document_found = true,
          }


      }),

      if(!document_found )
        {

        await db.collection("oneChatStream").doc( dot_notation_remover()).set({
      "ltsmessage":"",
      "unrdmessage":0,
      "msgtimestamp":FieldValue.serverTimestamp(),
      "sendername":widget.sender_name,
      "email_user":widget.email_reciever,
      "sender_email":widget.email_user,
      "wholesaler_id":widget.wholesaler_id,
      "retailer_id":widget.retailer_id,
      "participants":[widget.email_reciever,widget.email_user],
      "opponent_name":widget.opponent_name,
    }),
        }


    });
    await db.collection("stream_ids").doc("${dot_notation_remover()}").get().then((res) {

      if(res.data() != null)
      {
        setState(
            (){
              chatstreamexists = true;
              isLoading = false;
            }
        );

      }

      else{

        add_chatsream_id();

      }

    });
    
    
  }


  // wholesaler_id_mm
  
    String date_data = "";
    bool onScroll = false;

  List<MesssageModel> messagemodels = [];


  Timer ? timer;
  int count_on_new_text = 0;


  void _start_count(){


    if(count_on_new_text == 3)
      {
        timer!.cancel();
        count_on_new_text = 0;
      }
    else
      {
        timer = Timer.periodic(Duration(seconds: 1), (timer) {

        });
        count_on_new_text ++;
      }


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
        ()async{
      await check_chat_stream_id();

    }();


        itemPositionsListener.itemPositions.addListener(() {

          final indices =
              itemPositionsListener.itemPositions.value
                  .where((element) {

                    final isTopVisible = element.itemLeadingEdge >=0;
                    final isBottomVisible = element.itemTrailingEdge <=1;

                    return isTopVisible && isBottomVisible;

              })
                  .map((e) => e.index).toList();

          setState(
              (){
                  date_data =  "${messagemodels[indices[indices.length-1]].timestamp}";
              }
          );

        });
    
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return isLoading ?
    Container(
      width: MediaQuery.of(context).size.width,
      height:MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          borderRadius:BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15), ),
          color: Colors.black
      ),
      child: Center(child: CircularProgressIndicator(
        backgroundColor: Colors.white,
      ),),
    )
        :Stack(

      children: [
        Image.asset("assets/bg.jpeg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit:BoxFit.cover),

        Scaffold(
          backgroundColor: HexColor("#1A434E"),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              backgroundColor:HexColor("#1A434E"),
              leadingWidth: 40,
              titleSpacing: 0,
              leading: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back,color:Colors.white,
                      size: 24,),

                  ],
                ),
              ),
              title: InkWell(
                onTap: (){

                },

                child: Container(
                  margin: EdgeInsets.all(6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      widget.auth_email == widget.wholesaler_id ?  Text("${widget.sender_name}",
                          style:TextStyle(
                              fontSize: 18.5,
                              fontWeight: FontWeight.bold,
                              color:Colors.white
                          )):
                      Text("${widget.opponent_name}",
                          style:TextStyle(
                              fontSize: 18.5,
                              fontWeight: FontWeight.bold,
                              color:Colors.white
                          ))
                    ],
                  ),
                ),
              ),

            /*
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right:16.0),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color:Colors.grey[700]),
                  ),
                )
              ],
             */
            ),
          ),

          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: HexColor("#F5F5F5")
            ),
            child: Column(
              children: [

                Expanded(
                 // height: MediaQuery.of(context).size.height-159,
                  child:StreamBuilder(
                    stream: FirebaseFirestore
                        .instance
                        .collection("allenquiries")
                        .where("groupuid", isEqualTo: dot_notation_remover())
                        .orderBy("timestamp", descending: false)
                        .snapshots(),

                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
                    {
                      if(!snapshot.hasData)
                      {
                        return Center(child: CircularProgressIndicator(),);
                      }

                      messagemodels = [];

                      return NotificationListener(

                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.size,
                          controller: _scrollController,
                          itemBuilder: (context, index){

                            QueryDocumentSnapshot<Object?>? course = snapshot.data?.docs[index];

                            if(course?['message'] !="" &&
                            course?['timestamp'] != null )
                            {

                              if(course?['sender_email'] == widget.auth_email)
                              {
                                messagemodels.add(MesssageModel(

                                  product_id: course?['product_id'],
                                  product_name: course?['product_name'],
                                  product_photo: course?['product_photo'],
                                  product_description: course?['product_description'],
                                  product_price: course?['product_price'],

                                    timestamp: DateFormat('dd/MMM/yyy').format(DateTime.parse((course?['timestamp']).toDate().toString())),

                                    name: course?['retailer_name'].split('-')[0],
                                    message:course?['message'],
                                    time_ui: (DateFormat('hh:mm a').format(DateTime.parse((course?['timestamp']).toDate().toString()))),
                                ));
                                return OwnMessageCard(messageModel:  MesssageModel(
                                product_id: course?['product_id'],
                                product_name: course?['product_name'],
                                product_photo: course?['product_photo'],
                                product_description: course?['product_description'],
                                product_price: course?['product_price'],

                                  timestamp: DateFormat('dd/MMM/yyy').format(DateTime.parse((course?['timestamp']).toDate().toString())),

                                  name: course?['retailer_name'].split('-')[0],
                                  message:course?['message'],
                                  time_ui: (DateFormat('hh:mm a').format(DateTime.parse((course?['timestamp']).toDate().toString()))),
                                ),);

                              }
                              else
                              {
                                messagemodels.add(MesssageModel(
                                  timestamp: DateFormat('dd/MMM/yyy').format(DateTime.parse((course?['timestamp']).toDate().toString())),
                                  name: course?['retailer_name'].split('-')[0],
                                  message:course?['message'],

                                    time_ui: (DateFormat('hh:mm a').format(DateTime.parse( (course?['timestamp']).toDate().toString())))

                                  ,product_id: course?['product_id'],
                                  product_name: course?['product_name'],
                                  product_photo: course?['product_photo'],
                                  product_description: course?['product_description'],
                                  product_price: course?['product_price'],
                                ));


                                return ReplCard(messageModel:  MesssageModel(
                                  timestamp: DateFormat('dd/MMM/yyy').format(DateTime.parse((course?['timestamp']).toDate().toString())),
                                  name: course?['retailer_name'].split('-')[0],
                                  message:course?['message'],
                                  time_ui: (DateFormat('hh:mm a').format(DateTime.parse((course?['timestamp']).toDate().toString()))),
                                  product_id: course?['product_id'],
                                   product_name: course?['product_name'],
                                    product_photo: course?['product_photo'],
                                    product_description: course?['product_description'],
                                  product_price: course?['product_price'],
                                ),);


                              }
                            }
                            else
                            {
                              return Container();
                            }
                          },
                        ),

                      );
                    },

                  ),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height:70,
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width-60,
                          child: Card(
                            margin: EdgeInsets.only(left: 2, right: 2, bottom: 8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)
                            ),
                            child: TextFormField(
                              controller: _message,
                              textAlignVertical:TextAlignVertical.center ,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText:"message...",
                                  prefixIcon: IconButton(
                                    icon: Icon(
                                        Icons.keyboard, color: Colors.grey[700],
                                    ),
                                    onPressed: (){

                                    },
                                  ),
                                  contentPadding: EdgeInsets.all(5)
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only( bottom: 8, right: 5, left:2),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey[700],
                            child: IconButton(
                              onPressed: () async {
                                if(_message.text .length >0)
                                {
                                 // await add_Chat_Data(_message.text);

                                  Workmanager().registerOneOffTask("posting", "chat",
                                    inputData: {
                                      "wholesaler_id": widget.wholesaler_id,
                                      "groupuid":dot_notation_remover(),
                                      "sender_email":widget.auth_email,
                                      "wholesaler_name":"Brian",
                                      "retailer_name": "Jane",
                                      "company_name":"BNTECH",
                                      "message":_message.text,
                                      "product_id": widget.product_id,
                                      "ltsmessage": _message.text,
                                      "retailer_id":widget.retailer_id,
                                      "product_id":widget.product_id,
                                      "product_photo":widget.product_photo,
                                      "product_name":widget.product_photo,
                                      "product_description":widget.product_description,
                                      "product_price":widget.product_price,

                                    },);

                                  Future.delayed(Duration(seconds:5)).then((value) => {

                                  _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut),
                                      //_start_count();
                                  });

                                  setState(
                                          (){
                                        isLoading = false;
                                        _message.text = "";
                                      }
                                  );


                                }
                                else
                                {

                                  Toast.show("Say Something".toString(), context,duration:Toast.LENGTH_SHORT,
                                      gravity: Toast.BOTTOM);

                                }
                              },
                              icon: Icon(Icons.send,size:24, color:Colors.white),

                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                onScroll ?  Positioned(
                    top: 10,
                    left: MediaQuery.of(context).size.width*0.35,
                    child: Chat_Dates(date_data: date_data,)

                ): Container(),
              ],
            ),
          ),
        ),
      ],
    );

  }
}
