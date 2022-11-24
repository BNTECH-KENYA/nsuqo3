import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/pages/places_picker_ai.dart';
import 'package:nsuqo/pages/product_category.dart';
import 'package:nsuqo/pages/wholesaler_home_new.dart';
import 'package:toast/toast.dart';

import '../models/categories_model.dart';
import 'home_page_categories.dart';

class Create_Account_WholeSaler extends StatefulWidget {
  const Create_Account_WholeSaler({Key? key}) : super(key: key);

  @override
  State<Create_Account_WholeSaler> createState() => _Create_Account_WholeSalerState();
}

class _Create_Account_WholeSalerState extends State<Create_Account_WholeSaler> {

  final _formKey = GlobalKey<FormState> ();

  List<String> payment_details_terms = [];

  String location_data ="";
  String working_hours ="";
  String start_hours ="";
  String stop_hours ="";
  String value = "Select";
  final distributioncat = ['dist one', 'dist two', 'dist three'];

  DateTime dateTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute);
  TimeOfDay timeOfDay = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().hour);
  bool cash = false;
  bool mobile_money = false;
  bool credit_card = false;

  FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController _email = TextEditingController();
  TextEditingController _fname = TextEditingController();
  TextEditingController _lname = TextEditingController();
  TextEditingController _companyname = TextEditingController();
  TextEditingController _businessdescription= TextEditingController();
  TextEditingController _distributioncategory = TextEditingController();
  TextEditingController _marketcoverage = TextEditingController();
  TextEditingController _contactdetails = TextEditingController();

  Future<void> post_user_data()
  async {
    final data = {
      "business_description":_businessdescription.text,
      "company_name":_companyname.text,
      "contact_details":_contactdetails.text,
      "distribution_category":value,
      "lname":_lname.text,
      "fname":_fname.text,
      "location":location_data,
      "market_coverage":_marketcoverage.text,
      "payment_detailsterms":payment_details_terms,
      "working_hours":"${start_hours}-${stop_hours}",
    };

    db.collection("userdd").doc(_email.text).update(data).then(
            (value){

          Navigator.of(context).push(
              MaterialPageRoute
                (builder: (context)=>Whole_Saler_categories()));

        },
        onError: (e)=> print("Error updating documnet $e")
    );



  }

    Future <void> payment_details_and_terms_bt () async{

      showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top:Radius.circular(20),
            ),
          ),
          builder: (BuildContext context){
            return Container(
              height: 205,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Text("Select Payment Terms", style: TextStyle(
                    color: Colors.black
                  ),),
                  ListTile(
                    leading: Checkbox(
                        value: cash,
                        onChanged: (val){

                          setState(() {
                            cash = !cash;
                            if(cash == true)
                              {
                                if(!payment_details_terms.contains("Cash"))
                                {
                                  payment_details_terms.add("Cash");
                                }
                              }
                            else
                              {
                                if(payment_details_terms.contains("Cash"))
                                {
                                  payment_details_terms.remove("Cash");
                                }
                              }

                          });
                        }),
                    title: Text("Cash"),
                  ),
                  SizedBox(height:5),
                  ListTile(
                    leading: Checkbox(
                        value: mobile_money,
                        onChanged: (val){

                          setState(() {
                            mobile_money = !mobile_money;
                            if(mobile_money == true)
                            {
                              if(!payment_details_terms.contains("Mobile Money"))
                              {
                                payment_details_terms.add("Mobile Money");
                              }
                            }
                            else
                            {
                              if(payment_details_terms.contains("Mobile Money"))
                              {
                                payment_details_terms.remove("Mobile Money");
                              }
                            }

                          });
                        }),
                    title: Text("Mobile Money"),

                  ),
                  SizedBox(height:5),
                  ListTile(
                    leading: Checkbox(
                        value: credit_card,
                        onChanged: (val){
                          setState(() {
                            credit_card = !credit_card;
                            if(credit_card == true)
                            {
                              if(!payment_details_terms.contains("Credit Card"))
                              {
                                payment_details_terms.add("Credit Card");
                              }
                            }
                            else
                            {
                              if(payment_details_terms.contains("Credit Card"))
                              {
                                payment_details_terms.remove("Credit Card");
                              }
                            }

                          });
                        }),
                    title: Text("Credit Card"),

                  ),
                ],
              ),

            );
          }

      );

    }

  Future<void> getUserData(user_email)
  async {

    final docref = db.collection("userdd").doc(user_email);
    await docref.get().then((res) {

      if(res.data() != null)
      {
        if(res.data()!['accounttype'] =="wholesaler")
        {

          if(res.data()!['fname'] != "")
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

    final hours = dateTime.hour.toString().padLeft(2,'0');
    final minutes = dateTime.hour.toString().padLeft(2,'0');

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color:Colors.white)),
        title:Text(
          'Create Account WholeSaler',
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
                      controller: _fname,
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
                      controller: _lname,

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
                      controller: _email,

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
                      controller: _companyname,

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
                      controller: _businessdescription,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(

                        icon: Icon(Icons.description),
                        hintText: "Enter Business Description",
                        labelText: 'Business Description',
                      ),
                      validator: (value){
                        if(value!.isEmpty){

                          return " Please Business Description";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 20,),


                    InkWell(
                      onTap:() async {
                        CategoriesModel category = await Navigator.push(context,
                            MaterialPageRoute(builder:
                                (context) => Select_Category()));

                        if(category != null)
                        {
                          setState(() {
                            value = category.category_name;
                          });
                        }
                              },
                        child: Container (
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: Row(
                            children: [
                              Icon(Icons.vertical_distribute),
                              SizedBox(width:10),
                              Text("Select Distribution Category"),
                              SizedBox(width:10),
                            ],
                          ),
                        )
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

                          "${value}", style: TextStyle(
                            color: Colors.grey[700]
                        ),

                        ),

                      ),
                    ),


                    SizedBox(height: 20,),

                    InkWell(
                      onTap:() async {
                       await  payment_details_and_terms_bt();
                      },
                      child: Row(
                        children: [
                          Icon(Icons.payment, color: Colors.grey[500],),
                          SizedBox(width: 10,),
                          Text("Select Payment Details & Terms", style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 15

                          ),),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 205,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Text("Select Payment Terms", style: TextStyle(
                              color: Colors.black
                          ),),
                          ListTile(
                            leading: Checkbox(
                                value: cash,
                                onChanged: (val){

                                  setState(() {
                                    cash = !cash;
                                    if(cash == true)
                                    {
                                      if(!payment_details_terms.contains("Cash"))
                                      {
                                        payment_details_terms.add("Cash");
                                      }
                                    }
                                    else
                                    {
                                      if(payment_details_terms.contains("Cash"))
                                      {
                                        payment_details_terms.remove("Cash");
                                      }
                                    }

                                  });
                                }),
                            title: Text("Cash"),
                          ),
                          SizedBox(height:5),
                          ListTile(
                            leading: Checkbox(
                                value: mobile_money,
                                onChanged: (val){

                                  setState(() {
                                    mobile_money = !mobile_money;
                                    if(mobile_money == true)
                                    {
                                      if(!payment_details_terms.contains("Mobile Money"))
                                      {
                                        payment_details_terms.add("Mobile Money");
                                      }
                                    }
                                    else
                                    {
                                      if(payment_details_terms.contains("Mobile Money"))
                                      {
                                        payment_details_terms.remove("Mobile Money");
                                      }
                                    }

                                  });
                                }),
                            title: Text("Mobile Money"),

                          ),
                          SizedBox(height:5),
                          ListTile(
                            leading: Checkbox(
                                value: credit_card,
                                onChanged: (val){
                                  setState(() {
                                    credit_card = !credit_card;
                                    if(credit_card == true)
                                    {
                                      if(!payment_details_terms.contains("Credit Card"))
                                      {
                                        payment_details_terms.add("Credit Card");
                                      }
                                    }
                                    else
                                    {
                                      if(payment_details_terms.contains("Credit Card"))
                                      {
                                        payment_details_terms.remove("Credit Card");
                                      }
                                    }

                                  });
                                }),
                            title: Text("Credit Card"),

                          ),
                        ],
                      ),

                    ),

                    SizedBox(height:20),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 87,
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.timer, color: Colors.grey[500],),
                              SizedBox(width: 10,),
                              Text("Select Working Hours", style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 15

                              ),),
                            ],
                          ),
                          SizedBox(height:10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [

                              InkWell(
                                onTap:() async {

                                  final time = await pickTime();
                                  if(time == null) return;

                                  final timeofdayin = TimeOfDay(
                                    hour: time.hour, minute: time.minute,
                                  );


                                  setState(
                                          (){
                                        timeOfDay = timeofdayin;
                                        start_hours = "${timeofdayin.hour}:${timeofdayin.minute}";
                                      }
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.2),
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                  ),
                                  child:
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children:[

                                        Text("Start"),
                                        SizedBox(height: 5,),
                                        Text("${start_hours}")

                                      ]

                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap:() async {

                                  final time = await pickTime();
                                  if(time == null) return;

                                  final timeofdayin = TimeOfDay(
                                    hour: time.hour, minute: time.minute,
                                  );


                                  setState(
                                          (){
                                        timeOfDay = timeofdayin;
                                        stop_hours = "${timeofdayin.hour}:${timeofdayin.minute}";
                                      }
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.2),
                                      borderRadius: BorderRadius.all(Radius.circular(5))
                                  ),
                                  child:
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children:[

                                        Text("Stop"),
                                        SizedBox(height: 5,),
                                        Text("${stop_hours}")

                                      ]

                                    ),
                                  ),
                                ),
                              )

                            ],
                          ),

                        ],
                      )
                    ),


                    SizedBox(height: 20,),

                    TextFormField(
                      controller: _marketcoverage,
                      decoration: InputDecoration(
                        icon: Icon(Icons.area_chart),
                        hintText: "e.g nairobi, mombasa, kisumu",
                        labelText: "Market Coverage",
                      ),
                      validator: (value){
                        if(value!.isEmpty){

                          return " Please Enter Market Coverage";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 20,),

                    InkWell(
                      onTap:() async {

                        location_data = await Navigator.push(context,
                            MaterialPageRoute(builder:
                                (context) => Places_Search()));

                        if(location_data != null)
                        {
                          setState(() {
                            location_data = location_data;
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

                          "${location_data}", style: TextStyle(
                            color: Colors.grey[700]
                        ),

                        ),

                      ),
                    ),

                    SizedBox(height: 20,),

                    SizedBox(width:10),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      child: TextFormField(
                        controller: _contactdetails,
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

                            if(location_data == "")
                              {
                                Toast.show("Pick Your Business Location".toString(), context,duration:Toast.LENGTH_SHORT,
                                    gravity: Toast.TOP);
                              }
                            else if(start_hours == ""){
                              Toast.show("Select Start Hours".toString(), context,duration:Toast.LENGTH_SHORT,
                                  gravity: Toast.TOP);
                            }
                            else if(start_hours == ""){
                              Toast.show("Select Start Hours".toString(), context,duration:Toast.LENGTH_SHORT,
                                  gravity: Toast.TOP);
                            }
                            else if(value == "Select")
                              {
                                Toast.show("Select Distribution category".toString(), context,duration:Toast.LENGTH_SHORT,
                                    gravity: Toast.TOP);
                              }
                            else{

                              post_user_data();
                            }
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




  Future<TimeOfDay?> pickTime() =>showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(value:item,
    child: Text(
      item,

    ),);
}
