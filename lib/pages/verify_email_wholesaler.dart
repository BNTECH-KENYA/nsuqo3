import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/pages/home/homepagecategories/wholesaler/wholesaler_categories.new_edition.dart';
import 'package:nsuqo/pages/wholesaler_home_new.dart';
import 'package:toast/toast.dart';

import '../helpers/exit_pop.dart';

class Verify_Email_WholeSaler extends StatefulWidget {
  const Verify_Email_WholeSaler({Key? key}) : super(key: key);

  @override
  State<Verify_Email_WholeSaler> createState() => _Verify_Email_WholeSalerState();

}

class _Verify_Email_WholeSalerState extends State<Verify_Email_WholeSaler> {

  TextEditingController _email = TextEditingController();
  final auth = FirebaseAuth.instance;
  late User user;
  Timer? timer;

  Future <void> checkEmailVerfied () async {
    user = auth.currentUser!;
    await user.reload();

    if(user.emailVerified){
      timer!.cancel();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=> Whole_Saler_categories()));

    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    timer = Timer.periodic(Duration(seconds:5), (timer){

      checkEmailVerfied ();

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

                  Text("Verify Email", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),),

                  SizedBox(height: 30,),

                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text("check you email for mail verification link or spam folder", style:TextStyle(
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
                        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
                        Toast.show("Email Verification Link Sent to your email please check".toString(), context,duration:Toast.LENGTH_SHORT,
                            gravity: Toast.TOP);
                      }

                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                          color:  Colors.grey[700]!,
                          border: Border.all(
                              color:  Colors.grey[700]!
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text("Resend Verification", style: TextStyle(
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
