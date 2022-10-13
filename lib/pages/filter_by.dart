import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/models/filters.dart';
import 'package:nsuqo/models/filters_params.dart';
import 'package:nsuqo/models/products_model.dart';
import 'package:nsuqo/pages/distributors.dart';
import 'package:nsuqo/pages/part_no.dart';
import 'package:nsuqo/pages/partner.dart';
import 'package:nsuqo/pages/places_picker_ai.dart';
import 'package:nsuqo/pages/processor.dart';
import 'package:nsuqo/pages/ram.dart';
import 'package:nsuqo/pages/resolution.dart';
import 'package:nsuqo/pages/screen.dart';
import 'package:nsuqo/pages/scrrensize.dart';
import 'package:nsuqo/pages/storage.dart';

import 'brands.dart';
import 'package.dart';

class Filter_By extends StatefulWidget {
  const Filter_By({Key? key, required this.item_model, required this.filters_params}) : super(key: key);
  final List<Item_Model> item_model;
  final  Filters_Params_Model filters_params;

  @override
  State<Filter_By> createState() => _Filter_ByState();

}

class _Filter_ByState extends State<Filter_By> {


    List<dynamic> array_filters = [];
    RangeValues value_prices = RangeValues(0, 100000);
    RangeValues value_moq = RangeValues(0, 100);
    RangeValues value_yrs = RangeValues(0, 3);

