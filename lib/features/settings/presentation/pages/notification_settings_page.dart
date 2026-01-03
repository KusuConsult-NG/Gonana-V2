import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/scaffold_with_background.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _smsNotifications = false;
  bool _orderUpdates = true;
  bool _promoOffers = true;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Notification Settings',
          style: GoogleFonts.montserrat(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black87,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: const BackButton(),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black.withValues(alpha: 0.2)
            : Colors.white.withValues(alpha: 0.1),
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
          ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildSectionHeader(context, 'General'),
            const SizedBox(height: 8),
            _buildToggleTile(
              context,
              'Push Notifications',
              'Receive notifications on your device',
              _pushNotifications,
              (val) => setState(() => _pushNotifications = val),
            ),
            const SizedBox(height: 12),
            _buildToggleTile(
              context,
              'Email Notifications',
              'Receive updates via email',
              _emailNotifications,
              (val) => setState(() => _emailNotifications = val),
            ),
            const SizedBox(height: 12),
            _buildToggleTile(
              context,
              'SMS Notifications',
              'Receive updates via SMS',
              _smsNotifications,
              (val) => setState(() => _smsNotifications = val),
            ),
            const SizedBox(height: 24),
            _buildSectionHeader(context, 'Preferences'),
            const SizedBox(height: 8),
            _buildToggleTile(
              context,
              'Order Updates',
              'Get notified about your order status',
              _orderUpdates,
              (val) => setState(() => _orderUpdates = val),
            ),
            const SizedBox(height: 12),
            _buildToggleTile(
              context,
              'Promotional Offers',
              'Get notified about hot deals and promos',
              _promoOffers,
              (val) => setState(() => _promoOffers = val),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: GoogleFonts.montserrat(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black87,
      ),
    );
  }

  Widget _buildToggleTile(
    BuildContext context,
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return GlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      opacity: 0.6,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      child: SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[400]
                : Colors.grey[700],
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeThumbColor: Colors.green, // AppTheme.primaryColor
      ),
    );
  }
}
