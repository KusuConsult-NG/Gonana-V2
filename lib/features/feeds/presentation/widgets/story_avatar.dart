import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/story_entity.dart';

class StoryAvatar extends StatelessWidget {
  final StoryEntity story;

  const StoryAvatar({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(2), // Space for gradient border
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: story.isViewed
                  ? null
                  : const LinearGradient(
                      colors: [
                        Color(0xFF29844B),
                        Color(0xFFBCE4C4),
                        Color(0xFF00E5FF), // added Cyan for future pop
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              color: story.isViewed ? Colors.grey[300] : null,
              boxShadow: story.isViewed
                  ? null
                  : [
                      BoxShadow(
                        color: const Color(0xFF29844B).withValues(alpha: 0.4),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
            ),
            child: Container(
              padding: const EdgeInsets.all(3), // Increased gap slightly
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(story.ownerPhoto),
              ),
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 70,
            child: Text(
              story.ownerName,
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
