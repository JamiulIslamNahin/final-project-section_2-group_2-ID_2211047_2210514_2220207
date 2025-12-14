import 'package:flutter/material.dart';

class LanguageCard extends StatelessWidget {
  final String title;
  final String flag;
  final Color color;
  final VoidCallback onTap;

  const LanguageCard({
    super.key,
    required this.title,
    required this.flag,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -10,
              top: -10,
              child:
              Icon(Icons.message_rounded, color: Colors.white24, size: 60),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(flag, style: const TextStyle(fontSize: 38)),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
