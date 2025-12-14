import 'package:flutter/material.dart';
import '../widgets/language_card.dart';
import 'chat_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // FIXED: typed map → prevents all errors
    final List<Map<String, dynamic>> languages = [
      {"name": "Spanish", "flag": "🇪🇸", "color": Colors.red},
      {"name": "French", "flag": "🇫🇷", "color": Colors.blue},
      {"name": "Japanese", "flag": "🇯🇵", "color": Colors.pink},
      {"name": "German", "flag": "🇩🇪", "color": Colors.orange},
      {"name": "Mandarin Chinese", "flag": "🇨🇳", "color": Colors.green},
      {"name": "Korean", "flag": "🇰🇷", "color": Colors.purple},
      {"name": "English", "flag": "🇬🇧", "color": Colors.indigo},
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Icon(Icons.language, size: 80, color: Colors.blue),
              const SizedBox(height: 10),

              const Text(
                "Gemini Language Tutor",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 4),
              const Text(
                "Select a language and start your conversation.",
                style: TextStyle(fontSize: 15, color: Colors.black54),
              ),

              const SizedBox(height: 30),

              Expanded(
                child: GridView.builder(
                  itemCount: languages.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, index) {
                    final lang = languages[index];

                    return LanguageCard(
                      title: lang["name"],
                      flag: lang["flag"],
                      color: lang["color"],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ChatScreen(language: lang["name"]),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Text(
                  "Powered by Gemini AI",
                  style: TextStyle(color: Colors.black38),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
