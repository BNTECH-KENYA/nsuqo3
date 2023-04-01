/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Filter_Wholesaler_Specific_Products extends StatefulWidget {
  const Filter_Wholesaler_Specific_Products({Key? key}) : super(key: key);

  @override
  State<Filter_Wholesaler_Specific_Products> createState() => _Filter_Wholesaler_Specific_ProductsState();

}

class _Filter_Wholesaler_Specific_ProductsState extends State<Filter_Wholesaler_Specific_Products> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text("Filters"),
        actions: [

          Icon(Icons.clear),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

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
                        Text("Category", style:TextStyle(
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
                        Text("SubCategory", style:TextStyle(
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
                        Text("SubSubCategory", style:TextStyle(
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

          ],
        ),
      ),

    );
  }
}

 */