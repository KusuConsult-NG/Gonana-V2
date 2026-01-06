import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/presentation/pages/sign_in_page.dart';
import '../features/auth/presentation/pages/sign_up_page.dart';
import '../features/auth/presentation/pages/forgot_password_page.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/splash/presentation/pages/splash_page.dart';
import '../features/chat/presentation/pages/chat_list_page.dart';
import '../features/chat/presentation/pages/chat_detail_page.dart';

import '../features/settings/presentation/pages/profile_edit_page.dart';
import '../features/settings/presentation/pages/verification_page.dart';
import '../features/settings/presentation/pages/security_page.dart';
import '../features/settings/presentation/pages/change_password_page.dart';
import '../features/settings/presentation/pages/change_pin_page.dart';
import '../features/auth/presentation/pages/create_pin_page.dart';
import '../features/wallet/presentation/pages/deposit_page.dart';
import '../features/wallet/presentation/pages/withdraw_page.dart';
import '../features/wallet/presentation/pages/transaction_details_page.dart';
import '../features/wallet/domain/entities/transaction_entity.dart';
import '../features/savings/presentation/pages/savings_page.dart';
import '../features/feeds/presentation/pages/create_post_page.dart';
import '../features/savings/presentation/pages/create_savings_page.dart';
import '../features/auth/presentation/pages/pin_entry_page.dart';
import '../features/auth/presentation/pages/email_verification_page.dart';
import '../features/auth/presentation/pages/forgot_password_otp_page.dart';
import '../features/staking/presentation/pages/staking_page.dart';
import '../features/staking/presentation/pages/stake_amount_page.dart';
import '../features/savings/presentation/pages/savings_detail_page.dart';
import '../features/market/presentation/pages/create_product_page.dart';
import '../features/market/presentation/pages/product_details_page.dart';
import '../features/market/presentation/pages/my_products_page.dart';
import '../features/market/domain/entities/product_entity.dart';
// import '../features/market/data/models/product_model.dart';
import '../features/market/presentation/pages/cart_page.dart';
import '../features/market/presentation/pages/my_orders_page.dart';
import '../features/market/presentation/pages/my_sales_page.dart';
import '../features/payment/presentation/pages/payment_page.dart';
import '../features/notifications/presentation/pages/notifications_page.dart';
import '../features/settings/presentation/pages/notification_settings_page.dart';
import '../features/market/presentation/pages/product_reviews_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashPage()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(
      path: '/enter-pin',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final isTransaction = extra?['isTransaction'] ?? false;
        final onSuccess = extra?['onSuccess'] as VoidCallback?;
        return PinEntryPage(isTransaction: isTransaction, onSuccess: onSuccess);
      },
    ),
    GoRoute(path: '/signup', builder: (context, state) => const SignupPage()),
    GoRoute(
      path: '/verify-email/:email',
      builder: (context, state) {
        final email = state.pathParameters['email']!;
        return EmailVerificationPage(email: email);
      },
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordPage(),
      routes: [
        GoRoute(
          path: 'verify/:email',
          builder: (context, state) {
            final email = state.pathParameters['email']!;
            return ForgotPasswordOtpPage(email: email);
          },
        ),
      ],
    ),
    GoRoute(path: '/home', builder: (context, state) => const HomePage()),
    GoRoute(path: '/chats', builder: (context, state) => const ChatListPage()),
    GoRoute(
      path: '/chat/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ChatDetailPage(chatId: id);
      },
    ),
    GoRoute(
      path: '/create-post',
      builder: (context, state) => const CreatePostPage(),
    ),
    // Wallet Routes
    GoRoute(
      path: '/wallet/deposit',
      builder: (context, state) => const DepositPage(),
    ),
    GoRoute(
      path: '/wallet/transaction-details',
      builder: (context, state) {
        final transaction = state.extra as TransactionEntity;
        return TransactionDetailsPage(transaction: transaction);
      },
    ),
    GoRoute(
      path: '/wallet/withdraw',
      builder: (context, state) => const WithdrawPage(),
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationsPage(),
    ),
    GoRoute(
      path: '/settings/notifications',
      builder: (context, state) => const NotificationSettingsPage(),
    ),
    // Settings Routes
    GoRoute(
      path: '/settings/profile',
      builder: (context, state) => const ProfileEditPage(),
    ),
    GoRoute(
      path: '/settings/verification',
      builder: (context, state) => const VerificationPage(),
    ),
    GoRoute(
      path: '/settings/security',
      builder: (context, state) => const SecurityPage(),
      routes: [
        GoRoute(
          path: 'password',
          builder: (context, state) => const ChangePasswordPage(),
        ),
        GoRoute(
          path: 'pin',
          builder: (context, state) =>
              const CreatePinPage(), // Renaming this path to generic PIN page or handling logic inside
        ),
        GoRoute(
          path: 'change-pin',
          builder: (context, state) => const ChangePinPage(),
        ),
      ],
    ),
    // Savings Routes
    GoRoute(
      path: '/savings',
      builder: (context, state) => const SavingsPage(),
      routes: [
        GoRoute(
          path: 'create',
          builder: (context, state) => const CreateSavingsPage(),
        ),
        GoRoute(
          path: 'detail',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            return SavingsDetailPage(asset: extra);
          },
        ),
      ],
    ),
    // Staking Routes
    GoRoute(
      path: '/staking',
      builder: (context, state) => const StakingPage(),
      routes: [
        GoRoute(
          path: 'stake',
          builder: (context, state) {
            final pool = state.extra as Map<String, dynamic>;
            return StakeAmountPage(pool: pool);
          },
        ),
      ],
    ),
    // Market Routes
    GoRoute(
      path: '/market',
      routes: [
        GoRoute(
          path: 'create',
          builder: (context, state) => const CreateProductPage(),
        ),
        GoRoute(
          path: 'my-products',
          builder: (context, state) => const MyProductsPage(),
        ),
        GoRoute(
          path: 'details',
          builder: (context, state) {
            final product = state.extra as ProductEntity;
            return ProductDetailsPage(product: product);
          },
        ),
        GoRoute(
          path: 'orders',
          builder: (context, state) => const MyOrdersPage(),
        ),
        GoRoute(
          path: 'reviews/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return ProductReviewsPage(productId: id);
          },
        ),
        GoRoute(
          path: 'sales',
          builder: (context, state) => const MySalesPage(),
        ),
      ],
      builder: (context, state) =>
          const HomePage(), // Or a specific market page if separate
    ),
    GoRoute(
      path: '/payment',
      builder: (context, state) {
        final product = state.extra as ProductEntity?;
        return PaymentPage(product: product);
      },
    ),
    GoRoute(path: '/cart', builder: (context, state) => const CartPage()),
  ],
);
