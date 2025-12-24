import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class EditNoteScreen extends StatefulWidget {
  final String noteId;
  final String currentNoteText;

  const EditNoteScreen({
    super.key,
    required this.noteId,
    required this.currentNoteText,
  });

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late TextEditingController editController;
  final ref = FirebaseDatabase.instance.ref('Notes');
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Purana note text pehle se field mein show hoga
    editController = TextEditingController(text: widget.currentNoteText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Image ke mutabiq black background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            children: [
              // Safaid Container (Edit Area)
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    controller: editController,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: "Edit Your Note...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // 🔹 Update Button
              SizedBox(
                width: 150,
                height: 45,
                child: ElevatedButton(
                  onPressed: isLoading ? null : () {
                    setState(() => isLoading = true);
                    ref.child(widget.noteId).update({
                      'noteContent': editController.text,
                    }).then((value) {
                      setState(() => isLoading = false);
                      Navigator.pop(context); // Update ke baad wapis list par
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: isLoading 
                    ? const CircularProgressIndicator(color: Colors.black)
                    : const Text("Update", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),

              const SizedBox(height: 15),

              // 🔹 Back Button
              SizedBox(
                width: 150,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Wapis ShowNotesScreen par
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
            ],
          ),
        ),
      ),
    );
  }
}