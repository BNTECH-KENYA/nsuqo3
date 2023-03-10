import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient{
  final Uri  currencyURL = Uri.https("free.currconv.com", "/api/v7/currencies",{"apiKey":"7a8e1c96393b4f8876bd"});

  Future<List<String>?>  getCurrencies() async {
    try{
      http.Response res = await http.get(currencyURL);
      if(res.statusCode == 200)
      {
        var body = jsonDecode(res.body);
        var list = body["results"];
        List<String> currencies = (list.keys).toList();
        print (currencies);
        return currencies;
      }
      else
      {
        print("error one gettin currencies");
        return null;
      }
    }
    catch (error)
    {
      print("error one gettin currencies" + error.toString());

      return null;
    }


  }

  Future<double> getRate(String from, String to) async
  {
    final Uri rateUrl = Uri.https('free.currconv.com', '/api/v7/convert',
        {
          "apiKey":"7a8e1c96393b4f8876bd",
          "q": "${from}_${to}",
          "compact" : "ultra"
        });
    http.Response res = await http.get(rateUrl);
    if(res.statusCode == 200)
    {
      var body = jsonDecode(res.body);
      return body["${from}_${to}"];
    }

    else
    {
      print("Failed to connect to api");
      throw Exception("Failed to connect to api");
    }
  }

}