import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/user_entity.dart';

class ProfileSection extends StatelessWidget {
  final UserEntity user;
  final VoidCallback onEdit;

  const ProfileSection({super.key, required this.user, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF29844B), // Gonana Green
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              backgroundImage: user.profilePhoto != null
                  ? NetworkImage(user.profilePhoto!)
                  : null,
              child: user.profilePhoto == null
                  ? const Icon(Icons.person, color: Color(0xFF29844B))
                  : null,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.firstName ?? ''} ${user.lastName ?? ''}',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  user.accountType ?? 'User',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onEdit,
            icon: const Icon(Icons.edit_outlined, color: Color(0xFF29844B)),
          ),
        ],
      ),
    );
  }
}
