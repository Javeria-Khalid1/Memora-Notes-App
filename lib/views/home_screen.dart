 import 'package:flutter/material.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // 🔹 TOP DECORATION (Waves Icon)
            const Positioned(
              top: 20,
              right: 24,
              child: Opacity(
                opacity: 0.3,
                child: Icon(
                  Icons.waves,
                  size: 40,
                  color: Colors.black,
                ),
              ),
            ),

            // 🔹 MAIN CENTER CONTENT
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min, 
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Top Logo Icon
                    const Icon(
                      Icons.grid_view_rounded,
                      size: 35,
                      color: Colors.black,
                    ),
                    
                    const SizedBox(height: 20),

                    // MEMORA - Bold and Spaced
                    const Text(
                      "MEMORA",
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 10,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 5),

                    // Tagline
                    Text(
                      "Keep Your Ideas Alive",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),

                    const SizedBox(height: 50),

                    // Large Center Illustration
                    const Icon(
                      Icons.edit_note_rounded,
                      size: 180,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),

            // 🔹 BOTTOM SECTION (Indicator & Button)
            Positioned(
              bottom: 40,
              left: 30,
              right: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Modern Dot Indicators
                  Row(
                    children: [
                      _buildDot(true),
                      _buildDot(false),
                      _buildDot(false),
                    ],
                  ),

                  // 🔹 UPDATED: Get Started Button (Directly to LoginScreen)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 12,
                      ),
                      elevation: 4,
                    ),
                    child: const Row(
                      children: [
                        Text(
                          "Get Started",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward_ios, size: 14),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for dots
  Widget _buildDot(bool isActive) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: isActive ? 18 : 6,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.black12,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}