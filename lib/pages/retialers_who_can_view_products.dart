import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/models/retailers_model.dart';

import '../widgets/retailers_limited.dart';

class Retailers_who_can_view extends StatefulWidget {
  const Retailers_who_can_view({Key? key, required this.wholesaler_id}) : super(key: key);
  final String wholesaler_id;

  @override
  State<Retailers_who_can_view> createState() => _Retailers_who_can_viewState();
}

class _Retailers_who_can_viewState extends State<Retailers_who_can_view> {
  @override

  FirebaseFirestore db = FirebaseFirestore.instance;

  bool all = false;

  List<Color> colors_list=[

    Colors.deepOrange, Colors.blue, Colors.deepPurpleAccent, Colors.lightGreen,
    Colors.pinkAccent, Colors.yellowAccent,Colors.purple, Colors.greenAccent,
    Colors.orange, Colors.teal, Colors.brown, Colors.limeAccent

  ];

  List<Retailers_Model> retailers = [];
  List<Retailers_Model> retailers_search = [];
  List<String> can_view_list = [];



  bool isLoading = true;
  int color_count = 0;



  Future<void> getRetailers() async {

    // remember to change to required data
    final service_listings = db.collection("userdd").where("accounttype", isEqualTo: "retailer");

    retailers_search = [];
    await service_listings.get().then((ref) {
      print("redata 1 &****************************${ref.docs}");
      setState(
              () {
            ref.docs.forEach((element) {
              if(color_count == (colors_list.length-1))
              {
                color_count=0;
              }
              bool can_view_in = false;
              (element.data()['wholesaler_limit_list']).forEach((element)
              {
                if(element == widget.wholesaler_id)
                  {
                    can_view_in = true;
                  }
              }
              );
              retailers.add(
                Retailers_Model(
                    retailer_email:  element.data()['emailidInput'],
                    company_name:  element.data()['companyNameinput'], 
                    retailer_phonenumber:  element.data()['phonenumberInput'], 
                    retailer_name:  element.data()['firstNameinput'],
                    can_view: can_view_in, ),
                    //element.data()['availability'],
              );
              retailers_search.add(
                Retailers_Model(
                    retailer_email:  element.data()['emailidInput'],
                    company_name:  element.data()['companyNameinput'],
                    retailer_phonenumber:  element.data()['phonenumberInput'],
                    retailer_name:  element.data()['firstNameinput'],
                    can_view: can_view_in),
              );
              
              color_count++;

            });
            retailers.forEach((element) {
              if(element.can_view == true){

                can_view_list.add(element.retailer_email);

              }

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
        () async {
      await getRetailers();
    }();
  }
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Who can view your products ?",style: TextStyle(
          color: Colors.grey[200],
          fontSize: 16,

        ),

        ),
        iconTheme: IconThemeData(
          color: Colors.grey[200]
        ),
      ),

     body:

     Container(

       width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.height,

       child: Stack(
         children: [

           Positioned(
             top:20,
             child: Container(

               width: MediaQuery.of(context).size.width,
               height: MediaQuery.of(context).size.height-130,

               child: ListView.builder(

               itemCount: retailers_search.length + 1,
               itemBuilder: (context, index){

                 if(index == 0)
                   {
                     return SizedBox(height: 30,);
                   }
                 else{
                   return  InkWell(
                       onTap: (){

                         if(retailers_search[index-1].can_view)
                         {
                           final data = {
                             "wholesaler_limit_list": FieldValue.arrayRemove(
                                 [widget.wholesaler_id]
                             )
                           };

                           db.collection("userdd").doc(retailers_search[index-1].retailer_email).update(data).then(
                                   (value){

                                 getRetailers();

                               },
                               onError: (e)=> print("Error updating documnet $e")
                           );

                         }
                         else{

                           final data = {
                             "wholesaler_limit_list":FieldValue.arrayUnion(
                                 [widget.wholesaler_id]
                             ),
                           };

                           db.collection("userdd").doc(retailers_search[index-1].retailer_email).update(data).then(
                                   (value){

                                 getRetailers();

                               },
                               onError: (e)=> print("Error updating documnet $e")
                           );

                         }

                       },
                       child: Retailers_view_products(retailer_model: retailers_search[index-1],));
                 }

               }

                ),
             ),
           ),
           Positioned(
             top: 10,

             child: Padding(
               padding: const EdgeInsets.only(left:8.0, right:8.0),
               child: Container(

                 decoration: BoxDecoration(
                   color: Colors.black
                 ),
                 width: MediaQuery.of(context).size.width,

                 height: 40,

                 child:Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                   all? Text("Deselect All", style: TextStyle(
                     color: Colors.grey[200]
                   ),):Text("Select All", style: TextStyle(
                       color: Colors.grey[200]
                   )),
                     Checkbox(

                         value: all,
                         onChanged: (val)async{
                           setState(()  {
                             all = ! all;
                           });
                             if(all)
                               {


                                 if(retailers_search.length >0)
                                   {


                                     final data = {
                                       "wholesaler_limit_list":FieldValue.arrayUnion(
                                           [widget.wholesaler_id]
                                       ),
                                     };


                                     List<DocumentReference> posts = [];

                                     retailers_search.forEach((element) {

                                       posts.add(db.collection("userdd").doc(element.retailer_email));
                                     });


                                     int i = 0;
                                     while(true){

                                       posts[i].update(data);
                                       i++;
                                       if(i == (posts.length)){

                                         i=0;
                                         await getRetailers();
                                         break;

                                       }
                                     }

                                   }

                               }else{
                               if(retailers_search.length>0)
                                 {

                                   final data = {
                                     "wholesaler_limit_list":[],
                                   };

                                   List<DocumentReference> posts = [];

                                   retailers_search.forEach((element) {

                                     posts.add(db.collection("userdd").doc(element.retailer_email));
                                   });

                                   int i = 0;
                                   while(true){

                                     posts[i].update(data);
                                     i++;

                                     if(i == (posts.length)){
                                       i=0;
                                       await getRetailers();
                                       break;
                                     }





                                   }
                                 }
                             }
                         })
                   ],
                 )
               ),
             ),
           ),

         ],
       ),
     ),

    );
  }
}
