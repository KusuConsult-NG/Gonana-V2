import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/kyc_guard.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/scaffold_with_background.dart';
import '../bloc/savings_bloc.dart';
import '../bloc/savings_state.dart';

class SavingsPage extends StatelessWidget {
  const SavingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Savings Assets',
          style: GoogleFonts.inter(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black87,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black87,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<SavingsBloc, SavingsState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => Center(child: Text('Error: $message')),
            loaded: (assets, userSavings) {
              final totalBalance = userSavings.fold<double>(
                0,
                (prev, element) => prev + element.balance,
              );

              return SafeArea(
                child: ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: assets.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return FadeInDown(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: GlassContainer(
                            borderRadius: BorderRadius.circular(20),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(
                                    'Total Savings',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '₦ ${totalBalance.toStringAsFixed(2)}',
                                    style: GoogleFonts.inter(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF29844B),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '+12.5% APY (Avg)',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    final asset = assets[index - 1];
                    // Check if user has this asset
                    final userAssetIndex = userSavings.indexWhere(
                      (s) => s.assetId == asset.id,
                    );
                    final userAsset = userAssetIndex != -1
                        ? userSavings[userAssetIndex]
                        : null;

                    return FadeInUp(
                      delay: Duration(milliseconds: index * 100),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: GestureDetector(
                          onTap: () {
                            context.push(
                              '/savings/detail',
                              extra: {'asset': asset, 'userSavings': userAsset},
                            );
                          },
                          child: GlassContainer(
                            padding: const EdgeInsets.all(16),
                            borderRadius: BorderRadius.circular(16),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.5),
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    asset.icon,
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        asset.name,
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        asset.description,
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      if (userAsset != null)
                                        Text(
                                          'Balance: ₦ ${userAsset.balance.toStringAsFixed(2)}',
                                          style: GoogleFonts.inter(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF29844B),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${asset.apy}%',
                                      style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF29844B),
                                      ),
                                    ),
                                    Text(
                                      'APY',
                                      style: GoogleFonts.inter(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          KycGuard.check(
            context,
            onVerified: () {
              context.push('/savings/create');
            },
          );
        },
        backgroundColor: const Color(0xFF29844B),
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'New Save',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
