import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/pages/product_information.dart';
import 'package:nsuqo/pages/subcategories.dart';
import 'package:toast/toast.dart';

import '../helpers/storage.dart';
import '../widgets/add_product_photos.dart';

class Add_Products extends StatefulWidget {
  const Add_Products({Key? key,required this.location, required this.user_email, required this.company_name}) : super(key: key);
  final String user_email, company_name, location;

  @override
  State<Add_Products> createState() => _Add_ProductsState();
}

class _Add_ProductsState extends State<Add_Products> {

  bool isLoading = false;
  late String document_id;
  final storage _storage = storage();

  TextEditingController _productname = TextEditingController();
  TextEditingController _productdescription = TextEditingController();
  TextEditingController _warrantperiod = TextEditingController();
  TextEditingController _availability = TextEditingController();
  TextEditingController _productprice = TextEditingController();
  TextEditingController _moq = TextEditingController();
  TextEditingController _partno = TextEditingController();

  List<File> ? photoFiles;
  List<String> ? fileDownloadUris= [];

  var imagePath;
  var imageName;
  String imageLink = "";
  String _subcategory = "";

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> uploadingItemData()
  async {
    setState(
            (){
          isLoading = true;
        }
    );

    final data = <String, dynamic>
    {

      "wholesalerid": widget.user_email,
      "company_name":widget.company_name,
      "productname": _productname.text.toString(),
      "category": "computing",
      "subcategory": _subcategory,
      "productdescription": _productdescription.text.toString(),
      "productprice": _productprice.text.toString(),
      "availability": _availability.text.toString(),
      "warrantperiod": _warrantperiod.text.toString(),
      "noofclicks": "0",
      "moq": _moq.text.toString(),
      "partno": _partno.text.toString(),
      "photosLinks": fileDownloadUris,
      "location": widget.location,

    };

    await db.collection("products").add(data).then(
            (DocumentReference doc) {
              document_id = doc.id;
        }
    );

    return document_id;

  }

