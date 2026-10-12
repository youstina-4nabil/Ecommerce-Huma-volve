import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/features/auth/cubit/auth_cubit.dart';
import 'core/features/cart/cubit/cart_cubit.dart';
import 'core/features/home/cubit/prodect_cubit.dart';

import 'core/features/splash/screens/splash_screen.dart';
import 'core/services/auth_service.dart';
import 'core/services/prodect_service.dart';
import 'core/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit(AuthService())),
        BlocProvider(
          create: (_) => ProductsCubit(ProductService())..loadData(),
        ),
        BlocProvider(create: (_) => CartCubit()),
      ],
      child: MaterialApp(
        title: 'E-Commerce App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}