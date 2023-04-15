import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nsuqo/pages/sub_categories.dart';
import 'package:toast/toast.dart';

import '../subcategories/sub_categories_wholesaler_filter_on_reseller.dart';


class wholesaler_Specific_Brands extends StatefulWidget {

  const wholesaler_Specific_Brands({Key? key, required this.category,
    required this.listbrands, required this.wholesalerid,
    required this.subcategories}) : super(key: key);
  final String category;
  final List<dynamic> listbrands;
  final String  wholesalerid;
  final List<dynamic> subcategories;

  @override
  State<wholesaler_Specific_Brands> createState() => _wholesaler_Specific_BrandsState();

}

class _wholesaler_Specific_BrandsState extends State<wholesaler_Specific_Brands> {

  FirebaseFirestore db = FirebaseFirestore.instance;

  bool isLoading = true;

  List<String> brands = [];
  List<Color> colors_list=[

    Colors.grey[800]!, Colors.grey[700]!, Colors.black, Colors.grey[800]!,
    Colors.grey[700]!, Colors.black, Colors.grey[800]!, Colors.grey[700]!,
    Colors.grey[800]!, Colors.grey[700]!, Colors.black, Colors.grey[800]!,

  ];

  int color_increment =0;

  Future <void> get_subcategories() async{


    final service_listings = db.collection("brands")
        .where("brandcategory", isEqualTo: widget.category);

    await service_listings.get().then((ref) {
      setState(
              () {

            ref.docs.forEach((element) {


              if(color_increment == 11)
              {
                color_increment = 0;
              }




              if((widget.listbrands.contains(element.data()['brandname'])))
                {
                  brands.add(element.data()['brandname']);

                }




              color_increment++;
            });

            isLoading = false;
          }
      );
    });

  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

        ()async{

      await get_subcategories();

    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left:16.0, right:16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30,),
                InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },

                    child: Icon(Icons.arrow_back, color: HexColor("#1A434E"), size: 30,)),
                SizedBox(height: 20,),
                Text("${widget.category} Brands",style:TextStyle(
                    fontWeight: FontWeight.w600,
                    color: HexColor("#1A434E"),
                    fontSize:18
                )),
                SizedBox(height: 10,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: brands.length *60,
                  child: ListView.builder(
                      itemCount: brands.length,

                      itemBuilder:(BuildContext context, int index) {

    if(!(widget.listbrands.contains(brands[index])))
    {

    return Container();

    }
    else{

      return InkWell(
        onTap: (){
          Navigator.of(context).push(
              MaterialPageRoute
                (builder: (context)=>Sub_Categories_On_Resseler(
                brand:brands[index], wholesalerid: widget.wholesalerid, subcategories: widget.subcategories, category: widget.category ,)));
        },

        child: Card(
          color: Colors.grey[200],
          child: Container(

            width: MediaQuery.of(context).size.width,
            height: 50,
            child:
            Padding(
              padding: const EdgeInsets.only(left:0.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Text("${brands[index][0].toUpperCase()}${brands[index][1].toUpperCase()}",
                      style: TextStyle(
                          color: HexColor("#FFFFFF"),
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  title: Text("${brands[index]}",
                    style: TextStyle(
                      color: HexColor("#1A434E"),

                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20, color: HexColor("#1A434E"),),
                ),
              ),
            ),

          ),
        ),
      );
    }

                      }),
                )

              ],

            ),
          )),

    );
  }
}
