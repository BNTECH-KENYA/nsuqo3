import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/pages/places_picker_ai.dart';
import 'package:nsuqo/pages/product_category.dart';
import 'package:nsuqo/pages/sign_in.dart';
import 'package:nsuqo/pages/subcategories.dart';
import 'package:nsuqo/pages/wholesaler_categories.new_edition.dart';
import 'package:nsuqo/pages/wholesaler_home.dart';
import 'package:nsuqo/pages/wholesaler_home_new.dart';
import 'package:toast/toast.dart';

import '../models/categories_model.dart';

class Edit_Profile extends StatefulWidget {
  const Edit_Profile({Key? key}) : super(key: key);
  @override
  State<Edit_Profile> createState() => _Edit_ProfileState();
}

class _Edit_ProfileState extends State<Edit_Profile> {

  TextEditingController _companyname = TextEditingController();
  TextEditingController _businessdescription = TextEditingController();
  TextEditingController _marketcoverage = TextEditingController();
  TextEditingController _wholesalerPhoneNumber = TextEditingController();
  TextEditingController _wholesaleremail = TextEditingController();
  TextEditingController exchange_rate = TextEditingController();

  bool credit_card = false;
  bool mobilemoney = false;
  bool cash = false;

  String start_hours ="";
  String stop_hours ="";

