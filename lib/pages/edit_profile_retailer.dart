import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/pages/sign_in.dart';
import 'package:nsuqo/pages/subcategories.dart';
import 'package:toast/toast.dart';

import 'home_page_categories.dart';

class Edit_Retailer_Profile extends StatefulWidget {
  const Edit_Retailer_Profile({Key? key}) : super(key: key);

  @override
  State<Edit_Retailer_Profile> createState() => _Edit_Retailer_ProfileState();
}
class _Edit_Retailer_ProfileState extends State<Edit_Retailer_Profile> {

  TextEditingController _firstname = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  TextEditingController _companyname = TextEditingController();
  TextEditingController _phonenumber = TextEditingController();
  TextEditingController _emailaddress = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _city = TextEditingController();

  String user_email = "";
  bool isLoading = true;

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> getuserdata()
  async {
    final docref = db.collection("userdd").doc(user_email);
    await docref.get().then((res) {

      if(res.data() != null)
      {
        setState(
                (){
                  _firstname.text = res.data()!['firstNameinput'];
                  _lastname.text = res.data()!['lastNameinput'];
                  _companyname.text = res.data()!['companyNameinput'];
                  _phonenumber.text = res.data()!['phonenumberInput'];
                  _emailaddress.text = user_email;
                  _address.text = res.data()!['address1ControLTextArea'];
                  _city.text = res.data()!['citynameInput'];


              isLoading = false;

            }
        );


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
              user_email = user.email!;

            });

        getuserdata();
      }
      else{
        setState(
                (){
              isLoading = false;
            }
        );

        Navigator.of(context).push(
            MaterialPageRoute
              (builder: (context)=>Sign_In()));

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
    return  isLoading? Container(
      width: MediaQuery.of(context).size.width,
      height:MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          borderRadius:BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15), ),
          color: Colors.deepOrange
      ),
      child: Center(child: CircularProgressIndicator(
        backgroundColor: Colors.white,
      ),),
    ): Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color:Colors.white)),
        title:Text(
          'My Profile',
          style: TextStyle(
              color:Colors.white
          ),
        ),

        actions: [

          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: InkWell(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).push(
                      MaterialPageRoute
                        (builder: (context)=>Sign_In())

                  );
                },
                child: Icon(Icons.logout_sharp, color: Colors.white,)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left:16.0, right:16.0, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("First Name", style:TextStyle(

                  color:Colors.grey[800],
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

                    controller: _firstname,
                    decoration: InputDecoration(
                        hintText: '',
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

              Text("Last Name", style:TextStyle(

                  color:Colors.grey[800],
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

                    controller: _lastname,
                    decoration: InputDecoration(
                        hintText: '',
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

              Text("Company Name", style:TextStyle(

                  color:Colors.grey[800],
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

                    controller: _companyname,
                    decoration: InputDecoration(
                        hintText: '',
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

              Text("City Name", style:TextStyle(

                  color:Colors.grey[800],
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

                    controller: _city,
                    decoration: InputDecoration(
                        hintText: '',
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

              Text("Your Address", style:TextStyle(

                  color:Colors.grey[800],
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

                    controller: _address,
                    decoration: InputDecoration(
                        hintText: '',
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

              Text("Enter your email", style:TextStyle(

                  color:Colors.grey[800],
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
                    controller: _emailaddress,
                    keyboardType: TextInputType.emailAddress,
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

              Text("Enter your PhoneNumber", style:TextStyle(

                  color:Colors.grey[800],
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

                    controller: _phonenumber,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: '07xx xxx xxx',
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

              InkWell(
                onTap:() async {

                  if(_firstname.text.toString().trim().isEmpty)
                  {
                    Toast.show("Enter First name".toString(), context,duration:Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);
                  }

                  else if(_lastname.text.toString().trim().isEmpty)
                  {

                    Toast.show("Enter Last Name".toString(), context,duration:Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);
                  }
                  else if(_companyname.text.toString().trim().isEmpty)
                  {

                    Toast.show("Enter Company Name".toString(), context,duration:Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);
                  }
                  else if(_city.text.toString().trim().isEmpty)
                  {

                    Toast.show("Enter City Name".toString(), context,duration:Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);
                  }

                  else if(_address.text.toString().trim().isEmpty)
                  {

                    Toast.show("Enter Address".toString(), context,duration:Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);
                  }



                  else if(_phonenumber.text.length < 10)
                  {

                    Toast.show("Enter Phonenumber".toString(), context,duration:Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);
                  }


                  else{

                    setState(() {
                      isLoading = true;
                    });



                    final dataupdate = <String, dynamic>
                    {

                      "firstNameinput":_firstname.text,
                      "lastNameinput":_lastname.text,
                      "companyNameinput":_companyname.text,
                      "phonenumberInput":_phonenumber.text,
                      "emailidInput":_emailaddress.text,
                      "address1ControLTextArea":_address.text,
                      "citynameInput":_city.text,

                    };

                    await db.collection("userdd").doc(user_email).update(dataupdate);

                    setState(
                            (){
                          isLoading = false;
                        }
                    );

                    Navigator.of(context).push(
                        MaterialPageRoute
                          (builder: (context)=>Home_Categories())

                    );
                  }
                },

                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      border: Border.all(
                          color: Colors.grey[500]!
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text("Save Changes", style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16
                      ),),
                    )
                ),
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      )
    );
  }
}
