import 'Data.dart';
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

Future<List<Details>> fetch(String base )async{
  var jsonResponse = <String,dynamic>{};
  // Await the http get response, then decode the json-formatted response.
  try {
    var response = await http.get(Uri.parse(base));
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body) as Map<String, dynamic>;
    }
    else {
      developer.log('Request failed with status: ${response.statusCode}.');
    }
  }
  catch(e){
    developer.log(e.toString());
    jsonResponse = {"data":["nothing"]};
  }
  List data = jsonResponse["data"];
  List<Details> details = [];
  int i = 0;
  try {
    for (i = 0; i < data.length; i++) {
      details.add(Details(
        avatar: data[i]["avatar"],
        email: data[i]["email"],
        first_name: data[i]["first_name"],
        id: data[i]["id"].toString(),
        last_name: data[i]["last_name"],
      ));
    }
  }catch(e){
    developer.log(e.toString());
  }
  return details;
}

Future send(String password,String email,String uri)async{
  // String last_name = name.substring(name.indexOf(" ")).trim();
  // String first_name = name.replaceAll(" "+last_name, "").trim();
  var jsonMap = {
    'email': "eve.holt@reqres.in",
    'password': "cityslicka",
  };

  //String jsonStr = jsonEncode(jsonMap);
  print(jsonMap);
  var result = await http.post( Uri.parse(uri) , body: jsonMap);
  print(result.statusCode);
  print(result.body);

  return json.decode(result.body) as Map<String, dynamic>;
}