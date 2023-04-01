import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nsuqo/pages/reset_password.dart';
import 'package:nsuqo/pages/home/homepagecategories/wholesaler/wholesaler_categories.new_edition.dart';
import 'package:nsuqo/pages/wholesaler_home.dart';
import 'package:nsuqo/pages/wholesaler_home_new.dart';
import 'package:toast/toast.dart';

import '../../../widgets/retailer_wholesaler.dart';
import '../../create_account_retailer.dart';
import '../../home/homepagecategories/home_page_categories.dart';
import '../../home_retailer.dart';

class Sign_Up_Retailer extends StatefulWidget {
  const Sign_Up_Retailer({Key? key}) : super(key: key);

  @override
  State<Sign_Up_Retailer> createState() => _Sign_Up_RetailerState();

}

class _Sign_Up_RetailerState extends State<Sign_Up_Retailer> {

  FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _cfpassword = TextEditingController();

  bool isLoading = true;
  bool obsuretext = true;
  String business_name = "";

  Future <void> sign_up_retailer ( email, password) async{
    setState(
            (){
          isLoading = true;
        });
    try{
     await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
        print("success");
        post_user_data(email);

      }

      );

    }on FirebaseAuthException catch(e) {
      Toast.show("${e}".toString(), context,duration:Toast.LENGTH_SHORT,
          gravity: Toast.TOP);
      setState(
      (){
      isLoading = false;
      });
    }


  }

  Future<void> post_user_data(email)
  async {
    final data = {
      "accounttype":"retailer",
      "address1ControlTextare":"",
      "citynameInput":"",
      "companyNameinput":"",
      "emailidInput":email,
      "firstNameinput":"",
      "identifier":email,
      "lastNameinput":"",
      "phonenumberInput":"",
      "state":"out",
      "approved":"pending",
      "wholesaler_limit_list": []

    };

      db.collection("userdd").doc(email).set(data).then(( documentSnapshot){

        checkAuth2();

      });

  }


  Future<void> checkAuth2()async {
    await FirebaseAuth.instance
        .authStateChanges()
        .listen((user)
    {
      if(user != null)
      {
         user?. sendEmailVerification();
         Navigator.of(context).push(
             MaterialPageRoute
               (builder: (context)=>Create_Account_Retailer()));
      }
      else{
        setState(
                (){
              isLoading = false;
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
          Navigator.of(context).push(
              MaterialPageRoute
                (builder: (context)=>Whole_Saler_categories()));
          setState(
                  (){
                isLoading = false;
              }
          );

        }
        else
        {
          Navigator.of(context).push(
              MaterialPageRoute
                (builder: (context)=>Home_Categories()));
          setState(
                  (){
                isLoading = false;

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
        getUserData(user.email);

      }
      else{
        setState(
                (){
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
        ()async{
      await checkAuth();

    }();
  }

  @override
  Widget build(BuildContext context) {


    return isLoading ?  Container(
      width: MediaQuery.of(context).size.width,
      height:MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          borderRadius:BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15), ),
          color: Colors.deepOrange
      ),
      child: Center(child: CircularProgressIndicator(
        backgroundColor: Colors.white,
      ),),
    )  :Scaffold(

      backgroundColor: Colors.white,
      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

           /*
                        Container(
                          width:MediaQuery.of(context).size.width,
                          height:MediaQuery.of(context).size.height*0.3,
                          child: Center(
                            child: Image(
                              image: AssetImage("assets/launch_image.png"),
                              width: 150,
                              height: 150,

                            ),
                          ),
                        ),

                    */


                        InkWell(
                          onTap: (){

                            Navigator.pop(context);

                          },
                          child: Container(
                              width:40,
                              height:40,
                              child:
                              Card(child: Icon(Icons.arrow_back_ios, ))
                          ),
                        ),

                        SizedBox(height: 30,),

                        Text("Hello! Register to get started", style: TextStyle(

                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),),

                        SizedBox(height: 30,),

                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          /*
                              Text("Enter Email", style:TextStyle(
                                  color:Colors.grey[600],
                                  fontWeight: FontWeight.w400,
                                  fontSize:14
                              )),
                           */

                              SizedBox(height: 10,),

                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: HexColor("#E8ECF4"),
                                  border: Border.all(

                                    color: HexColor("#F7F8F9"),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.alternate_email,color: Colors.grey[400],),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0, right: 12.0,top: 12.0, bottom: 4),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width-83,
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom:8.0),
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

                                    ),
                                  ],
                                ),
                              ),


                              SizedBox(height: 20,),

                            /*
                              Text("Enter Password", style:TextStyle(
                                  color:Colors.grey[600],
                                  fontWeight: FontWeight.w400,
                                  fontSize:14
                              )),
                             */

                              SizedBox(height: 10,),

                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: HexColor("#E8ECF4"),
                                  border: Border.all(

                                    color: HexColor("#F7F8F9"),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.lock_outline,color: Colors.grey[400],),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5, right: 12.0,top: 12.0, bottom: 4),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width-108,
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom:8.0),
                                          child: TextField(

                                            obscureText: obsuretext,
                                            controller: _password,
                                            decoration: InputDecoration(
                                                hintText: 'password',
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

                                    ),

                                    obsuretext ?

                                    InkWell(

                                        onTap: (){
                                          setState(
                                                  (){
                                                obsuretext = !obsuretext;
                                              }
                                          );

                                        },
                                        child: Icon(Icons.visibility_off_outlined,color: Colors.grey[400],))
                                        :
                                    InkWell(

                                        onTap: (){
                                          setState(
                                                  (){
                                                obsuretext = !obsuretext;
                                              }
                                          );
                                        },
                                        child: Icon(Icons.visibility_outlined,color: Colors.grey[400],))

                                    ,
                                  ],
                                ),
                              ),

                              SizedBox(height: 20,),

                         /*
                              Text("Confirm Password", style:TextStyle(
                                  color:Colors.grey[600],
                                  fontWeight: FontWeight.w400,
                                  fontSize:14
                              )),

                          */

                              SizedBox(height: 10,),

                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: HexColor("#E8ECF4"),
                                  border: Border.all(

                                    color: HexColor("#F7F8F9"),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.lock_outline,color: Colors.grey[400],),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5, right: 12.0,top: 12.0, bottom: 4),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width-108,
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom:8.0),
                                          child: TextField(

                                            obscureText: obsuretext,
                                            controller: _cfpassword,
                                            decoration: InputDecoration(
                                                hintText: 'password',
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

                                    ),

                                    obsuretext ?

                                    InkWell(

                                        onTap: (){
                                          setState(
                                                  (){
                                                obsuretext = !obsuretext;
                                              }
                                          );

                                        },
                                        child: Icon(Icons.visibility_off_outlined,color: Colors.grey[400],))
                                        :
                                    InkWell(

                                        onTap: (){
                                          setState(
                                                  (){
                                                obsuretext = !obsuretext;
                                              }
                                          );
                                        },

                                        child: Icon(Icons.visibility_outlined,color: Colors.grey[400],)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20,),

                        InkWell(
                          onTap: () async {

                            if(_email.text.toString().trim().isEmpty || !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(_email.text.toString()))
                            {
                              Toast.show("Enter a valid email address".toString(), context,duration:Toast.LENGTH_SHORT,
                                  gravity: Toast.BOTTOM);
                            }
                            else if(_password.text.toString().trim().isEmpty)
                            {
                              Toast.show("Enter your password".toString(), context,duration:Toast.LENGTH_SHORT,
                                  gravity: Toast.BOTTOM);
                            }
                            else if(_password.text.toString().trim() != _cfpassword.text.toString().trim())
                            {
                              Toast.show("Password Doesn't match".toString(), context,duration:Toast.LENGTH_SHORT,
                                  gravity: Toast.BOTTOM);
                            }
                            else
                            {
                              //login code
                              await sign_up_retailer ( _email.text.toString(), _password.text.toString());

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
                                child: Text("Sign Up", style: TextStyle(
                                    color: HexColor("#FFFFFF"),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18
                                ),),
                              )
                          ),
                        ),

                        SizedBox(height:20),



                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 80,
                    child:   SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: Stack(

                        children:[
                          Positioned(
                            top:2,
                            left:  MediaQuery.of(context).size.width * 0.25,

                            child: InkWell(
                              onTap:() async{

                                await  Retailer_Wholesaler(context);
                                //Reset_Password
                              },
                              child: Text("Already Have an Account?", style:TextStyle(
                                  color:Colors.green,
                                  fontWeight: FontWeight.w700,
                                  fontSize:14
                              )),
                            ),
                          )
                        ]
                    ),
                  ),)
                ],
              ),
            ),
          ),
        ),




      ),
    );
  }
}


