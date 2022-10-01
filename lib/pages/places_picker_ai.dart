import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../helpers/autocomplete_result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Places_Search extends StatefulWidget {
  const Places_Search({Key? key}) : super(key: key);

  @override
  State<Places_Search> createState() => _Places_SearchState();
}

class _Places_SearchState extends State<Places_Search> {


  List<AutoCompleteResult> search_results = [];

  final String key = 'AIzaSyCAawMnC6vfUa40ZNFsLN-ov7Pa4DjcUrM';
  final String types = 'geocode';

  Future searchPlaces(String searchInput) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchInput&types=$types&key=$key';

    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);

    var results = json['predictions'] as List;

    setState(
        (){
          search_results = results.map((e) => AutoCompleteResult.fromJson(e)).toList();
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left:16.0, right:16.0, top:16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.grey[500]!
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0,top: 4.0, bottom: 4),
                    child: TextField(
                      onChanged: (val) async {

                       if(val.length>0)
                         {

                                searchPlaces(val);
                         }
                       else{
                         setState(
                             (){
                               search_results = [];
                             }
                         );
                       }
                      },

                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_on_outlined),
                        suffixIcon: Icon(Icons.search),
                          hintText: 'Search Your Location ...',

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

                SizedBox(height:20),

                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height-(255+116),
                  child: ListView.builder(
                    itemCount: search_results.length,
                    itemBuilder: (context, index){
                      return InkWell(
                        onTap:(){

                          Navigator.pop(context,search_results[index].description );


                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Card(
                            child: ListTile(
                              leading: Icon(Icons.location_on, color:Colors.grey[800]),
                              title: Text("${search_results[index].description}"),
                            ),
                          ),
                        ),
                      );
                    }
                  ),
                )
              ],
            ),
          )),

    );
  }
}
