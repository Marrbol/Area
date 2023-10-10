import 'package:flutter/material.dart';
import 'package:mobile_app/pages/create_task_page.dart';
import 'package:mobile_app/variable.dart';

class AddItemToPlaylist extends StatefulWidget {
  const AddItemToPlaylist({super.key});

  @override
  State<AddItemToPlaylist> createState() => _AddItemToPlaylistState();
}

class _AddItemToPlaylistState extends State<AddItemToPlaylist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add item to playlist"),
      ),
      body: Center(
        child:
          Column(
            children: [
              const SizedBox(height: 200),
              TextField(
                controller: AllVariables.spotifyAddItemToPlaylistReactionName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CreateTaskPage()));
                },
                child: const Text("confirm"),
              ),
            ],
          ),
      ),
      backgroundColor: const Color.fromRGBO(30, 215, 96, 1),
    );
  }
}