  @override
  Widget build(BuildContext context) {

    return isLoading? Container(
      width: MediaQuery.of(context).size.width,
      height:MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          borderRadius:BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15), ),
          color: Colors.deepOrange
      ),
      child: Center(child: CircularProgressIndicator(
        backgroundColor: Colors.white,
      ),),
    ) : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          leading: Icon(Icons.arrow_back, color:Colors.white),
          title:Text(
            'Add Product',
            style: TextStyle(
                color:Colors.white
            ),
          )
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left:16.0, right:16.0, top:16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text("Enter  Product Name", style:TextStyle(

                color:Colors.grey[800],
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
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0,top: 12.0, bottom: 4),
                  child: TextField(

                    controller: _productname,
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
              Text("Enter  Product part number", style:TextStyle(

                color:Colors.grey[800],
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
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0,top: 12.0, bottom: 4),
                  child: TextField(

                    controller: _partno,
                    decoration: InputDecoration(
                        hintText: '1234',
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

                  String subcategpory = await Navigator.push(context,
                      MaterialPageRoute(builder:
                          (context) => SubCategories_Page()));

                  if(subcategpory != null)
                  {
                    setState(() {
                      _subcategory = subcategpory;
                    });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Select Product Category & Sub Category", style:TextStyle(

                        color:Colors.grey[800],
                        fontWeight: FontWeight.w400,
                        fontSize:16
                    )),
                    Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey[500],)
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

                 "Computing,  ${_subcategory}", style: TextStyle(
                    color: Colors.grey[700]
                  ),

                  ),

                ),
              ),

              SizedBox(height: 20,),

              Text("Enter Product Description", style:TextStyle(

                  color:Colors.grey[800],
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
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0,top: 2.0, bottom: 2),
                  child: TextField(
                    controller: _productdescription,
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
              Text("Enter  Product Price(KES)", style:TextStyle(

                  color:Colors.grey[800],
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
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0,top: 12.0, bottom: 4),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _productprice,
                    decoration: InputDecoration(
                        hintText: '2000',
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

              Text("Enter  Warrant Period", style:TextStyle(

                  color:Colors.grey[800],
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
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0,top: 12.0, bottom: 4),
                  child: TextField(

                    controller: _warrantperiod,
                    decoration: InputDecoration(
                        hintText: 'warrant period',
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
              Text("Enter  Availability", style:TextStyle(

                  color:Colors.grey[800],
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
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0,top: 12.0, bottom: 4),
                  child: TextField(
                      controller: _availability,
                    decoration: InputDecoration(
                        hintText: 'availability',
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
              Text("(MOQ) Minimum Order Quantity", style:TextStyle(

                  color:Colors.grey[800],
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
                  borderRadius: BorderRadius.circular(2),
                ),

                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0,top: 12.0, bottom: 4),
                  child: TextField(
                      controller: _moq,
                    decoration: InputDecoration(
                        hintText: '10 cartons',
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


                  print(">>>>>>>>>>>>>>>>>>|-pdflength${photoFiles?.length}");
                  final result = await FilePicker.platform.pickFiles(
                      allowMultiple:true,
                      type: FileType.custom,
                      allowedExtensions: ['png','jpg']
                  );
                  if(result == null) return;
                  print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>> |-result ${result.count}");
                  if(result.count <= 2){
                    setState(
                            (){

                          photoFiles =result.paths.map((path) => File(path!)).toList() ;
                        }
                    );
                  }
                  else
                  {

                  }

                },
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Add Product Photo\n (optional max 2)", style:TextStyle(

                        color:Colors.grey[800],
                        fontWeight: FontWeight.w400,
                        fontSize:16
                    )),
                    Icon(Icons.add_a_photo, size: 30, color:Colors.grey[600]),
                  ],
                ),
              ),

              SizedBox(height: 10,),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                height:(photoFiles?.length == null)? 0 :photoFiles!.length * 280,
                child: ListView.builder(
                itemCount: (photoFiles?.length == null)? 0:photoFiles?.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {

                  return Product_Photos(
                       path: photoFiles![index].path,
                  );

                }

                ),
              ),

              SizedBox(height: 20,),

              InkWell(
                onTap: () async {

                  if(_productname.text.toString().trim().isEmpty)
                  {
                    Toast.show("Enter Product Name".toString(), context,duration:Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);
                  }

                  else if(_productdescription.text.toString().trim().isEmpty)
                  {

                    Toast.show("Enter Product Description".toString(), context,duration:Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);
                  }
                  else if(_productprice.text.toString().trim().isEmpty)
                  {

                    Toast.show("Enter Product Price".toString(), context,duration:Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);
                  }
                  else if(_warrantperiod.text.toString().trim().isEmpty)
                  {

                    Toast.show("Enter Warrant Period".toString(), context,duration:Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);
                  }

                  else if(_availability.text.toString().trim().isEmpty)
                  {

                    Toast.show("Enter Availability".toString(), context,duration:Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);
                  }

                  else if(_moq.text.toString().trim().isEmpty)
                  {

                    Toast.show("Enter Minimum Availability Quantity".toString(), context,duration:Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);
                  }

                  else if(_partno.text.toString().trim().isEmpty)
                  {

                    Toast.show("Enter Product Part Number".toString(), context,duration:Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);
                  }

                  else if(_subcategory.isEmpty)
                  {

                    Toast.show("Select SubCategory".toString(), context,duration:Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);
                  }

                  else{

                    setState(() {
                      isLoading = true;
                    });
                    String groupServiceId = await uploadingItemData();
                    for (var image in photoFiles!)
                    {
                      String? dowbloaduri =  await _storage.uploadImage(image.path, groupServiceId+"/"+image.path.toString());
                      print(" download image at ->   ${dowbloaduri.toString()}");
                      fileDownloadUris?.add(dowbloaduri!);
                    }

                    final dataupdate = <String, dynamic>
                    {
                      "photosLinks":fileDownloadUris,
                    };

                    await db.collection("products").doc(groupServiceId).update(dataupdate)
                        .then((value) {
                      setState(
                              (){
                            isLoading = false;

                          }
                      );

                      print("~~~~~~~~~~~~~~Success in Jesus Name~~~~~~~~~~~~~");
                      Navigator.of(context).push(
                          MaterialPageRoute
                            (builder: (context)=>Product_Information(document_id: document_id,))
                      );
                    });
                  }

                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    border: Border.all(
                        color: Colors.grey[500]!
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                      child: Text("Save Product", style: TextStyle(
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
}
