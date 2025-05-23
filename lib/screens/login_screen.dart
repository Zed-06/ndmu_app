import 'package:flutter/material.dart';
import 'package:ndmu_app/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<Offset> _formSlide;
  late final Animation<double> _logoScale;

  // FocusNodes for the two fields
  final FocusNode _idFocus = FocusNode();
  final FocusNode _pwdFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    // 1.5-second animation for both logo scale and form slide
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _formSlide = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _logoScale = Tween<double>(begin: 1.2, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );

    // Restart the animation after a 500 ms delay
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _ctrl.forward();
    });

    // Rebuild when focus changes so AnimatedContainer responds
    _idFocus.addListener(() => setState(() {}));
    _pwdFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _idFocus
      ..removeListener(() => setState(() {}))
      ..dispose();
    _pwdFocus
      ..removeListener(() => setState(() {}))
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFF0097B2), Color(0xFF7ED957)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo scales down from 1.2→1.0
                ScaleTransition(
                  scale: _logoScale,
                  child: Image.asset(
                    'assets/ndmu.png',
                    width: 120,
                    height: 120,
                  ),
                ),
                const SizedBox(height: 24),

                // Form slides up
                SlideTransition(
                  position: _formSlide,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'NOTRE DAME OF MARBEL UNIVERSITY',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Email/ID field with animated border
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _idFocus.hasFocus
                                  ? Colors.blue
                                  : Colors.grey.shade400,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            focusNode: _idFocus,
                            decoration: const InputDecoration(
                              labelText: 'Email / Student ID',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Password field with animated border
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _pwdFocus.hasFocus
                                  ? Colors.blue
                                  : Colors.grey.shade400,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            focusNode: _pwdFocus,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Log In button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                PageRouteBuilder(
                                  transitionDuration: const Duration(milliseconds: 600),
                                  pageBuilder: (_, animation, __) => const HomeScreen(), // replace if needed
                                  transitionsBuilder: (_, animation, __, child) {
                                    final fade = Tween<double>(begin: 0, end: 1).animate(animation);
                                    final slide = Tween<Offset>(
                                      begin: const Offset(1, 0),
                                      end: Offset.zero,
                                    ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));

                                    return FadeTransition(
                                      opacity: fade,
                                      child: SlideTransition(position: slide, child: child),
                                    );
                                  },
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              backgroundColor: const Color(0xFF4E69FA),
                            ),
                            child: const Text('LOG IN', style: TextStyle(fontSize: 16)),
                          ),
                        ),

                        TextButton(
                          onPressed: () {/* TODO: Forgot Password */},
                          child: const Text('FORGOT PASSWORD'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}