import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_app/variable.dart';
import 'dart:math';
import 'package:crypto/crypto.dart';

const String discordClientId = '1156974898644795393';
const String discordClientSecret = 'X8IKJ1RTnh-QUyfFTTh6N5d1lZoUuSGD';
String redirectUri = 'mobile://oauth2-callback';
String customUriScheme = 'mobile';
String codeVerifier = '';
String codeChallenge = '';

void discordAuthentication() {
    codeVerifier = generateCodeVerifier();
    codeChallenge = generateCodeChallenge(codeVerifier);

    discordAuthentication2();
}

String generateCodeVerifier() {
    const String charset =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~';
    return List.generate(
        128, (i) => charset[Random.secure().nextInt(charset.length)]).join();
}

String generateCodeChallenge(String codeVerifier) {
    var bytes = utf8.encode(codeVerifier);
    var digest = sha256.convert(bytes);
    String codeChallenge = base64Url
        .encode(digest.bytes)
        .replaceAll("=", "")
        .replaceAll("+", "-")
        .replaceAll("/", "_");
    return codeChallenge;
}

void discordAuthentication2() async {
    if (AllVariables.accessToken["Discord"] != '') {
      return;
    }
    final url = Uri.https('discord.com', '/api/oauth2/authorize', {
        'response_type': 'code',
        'client_id': discordClientId,
        'redirect_uri': redirectUri,
        'scope': 'identify',
        'code_challenge': codeChallenge,
        'code_challenge_method': 'S256',
    });

    try {
        final result = await FlutterWebAuth.authenticate(
            url: url.toString(), callbackUrlScheme: customUriScheme);

        final code = Uri.parse(result).queryParameters['code'];
        final url2 = Uri.https('discord.com', '/api/oauth2/token');
        final response = await http.post(
            url2,
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: {
                "grant_type": "authorization_code",
                "code": code,
                "redirect_uri": redirectUri,
                "client_id": discordClientId,
                "client_secret": discordClientSecret,
                "code_verifier": codeVerifier,
            },
        );

        if (response.statusCode == 200) {
            var jsonResponse = json.decode(response.body) as Map<String, dynamic>;
            AllVariables.accessToken["Discord"] = jsonResponse["access_token"];
            print("Discord access token: ${jsonResponse['access_token']}");
        } else {
            print('Error: ${response.statusCode}');
            print(response.body);
        }
    } catch (e) {
        print('Error: $e');
    }
}