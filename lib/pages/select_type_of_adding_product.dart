import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'add_product.dart';
import 'catalogue_page.dart';

class Type_Of_Adding_Product extends StatefulWidget {
  const Type_Of_Adding_Product({Key? key, required this.company_name, required this.email, required this.location}) : super(key: key);

  final String company_name, email, location;

  @override
  State<Type_Of_Adding_Product> createState() => _Type_Of_Adding_ProductState();
}

class _Type_Of_Adding_ProductState extends State<Type_Of_Adding_Product> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

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

                  Text("Opasso Products", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),),

                  SizedBox(height: 30,),


                  Container(


                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,

                    child: Column(
                      children: [

                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text("Add product from a selection of preloaded product catalogue", style:TextStyle(
                              color:Colors.grey[500],
                              fontWeight: FontWeight.w400,
                              fontSize:14
                          )),
                        ),

                        SizedBox(height: 10,),

                        InkWell(
                          onTap:(){

                            Navigator.of(context).push(
                                MaterialPageRoute
                                  (builder: (context)=>Catalogue_Page(
                                )));
                            //Catalogue_Page
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text("Proceed to Catalogue", style: TextStyle(
                                color: Colors.white
                              ),),
                            ),
                          ),
                        ),

                        SizedBox(height: 10,),


                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text("Add a unique product", style:TextStyle(
                              color:Colors.grey[500],
                              fontWeight: FontWeight.w400,
                              fontSize:14
                          )),
                        ),

                        SizedBox(height: 10,),

                        InkWell(
                          onTap:(){

                            Navigator.of(context).push(
                                MaterialPageRoute
                                  (builder: (context)=>Add_Products(
                                  user_email: widget.email,
                                  company_name:widget.company_name,
                                  location: widget.location ,)));

                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text("Add Product", style: TextStyle(
                                  color: Colors.white
                              ),),
                            ),
                          ),
                        ),

                      ],
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
