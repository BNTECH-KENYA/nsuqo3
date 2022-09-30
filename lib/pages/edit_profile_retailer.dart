import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/pages/sign_in.dart';
import 'package:nsuqo/pages/subcategories.dart';

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

  String locationdata = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        hintText: 'Desktop',
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
                        hintText: 'Desktop',
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
                        hintText: 'Desktop',
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

                  String subcategpory = await Navigator.push(context,
                      MaterialPageRoute(builder:
                          (context) => SubCategories_Page()));

                  if(subcategpory != null)
                  {
                    setState(() {
                      //distributioncat = subcategpory;
                    });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Your Location", style:TextStyle(

                        color:Colors.grey[800],
                        fontWeight: FontWeight.w400,
                        fontSize:16
                    )),
                    Icon(Icons.location_on_outlined, size: 20, color: Colors.grey[500],)
                  ],
                ),
              ),
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
                  child: Text(

                    "${locationdata}", style: TextStyle(
                      color: Colors.grey[700]
                  ),

                  ),

                ),
              ),

              SizedBox(height: 20,),

              Container(
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
              SizedBox(height: 20,),
            ],
          ),
        ),
      )
    );
  }
}
