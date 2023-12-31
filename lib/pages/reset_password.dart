import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:hexcolor/hexcolor.dart';

class Reset_Password extends StatefulWidget {
  const Reset_Password({Key? key}) : super(key: key);

  @override
  State<Reset_Password> createState() => _Reset_PasswordState();
}

class _Reset_PasswordState extends State<Reset_Password> {

  TextEditingController _email = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: HexColor("#F5F5F5"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                SizedBox(height: 20,),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                      width:40,
                      height:40,
                      child:
                      Card(child: Center(child: Icon(Icons.arrow_back_ios, )))
                  ),
                ),

                SizedBox(height: 20,),

                Text("Forgot Password", style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),),

                SizedBox(height: 30,),

                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text("Don't worry! it happens. Please enter the email associated with your account", style:TextStyle(
                      color:Colors.grey[500],
                      fontWeight: FontWeight.w400,
                      fontSize:14
                  )),
                ),

                SizedBox(height: 20,),

                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: HexColor("#E8ECF4"),

                    border: Border.all(
                      color: HexColor("#F7F8F9"),
                    ),
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
                      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email.text);
                      Toast.show("Password Reset Link Sent to your email please check".toString(), context,duration:Toast.LENGTH_SHORT,
                          gravity: Toast.TOP);
                    }

                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        color:  HexColor("#1A434E"),
                        border: Border.all(
                            color:  HexColor("#1A434E")
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text("Submit", style: TextStyle(
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
    );
  }
}