/*


    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left:16.0, right:16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 50,),
                  Text("Sign In",textAlign: TextAlign.center, style:TextStyle(
                      color:Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize:27
                  )),

                  SizedBox(height: 30,),

                  Text("Enter Email", style:TextStyle(
                      color:Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize:16
                  )),

                  SizedBox(height: 10,),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.grey[500]!
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0,top: 12.0, bottom: 4),
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

                  SizedBox(height: 20,),

                  Text("Enter Password", style:TextStyle(
                      color:Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize:16
                  )),

                  SizedBox(height: 10,),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.grey[500]!
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0,top: 12.0, bottom: 4),
                      child: TextField(
                        controller: _password,

                        decoration: InputDecoration(
                            hintText: '****************',
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

                  SizedBox(height: 20,),

                  isLoading?
                  InkWell(
                    onTap: (){

                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.grey[500]!
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text("Sign you in Please Wait...", style: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.w700,
                              fontSize: 16
                          ),),
                        )
                    ),
                  ) :InkWell(
                    onTap: () async {

                      if(_email.text.toString().trim().isEmpty || !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(_email.text.toString()))
                      {
                        Toast.show("Enter a valid email address".toString(), context,duration:Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM);
                      }
                      else if(_password.text.toString().trim().isEmpty)
                      {
                        Toast.show("Enter your password".toString(), context,duration:Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM);
                      }
                      else
                      {
                        //login code
                        await sign_in_wholesaler ( _email.text.toString(), _password.text.toString());
                    }

                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.grey[500]!
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text("Sign In", style: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.w700,
                              fontSize: 16
                          ),),
                        )
                    ),
                  ),

                  SizedBox(height: 10,),

                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text("Forgot password?", style:TextStyle(
                          color:Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize:16
                      )),
                    ),
                  ),

                  SizedBox(height: 10,),
                ],
              ),
            ),
          )),
    );

 */
