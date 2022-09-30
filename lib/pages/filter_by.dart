import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Filter_By extends StatefulWidget {
  const Filter_By({Key? key}) : super(key: key);

  @override
  State<Filter_By> createState() => _Filter_ByState();

}

class _Filter_ByState extends State<Filter_By> {



    RangeValues value_prices = RangeValues(0, 100000);
    RangeValues value_moq = RangeValues(0, 100);
    RangeValues value_yrs = RangeValues(0, 3);

    final double min_price = 0;
    final double max_price = 100000;

    bool available = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:Colors.grey[100],
      appBar:AppBar(

        backgroundColor:Colors.deepOrange,
        title:Container(
        width:MediaQuery.of(context).size.width,

        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          Text("Reset All", style:TextStyle(
            fontSize: 17,

          )),
          Text("Filters",

              style:TextStyle(
                fontSize: 17,

              )
          ),
          Text("Done",
              style:TextStyle(
                fontSize: 17,

              )
          ),
        ]
        )

    )

      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left:16.0, right:16.0, top:16.0),
          child: Column(
            children: [

              Container(
                width: MediaQuery.of(context).size.width,
                height: 30,
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
               children: [
                 Row(
                   children: [
                     Icon(Icons.money),
                     SizedBox(width: 10,),
                     Text("Price", style:TextStyle(
                         color:Colors.grey[700],
                          fontSize: 16,
                       fontWeight: FontWeight.w600
                     )),
                   ],
                 ),

               ],
                ),
              ),
              SizedBox(height: 5,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 66,
                child:Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:16.0, right:16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text("${value_prices.start.round()}", style:TextStyle(
                            color:Colors.grey[600],
                            fontWeight: FontWeight.w600,
                            fontSize: 15
                          )),

                          Text("${value_prices.end}", style:TextStyle(
                            color:Colors.grey[600],
                            fontWeight: FontWeight.w600,
                            fontSize: 15
                          )),

                        ],
                      ),
                    ),
                    RangeSlider(
                      values: value_prices,
                      min: 0,
                      max: 100000,
                      divisions: 1000,
                      activeColor: Colors.deepOrange,
                      onChanged: (value_prices)=> setState(()=>this.value_prices = value_prices),

                    ),
                  ],
                )
                ,
              ),

      SizedBox(height: 10,),

          Container(
            width: MediaQuery.of(context).size.width,
            height: 30,
            child: Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                  Icon(Icons.add_circle, color: Colors.deepOrange,size: 30,),
                    SizedBox(width: 10,),
                    Text("Distributor", style:TextStyle(
                        color:Colors.grey[700],
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                    )),
                  ],
                ),
              ],
            ),
          ),


             Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Select Distributor", style:TextStyle(
                        color:Colors.grey[600],
                        fontSize: 15,
                        fontWeight: FontWeight.w600
                    )),
                    Icon(Icons.arrow_forward, size: 20,color:Colors.grey[600])
                  ],
                ),
              ),

              SizedBox(height: 10,),

          Container(
            width: MediaQuery.of(context).size.width,
            height: 30,
            child: Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.add_circle, size: 30, color: Colors.deepOrange,),
                    SizedBox(width: 10,),

                    Text("Part No", style:TextStyle(
                        color:Colors.grey[700],
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                    )),
                  ],
                ),
              ],
            ),
          ),

              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Select Part No", style:TextStyle(
                        color:Colors.grey[600],
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                    )),
                    Icon(Icons.arrow_forward, size: 20,color:Colors.grey[600])
                  ],
                ),
              ),

              SizedBox(height: 10,),

          Container(
            width: MediaQuery.of(context).size.width,
            height: 30,
            child: Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.opacity_outlined),
                    SizedBox(width: 10,),
                    Text("MOQ", style:TextStyle(
                        color:Colors.grey[700],
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                    )),
                  ],
                ),
              ],
            ),
          ),

              SizedBox(height: 10,),
             Container(
                width: MediaQuery.of(context).size.width,
                height: 66,
                child:Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:16.0, right:16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text("${value_moq.start.round()}", style:TextStyle(
                              color:Colors.grey[600],
                              fontWeight: FontWeight.w600,
                              fontSize: 15
                          )),

                          Text("${value_moq.end}", style:TextStyle(
                              color:Colors.grey[600],
                              fontWeight: FontWeight.w600,
                              fontSize: 15
                          )),

                        ],
                      ),
                    ),
                    RangeSlider(
                      values: value_moq,
                      min: 0,
                      max: 100,
                      divisions: 10,
                      activeColor: Colors.deepOrange,
                      onChanged: (value_moq)=> setState(()=>this.value_moq = value_moq),

                    ),
                  ],
                )
              ),

              SizedBox(height: 10,),

          Container(
            width: MediaQuery.of(context).size.width,
            height: 30,
            child: Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                Text("Availability", style:TextStyle(
                    color:Colors.grey[700],
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                )),
              ],
            ),
          ),

           Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Available", style:TextStyle(
                        color:Colors.grey[600],
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                    )),
                    Checkbox(
                        value: available,
                        onChanged: (val){
                          setState(
                              ()
                                  {
                                    available = !available;
                                  }
                          );

                        }
                    )
                  ],
                ),
              ),

              SizedBox(height: 10,),

          Container(
            width: MediaQuery.of(context).size.width,
            height: 30,
            child: Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                Text("Warrant", style:TextStyle(
                    color:Colors.grey[700],
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                )),
              ],
            ),
          ),

               Container(
                width: MediaQuery.of(context).size.width,
                height: 66,
                child:Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Container(
                          width:40,
                          height:40,

                          child: Card(

                            child: Center(
                              child: Text("1", style:TextStyle(
                                  color:Colors.grey[600],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15
                              )),
                            ),
                          ),
                        ),
                        Container(
                          width:40,
                          height:40,

                          child: Card(

                            child: Center(
                              child: Text("2", style:TextStyle(
                                  color:Colors.grey[600],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15
                              )),
                            ),
                          ),
                        ),
                        Container(
                          width:40,
                          height:40,

                          child: Card(

                            child: Center(
                              child: Text("3", style:TextStyle(
                                  color:Colors.grey[600],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15
                              )),
                            ),
                          ),
                        ),
                        Container(
                          width:40,
                          height:40,

                          child: Card(

                            child: Center(
                              child: Text("4", style:TextStyle(
                                  color:Colors.grey[600],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15
                              )),
                            ),
                          ),
                        ),
                        Container(
                          width:40,
                          height:40,

                          child: Card(

                            child: Center(
                              child: Text("5", style:TextStyle(
                                  color:Colors.grey[600],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15
                              )),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      )
    );
  }
}
