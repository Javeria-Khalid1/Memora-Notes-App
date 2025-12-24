  import 'package:flutter/material.dart';

import 'login_screen.dart';

import 'addnotes_screen.dart';

import 'shownotes_screen.dart';



class CreateNotesScreen extends StatelessWidget {

  const CreateNotesScreen({super.key});



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      body: SafeArea(

        child: Padding(

          padding: const EdgeInsets.symmetric(horizontal: 30),

          child: Column(

            children: [

              const SizedBox(height: 60),



              // 🔹 App Name

              const Text(

                "Memora",

                style: TextStyle(

                  fontSize: 28,

                  fontWeight: FontWeight.bold,

                ),

              ),



              const SizedBox(height: 50),



              // 🔹 Notes Icon

              const Icon(

                Icons.description_outlined,

                size: 110,

                color: Colors.black,

              ),



              const SizedBox(height: 60),



              // 🔹 Create New Notes Button

              SizedBox(

                width: double.infinity,

                height: 48,

                child: ElevatedButton(

                  onPressed: () {

                    // Navigate to AddNotesScreen

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (context) => const AddNotesScreen(),

                      ),

                    );

                  },

                  style: ElevatedButton.styleFrom(

                    backgroundColor: Colors.black,

                    shape: RoundedRectangleBorder(

                      borderRadius: BorderRadius.circular(12),

                    ),

                  ),

                  child: const Text(

                    "Create New Notes",

                    style: TextStyle(

                      color: Colors.white,

                      fontSize: 16,

                    ),

                  ),

                ),

              ),



              const SizedBox(height: 22),



              // 🔹 Show All Notes Button

              SizedBox(

                width: double.infinity,

                height: 48,

                child: ElevatedButton(

                  onPressed: () {

                    // Navigate to ShowNotesScreen

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (context) => const ShowNotesScreen(),

                      ),

                    );

                  },

                  style: ElevatedButton.styleFrom(

                    backgroundColor: Colors.black,

                    shape: RoundedRectangleBorder(

                      borderRadius: BorderRadius.circular(12),

                    ),

                  ),

                  child: const Text(

                    "Show All Notes",

                    style: TextStyle(

                      color: Colors.white,

                      fontSize: 16,

                    ),

                  ),

                ),

              ),



              const Spacer(),



              // 🔹 Back Button (Goes back to Login)

              Padding(

                padding: const EdgeInsets.only(bottom: 30),

                child: SizedBox(

                  width: 160,

                  height: 42,

                  child: ElevatedButton(

                    onPressed: () {

                      Navigator.pushReplacement(

                        context,

                        MaterialPageRoute(

                          builder: (context) => const LoginScreen(),

                        ),

                      );

                    },

                    style: ElevatedButton.styleFrom(

                      backgroundColor: Colors.black,

                      shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(12),

                      ),

                    ),

                    child: const Text(

                      "Back",

                      style: TextStyle(

                        color: Colors.white,

                        fontSize: 15,

                      ),

                    ),

                  ),

                ),

              ),

            ],

          ),

        ),

      ),

    );

  }

} 