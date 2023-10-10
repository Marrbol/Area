import 'package:flutter/material.dart';
import 'package:mobile_app/pages/if_this_page.dart';
import 'package:mobile_app/pages/then_that_page.dart';
import 'package:mobile_app/variable.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  String whatPrintIf = "";
  String whatPrintThen = "";
  @override
  Widget build(BuildContext context) {
    if (AllVariables.Action == "") {
      whatPrintIf = "This";
    } else {
      whatPrintIf = AllVariables.Action;
    }
    if (AllVariables.reaction == "") {
      whatPrintThen = "That";
    } else {
      whatPrintThen = AllVariables.reaction;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Task"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 80),
            Flexible(
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(20)),
                    backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(117, 189, 255, 1)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const IfThisPage()),
                    );
                  },
                  child: Text("If $whatPrintIf",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 255, 255, 255)
                    )
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Flexible(
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(20)),
                    backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(117, 189, 255, 1)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ThenThatPage()),
                    );
                  },
                  child: Text("Then $whatPrintThen",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 255, 255, 255)
                    )
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                print(AllVariables.spotifyCreatePlaylistReactionName.text + " " + AllVariables.spotifyCreatePlaylistReactionDescription.text + " " + AllVariables.spotifyCreatePlaylistReactionPrivate.text);
              },
              child: const Text("Back"),
            )
          ],
        ),
      ),
    );
  }
}