  TimeOfDay timeOfDay = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().hour);
  DateTime dateTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute);


  List <dynamic> payment_details_terms = [];


  String distributioncat ="";
  String location_data ="";
  String working_hours ="0-0";
  String wholesalerid ="";
  String email ="";

  bool isLoading = true;

  String user_email = "";

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> getuserdata()
  async {
    final docref = db.collection("userdd").doc(user_email);
    await docref.get().then((res) {

      if(res.data() != null)
      {
        print(res.data()!['working_hours']);
        setState(
                (){
              working_hours = res.data()!['working_hours'];
              email = res.data()!['email'];
              _wholesaleremail.text = res.data()!['email'];
              _businessdescription.text = res.data()!['business_description'];
              wholesalerid = res.id;
              _wholesalerPhoneNumber.text = res.data()!['contact_details'];
              _companyname.text = res.data()!['company_name'];
              location_data = res.data()!['location'];
              payment_details_terms = res.data()!['payment_detailsterms'];
              _marketcoverage.text = res.data()!['market_coverage'];
              distributioncat = res.data()!['distribution_category'];
              res.data()!.containsKey("exchange_rate")?  exchange_rate.text = res.data()!['exchange_rate'].toString(): exchange_rate.text = "0";
              start_hours = "${working_hours.split("-")[0]}";
              stop_hours = "${working_hours.split("-")[1]}";

              if(payment_details_terms.contains("Cash")) cash = true;
              if(payment_details_terms.contains("Mobile Money")) mobilemoney = true;
              if(payment_details_terms.contains("Credit Card")) credit_card = true;

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


    final hours = dateTime.hour.toString().padLeft(2,'0');
    final minutes = dateTime.hour.toString().padLeft(2,'0');

    return isLoading? Container(
      width: MediaQuery.of(context).size.width,
      height:MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          borderRadius:BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15), ),
          color: Colors.black
      ),
      child: Center(child: CircularProgressIndicator(
        backgroundColor: Colors.white,
      ),),
    ):
    Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
          backgroundColor: Colors.black,
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
                child: Padding(
                  padding: const EdgeInsets.only(right:10.0, top:10),
                  child: Text("Sign Out" , style:TextStyle(
                      color: Colors.white
                  ),),
                )),
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left:16.0, right:16.0, top:16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text("Company Name", style:TextStyle(

                  color:Colors.grey[200],
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
                  borderRadius: BorderRadius.circular(20),
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


              Text("Business Description", style:TextStyle(

                  color:Colors.grey[200],
                  fontWeight: FontWeight.w400,
                  fontSize:16
              )),

              SizedBox(height: 10,),

              Container(
                width: MediaQuery.of(context).size.width,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.grey[500]!
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0,top: 2.0, bottom: 2),
                  child: TextField(
                    controller: _businessdescription,
                    maxLines: 5,
                    minLines: 5,
                    maxLength: 200,
                    decoration: InputDecoration(
                        hintText: 'product description',
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

                        color:Colors.grey[200],
                        fontWeight: FontWeight.w400,
                        fontSize:16
                    )),
                    Icon(Icons.location_on_outlined, size: 20, color: Colors.grey[300],)
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
                  borderRadius: BorderRadius.circular(20),
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


              Text("Market Coverage", style:TextStyle(

                  color:Colors.grey[200],
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
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0,top: 12.0, bottom: 4),
                  child: TextField(

                    controller: _marketcoverage,
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

              Text("Payment Details and Terms", style:TextStyle(

                  color:Colors.grey[200],
                  fontWeight: FontWeight.w400,
                  fontSize:16
              )),

              SizedBox(height: 10,),
              Container(
                height: 205,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text("Select Payment Terms", style: TextStyle(
                      color:Colors.grey[200],
                    ),),
                    ListTile(
                      leading: Card(
                        child: Checkbox(
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
                      ),
                      title: Text("Cash", style:TextStyle(

                            color:Colors.grey[200],

                      )),
                    ),
                    SizedBox(height:5),
                    ListTile(
                      leading:
                      Card(
                        child: Checkbox(
                            value: mobilemoney,
                            onChanged: (val){

                              setState(() {
                                mobilemoney = !mobilemoney;
                                if(mobilemoney == true)
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
                      ),
                      title: Text("Mobile Money", style:TextStyle(
                        color:Colors.grey[200],

                      )),

                    ),
                    SizedBox(height:5),
                    ListTile(
                      leading:
                      Card(
                        child: Checkbox(
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
                      ),
                      title: Text("Credit Card", style:TextStyle(
                        color:Colors.grey[200],

                      )),

                    ),
                  ],
                ),

              ),

              SizedBox(height: 20,),

              Text("Working Hours", style:TextStyle(

                  color:Colors.grey[200],
                  fontWeight: FontWeight.w400,
                  fontSize:16
              )),

              SizedBox(height: 10,),

              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(
                      color: Colors.grey[500]!
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0,top: 12.0, bottom: 4),
                  child: Text(

                    "Select Opening Time below", style: TextStyle(
                      color: Colors.grey[200]
                  ),

                  ),

                ),
              ),

              SizedBox(height: 5,),

              InkWell(
                onTap: () async {

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
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.grey[500]!
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0,top: 12.0, bottom: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          start_hours, style: TextStyle(
                            color: Colors.grey[700]
                        ),

                        ),
                        Icon(Icons.access_time_rounded,color: Colors.grey[700],size:20),
                      ],
                    ),

                  ),
                ),
              ),

              SizedBox(height: 10,),

              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(
                      color: Colors.grey[500]!
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0,top: 12.0, bottom: 4),
                  child: Text(

                    "Select Closing Time below", style: TextStyle(
                      color: Colors.grey[200]
                  ),

                  ),

                ),
              ),

              SizedBox(height: 5,),

              InkWell(
                onTap: () async {


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
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.grey[500]!
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0,top: 12.0, bottom: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          stop_hours, style: TextStyle(
                            color: Colors.grey[700]
                        ),

                        ),
                        Icon(Icons.access_time_rounded,color: Colors.grey[700],size:20),
                      ],
                    ),

                  ),
                ),
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
                      distributioncat = category.category_name;
                    });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Distribution Category", style:TextStyle(

                        color:Colors.grey[200],
                        fontWeight: FontWeight.w400,
                        fontSize:16
                    )),
                    Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey[300],)
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
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0,top: 12.0, bottom: 4),
                  child: Text(

                    " ${distributioncat}", style: TextStyle(
                      color: Colors.grey[700]
                  ),

                  ),

                ),
              ),

              SizedBox(height: 20,),


              Text("Enter your PhoneNumber", style:TextStyle(

                  color:Colors.grey[200],
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
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0,top: 12.0, bottom: 4),
                  child: TextField(

                    controller: _wholesalerPhoneNumber,
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
              ), SizedBox(height: 20,),


              Text("Enter your email", style:TextStyle(

                  color:Colors.grey[200],
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
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0,top: 12.0, bottom: 4),
                  child: TextField(
                    controller: _wholesaleremail,
                    keyboardType: TextInputType.emailAddress,
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

              Text("Exchange Rate", style:TextStyle(

                  color:Colors.grey[200],
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
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0,top: 12.0, bottom: 4),
                  child: TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    controller: exchange_rate,
                    decoration: InputDecoration(
                        hintText: '120.00',
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
                onTap: () async {

                  if(_companyname.text.toString().trim().isEmpty)
                  {
                    Toast.show("Enter Company name".toString(), context,duration:Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);
                  }

                  else if(_businessdescription.text.toString().trim().isEmpty)
                  {

                    Toast.show("Enter Busines Description".toString(), context,duration:Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);
                  }
                  else if(_marketcoverage.text.toString().trim().isEmpty)
                  {

                    Toast.show("Enter Market Coverage".toString(), context,duration:Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);
                  }
                  else if(_wholesalerPhoneNumber.text.toString().trim().isEmpty)
                  {

                    Toast.show("Enter Your Phone Number".toString(), context,duration:Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);
                  }

                  else if(_wholesaleremail.text.toString().trim().isEmpty)
                  {

                    Toast.show("Enter your emailAddress".toString(), context,duration:Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);
                  }



                  else if(distributioncat.isEmpty)
                  {

                    Toast.show("Select Distribution Category".toString(), context,duration:Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);
                  }

                  else if(location_data.isEmpty)
                  {

                    Toast.show("Pick A location".toString(), context,duration:Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);
                  }
                  else if(exchange_rate.text == "")
                  {
                    Toast.show("Enter Your Exchange Rates USD".toString(), context,duration:Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);
                  }

                  else{

                    setState(() {
                      isLoading = true;
                    });



                    final dataupdate = <String, dynamic>
                    {

                      "business_description":_businessdescription.text,
                      "company_name":_companyname.text,
                      "contact_details":_wholesalerPhoneNumber.text,
                      "distribution_category":distributioncat,
                      "email":_wholesaleremail.text,
                      "location":location_data,
                      "market_coverage":_marketcoverage.text,
                      "working_hours":"$start_hours-$stop_hours",
                      "payment_detailsterms":payment_details_terms,
                      "exchange_rate":exchange_rate.text,

                    };

                    await db.collection("userdd").doc(user_email).update(dataupdate);

                    setState(
                            (){
                          isLoading = false;
                        }
                    );

                    Navigator.of(context).push(
                        MaterialPageRoute
                          (builder: (context)=>Whole_Saler_categories())

                    );
                  }

                },

                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height:40,
                    decoration: BoxDecoration(
                      color: Colors.grey[700],
                      border: Border.all(
                          color: Colors.grey[500]!
                      ),
                      borderRadius: BorderRadius.circular(20),
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
      ),

    );
  }

  Future<TimeOfDay?> pickTime() =>showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
}
