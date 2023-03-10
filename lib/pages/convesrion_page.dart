/*


import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {

  final url = "https://secure.3gdirectpay.com/API/v6/";
  List<String> currencies= [];
  List<String> currencies1= ["USD"];
  String from= "KES";
  String to = "USD";

  double rate = 0.0 ;
  double result = 0.0;
  var amounttoconvert;
  bool isLoading = true;

  TextEditingController _amounttoconvert = new TextEditingController();
  //ApiClient client = ApiClient();

  Future <bool> getInternetConn() async
  {
    try{
      final result = await InternetAddress.lookup("google.com");
      if(result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        print("there");
        return true;
      }
      else return false;
    } on SocketException catch(error){
      print(error.message);
      return false;
    }
  }

  Future getPaymentAmount() async{

    print("waiting");

    await FirebaseFirestore.instance
        .collection('others')
        .doc("docOthers")
        .get()
        .then((res) =>
        setState(() {
          _amounttoconvert.text =res.data()!['amountpaid'];
          amounttoconvert =res.data()!['amountpaid'];
          print(_amounttoconvert.text.toString());

        })
        ,
        onError: (e) => print("Error completing: $e")
    );
    print("done");

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    (() async {
      bool internet = await getInternetConn();

      if(internet)
      {
        await getPaymentAmount();
        List<String>? list = await client.getCurrencies();
        setState(() {
          currencies = list!;
          isLoading = false;
        });
      }
      else
      {
        print( "no connection");
      }

    })();
  }
  @override
  Widget build(BuildContext context) {
    context.watch<LanguageController>();

    if(isLoading){
      return Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [Theme.of(context).accentColor, Theme.of(context).primaryColor],
            begin: const FractionalOffset(0, 0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              SpinKitSpinningLines(
                color: Colors.white,
                size: 100.0,
              ),
              SizedBox(height: 20),

              Text(
                "loading_data".tr().toString(),
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  fontSize: 20,
                ),

              ),
            ],
          ),
        )
        ,
      );
    }
    else {
      return Scaffold(

        backgroundColor: Color(0xff010928),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 18.0),

                child: Column(

                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 200.0,
                        child: Text("payment_activity".tr().toString(), style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                        ),),

                      ),
                      SizedBox(height: 20),
                      Text(

                        'Convert_currency'.tr().toString(),
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),

                      ),

                      SizedBox(height: 20),
                      Container(
                        child: Center(
                          child: Column(
                            children: [
                              TextField(
                                controller: _amounttoconvert,
                                enableInteractiveSelection: false,
                                onSubmitted: (value) async {

                                  print(value);
                                  amounttoconvert = value;

                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelText: 'amount_to_pay'.tr().toString(),
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18.0,
                                      color: Colors.blue[900],
                                    )
                                ),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(height: 50.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  customDropDrown(currencies1, from, (val) {
                                    setState(() {
                                      from = val;
                                    });
                                  }),
                                  FloatingActionButton(
                                    onPressed: () {

                                    },
                                    child: Icon(Icons.arrow_forward),
                                    elevation: 0.0,
                                    backgroundColor: Colors.blue[900],
                                  ),
                                  customDropDrown(currencies, to, (val) {
                                    setState(() {
                                      to = val;
                                    });
                                  }),
                                ],
                              ),
                              SizedBox(height: 20.0),

                              ElevatedButton(
                                onPressed: () async
                                {
                                  if (_amounttoconvert.text != null &&
                                      _amounttoconvert.text.trim() != "") {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    rate = await client.getRate(from, to);
                                    setState(() {
                                      result =
                                          double.parse((rate * (double.parse(
                                              amounttoconvert.toString()
                                          ))).toStringAsFixed(3));
                                      isLoading = false;
                                    });
                                  }
                                },
                                child: Text('convert'.tr().toString(),
                                    style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18,
                                    )
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Column(
                                      children: [
                                        Text('result'.tr().toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                        Text(result.toString(),
                                            style: TextStyle(
                                              color: Colors.blue[900],
                                              fontSize: 36.0,
                                              fontWeight: FontWeight.bold,

                                            )),
                                      ]
                                  )
                              ),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),

                      Padding(
                        padding: const EdgeInsets.only(left: 90.0),
                        child: new GestureDetector(
                          onTap: () async
                          {
                            setState(() {
                              isLoading = true;
                            });
                            final response = await post(Uri.parse(url),
                                body: "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n" +
                                    "<API3G>\n" +
                                    "<CompanyToken>50EC6AD4-1257-452E-8F35-B27EDA0CB14C</CompanyToken>\n" +
                                    "<Request>createToken</Request>\n" +
                                    "<Transaction>\n" +
                                    "<PaymentAmount>0.50</PaymentAmount>\n" +
                                    "<PaymentCurrency>USD</PaymentCurrency>\n" +
                                    "<CompanyRef>KDIEOM</CompanyRef>\n" +
                                    "<RedirectURL>https://tbldc.org/appadmindvxb/transactiondisplay/transactiondisp.html</RedirectURL>\n" +
                                    "<BackURL>https://tbldc.org/appadmindvxb/transactiondisplay/transactiondisp.html</BackURL>\n" +
                                    "<CompanyRefUnique>0</CompanyRefUnique>\n" +
                                    "<PTL>5</PTL>\n" +
                                    "</Transaction>\n" +
                                    "<Services>\n" +
                                    "  <Service>\n" +
                                    "<ServiceType>48565</ServiceType>\n" +
                                    "    <ServiceDescription>flight to diani</ServiceDescription>\n" +
                                    "    <ServiceDate>2022/12/20 19:00</ServiceDate>\n" +
                                    "  </Service>\n" +
                                    "</Services>\n" +
                                    "</API3G>"
                            );
                            setState(() {
                              isLoading = false;
                            });
                            String xml = response.body; //Populated XML String....

                            var parts = xml.split ( "<TransToken>" );
                            var parts2 = parts[1].split ( "</TransToken>" );

                            String transtoken = parts2[0];
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                                DpoPage(transtokencc: transtoken)));
                            print(response.body);
                          },

                          child: Card(
                            color: Colors.white,
                            child: Column(

                              children: [
                                Image.asset(
                                  "assets/images/Screenshot/dpo.png",
                                  height: 70,
                                  width: 100,
                                ),
                                Text(
                                  'pay_now'.tr().toString(),
                                  style: GoogleFonts.lato(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ]
                )
            ),
          ),
        ),

      );
    }
  }
}


 */