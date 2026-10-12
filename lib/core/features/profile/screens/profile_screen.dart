import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../network/api.dart';
import '../../../models/user_profile.dart';

import '../../../services/auth_service.dart';
import '../../../theme.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../../auth/cubit/auth_state.dart';
import '../widgets/profile_menu_item.dart';
import '../../auth/login/screens/login_screen.dart';



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // تحميل البروفايل أول ما الشاشة تفتح
    Future.microtask(() => context.read<AuthCubit>().loadProfile());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppTheme.background,
        body: SafeArea(
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is AuthFailure) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(state.message),
                      TextButton(
                        onPressed: () =>
                            context.read<AuthCubit>().loadProfile(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }
              if (state is AuthAuthenticated) {
                return _buildContent(context, state.user);
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, UserProfile user) {
    return Column(
      children: [
        // ... نفس المحتوى ...
        ProfileMenuItem(
          icon: Icons.logout,
          title: 'Logout',
          isDestructive: true,
          onTap: () => context.read<AuthCubit>().logout(),
        ),
      ],
    );
  }
}