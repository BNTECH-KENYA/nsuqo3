import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nsuqo/models/messagemodel.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../widgets/date_chat_widget.dart';
import '../widgets/otherCard.dart';
import '../widgets/owncontributor.dart';

class Chat_Page extends StatefulWidget {

  const Chat_Page({Key? key,
    required this.wholesaler_id,
    required this.email_reciever,
    required this.email_user,
    required this.retailer_id,
    required this.sender_name,
    required this.opponent_name,
    required this.auth_email,

  }) : super(key: key);
  final String wholesaler_id,email_reciever,email_user, retailer_id, sender_name, opponent_name,auth_email;

  @override
  State<Chat_Page> createState() => _Chat_PageState();
}

class _Chat_PageState extends State<Chat_Page> {

  final itemController = ItemScrollController();
  final itemPositionsListener  = ItemPositionsListener.create();

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
  Widget build(BuildContext context) {

    return isLoading ?
    Container(
      width: MediaQuery.of(context).size.width,
      height:MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          borderRadius:BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15), ),
          color: Colors.deepOrange
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
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              backgroundColor:Colors.deepOrange,
              leadingWidth: 70,
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
                 CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                    )
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

            ),
          ),

          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [

                Container(
                  height: MediaQuery.of(context).size.height-159,
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

                        child: ScrollablePositionedList.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.size,
                          itemBuilder: (context, index){

                            QueryDocumentSnapshot<Object?>? course = snapshot.data?.docs[index];

                            if(course?['message'] !="" )
                            {

                              if(course?['sender_email'] == widget.auth_email)
                              {
                                messagemodels.add(MesssageModel(
                                    timestamp: DateFormat('dd/MMM/yyy').format(DateTime.parse((course?['timestamp']).toDate().toString())),

                                    name: course?['retailer_name'].split('-')[0],
                                    message:course?['message'],
                                    time_ui: (DateFormat('hh:mm a').format(DateTime.parse((course?['timestamp']).toDate().toString()))),
                                ));
                                return OwnMessageCard(messageModel:  MesssageModel(
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
                                  time_ui: (DateFormat('hh:mm a').format(DateTime.parse((course?['timestamp']).toDate().toString()))),
                                ));
                                return ReplCard(messageModel:  MesssageModel(
                                  timestamp: DateFormat('dd/MMM/yyy').format(DateTime.parse((course?['timestamp']).toDate().toString())),

                                  name: course?['retailer_name'].split('-')[0],
                                  message:course?['message'],
                                  time_ui: (DateFormat('hh:mm a').format(DateTime.parse((course?['timestamp']).toDate().toString()))),),);
                              }
                            }
                            else
                            {
                              return Container();
                            }



                          },
                          itemPositionsListener: itemPositionsListener,
                          itemScrollController: itemController,

                        ),
                        onNotification: (t){
                          if(t is ScrollUpdateNotification)
                            {
                              setState(
                                  (){

                                    onScroll = true;
                                  }
                              );
                              return true;
                            }
                          else
                            {
                              setState(
                                      (){

                                    onScroll = false;
                                  }
                              );
                              return false;
                            }

                        },
                      );
                    },

                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
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
                                      Icons.keyboard
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
                          radius: 25,
                          backgroundColor: Colors.deepOrange,
                          child: IconButton(
                            onPressed: () async {
                              if(_message.text .length >0)
                              {
                                await add_Chat_Data(_message.text);
                              }
                              else
                              {

                              }
                            },
                            icon: Icon(Icons.send,size:36, color:Colors.white),

                          ),
                        ),
                      ),
                    ],
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
