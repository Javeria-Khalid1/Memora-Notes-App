 import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'edit_screen.dart'; // EditNoteScreen import karein

class ShowNotesScreen extends StatefulWidget {
  const ShowNotesScreen({super.key});

  @override
  State<ShowNotesScreen> createState() => _ShowNotesScreenState();
}

class _ShowNotesScreenState extends State<ShowNotesScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Notes');

  @override
  Widget build(BuildContext context) {
    final String currentUserId = auth.currentUser!.uid;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("My Notes", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false, // Default back arrow hata diya
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              defaultChild: const Center(child: CircularProgressIndicator(color: Colors.white)),
              itemBuilder: (context, snapshot, animation, index) {
                if (snapshot.child('userId').value.toString() == currentUserId) {
                  final noteText = snapshot.child('noteContent').value.toString();
                  final noteId = snapshot.child('id').value.toString();

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        title: Text(noteText, style: const TextStyle(fontWeight: FontWeight.w500)),
                        subtitle: Text(
                          "Created: ${snapshot.child('createdAt').value.toString().substring(0, 16)}",
                          style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // ✏️ Edit Icon (Nayi screen par le jayega)
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditNoteScreen(
                                      noteId: noteId,
                                      currentNoteText: noteText,
                                    ),
                                  ),
                                );
                              },
                            ),
                            // 🗑️ Delete Icon
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                ref.child(noteId).remove();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          
          // 🔹 Bottom Back Button
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SizedBox(
              width: 150,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Pichli screen par wapis
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Back", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}