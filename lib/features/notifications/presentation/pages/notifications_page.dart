import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../config/injection.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../domain/entities/notification_entity.dart';
import '../bloc/notification_bloc.dart';
import '../widgets/notification_card.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<NotificationBloc>()
            ..add(const NotificationEvent.loadNotifications()),
      child: const _NotificationsView(),
    );
  }
}

class _NotificationsView extends StatefulWidget {
  const _NotificationsView();

  @override
  State<_NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<_NotificationsView> {
  NotificationType? _selectedFilter;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xff111827)
          : const Color(0xfff3f4f6),
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        backgroundColor: isDark ? const Color(0xff1f2937) : Colors.white,
        elevation: 0,
        actions: [
          // Mark all as read button
          TextButton(
            onPressed: () {
              // Mark all as read logic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All notifications marked as read'),
                ),
              );
            },
            child: Text(
              'Mark all read',
              style: GoogleFonts.inter(
                color: const Color(0xff22c55e),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter chips
          Container(
            padding: const EdgeInsets.all(16),
            color: isDark ? const Color(0xff1f2937) : Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _FilterChip(
                    label: 'All',
                    isSelected: _selectedFilter == null,
                    onTap: () => setState(() => _selectedFilter = null),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Orders',
                    isSelected: _selectedFilter == NotificationType.order,
                    onTap: () => setState(
                      () => _selectedFilter = NotificationType.order,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Wallet',
                    isSelected: _selectedFilter == NotificationType.wallet,
                    onTap: () => setState(
                      () => _selectedFilter = NotificationType.wallet,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Feed',
                    isSelected: _selectedFilter == NotificationType.feed,
                    onTap: () =>
                        setState(() => _selectedFilter = NotificationType.feed),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'System',
                    isSelected: _selectedFilter == NotificationType.system,
                    onTap: () => setState(
                      () => _selectedFilter = NotificationType.system,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Notifications list
          Expanded(
            child: BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox.shrink(),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (message) => Center(
                    child: EmptyState(
                      icon: Icons.error_outline,
                      title: 'Oops!',
                      message: message,
                      actionLabel: 'Retry',
                      onActionPressed: () {
                        context.read<NotificationBloc>().add(
                          const NotificationEvent.loadNotifications(),
                        );
                      },
                    ),
                  ),
                  loaded: (notifications) {
                    // Filter notifications
                    final filtered = _selectedFilter == null
                        ? notifications
                        : notifications
                              .where((n) => n.type == _selectedFilter)
                              .toList();

                    if (filtered.isEmpty) {
                      return EmptyState(
                        icon: Icons.notifications_none,
                        title: _selectedFilter == null
                            ? 'No notifications yet'
                            : 'No ${_selectedFilter?.name} notifications',
                        message:
                            'When you get notifications, they\'ll show up here.',
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<NotificationBloc>().add(
                          const NotificationEvent.loadNotifications(),
                        );
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: _buildSectionedList(filtered).length,
                        itemBuilder: (context, index) {
                          final item = _buildSectionedList(filtered)[index];

                          // Section header
                          if (item is String) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                              child: Text(
                                item,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: isDark
                                      ? const Color(0xff9ca3af)
                                      : const Color(0xff6b7280),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            );
                          }

                          // Notification card
                          final notification = item as NotificationEntity;
                          return NotificationCard(
                            notification: notification,
                            onTap: () {
                              // Handle notification tap (e.g., deep link)
                              if (notification.actionUrl != null) {
                                // Navigate to action URL
                              }
                            },
                            onMarkAsRead: () {
                              // Mark as read logic
                            },
                            onDelete: () {
                              // Delete logic
                            },
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Build sectioned list with "NEW" and "EARLIER" headers
  List<dynamic> _buildSectionedList(List<NotificationEntity> notifications) {
    final now = DateTime.now();
    final List<dynamic> sectioned = [];

    // Separate into new (last 24h) and earlier
    final newNotifications = notifications
        .where((n) => now.difference(n.timestamp).inHours < 24)
        .toList();
    final earlierNotifications = notifications
        .where((n) => now.difference(n.timestamp).inHours >= 24)
        .toList();

    // Add "NEW" section
    if (newNotifications.isNotEmpty) {
      sectioned.add('NEW');
      sectioned.addAll(newNotifications);
    }

    // Add "EARLIER" section
    if (earlierNotifications.isNotEmpty) {
      sectioned.add('EARLIER');
      sectioned.addAll(earlierNotifications);
    }

    return sectioned;
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xff22c55e)
              : (isDark ? const Color(0xff374151) : const Color(0xffe5e7eb)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected
                ? Colors.white
                : (isDark ? Colors.white70 : Colors.black87),
          ),
        ),
      ),
    );
  }
}
