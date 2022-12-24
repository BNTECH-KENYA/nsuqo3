import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/pages/sub_categories.dart';

import '../widgets/cat_new_ui.dart';
import '../widgets/cat_new_ui_cc.dart';

class Home_Page_design_ui extends StatefulWidget {
  const Home_Page_design_ui({Key? key}) : super(key: key);

  @override
  State<Home_Page_design_ui> createState() => _Home_Page_design_uiState();
}

class _Home_Page_design_uiState extends State<Home_Page_design_ui> {

  List<String> categories = ["Phones and Tablets", "Consumer Electronic", "Computing", "More"];



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.deepOrange,

      body: SafeArea(

          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [

                SingleChildScrollView(

                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*0.25,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 330,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 50,

                              child: InkWell(
                                  onTap: (){
                                    Navigator.of(context).push(
                                        MaterialPageRoute
                                          (builder: (context)=>Sub_Categories(subcat:'Computing',)));
                                  },
                                  child: Cat_New_Ui( imagepath: 'assets/computing.jpeg', category: 'Computing', ),
                            ),
                            ),

                            Positioned(
                              left: 50,
                              bottom: 0,
                              child: InkWell(
                                  onTap: (){

                                    Navigator.of(context).push(
                                        MaterialPageRoute
                                          (builder: (context)=>Sub_Categories(subcat: 'Consumer Electronic',)));
                                  },
                                  child: Cat_New_Ui( category: 'Consumer Electronic', imagepath: 'assets/electronics.jpeg', )),
                            ),

                            Positioned(
                              right: 50,

                              child: InkWell(
                                  onTap: (){

                                    Navigator.of(context).push(
                                        MaterialPageRoute
                                          (builder: (context)=>Sub_Categories(subcat: 'Phones and Tablets',)));
                                  },
                                  child: Cat_New_Ui( category: 'Phones and Tablets', imagepath: 'assets/androidandphones.jpeg',)),
                            ),
                            Center(
                              child: InkWell(
                                  onTap: (){



                                  },
                                  child: Cat_New_Ui_cc(cat_name: "Wholesalers PriceList",)),
                            ),
                            Positioned(
                              right: 50,
                              bottom: 0,

                              child: InkWell(
                                  onTap: (){

                                    Navigator.of(context).push(
                                        MaterialPageRoute
                                          (builder: (context)=>Sub_Categories(subcat: 'More',)));

                                  },
                                  child: Cat_New_Ui( category: 'More', imagepath: 'assets/more.jpeg',)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                Positioned(
                  top: 10,
                    left: 10,
                    child:Container(

                      width: MediaQuery.of(context).size.width,
                      child:
                      Padding(
                        padding: const EdgeInsets.only(right:20.0),
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [

                                CircleAvatar(
                                    child: Icon(Icons.person_outline_sharp, color: Colors.white,)

                                ),
                                SizedBox(width: 10,),
                                Text("Bngatia122", style: TextStyle(
                                  color:Colors.white,
                                  fontWeight: FontWeight.bold
                                ),)
                              ],
                            ),

                            Icon(Icons.share, color: Colors.white,)

                          ],
                        ),
                      ),
                    ))
              ],
            ),
          )

      ),
    );
  }
}
