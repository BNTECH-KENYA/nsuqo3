import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../helpers/exit_pop.dart';
import 'home_page_categories.dart';

class Account_Approval extends StatefulWidget {
  const Account_Approval({Key? key, required this.email_val}) : super(key: key);
  final String email_val;

  @override
  State<Account_Approval> createState() => _Account_ApprovalState();
}
class _Account_ApprovalState extends State<Account_Approval> {

  FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController _email = TextEditingController();
  TextEditingController _message = TextEditingController();

  Timer ? timer;

  Future<void> post_user_data()
  async {
    final data = {
      "email":_email.text,
      "concern":_message.text,

    };

    db.collection("concerns").add(data).then(( documentSnapshot){


    });

  }

  Future<void> getUserData()
  async {
    final docref = db.collection("userdd").doc(widget.email_val);
    await docref.get().then((res) {

      if(res.data() != null)
      {
        if(res.data()!['approved'] =="approved")
        {
          timer!.cancel();

          Navigator.of(context).push(
              MaterialPageRoute
                (builder: (context)=>Home_Categories()));
          setState(
                  (){
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    timer = Timer.periodic(Duration(seconds:5), (timer){

      getUserData ();

    });

    setState(() {
     _email.text =widget.email_val;
    });




  }


  @override
  void dispose() {
    timer!.cancel();
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>showExitPopup(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 20,),

                  Container(
                    width:MediaQuery.of(context).size.width,
                    height:MediaQuery.of(context).size.height*0.25,
                    child: Center(
                      child: Image(
                        image: AssetImage("assets/launch_image.png"),
                        width: 150,
                        height: 150,

                      ),
                    ),
                  ),

                  Text("Account Approval ..", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),),

                  SizedBox(height: 30,),

                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text("After Your Account Has been approved you will be given access, You can Raise your concern in the section below", style:TextStyle(
                        color:Colors.grey[500],
                        fontWeight: FontWeight.w400,
                        fontSize:14
                    )),
                  ),

                  SizedBox(height: 20,),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.white
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.alternate_email,color: Colors.grey[400],),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 12.0,top: 12.0, bottom: 4),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width-83,
                            child: TextField(
                              controller: _email,
                              decoration: InputDecoration(
                                  hintText: 'example@gmail.com',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[400],

                                  ),

                                  border: InputBorder.none
                              ),
                              cursorColor: Colors.grey[500],
                            ),
                          ),

                        ),
                      ],
                    ),
                  ),

                  SizedBox(height:20),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.white
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.alternate_email,color: Colors.grey[400],),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 12.0,top: 12.0, bottom: 4),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width-83,
                            child: TextField(
                              controller: _message,
                              decoration: InputDecoration(
                                  hintText: 'message',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[400],

                                  ),

                                  border: InputBorder.none
                              ),
                              cursorColor: Colors.grey[500],
                            ),
                          ),

                        ),
                      ],
                    ),
                  ),

                  SizedBox(height:20),
                  InkWell(
                    onTap: () async {

                      if(_email.text.toString().trim().isEmpty || !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(_email.text.toString()))
                      {
                        Toast.show("Enter a valid email address".toString(), context,duration:Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM);
                      }

                      else
                      {
                        //login code
                        await FirebaseAuth.instance.sendPasswordResetEmail(email: _email.text);
                        Toast.show("Message Sent Successfully".toString(), context,duration:Toast.LENGTH_SHORT,
                            gravity: Toast.TOP);
                      }

                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[700]!,
                          border: Border.all(
                              color:  Colors.grey[700]!
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text("Send Concern", style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16
                          ),),
                        )
                    ),
                  ),

                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}
