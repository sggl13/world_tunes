import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/routing/routes.dart';
import '../../core/utils/app_colors.dart';
import '../../core/providers/auth_provider.dart';
import '../widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.radio, color: AppColors.mainBlueDark, size: 40,),
            const SizedBox(width: 16),
            Text(
              'World Tunes',
              style: TextStyle(
                fontSize: 40,
                color: AppColors.mainBlueDark,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.25),
          image: const DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            width: 300,
            height: 450,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.mainBlueDark, width: 3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                    color: AppColors.mainBlueDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextFormField(
                  controller: loginProvider.emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: loginProvider.passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 32),
                loginProvider.isLoading
                    ? CircularProgressIndicator(color: AppColors.mainBlueDark,)
                    : CustomButton(
                        width: 150,
                        height: 41,
                        primaryColor: AppColors.mainBlueDark,
                        hoverColor: AppColors.mainBlueDark.withOpacity(0.5),
                        text: const Text('Login', style: TextStyle(color: Colors.white, fontSize: 16)),
                        onPressed: () async {
                          await loginProvider.login(context);
                        },
                      ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Future.microtask(() => context.go(Routes.createAccount));
                  },
                  child: Text(
                    'Create an account',
                    style: TextStyle(
                      color: AppColors.mainBlueDark,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      )
    );
  }
}
