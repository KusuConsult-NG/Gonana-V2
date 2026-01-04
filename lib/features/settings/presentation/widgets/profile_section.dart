import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/user_entity.dart';

class ProfileSection extends StatelessWidget {
  final UserEntity user;
  final VoidCallback onEdit;

  const ProfileSection({super.key, required this.user, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xff1f2937) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? const Color(0xff374151) : const Color(0xffe5e7eb),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Larger Avatar with gradient border
          Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xff22c55e), Color(0xff16a34a)],
              ),
            ),
            child: CircleAvatar(
              radius: 40,
              backgroundColor: isDark ? const Color(0xff1f2937) : Colors.white,
              backgroundImage: user.profilePhoto != null
                  ? NetworkImage(user.profilePhoto!)
                  : null,
              child: user.profilePhoto == null
                  ? const Icon(Icons.person, color: Color(0xff22c55e), size: 40)
                  : null,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.firstName ?? ''} ${user.lastName ?? ''}',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user.email ?? '',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: isDark
                        ? const Color(0xff9ca3af)
                        : const Color(0xff6b7280),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xff22c55e).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    user.accountType ?? 'User',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff22c55e),
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onEdit,
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xff22c55e).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.edit_outlined,
                color: Color(0xff22c55e),
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
