import 'package:flutter/material.dart';
import 'package:letter/create_screen.dart';

import 'package:letter/db.dart';
import 'package:letter/styedButton.dart';
import 'package:letter/theme.dart';
import 'textStyle.dart';
import 'note_edie.dart';

class HomeScreen extends StatefulWidget {
  final currentProfileId;
  const HomeScreen({super.key, this.currentProfileId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isloading = true;

  Db sqlDB = Db();
  List profiles = [];
  List Notes = [];
  int? currentProfileId;

  Future profileNotes() async {
    List<Map> response = await sqlDB.read("PROFILE");

    if (response.isNotEmpty) {
      profiles = response;
      currentProfileId = profiles.first["profileid"];
      await readData();
    }
    setState(() {
      isloading = false;
    });
  }

  Future readData() async {
    List<Map> response = await sqlDB.getNotesProfile(
      "NOTES",
      "profileid=$currentProfileId",
    );

    print(Notes);

    if (mounted) {
      setState(() {
        Notes = response;
        isloading = false;
      });
    }
  }

  @override
  void initState() {
    profileNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Styletitle('Notes'),
        actions: [
          if (profiles.isNotEmpty)
            DropdownButton<int>(
              value: currentProfileId,
              dropdownColor: AppColors.secndryColor,
              underline: SizedBox(),
              icon: Icon(Icons.account_circle_rounded),
              items: profiles.map((p) {
                return DropdownMenuItem<int>(
                  value: p['profileid'],
                  child: Text(
                    p['profilename'],
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: (newProfileId) async {
                if (newProfileId != null && newProfileId != currentProfileId) {
                  setState(() {
                    currentProfileId = newProfileId;
                    isloading = true;
                  });
                  await readData();
                }
              },
            ),
          const SizedBox(width: 15),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {

if(currentProfileId==null){
  ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Create profile first"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
}

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Create(profileId: currentProfileId!),
            ),
          );
          readData();
        },
        child: Icon(Icons.add),
      ),

      body: isloading
          ? const Center(child: CircularProgressIndicator())
          : Notes.isEmpty
          ? const Center(child: Text('No notes'))
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      ListView.builder(
                        itemCount: Notes.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Card(
                            color: AppColors.primaryAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text("${Notes[index]['title']}"),
                                subtitle: Text("${Notes[index]['content']}"),
                                trailing: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => noteedie(
                                              note: Notes[index]['content'],
                                              color: Notes[index]['color'],
                                              title: Notes[index]['title'],
                                              id: Notes[index]['id'],
                                              
                                            ),
                                          ),
                                        );
                                        await readData();
                                      },
                                      icon: Icon(Icons.edit),
                                    ),

                                    IconButton(
                                      onPressed: () async {
                                        await showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return AlertDialog(
                                              title: Styleheading("Delete"),
                                              content: const Stylebody(
                                                "Do you want to delete this note",
                                              ),
                                              actions: [
                                                Row(
                                                  children: [
                                                    StyledButton(
                                                      onPressed: () async {
                                                        int response =
                                                            await sqlDB.delete(
                                                              "NOTES",
                                                              "id=${Notes[index]['id']}",
                                                            );
                                                        if (response > 0) {
                                                          Notes.removeWhere(
                                                            (element) =>
                                                                element['id'] ==
                                                                Notes[index]['id'],
                                                          );
                                                          await readData();
                                                        }
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("Delete"),
                                                    ),

                                                    StyledButton(
                                                      onPressed: () {
                                                        Navigator.pop(ctx);
                                                      },
                                                      child: Text("cancel"),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
