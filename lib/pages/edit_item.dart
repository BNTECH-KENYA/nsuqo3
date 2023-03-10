import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsuqo/helpers/storage.dart';
import 'package:nsuqo/models/categories_model.dart';
import 'package:nsuqo/models/subcategory_model.dart';
import 'package:nsuqo/pages/product_category.dart';
import 'package:nsuqo/pages/product_information.dart';
import 'package:nsuqo/pages/product_subcategories.dart';
import 'package:nsuqo/pages/product_subsubcategories.dart';
import 'package:nsuqo/pages/select_availability.dart';
import 'package:nsuqo/pages/subcategories.dart';
import 'package:toast/toast.dart';

import '../models/filters_params.dart';
import '../models/subsubcategory_model.dart';
import '../widgets/add_product_photos.dart';

class Edit_Item extends StatefulWidget {
  const Edit_Item({Key? key,required this.location, required this.user_email, required this.company_name, required this.doc_ic}) : super(key: key);
  final String user_email, company_name, location, doc_ic;

  @override
  State<Edit_Item> createState() => _Edit_ItemState();

}

class _Edit_ItemState extends State<Edit_Item> {

  _Edit_ItemState(){
    _selectedVal = _warrant_length[0];
  }

  bool isLoading = true;
  String document_id = "";

  final storage _storage = storage();


  TextEditingController _productname = TextEditingController();
  TextEditingController _productdescription = TextEditingController();
  TextEditingController _warrantperiod = TextEditingController();
  TextEditingController _productprice = TextEditingController();
  TextEditingController _moq = TextEditingController();
  TextEditingController _partno = TextEditingController();
  TextEditingController _brand = TextEditingController();
  TextEditingController _processor = TextEditingController();
  TextEditingController _storageproduct = TextEditingController();
  TextEditingController _size = TextEditingController();
  TextEditingController _screen = TextEditingController();
  TextEditingController _screensize = TextEditingController();
  TextEditingController _package = TextEditingController();
  TextEditingController _partner = TextEditingController();
  TextEditingController _resolution = TextEditingController();
  TextEditingController _ram = TextEditingController();


  List<File> ? photoFiles;
  List<String> ? fileDownloadUris= [];
  List<dynamic> ? photoLinksin= [];
  int max_photos =2;
  Filters_Params_Model _filters_params_model =
  Filters_Params_Model(

      availability: true,
      warrant_period: true,
      moq: true,
      partno: true,
      company_name: true,
      location: true,
      ram: false,
      processor: false,
      screen: false,
      brand: false,
      resolution: false,
      storage: false,
      screensize: false,
      partner: false,
      package: false,
      size: false

  );

  var imagePath;
  var imageName;
  String imageLink = "";
  String _subcategory = "";
  String _category = "";
  String _categoryId = "";
  String _subcategoryId = "";
  String _availablility = "";
  String _subsubcategory = "";
  String ram ="";
  String processor = "";
  String screen = "";
  String brand  = "";
  String resolution ="";
  String _storageproducts ="";
  String screensize ="";
  String partner ="";
  String package = "";
  String size ="";

  final  _warrant_length = ["days", "months", "years"];
  String ? _selectedVal = "days";

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
      "category": _category,
      "subcategory": _subcategory,
      "subsubcategory": _subsubcategory,
      "productdescription": _productdescription.text.toString(),
      "productprice": _productprice.text.toString(),
      "availability": _availablility,
      "warrantperiod": _warrantperiod.text.toString() +"_"+ _selectedVal!,
      "noofclicks": "0",
      "moq": _moq.text.toString(),
      "partno": _partno.text.toString(),
      "photosLinks": fileDownloadUris,
      "location": widget.location,
      "ram":_ram.text.toString(),
      "processor":_processor.text.toString(),
      "screen":_screen.text.toString(),
      "brand":_brand.text.toString(),
      "resolution":_resolution.text.toString(),
      "storage":_storageproduct.text.toString(),
      "screensize":_screensize.text.toString(),
      "partner":_partner.text.toString(),
      "package":_package.text.toString(),
      "size":_size.text.toString(),

