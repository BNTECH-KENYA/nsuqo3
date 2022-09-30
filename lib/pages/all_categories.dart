import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../categories_grids.dart';

class All_Categories extends StatefulWidget {
  const All_Categories({Key? key}) : super(key: key);

  @override
  State<All_Categories> createState() => _All_CategoriesState();
}

class _All_CategoriesState extends State<All_Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        leading: Icon(Icons.arrow_back, color:Colors.white),
       title:Text(
          'All categories',
          style: TextStyle(
            color:Colors.white
          ),
        )
      ),
      body: Row(
        children: [
          Container(
            width: 80,
            child: ListView(
              children: [
                
                Column(
                  children: [
                    SizedBox(height: 20,),
                    Icon(Icons.computer, color: Colors.grey[800],size:30,),
                    Text("Computing",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[800],

                    ),)
                  ],
                ),

                Column(
                  children: [
                    SizedBox(height: 20,),
                    Icon(Icons.desk, color: Colors.grey[800],size:30,),
                    Text("Home & Office",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[800],

                    ),)
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 20,),
                    Icon(Icons.gamepad, color: Colors.grey[800],size:30,),
                    Text("Gaming",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[800],

                    ),)
                  ],
                ),

                Column(
                  children: [
                    SizedBox(height: 20,),
                    Icon(Icons.phone_android, color: Colors.grey[800],size:30,),
                    Text("Phones & Tablets",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[800],

                    ),)
                  ],
                ),

                Column(
                  children: [
                    SizedBox(height: 20,),
                    Icon(Icons.cable, color: Colors.grey[800],size:30,),
                    Text("Electronics",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[800],

                    ),)
                  ],
                ),
              ],
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width-80,
            child: ListView(

              children: [

                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:8.0, right:8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Top-Ranking for you",
                              style: TextStyle(
                                  color: Colors.grey[850],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600

                              ),
                            ),

                            Icon(Icons.arrow_forward_ios, size: 25,color: Colors.grey[800],),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 280,
                        child: GridView(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.7,
                            ),
                        children: [

                          Container(
                            height:110,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:8.0, right:8.0),
                                  child: Container(
                                    height: 70,
                                    decoration: BoxDecoration(
                                        borderRadius:BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15), ),
                                        image: DecorationImage(
                                          image: AssetImage("assets/IMG-20220714-WA0001.jpg"),
                                          fit:BoxFit.cover,

                                        )
                                    ),

                                  ),
                                ),
                                Positioned(
                                  top: 80,
                                  child: SizedBox(
                                    width: 90,
                                    child: Text("Mens Shirt with flowers like coates",textAlign: TextAlign.center, style:TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 10
                                    )),
                                  ),
                                ),

                                Positioned(
                                  left:10,
                                  child: Container(
                                    width: 30,
                                    height: 15,
                                    decoration: BoxDecoration(
                                        borderRadius:BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15), ),
                                        color: Colors.deepOrange
                                    ),
                                    child: Center(
                                      child: Text(
                                        "TOP",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10
                                        ),
                                      ),
                                    ),
                                  ),

                                )
                              ],
                            ),
                          ),
                          Container(
                            height:110,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:8.0, right:8.0),
                                  child: Container(
                                    height: 70,
                                    decoration: BoxDecoration(
                                        borderRadius:BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15), ),
                                        image: DecorationImage(
                                          image: AssetImage("assets/IMG-20220714-WA0000.jpg"),
                                          fit:BoxFit.cover,

                                        )
                                    ),

                                  ),
                                ),
                                Positioned(
                                  top: 80,
                                  child: SizedBox(
                                    width: 90,
                                    child: Text("Mens Shirt with flowers like coates",textAlign: TextAlign.center, style:TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 10
                                    )),
                                  ),
                                ),

                                Positioned(
                                  left:10,
                                  child: Container(
                                    width: 30,
                                    height: 15,
                                    decoration: BoxDecoration(
                                        borderRadius:BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15), ),
                                        color: Colors.deepOrange
                                    ),
                                    child: Center(
                                      child: Text(
                                        "TOP",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10
                                        ),
                                      ),
                                    ),
                                  ),

                                )
                              ],
                            ),
                          ),
                          Container(
                            height:110,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:8.0, right:8.0),
                                  child: Container(
                                    height: 70,
                                    decoration: BoxDecoration(
                                        borderRadius:BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15), ),
                                        image: DecorationImage(
                                          image: AssetImage("assets/IMG-20220714-WA0001.jpg"),
                                          fit:BoxFit.cover,

                                        )
                                    ),

                                  ),
                                ),
                                Positioned(
                                  top: 80,
                                  child: SizedBox(
                                    width: 90,
                                    child: Text("Mens Shirt with flowers like coates",textAlign: TextAlign.center, style:TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 10
                                    )),
                                  ),
                                ),

                                Positioned(
                                  left:10,
                                  child: Container(
                                    width: 30,
                                    height: 15,
                                    decoration: BoxDecoration(
                                        borderRadius:BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15), ),
                                        color: Colors.deepOrange
                                    ),
                                    child: Center(
                                      child: Text(
                                        "TOP",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10
                                        ),
                                      ),
                                    ),
                                  ),

                                )
                              ],
                            ),
                          ),
                          Container(
                            height:110,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:8.0, right:8.0),
                                  child: Container(
                                    height: 70,
                                    decoration: BoxDecoration(
                                        borderRadius:BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15), ),
                                        image: DecorationImage(
                                          image: AssetImage("assets/IMG-20220714-WA0002.jpg"),
                                          fit:BoxFit.cover,

                                        )
                                    ),

                                  ),
                                ),
                                Positioned(
                                  top: 80,
                                  child: SizedBox(
                                    width: 90,
                                    child: Text("Mens Shirt with flowers like coates",textAlign: TextAlign.center, style:TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 10
                                    )),
                                  ),
                                ),

                                Positioned(
                                  left:10,
                                  child: Container(
                                    width: 30,
                                    height: 15,
                                    decoration: BoxDecoration(
                                        borderRadius:BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15), ),
                                        color: Colors.deepOrange
                                    ),
                                    child: Center(
                                      child: Text(
                                        "TOP",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10
                                        ),
                                      ),
                                    ),
                                  ),

                                )
                              ],
                            ),
                          ),
                          Container(
                            height:110,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:8.0, right:8.0),
                                  child: Container(
                                    height: 70,
                                    decoration: BoxDecoration(
                                        borderRadius:BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15), ),
                                        image: DecorationImage(
                                          image: AssetImage("assets/IMG-20220714-WA0003.jpg"),
                                          fit:BoxFit.cover,

                                        )
                                    ),

                                  ),
                                ),
                                Positioned(
                                  top: 80,
                                  child: SizedBox(
                                    width: 90,
                                    child: Text("Mens Shirt with flowers like coates",textAlign: TextAlign.center, style:TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 10
                                    )),
                                  ),
                                ),

                                Positioned(
                                  left:10,
                                  child: Container(
                                    width: 30,
                                    height: 15,
                                    decoration: BoxDecoration(
                                        borderRadius:BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15), ),
                                        color: Colors.deepOrange
                                    ),
                                    child: Center(
                                      child: Text(
                                        "TOP",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10
                                        ),
                                      ),
                                    ),
                                  ),

                                )
                              ],
                            ),
                          ),
                          Container(
                            height:110,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:8.0, right:8.0),
                                  child: Container(
                                    height: 70,
                                    decoration: BoxDecoration(
                                        borderRadius:BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15), ),
                                        image: DecorationImage(
                                          image: AssetImage("assets/IMG-20220714-WA0002.jpg"),
                                          fit:BoxFit.cover,

                                        )
                                    ),

                                  ),
                                ),
                                Positioned(
                                  top: 80,
                                  child: SizedBox(
                                    width: 90,
                                    child: Text("Mens Shirt with flowers like coates",textAlign: TextAlign.center, style:TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 10
                                    )),
                                  ),
                                ),

                                Positioned(
                                  left:10,
                                  child: Container(
                                    width: 30,
                                    height: 15,
                                    decoration: BoxDecoration(
                                        borderRadius:BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15), ),
                                        color: Colors.deepOrange
                                    ),
                                    child: Center(
                                      child: Text(
                                        "TOP",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10
                                        ),
                                      ),
                                    ),
                                  ),

                                )
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),



              ],
            ),
            
          )
        ],
      ),
    );
  }
}
