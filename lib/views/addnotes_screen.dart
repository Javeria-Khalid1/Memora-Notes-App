 import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddNotesScreen extends StatefulWidget {
  const AddNotesScreen({super.key});

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  final TextEditingController noteController = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref('Notes'); 
  bool isLoading = false;

  Future<void> addNote() async {
    String noteText = noteController.text.trim();

    if (noteText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter some text...")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Current User ki ID lena
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      
      // Unique key generate karna
      String noteId = DateTime.now().millisecondsSinceEpoch.toString();

      await databaseRef.child(noteId).set({
        'id': noteId,
        'userId': userId,
        'noteContent': noteText,
        'createdAt': DateTime.now().toString(),
      });

      if (mounted) {
        // Updated Success Message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Note has been saved"),
            backgroundColor: Colors.green, // Success ke liye green color behtar lagta hai
          ),
        );
        noteController.clear();
        Navigator.pop(context); 
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.toString()}")),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, 
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            children: [
              // White Container for writing notes
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    controller: noteController,
                    maxLines: null, 
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    decoration: const InputDecoration(
                      hintText: "Enter Your Note Here",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Add Note Button
              SizedBox(
                width: 150,
                height: 45,
                child: ElevatedButton(
                  onPressed: isLoading ? null : addNote,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Thoda square look jaisa image mein tha
                    ),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
                        )
                      : const Text("Add Note", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),

              const SizedBox(height: 15),

              // Back Button
              SizedBox(
                width: 150,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); 
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Back", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}