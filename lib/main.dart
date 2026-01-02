import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/injection.dart';
import 'config/router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'features/market/presentation/bloc/cart_bloc.dart';

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
    return BlocProvider(
      create: (context) => getIt<ThemeCubit>(),
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
