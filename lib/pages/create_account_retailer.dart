import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/pages/wholesaler_categories.new_edition.dart';
import 'package:nsuqo/pages/wholesaler_home_new.dart';

import 'home_page_categories.dart';

class Create_Account_Retailer extends StatefulWidget {
  const Create_Account_Retailer({Key? key}) : super(key: key);

  @override
  State<Create_Account_Retailer> createState() => _Create_Account_RetailerState();
}

class _Create_Account_RetailerState extends State<Create_Account_Retailer> {

  final _formKey = GlobalKey<FormState> ();

  FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController _email = TextEditingController();
  TextEditingController _fname = TextEditingController();
  TextEditingController _lname = TextEditingController();
  TextEditingController _companyname = TextEditingController();
  TextEditingController _cityname = TextEditingController();
  TextEditingController _addressinput = TextEditingController();
  TextEditingController _companycontact = TextEditingController();

  Future<void> post_user_data()
  async {
    final data = {
      "address1ControlTextarea":_addressinput.text,
      "citynameInput":_cityname.text,
      "companyNameinput":_companyname.text,
      "firstNameinput":_fname.text,
      "lastNameinput":_lname.text,
      "phonenumberInput":_companycontact.text,
    };

    db.collection("userdd").doc(_email.text).update(data).then(
        (value){

          Navigator.of(context).push(
              MaterialPageRoute
                (builder: (context)=>Home_Categories()));

        },
      onError: (e)=> print("Error updating documnet $e")
    );



  }

  Future<void> getUserData(user_email)
  async {

    final docref = db.collection("userdd").doc(user_email);
    await docref.get().then((res) {

      if(res.data() != null)
      {
        if(res.data()!['accounttype'] =="retailer")
        {

          if(res.data()!['firstNameinput'] != "")
            {
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
          Navigator.of(context).push(
              MaterialPageRoute
                (builder: (context)=>Whole_Saler_categories()));
          setState(
                  (){

              }
          );

        }



      }
      else
      {
        setState(
                (){

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
              _email.text = user.email!;
            }
        );
        getUserData(user.email);

      }
      else{
        setState(
                (){
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
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color:Colors.white)),
        title:Text(
          'Create Account Retailer',
          style: TextStyle(
              color:Colors.white
          ),
        ),


      ),
      body: SafeArea(

        child: Form(
            key:_formKey,
            child: SingleChildScrollView(
              child:
              Padding(
                padding: const EdgeInsets.only(left:20.0, right:20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller:_fname,
                      decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: "Enter First Name",
                        labelText: 'First Name',
                      ),
                      validator: (value){
                        if(value!.isEmpty){

                          return ' Please Enter First Name';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 20,),

                    TextFormField(
                      controller:_lname,
                      decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: "Enter Last Name",
                        labelText: 'Last Name',
                      ),
                      validator: (value){
                        if(value!.isEmpty){

                          return ' Please Enter Last Name';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 20,),

                    TextFormField(
                      controller:_email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: "Enter Email",
                        labelText: 'Email',
                      ),
                      validator: (value){
                        if(value!.isEmpty){

                          return ' Please Enter your Email';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 20,),

                    TextFormField(
                      controller:_companyname,
                      decoration: InputDecoration(
                        icon: Icon(Icons.warehouse_outlined),
                        hintText: "Enter Company Name",
                        labelText: 'Company Name',
                      ),
                      validator: (value){
                        if(value!.isEmpty){

                          return " Please Enter Company's Name";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 20,),

                    TextFormField(
                      controller:_cityname,
                      decoration: InputDecoration(
                        icon: Icon(Icons.factory),
                        hintText: "Enter City Name",
                        labelText: 'City Name',
                      ),
                      validator: (value){
                        if(value!.isEmpty){

                          return " Please Enter City Name";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 20,),

                    TextFormField(
                      controller: _addressinput,
                      decoration: InputDecoration(
                        icon: Icon(Icons.directions),
                        hintText: "Enter Company's Address",
                        labelText: "Company's Address",
                      ),
                      validator: (value){
                        if(value!.isEmpty){

                          return " Please Enter Company's Address";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 20,),



                    Container(
                      width: MediaQuery.of(context).size.width ,
                      height: 80,
                      child: TextFormField(
                        controller: _companycontact,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: "Enter Company's Phone Number",
                          labelText: "Company's Phone Number",
                        ),
                        validator: (value){
                          if(value!.isEmpty){

                            return "Company's Phone Number";

                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20,),

                    InkWell(
                      onTap:(){
                        if(_formKey.currentState!.validate())
                          {
                            post_user_data();

                          }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        decoration:BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              color:Colors.deepOrange
                              ),
                        child: Center(
                          child: Text(
                            "Create Account", style: TextStyle(
                            color: Colors.white
                          )
                          )
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            )),
      ),



    );
  }
}