      "filters_params":{
        "availability":_filters_params_model.availability,
        "warrant_period":_filters_params_model.warrant_period,
        "moq": _filters_params_model.moq,
        "partno": _filters_params_model.partno,
        "company_name": _filters_params_model.company_name,
        "location": _filters_params_model.location,
        "ram": _filters_params_model.ram,
        "processor": _filters_params_model.processor,
        "screen":_filters_params_model.screen,
        "brand": _filters_params_model.brand,
        "resolution": _filters_params_model.resolution,
        "storage": _filters_params_model.storage,
        "screensize": _filters_params_model.screensize,
        "partner": _filters_params_model.partner,
        "package": _filters_params_model.package,
        "size": _filters_params_model.size,

      }

    };

    await db.collection("products").doc(widget.doc_ic).update(data);

    return document_id;

  }


  Future<void> getProductDeatil()
  async {
    final docref = db.collection("products").doc(widget.doc_ic);
    await docref.get().then((res) {

      if(res.data() != null)
      {
        setState(
                (){

                  _filters_params_model = Filters_Params_Model(
                      availability: res.data()!['filters_params']["availability"],
                      warrant_period: res.data()!['filters_params']["warrant_period"],
                      moq: res.data()!['filters_params']["moq"],
                      partno: res.data()!['filters_params']["partno"],
                      company_name: res.data()!['filters_params']["company_name"],
                      location: res.data()!['filters_params']["location"],
                      ram: res.data()!['filters_params']["ram"],
                      processor: res.data()!['filters_params']["processor"],
                      screen: res.data()!['filters_params']["screen"],
                      brand: res.data()!['filters_params']["brand"],
                      resolution: res.data()!['filters_params']["resolution"],
                      storage: res.data()!['filters_params']["storage"],
                      screensize: res.data()!['filters_params']["screensize"],
                      partner: res.data()!['filters_params']["partner"],
                      package: res.data()!['filters_params']["package"],
                      size: res.data()!['filters_params']["size"],
                  );

                    _productname.text = res.data()!['productname'];
                   _productdescription.text =res.data()!['productdescription'];
                   _warrantperiod.text=res.data()!['warrantperiod'].contains("_")? res.data()!['warrantperiod'].split("_")[0]:res.data()!['warrantperiod'];
                   _selectedVal =res.data()!['warrantperiod'].contains("_")? res.data()!['warrantperiod'].split("_")[1]: "days";
                   _productprice.text = res.data()!['productprice'];
                   _moq.text =res.data()!['moq'];
                   _partno.text =res.data()!['partno'];
                   _brand.text =res.data()!['brand'];
                   _processor.text =res.data()!['processor'];
                   _storageproduct.text =res.data()!['storage'];
                   _size.text =res.data()!['size'];
                   _screen.text =res.data()!['screen'];
                   _screensize.text =res.data()!['screensize'];
                   _package.text =res.data()!['package'];
                   _partner.text =res.data()!['partner'];
                   _resolution.text =res.data()!['resolution'];
                   _ram.text =res.data()!['ram'];
                   photoLinksin = res.data()!['photosLinks'];
                   max_photos = 2- photoLinksin!.length;

                   _subcategory = res.data()!['subcategory'];
                   _category = res.data()!['category'];
                   _availablility = res.data()!['availability'];
                   _subsubcategory = res.data()!['subsubcategory'];

              isLoading = false;

              /*
               if(!isWholesaler)
              {
                opponent_name = company_name;
                email_reciever = wholesaler_id;
              }
               */
            }
        );


      }

    });

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    () async {

      await getProductDeatil();
    }();

  }
  @override
  Widget build(BuildContext context) {


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
    ) : Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black,
          leading: InkWell(
              onTap:(){

                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back, color:Colors.white)),
          title:Text(
            'Edit Product',
            style: TextStyle(
                color:Colors.grey[200]
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

                  CategoriesModel category = await Navigator.push(context,
                      MaterialPageRoute(builder:
                          (context) => Select_Category()));

                  if(category != null)
                  {
                    setState(() {
                      _category = category.category_name;
                      _categoryId = category.category_id;
                    });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text("Select Product Category", style:TextStyle(

                        color:Colors.grey[200],
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
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0,top: 12.0, bottom: 4),
                  child: Text(

                    "${_category}", style: TextStyle(
                      color: Colors.grey[700]
                  ),

                  ),

                ),
              ),

              SizedBox(height: 20,),

              InkWell(
                onTap:() async {

                  if(_category.length <1)

                  {
                    Toast.show("Select Product Category".toString(), context,duration:Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);
                  }

                  else
                  {
                    SubCategoriesModel subcategory_model= await Navigator.push(context,
                        MaterialPageRoute(builder:
                            (context) => Select_Sub_Category(categoryId: _categoryId,)));

                    if(subcategory_model != null)
                    {
                      setState(() {
                        _subcategory = subcategory_model.sub_category_name;
                        _subcategoryId = subcategory_model.sub_category_id;
                        _filters_params_model = subcategory_model.filters_params_model;
                      });
                    }
                  }

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text("Select Product Subcategory", style:TextStyle(

                        color:Colors.grey[200],
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
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0,top: 12.0, bottom: 4),
                  child: Text(

                    "${_subcategory}", style: TextStyle(
                      color: Colors.grey[700]
                  ),

                  ),

                ),
              ),

              SizedBox(height: 20,),

              InkWell(
                onTap:() async {

                  if(_subcategory.length <1)

                  {
                    Toast.show("Select Product Subcategory".toString(), context,duration:Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);
                  }

                  else
                  {
                    SubSubCategoriesModel subsubcategory_model= await Navigator.push(context,
                        MaterialPageRoute(builder:
                            (context) => Select_Sub_Sub_Category(subcategoryId: _subcategoryId,)));

                    if(subsubcategory_model != null)
                    {
                      setState(() {
                        _subsubcategory = subsubcategory_model.sub_sub_category_name;
                      });
                    }
                  }

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text("Select Product Subcategory", style:TextStyle(

                        color:Colors.grey[200],
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
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0,top: 12.0, bottom: 4),
                  child: Text(

                    "${_subsubcategory}", style: TextStyle(
                      color: Colors.grey[700]
                  ),

                  ),

                ),
              ),

              SizedBox(height: 20,),

              Text("Enter Product Description", style:TextStyle(

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
                    controller: _productdescription,
                    maxLines: 5,
                    minLines: 5,
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
              Text("Enter  Product Price(USD)", style:TextStyle(
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

                  color:Colors.grey[200],
                  fontWeight: FontWeight.w400,
                  fontSize:16
              )),

              SizedBox(height: 10,),

              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width-125,
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

                        keyboardType: TextInputType.number,
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
                  SizedBox(width:10),

                  DropdownButton(
                      value:_selectedVal,
                      items: _warrant_length.map(
                      (e) => DropdownMenuItem(child: Text(e), value: e,)
                  ).toList(),
                      onChanged: (val){

                    setState((){
                      _selectedVal = val as String;
                    });

                      }),


                ],
              ),

              SizedBox(height: 20,),
              InkWell(
                onTap:() async {

                String   _availablility_passed = await Navigator.push(context,
                      MaterialPageRoute(builder:
                          (context) => Availability()));

                if(_availablility_passed == null)
                {
                  setState(() {
                    _availablility = "";
                  });
                }
                else
                {
                  setState(() {
                    _availablility = _availablility_passed;
                  });
                }
                },
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text("Select Availability", style:TextStyle(

                        color:Colors.grey[200],
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
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0,top: 12.0, bottom: 4),
                  child:  Text(

                    "${_availablility}",style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],

                  ),

                  ),

                ),
              ),

              SizedBox(height: 20,),
              Text("(MOQ) Minimum Order Quantity", style:TextStyle(

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

              _filters_params_model.brand? Text("Enter Brand Name", style:TextStyle(

                  color:Colors.grey[200],
                  fontWeight: FontWeight.w400,
                  fontSize:16
              )):Container(),
              _filters_params_model.brand? SizedBox( height: 10,): Container(),

              _filters_params_model.brand?  Container(
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

                    controller: _brand,
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
              ):Container(),

              _filters_params_model.brand? SizedBox( height: 20,): Container(),

              _filters_params_model.package? Text("Enter package Name", style:TextStyle(

                  color:Colors.grey[800],
                  fontWeight: FontWeight.w400,
                  fontSize:16
              )):Container(),
              _filters_params_model.package? SizedBox( height: 10,): Container(),

              _filters_params_model.package? Container(
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

                    controller: _package,
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
              ):Container(),

              _filters_params_model.package? SizedBox( height: 20,): Container(),

              _filters_params_model.partner? Text("Enter partner Name", style:TextStyle(

                  color:Colors.grey[200],
                  fontWeight: FontWeight.w400,
                  fontSize:16
              )):Container(),
              _filters_params_model.partner? SizedBox( height: 10,): Container(),

              _filters_params_model.partner? Container(
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

                    controller: _partner,
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
              ):Container(),

              _filters_params_model.partner? SizedBox( height: 20,): Container(),
              _filters_params_model.processor? Text("Enter processor description", style:TextStyle(

                  color:Colors.grey[200],
                  fontWeight: FontWeight.w400,
                  fontSize:16
              )):Container(),
              _filters_params_model.processor? SizedBox( height: 10,): Container(),

              _filters_params_model.processor? Container(
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

                    controller: _processor,
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
              ):Container(),

              _filters_params_model.processor? SizedBox( height: 20,): Container(),
              _filters_params_model.ram? Text("Enter ram description", style:TextStyle(

                  color:Colors.grey[200],
                  fontWeight: FontWeight.w400,
                  fontSize:16
              )):Container(),
              _filters_params_model.ram? SizedBox( height: 10,): Container(),

              _filters_params_model.ram? Container(
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

                    controller: _ram,
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
              ):Container(),

              _filters_params_model.ram? SizedBox( height: 20,): Container(),
              _filters_params_model.resolution? Text("Enter resolution description", style:TextStyle(

                  color:Colors.grey[200],
                  fontWeight: FontWeight.w400,
                  fontSize:16
              )):Container(),
              _filters_params_model.resolution? SizedBox( height: 10,): Container(),

              _filters_params_model.resolution? Container(
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

                    controller: _resolution,
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
              ):Container(),

              _filters_params_model.resolution? SizedBox( height: 20,): Container(),
              _filters_params_model.screen? Text("Enter screen description", style:TextStyle(

                  color:Colors.grey[200],
                  fontWeight: FontWeight.w400,
                  fontSize:16
              )):Container(),
              _filters_params_model.screen? SizedBox( height: 10,): Container(),

              _filters_params_model.screen? Container(
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

                    controller: _screen,
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
              ):Container(),


              _filters_params_model.screen? SizedBox( height: 20,): Container(),

              _filters_params_model.screensize? Text("Enter screensize description", style:TextStyle(

                  color:Colors.grey[200],
                  fontWeight: FontWeight.w400,
                  fontSize:16
              )):Container(),
              _filters_params_model.screensize? SizedBox( height: 10,): Container(),

              _filters_params_model.screensize? Container(
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

                    controller: _screensize,
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
              ):Container(),

              _filters_params_model.screensize? SizedBox( height: 20,): Container(),
              _filters_params_model.size?Text("Enter size description", style:TextStyle(

                  color:Colors.grey[200],
                  fontWeight: FontWeight.w400,
                  fontSize:16
              )):Container(),
              _filters_params_model.screensize? SizedBox( height: 10,): Container(),

              _filters_params_model.size? Container(
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

                    controller: _size,
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
              ):Container(),

              _filters_params_model.screensize? SizedBox( height: 20,): Container(),
              _filters_params_model.storage? Text("Enter storage description", style:TextStyle(

                  color:Colors.grey[200],
                  fontWeight: FontWeight.w400,
                  fontSize:16
              )):Container(),
              _filters_params_model.storage? SizedBox( height: 10,): Container(),

              _filters_params_model.storage? Container(
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

                    controller: _storageproduct,
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
              ):Container(),

              _filters_params_model.storage? SizedBox( height: 20,): Container(),

              SizedBox(height: 20,),

              Text("Prevously Uploaded photos", style:TextStyle(

                  color:Colors.grey[200],
                  fontWeight: FontWeight.w400,
                  fontSize:16
              )
              ),


              SizedBox(height: 10,),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                height:100,
                child: ListView.builder(

                    itemCount: photoLinksin!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {

                      return Container(
                        width: 100,
                        height: 80,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey[500]!
                            ),

                            borderRadius:BorderRadius.all( Radius.circular(20), ),
                            image: DecorationImage(
                              image: NetworkImage(photoLinksin![index]),
                              fit:BoxFit.contain,

                            )
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                                right: 5,
                                bottom: 5,
                                child: 
                                InkWell(
                                    onTap: () async{
                                      
                                      setState(() {
                                        isLoading = true;
                                      });
                                      
                                      final update_doc = db.collection("products").doc(widget.doc_ic);

                                     await update_doc.update({
                                        "photosLinks":FieldValue.arrayRemove(photoLinksin![index]),
                                      });

                                     await getProductDeatil();

                                      setState(() {
                                        isLoading = false;
                                      });
                                      
                                    },
                                    child: Icon(Icons.delete, color: Colors.grey[700],))),
                          ],
                        ),
                      );

                    }

                ),
              ),


              SizedBox(height: 10,),

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
                  if(result.count <= max_photos){
                    setState(
                            (){

                          photoFiles =result.paths.map((path) => File(path!)).toList() ;
                        }
                    );

                  }
                  else
                  {

                    Toast.show("Maximum photos eceeded".toString(), context,duration:Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);
                  }

                },
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Add new photos\n (optional max ${max_photos})", style:TextStyle(

                        color:Colors.grey[200],
                        fontWeight: FontWeight.w400,
                        fontSize:16
                    )),
                    Icon(Icons.edit_sharp, size: 30, color:Colors.grey[200]),
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
                        fun: (){

                          setState(
                                  (){
                                photoFiles!.remove(photoFiles![index].path);
                              }
                          );

                        },
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

                  else if(_availablility.isEmpty)
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
                  else if(_selectedVal == null)
                  {

                    Toast.show("Select value".toString(), context,duration:Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);

                  }

                  else if(photoFiles == null)
                  {
                    setState(() {
                      isLoading = true;
                    });
                    String groupServiceId = await uploadingItemData();

                    setState(
                            (){
                          isLoading = false;

                        }
                    );

                    print("~~~~~~~~~~~~~~Success in Jesus Name~~~~~~~~~~~~~");
                    Navigator.of(context).push(
                        MaterialPageRoute
                          (builder: (context)=>Product_Information(document_id: widget.doc_ic,))
                    );

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

                    if(fileDownloadUris!.length == 2)
                      {
                        final dataupdate = <String, dynamic>
                        {

                          "photosLinks":FieldValue.arrayUnion(

                            [fileDownloadUris![0], fileDownloadUris![1]],

                          ),
                        };

                        await db.collection("products").doc(widget.doc_ic).update(dataupdate)
                            .then((value) {
                          setState(
                                  (){
                                isLoading = false;

                              }
                          );

                          print("~~~~~~~~~~~~~~Success in Jesus Name~~~~~~~~~~~~~");
                          Navigator.of(context).push(
                              MaterialPageRoute
                                (builder: (context)=>Product_Information(document_id: widget.doc_ic,))
                          );
                        });
                      }

                    else if(fileDownloadUris!.length == 1)
                      {
                        final dataupdate = <String, dynamic>
                        {

                          "photosLinks":FieldValue.arrayUnion(

                            [fileDownloadUris![0]],

                          ),
                        };

                        await db.collection("products").doc(widget.doc_ic).update(dataupdate)
                            .then((value) {
                          setState(
                                  (){
                                isLoading = false;
                              }
                          );

                          print("~~~~~~~~~~~~~~Success in Jesus Name~~~~~~~~~~~~~");
                          Navigator.of(context).push(
                              MaterialPageRoute
                                (builder: (context)=>Product_Information(document_id: widget.doc_ic,))
                          );
                        });
                      }

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
}
