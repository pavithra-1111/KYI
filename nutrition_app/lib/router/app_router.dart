import 'package:go_router/go_router.dart';
import '../screens/welcome_screen.dart';
import '../screens/login_screen.dart';
import '../screens/profile_setup_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/product_details_screen.dart';
import '../screens/search_results_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/profile-setup',
      builder: (context, state) => const ProfileSetupScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ProductDetailsScreen(productId: id);
      },
    ),
    GoRoute(
      path: '/search-results',
      builder: (context, state) {
        final query = state.uri.queryParameters['query'] ?? '';
        return SearchResultsScreen(query: query);
      },
    ),
  ],
);
