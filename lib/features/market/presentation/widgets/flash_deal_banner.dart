import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Flash deal banner with countdown timer
class FlashDealBanner extends StatefulWidget {
  final String title;
  final String subtitle;
  final DateTime endTime;
  final VoidCallback? onTap;

  const FlashDealBanner({
    super.key,
    this.title = '⚡ Flash Deals',
    this.subtitle = 'Limited time offers',
    required this.endTime,
    this.onTap,
  });

  @override
  State<FlashDealBanner> createState() => _FlashDealBannerState();
}

class _FlashDealBannerState extends State<FlashDealBanner> {
  late Timer _timer;
  Duration _remainingTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _updateRemainingTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateRemainingTime();
    });
  }

  void _updateRemainingTime() {
    setState(() {
      _remainingTime = widget.endTime.difference(DateTime.now());
      if (_remainingTime.isNegative) {
        _remainingTime = Duration.zero;
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xffFF6B6B), Color(0xffFF8E53)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xffFF6B6B).withValues(alpha: 0.3),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildCountdown(),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white.withValues(alpha: 0.8),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCountdown() {
    final hours = _remainingTime.inHours;
    final minutes = _remainingTime.inMinutes.remainder(60);
    final seconds = _remainingTime.inSeconds.remainder(60);

    return Row(
      children: [
        _buildTimeBox(hours.toString().padLeft(2, '0')),
        Text(
          ' : ',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        _buildTimeBox(minutes.toString().padLeft(2, '0')),
        Text(
          ' : ',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        _buildTimeBox(seconds.toString().padLeft(2, '0')),
      ],
    );
  }

  Widget _buildTimeBox(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        value,
        style: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}
