import 'package:flutter/material.dart';
import 'package:mobile_app/pages/reaction_pages/spotify/add_item_to_playlist.dart';
import 'package:mobile_app/pages/reaction_pages/spotify/create_playlist_page.dart';
import 'package:mobile_app/variable.dart';

class SpotifyReactionPage extends StatefulWidget {
  const SpotifyReactionPage({super.key});

  @override
  State<SpotifyReactionPage> createState() => _SpotifyReactionPageState();
}

const double spaceBetweenButton = 30;
const double heightButton = 45;
const double widthButton = 220;
const String spotifyReaction1 = "Add Items To Playlist";
class _SpotifyReactionPageState extends State<SpotifyReactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Spotify Reaction Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                width: 350,
                height: 250,
                color: const Color.fromRGBO(30, 215, 96, 1),
                child: const Center(
                  child: Text("Spotify Reaction Page",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100),
            SizedBox(
              width: widthButton,
              height: heightButton,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(117, 189, 255, 1)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddItemToPlaylist()),
                  );
                  AllVariables.reaction = "add_items_to_playlist";
                  AllVariables.reactionPrint = "ajoute un item à une playlist";
                },
                child: const Text(spotifyReaction1)
              ),
            ),
            const SizedBox(height: spaceBetweenButton),
            SizedBox(
              width: widthButton,
              height: heightButton,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(117, 189, 255, 1)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CreatePlayListPage()),
                  );
                  AllVariables.reaction = "createPlaylist";
                  AllVariables.reactionPrint = "créer une playlist";
                },
                child: const Text(AllVariables.spotifyReaction2)
              ),
            ),
            const SizedBox(height: spaceBetweenButton),
            SizedBox(
              width: widthButton,
              height: heightButton,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(117, 189, 255, 1)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SpotifyReactionPage()),
                  );
                },
                child: const Text("test")
              ),
            ),
            const SizedBox(height: spaceBetweenButton),
            SizedBox(
              width: widthButton,
              height: heightButton,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(117, 189, 255, 1)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SpotifyReactionPage()),
                  );
                },
                child: const Text("test")
              ),
            )
          ],
        ),
      )
    );
  }
}