import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nsuqo/helpers/storage.dart';
import 'package:nsuqo/pages/home_page_categories_final_Ui.dart';
import 'package:nsuqo/pages/sign_in.dart';
import 'package:workmanager/workmanager.dart';

late FirebaseFirestore db_global;
late storage _storage_global;

@pragma('vm:entry-point')
void callbackDispatcher (){
  Workmanager().executeTask(( taskName, inputData) async {
    await Firebase.initializeApp();
    db_global= FirebaseFirestore.instance;
    _storage_global = storage();
    bool retun_val = false;
    switch (taskName){
      case "chat":
        retun_val= await add_Chat_Data(inputData!);
        break;

    }
    return Future.value(retun_val);

  });
}


Future<bool> add_Chat_Data( post_data)
async {

  final chatdetails = <String, dynamic>{

    "timestamp":FieldValue.serverTimestamp(),
    "wholesaler_id":post_data['wholesaler_id'],
    "groupuid":post_data['groupuid'],
    "sender_email": post_data['sender_email'],
    "wholesaler_name": "Brian",
    "retailer_name": "Jane",
    "company_name":"BNTECH",
    "message":post_data['message'],
    "product_id":post_data['product_id'],
    "product_photo":post_data['product_photo'],
    "product_description":post_data['product_description'],
    "product_price":post_data['product_price'],
    "product_name":post_data['product_name'],


  };

  await db_global.collection("allenquiries").add(chatdetails).then(
          (DocumentReference doc) async {
       // documentid = doc.id;
        update_chat_Stream( post_data );

      }
  );


  return true;
}



Future<void> update_chat_Stream( post_data )
async {

  final stream = <String, dynamic>{

    "ltsmessage":post_data['message'],
    "unrdmessage":FieldValue.increment(1),
    "msgtimestamp":FieldValue.serverTimestamp(),
    "wholesaler_id":post_data['wholesaler_id'],
    "retailer_id":post_data['retailer_id'],
    "sender_email":post_data['sender_email'],

  };

  await db_global.collection("oneChatStream").doc(post_data['groupuid']).update(stream);

}

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Workmanager().initialize(callbackDispatcher);

  runApp(const ProviderScope ( child: MyApp(),));
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch:  Colors.grey,
      ),

      home: const Sign_In(),

    );
  }
}




