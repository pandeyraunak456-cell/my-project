import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_service.dart';
import 'register_page.dart';
import 'dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService auth = AuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;
  bool loading = false;
  bool isEmployee = true;

  void message(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      message('Please enter email and password');
      return;
    }

    setState(() => loading = true);

    try {
      await auth.login(
        email: email,
        password: password,
      );

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const DashboardPage(),
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      switch (e.code) {
        case 'invalid-email':
          message('Please enter a valid email address');
          break;
        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-credential':
        case 'invalid-login-credentials':
          message('Incorrect email or password');
          break;
        case 'user-disabled':
          message('This account has been disabled');
          break;
        case 'too-many-requests':
          message('Too many attempts. Try again later');
          break;
        case 'network-request-failed':
          message('Check your internet connection');
          break;
        default:
          message('Login failed: ${e.message ?? e.code}');
      }
    } catch (e) {
      if (mounted) message('Login failed: $e');
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  Future<void> googleLogin() async {
    setState(() => loading = true);

    try {
      await auth.googleLogin();

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const DashboardPage(),
        ),
        (route) => false,
      );
    } catch (e) {
      if (mounted) message('Google login failed: $e');
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  Future<void> linkedInLogin() async {
    setState(() => loading = true);

    try {
      await auth.linkedInLogin();

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const DashboardPage(),
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        message('LinkedIn login failed: ${e.message ?? e.code}');
      }
    } catch (e) {
      if (mounted) message('LinkedIn login failed: $e');
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF1746A2);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'JobQuicks',
          style: TextStyle(
            color: blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Welcome Back!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: blue,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Login to your JobQuicks account',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),

                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () =>
                                  setState(() => isEmployee = true),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    isEmployee ? blue : Colors.grey.shade200,
                                foregroundColor:
                                    isEmployee ? Colors.white : Colors.black,
                              ),
                              child: const Text('Employee'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () =>
                                  setState(() => isEmployee = false),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    !isEmployee ? blue : Colors.grey.shade200,
                                foregroundColor:
                                    !isEmployee ? Colors.white : Colors.black,
                              ),
                              child: const Text('Employer'),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 22),
                      const Text('Email Address'),
                      const SizedBox(height: 8),

                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Enter your email',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 18),
                      const Text('Password'),
                      const SizedBox(height: 8),

                      TextField(
                        controller: passwordController,
                        obscureText: hidePassword,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () => setState(
                              () => hidePassword = !hidePassword,
                            ),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () async {
                            final email = emailController.text.trim();

                            if (email.isEmpty) {
                              message('Enter your email first');
                              return;
                            }

                            try {
                              await auth.resetPassword(email);
                              if (mounted) {
                                message('Password reset email sent');
                              }
                            } on FirebaseAuthException catch (e) {
                              if (mounted) {
                                message(e.message ?? e.code);
                              }
                            }
                          },
                          child: const Text('Forgot Password?'),
                        ),
                      ),

                      const SizedBox(height: 12),

                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: loading ? null : login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: blue,
                            foregroundColor: Colors.white,
                          ),
                          child: loading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 22),
                      const Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text('OR LOGIN WITH'),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),

                      const SizedBox(height: 16),

                      OutlinedButton.icon(
                        onPressed: loading ? null : googleLogin,
                        icon: const Icon(Icons.g_mobiledata, size: 28),
                        label: const Text('Continue with Google'),
                      ),

                      const SizedBox(height: 10),

                      OutlinedButton.icon(
                        onPressed: loading ? null : linkedInLogin,
                        icon: const Icon(Icons.work_outline),
                        label: const Text('Continue with LinkedIn'),
                      ),

                      const SizedBox(height: 18),

                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          const Text("Don't have an account? "),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const RegisterPage(),
                                ),
                              );
                            },
                            child: const Text('Register'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}