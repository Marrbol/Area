import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_app/variable.dart';

Future<void> postDataToServer() async {
  /*final response = await http.post(
    Uri.parse("http://10.19.254.241:3000/create_action"),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(<String, dynamic>{
      'service_Name': 'Spotify',
      'action_Name': AllVariables.action,
      'reaction_Name': AllVariables.reaction,
      'action_Param': AllVariables.actionDescription,
      'reaction_Param': AllVariables.reactionDescription,
      'access_token': AllVariables.accessTokenSpotify,
      'user_id': '1234567',
    }),
  );

  if (response.statusCode == 200) {
    print('POST request successful');
  } else {
    print('POST request failed with status: ${response.statusCode}');
  }*/

  final res = await http.post(
    Uri.parse("http://10.19.254.241:3000/create_action"),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8'
    },
      body: jsonEncode(<String, dynamic>{
      'action_service_Name': AllVariables.nameServiceAction,
      'reaction_service_Name': AllVariables.nameServiceReaction,
      'action_Name': AllVariables.action,
      'reaction_Name': AllVariables.reaction,
      'action_Param': AllVariables.controllersAction,
      'reaction_Param': AllVariables.controllersReaction,
      'action_access_token': AllVariables.accessToken[AllVariables.nameServiceAction],
      'reaction_access_token': AllVariables.accessToken[AllVariables.nameServiceReaction],
      'user_id': 'Salut je suis l\'user is totalement useless',
      }),
  );
  if (res.statusCode == 200) {
    print('POST request successful');
  } else {
    print('POST request failed with status: ${res.statusCode}');
  }
}