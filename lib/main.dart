import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_providers.dart';
import 'screens/main_navigation_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: '✨ SlayShop ✨',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Primary color scheme
          primarySwatch: Colors.pink,
          primaryColor: Colors.pink,

          // App bar theme
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.pink,
            foregroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          // Card theme for products
          cardTheme: CardThemeData(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            shadowColor: Colors.grey.withOpacity(0.3),
          ),

          // Elevated button theme
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
          ),

          // Input decoration theme
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.pink, width: 2),
            ),
          ),

          // Text theme
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            headlineMedium: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
            bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
          ),

          // Floating action button theme
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.pink,
            foregroundColor: Colors.white,
          ),

          // Bottom navigation bar theme
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Colors.pink,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
          ),

          // Scaffold background color
          scaffoldBackgroundColor: Colors.grey.shade50,

          // Color scheme
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.pink,
            brightness: Brightness.light,
          ),
        ),
        home: const MainNavigationScreen(),
      ),
    );
  }
}