     String part_no = "";
     String warrant = "";
     String distributor = "";
     String location ="";
     String ram = "";
     String processor ="";
     String screensize ="";
     String resolution ="";
     String storage ="";
     String brand ="";
     String screen ="";
     String partner ="";
     String package ="";

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
          InkWell(
            onTap:(){

              Navigator.pop(context,array_filters);

            },
            child: Text("Done",
                style:TextStyle(
                  fontSize: 17,

                )
            ),
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
                      onChanged: (value_prices)=> setState((){
                        this.value_prices = value_prices;

                        array_filters.add(["price","${value_prices.start.round()}-${value_prices.end.round()}"]);

                      }),

                    ),
                  ],
                )
                ,
              ),

      SizedBox(height: 10,),

          InkWell(
            onTap: () async {

              distributor = await Navigator.of(context).push(
                  MaterialPageRoute
                    (builder: (context)=>Distributor(item_models: widget.item_model)));

              if(distributor != null)
              {
                setState(
                        (){
                          array_filters.add(["distributor","${distributor}"]);
                    }
                );
              }
              else{

                setState(
                        (){
                          distributor = "";
                    }
                );
              }
            },

            child: Container(
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
          ),


             Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${distributor}", style:TextStyle(
                        color:Colors.grey[600],
                        fontSize: 15,
                        fontWeight: FontWeight.w600
                    )),
                    Icon(Icons.arrow_forward, size: 20,color:Colors.grey[600])
                  ],
                ),
              ),

              SizedBox(height: 10,),

          InkWell(
            onTap: () async {

              part_no = await Navigator.of(context).push(
                  MaterialPageRoute
                    (builder: (context)=>Part_No(item_models: widget.item_model)));

              if(part_no != null)
              {
                setState(
                        (){
                          array_filters.add(["partno","${part_no}"]);
                    }
                );
              }
              else
                {
                  setState(
                          (){
                        part_no = "";
                      }
                  );

                }
            },

            child: Container(
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
          ),

              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${part_no}", style:TextStyle(
                        color:Colors.grey[600],
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                    )),
                    Icon(Icons.arrow_forward, size: 20,color:Colors.grey[600])
                  ],
                ),
              ),
              SizedBox(height: 10,),

             widget.filters_params.ram ?  InkWell(
            onTap: () async {

              ram = await Navigator.of(context).push(
                  MaterialPageRoute
                    (builder: (context)=>Ram(item_models: widget.item_model)));

              if(ram != null)
              {
                setState(
                        (){
                      array_filters.add(["ram",ram]);
                    }
                );
              }
              else
                {
                  setState(
                          (){
                        ram = "";
                      }
                  );

                }
            },

            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.add_circle, size: 30, color: Colors.deepOrange,),
                      SizedBox(width: 10,),

                      Text("Ram", style:TextStyle(
                          color:Colors.grey[700],
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ): Container(),

             widget.filters_params.ram ? Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${ram}", style:TextStyle(
                        color:Colors.grey[600],
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                    )),
                    Icon(Icons.arrow_forward, size: 20,color:Colors.grey[600])
                  ],
                ),
              ):Container(),

              SizedBox(height: 10,),

             widget.filters_params.processor ?  InkWell(
            onTap: () async {

              processor = await Navigator.of(context).push(
                  MaterialPageRoute
                    (builder: (context)=>Processor(item_models: widget.item_model)));

              if(processor != null)
              {
                setState(
                        (){
                      array_filters.add(["processor",processor]);
                    }
                );
              }
              else
                {
                  setState(
                          (){
                        ram = "";
                      }
                  );

                }
            },

            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.add_circle, size: 30, color: Colors.deepOrange,),
                      SizedBox(width: 10,),

                      Text("Processor", style:TextStyle(
                          color:Colors.grey[700],
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ): Container(),

             widget.filters_params.processor ? Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${processor}", style:TextStyle(
                        color:Colors.grey[600],
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                    )),
                    Icon(Icons.arrow_forward, size: 20,color:Colors.grey[600])
                  ],
                ),
              ):Container(),

              SizedBox(height: 10,),


              widget.filters_params.screensize ?  InkWell(
            onTap: () async {

              screensize = await Navigator.of(context).push(
                  MaterialPageRoute
                    (builder: (context)=>Screen_Size(item_models: widget.item_model)));

              if(screensize != null)
              {
                setState(
                        (){
                      array_filters.add(["screensize",screensize]);
                    }
                );
              }
              else
                {
                  setState(
                          (){
                            screensize = "";
                      }
                  );

                }
            },

            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.add_circle, size: 30, color: Colors.deepOrange,),
                      SizedBox(width: 10,),

                      Text("Screensize", style:TextStyle(
                          color:Colors.grey[700],
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ): Container(),

             widget.filters_params.screensize ? Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${screensize}", style:TextStyle(
                        color:Colors.grey[600],
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                    )),
                    Icon(Icons.arrow_forward, size: 20,color:Colors.grey[600])
                  ],
                ),
              ):Container(),

              SizedBox(height: 10,),

              widget.filters_params.resolution ?  InkWell(
            onTap: () async {

              resolution = await Navigator.of(context).push(
                  MaterialPageRoute
                    (builder: (context)=>Resolution(item_models: widget.item_model)));

              if(resolution != null)
              {
                setState(
                        (){
                      array_filters.add(["resolution",resolution]);
                    }
                );
              }
              else
                {
                  setState(
                          (){
                            resolution = "";
                      }
                  );

                }
            },

            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.add_circle, size: 30, color: Colors.deepOrange,),
                      SizedBox(width: 10,),

                      Text("Resolution", style:TextStyle(
                          color:Colors.grey[700],
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ): Container(),

             widget.filters_params.resolution ? Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${resolution}", style:TextStyle(
                        color:Colors.grey[600],
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                    )),
                    Icon(Icons.arrow_forward, size: 20,color:Colors.grey[600])
                  ],
                ),
              ):Container(),

              SizedBox(height: 10,),
              widget.filters_params.storage ?  InkWell(
            onTap: () async {

              storage = await Navigator.of(context).push(
                  MaterialPageRoute
                    (builder: (context)=>Storage(item_models: widget.item_model)));

              if(storage != null)
              {
                setState(
                        (){
                      array_filters.add(["storage",storage]);
                    }
                );
              }

              else
                {
                  setState(
                          (){
                            storage = "";
                      }
                  );

                }
            },

            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.add_circle, size: 30, color: Colors.deepOrange,),
                      SizedBox(width: 10,),

                      Text("Storage", style:TextStyle(
                          color:Colors.grey[700],
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ): Container(),

             widget.filters_params.storage ? Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${storage}", style:TextStyle(
                        color:Colors.grey[600],
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                    )),
                    Icon(Icons.arrow_forward, size: 20,color:Colors.grey[600])
                  ],
                ),
              ):Container(),

              SizedBox(height: 10,),

              widget.filters_params.brand ?  InkWell(
            onTap: () async {

              brand = await Navigator.of(context).push(
                  MaterialPageRoute
                    (builder: (context)=>Brands(item_models: widget.item_model)));

              if(brand != null)
              {
                setState(
                        (){
                      array_filters.add(["brand",brand]);
                    }
                );
              }
              else
                {
                  setState(
                          (){
                            brand = "";
                      }
                  );

                }
            },

            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.add_circle, size: 30, color: Colors.deepOrange,),
                      SizedBox(width: 10,),

                      Text("brand", style:TextStyle(
                          color:Colors.grey[700],
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ): Container(),

             widget.filters_params.brand ? Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${brand}", style:TextStyle(
                        color:Colors.grey[600],
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                    )),
                    Icon(Icons.arrow_forward, size: 20,color:Colors.grey[600])
                  ],
                ),
              ):Container(),

              SizedBox(height: 10,),

              widget.filters_params.screen ?  InkWell(
            onTap: () async {

              screen = await Navigator.of(context).push(
                  MaterialPageRoute
                    (builder: (context)=>Screen(item_models: widget.item_model)));

              if(screen != null)
              {
                setState(
                        (){
                      array_filters.add(["screen",screen]);
                    }
                );
              }
              else
                {
                  setState(
                          (){
                            screen = "";
                      }
                  );

                }
            },

            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.add_circle, size: 30, color: Colors.deepOrange,),
                      SizedBox(width: 10,),

                      Text("Screen", style:TextStyle(
                          color:Colors.grey[700],
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ): Container(),

             widget.filters_params.screen ? Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${screen}", style:TextStyle(
                        color:Colors.grey[600],
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                    )),
                    Icon(Icons.arrow_forward, size: 20,color:Colors.grey[600])
                  ],
                ),
              ):Container(),

              SizedBox(height: 10,),


              widget.filters_params.partner ?  InkWell(
            onTap: () async {

              partner = await Navigator.of(context).push(
                  MaterialPageRoute
                    (builder: (context)=>Partner(item_models: widget.item_model)));

              if(partner != null)
              {
                setState(
                        (){
                      array_filters.add(["partner",partner]);
                    }
                );
              }
              else
                {
                  setState(
                          (){
                            partner = "";
                      }
                  );

                }
            },

            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.add_circle, size: 30, color: Colors.deepOrange,),
                      SizedBox(width: 10,),

                      Text("Partner", style:TextStyle(
                          color:Colors.grey[700],
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ): Container(),

             widget.filters_params.partner ? Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${partner}", style:TextStyle(
                        color:Colors.grey[600],
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                    )),
                    Icon(Icons.arrow_forward, size: 20,color:Colors.grey[600])
                  ],
                ),
              ):Container(),

              SizedBox(height: 10,),


              widget.filters_params.package ?  InkWell(
            onTap: () async {

              package = await Navigator.of(context).push(
                  MaterialPageRoute
                    (builder: (context)=>Package(item_models: widget.item_model)));

              if(package != null)
              {
                setState(
                        (){
                      array_filters.add(["package",package]);
                    }
                );
              }
              else
                {
                  setState(
                          (){
                            package = "";
                      }
                  );

                }
            },

            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.add_circle, size: 30, color: Colors.deepOrange,),
                      SizedBox(width: 10,),

                      Text("Package", style:TextStyle(
                          color:Colors.grey[700],
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ): Container(),

             widget.filters_params.package ? Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${package}", style:TextStyle(
                        color:Colors.grey[600],
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                    )),
                    Icon(Icons.arrow_forward, size: 20,color:Colors.grey[600])
                  ],
                ),
              ):Container(),

              SizedBox(height: 10,),

          InkWell(
            onTap:() async {

              location = await Navigator.of(context).push(
                  MaterialPageRoute
                    (builder: (context)=>Places_Search()));

              if(location != null)
                {
                  setState(
                      (){
                        array_filters.add(["location","${location}"]);
                      }
                  );
                }
              else{

                setState(
                        (){
                      location = "";
                    }
                );

              }

            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.add_circle, size: 30, color: Colors.deepOrange,),
                      SizedBox(width: 10,),

                      Text("Location", style:TextStyle(
                          color:Colors.grey[700],
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ),

              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${location}", style:TextStyle(
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
                      onChanged: (value_moq)=> setState((){
                        this.value_moq = value_moq;
                        array_filters.add(["moq","${value_moq.start.round()}"]);

                      }),

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
                                    if(array_filters.contains(["available",true]) ||array_filters.contains(["available",false]) )
                                      {
                                        array_filters.remove(["available",true]);
                                        array_filters.remove(["available",false]);
                                        array_filters.add(["available",available]);

                                      }
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

                        InkWell(
                          onTap:(){

                            setState(
                                (){

                                  array_filters.add(['warrant','1']);
                                  warrant = "1";
                                }
                            );
                            },
                          child: Container(
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
                        ),
                        InkWell(

                          onTap:(){

                            setState(
                                    (){

                                      array_filters.add(['warrant','2']);
                                  warrant = "2";
                                }
                            );
                          },
                          child: Container(
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
                        ),
                        InkWell(
                          onTap:(){

                            setState(
                                    (){

                                      array_filters.add(['warrant','3']);
                                  warrant = "3";
                                }
                            );
                          },
                          child: Container(
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
                        ),
                        InkWell(
                          onTap:(){

                            setState(
                                    (){

                                      array_filters.add(['warrant','4']);
                                  warrant = "4";
                                }
                            );
                          },
                          child: Container(
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
                        ),
                        InkWell(
                          onTap:(){

                            setState(
                                    (){

                                      array_filters.add(['warrant','5']);
                                  warrant = "5";
                                }
                            );
                          },
                          child: Container(
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
