import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:mobile_app/variable.dart';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:mobile_app/pages/action_pages/discord/discord_action_page.dart';

class DiscordAuthenticationPage extends StatefulWidget {
    @override
    _DiscordAuthenticationPageState createState() =>
        _DiscordAuthenticationPageState();
}

class _DiscordAuthenticationPageState extends State<DiscordAuthenticationPage> {
    final String discordClientId = '1156974898644795393';
    final String discordClientSecret = 'X8IKJ1RTnh-QUyfFTTh6N5d1lZoUuSGD';
    final String redirectUri = 'mobile://oauth2-callback';
    final String customUriScheme = 'mobile';
    late String codeVerifier;
    late String codeChallenge;

    @override
    void initState() {
        super.initState();
        codeVerifier = generateCodeVerifier();
        codeChallenge = generateCodeChallenge(codeVerifier);
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

    void discordAuthentication() async {
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
                AllVariables.discordAccessToken = jsonResponse["access_token"];
                print("Discord access token: ${jsonResponse['access_token']}");
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DiscordActionPage()),
                );
            } else {
                print('Error: ${response.statusCode}');
                print(response.body);
            }
        } catch (e) {
            print('Error: $e');
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Discord Authentication'),
            ),
            body: Center(
                child: ElevatedButton(
                    onPressed: discordAuthentication,
                    child: Text('Authenticate with Discord'),
                ),
            ),
        );
    }
}