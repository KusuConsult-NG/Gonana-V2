import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/services/notification_service.dart';
import 'config/injection.dart';
import 'config/router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'features/market/presentation/bloc/cart_bloc.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';
import 'features/settings/presentation/bloc/settings_event.dart';
import 'features/feeds/presentation/bloc/feed_bloc.dart';
import 'features/feeds/presentation/bloc/feed_event.dart';
import 'features/market/presentation/bloc/market_bloc.dart';
import 'features/chat/presentation/bloc/chat_list_bloc.dart';
import 'features/chat/presentation/bloc/chat_list_event.dart';
import 'features/savings/presentation/bloc/savings_bloc.dart';
import 'features/staking/presentation/bloc/staking_bloc.dart';
import 'features/savings/presentation/bloc/savings_event.dart';
import 'features/staking/presentation/bloc/staking_event.dart';
import 'features/market/presentation/bloc/seller_product_bloc.dart';
import 'features/market/presentation/bloc/seller_product_event.dart';
import 'features/settings/presentation/bloc/kyc_bloc.dart';
import 'features/market/presentation/bloc/order_bloc.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';

void main() async {
  runZonedGuarded(
    () async {
      try {
        WidgetsFlutterBinding.ensureInitialized();

        // Custom Error Widget for Release Mode
        ErrorWidget.builder = (FlutterErrorDetails details) {
          return MaterialApp(
            home: Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 48,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Application Error',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        details.exception.toString(),
                        style: const TextStyle(color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Stack Trace:\n${details.stack.toString().split('\n').take(5).join('\n')}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        };

        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
        await configureDependencies();
        await getIt<NotificationService>().init();
        runApp(const MyApp());
      } catch (e, stackTrace) {
        debugPrint('Startup Error: $e');
        runApp(
          MaterialApp(
            home: Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Startup Error:\n$e\n\n$stackTrace',
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        );
      }
    },
    (error, stack) {
      debugPrint('Async Error: $error');
      runApp(
        MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Async Error:\n$error\n\n$stack',
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<ThemeCubit>()),
        BlocProvider(
          create: (context) =>
              getIt<AuthBloc>()..add(const AuthEvent.started()),
        ),
        BlocProvider(
          create: (context) =>
              getIt<SettingsBloc>()..add(const SettingsEvent.started()),
        ),
        BlocProvider(create: (context) => CartBloc()),
        BlocProvider(
          create: (context) =>
              getIt<FeedBloc>()..add(const FeedEvent.started()),
        ),
        BlocProvider(
          create: (context) =>
              getIt<MarketBloc>()..add(const MarketEvent.loadData()),
        ),
        BlocProvider(
          create: (context) =>
              getIt<ChatListBloc>()..add(const ChatListEvent.started()),
        ),
        BlocProvider(
          create: (context) =>
              getIt<SavingsBloc>()..add(const SavingsEvent.started()),
        ),
        BlocProvider(
          create: (context) =>
              getIt<StakingBloc>()..add(const StakingEvent.started()),
        ),
        BlocProvider(
          create: (context) =>
              getIt<SellerProductBloc>()
                ..add(const SellerProductEvent.loadMyProducts()),
        ),
        BlocProvider(create: (context) => getIt<KycBloc>()),
        BlocProvider(create: (context) => getIt<OrderBloc>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            title: 'Gonana Enhanced',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            routerConfig: router,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
