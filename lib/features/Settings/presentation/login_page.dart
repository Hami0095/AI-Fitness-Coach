// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_fonts/google_fonts.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);
  
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey   = GlobalKey<FormState>();
//   final _emailCtrl = TextEditingController();
//   final _passCtrl  = TextEditingController();
//   bool _isLoading  = false;
//   bool _obscure    = true;

//   Future<void> _submit() async {
//     if (!_formKey.currentState!.validate()) return;
//     setState(() => _isLoading = true);

//     // try {
//     //   await FirebaseAuth.instance.signInWithEmailAndPassword(
//     //     email: _emailCtrl.text.trim(),
//     //     password: _passCtrl.text,
//     //   );
//     //   // On success, navigate to home or pop
//     //   Navigator.of(context).pop();
//     // } on FirebaseAuthException catch (e) {
//     //   final msg = e.message ?? 'Login failed';
//     //   ScaffoldMessenger.of(context).showSnackBar(
//     //     SnackBar(content: Text(msg)),
//     //   );
//     // } finally {
//     //   if (mounted) setState(() => _isLoading = false);
//     // }
//   }

//   @override
//   void dispose() {
//     _emailCtrl.dispose();
//     _passCtrl.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // full-screen gradient
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.grey.shade900, Colors.black],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24),
//             child: Card(
//               elevation: 8,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               color: Colors.white,
//               child: Padding(
//                 padding: const EdgeInsets.all(24),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         'Welcome Back',
//                         style: GoogleFonts.lato(
//                           fontSize: 26,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.teal.shade700,
//                         ),
//                       ),
//                       const SizedBox(height: 24),

//                       // — Email field —
//                       TextFormField(
//                         controller: _emailCtrl,
//                         keyboardType: TextInputType.emailAddress,
//                         style: GoogleFonts.lato(),
//                         decoration: InputDecoration(
//                           prefixIcon: const Icon(Icons.email, color: Colors.teal),
//                           labelText: 'Email',
//                           labelStyle: GoogleFonts.lato(),
//                           filled: true,
//                           fillColor: Colors.grey.shade100,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                         validator: (v) {
//                           if (v == null || v.isEmpty) return 'Enter your email';
//                           if (!RegExp(r'\S+@\S+\.\S+').hasMatch(v)) return 'Invalid email';
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 16),

//                       // — Password field —
//                       TextFormField(
//                         controller: _passCtrl,
//                         obscureText: _obscure,
//                         style: GoogleFonts.lato(),
//                         decoration: InputDecoration(
//                           prefixIcon: const Icon(Icons.lock, color: Colors.teal),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _obscure ? Icons.visibility_off : Icons.visibility,
//                               color: Colors.grey,
//                             ),
//                             onPressed: () => setState(() => _obscure = !_obscure),
//                           ),
//                           labelText: 'Password',
//                           labelStyle: GoogleFonts.lato(),
//                           filled: true,
//                           fillColor: Colors.grey.shade100,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                         validator: (v) {
//                           if (v == null || v.isEmpty) return 'Enter your password';
//                           if (v.length < 6) return 'Min. 6 characters';
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 24),

//                       // — Login button —
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: _isLoading ? null : _submit,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.teal,
//                             padding: const EdgeInsets.symmetric(vertical: 14),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           child: _isLoading
//                               ? const SizedBox(
//                                   height: 20,
//                                   width: 20,
//                                   child: CircularProgressIndicator(
//                                     strokeWidth: 2,
//                                     color: Colors.white,
//                                   ),
//                                 )
//                               : Text(
//                                   'Log In',
//                                   style: GoogleFonts.lato(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                         ),
//                       ),

//                       const SizedBox(height: 12),
//                       TextButton(
//                         onPressed: () {
//                           // navigate to sign up
//                           context.push('/signup');
//                         },
//                         child: Text(
//                           'Don’t have an account? Sign Up',
//                           style: GoogleFonts.lato(
//                             color: Colors.teal.shade700,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _isLoading = false;
  bool _obscure = true;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    // TODO: wire up your email/password login logic here.
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);
    // On success, navigate:
    context.pop();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // full-screen gradient
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 25, 25, 25),
              Color.fromARGB(255, 64, 64, 64),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Welcome Back',
                        style: GoogleFonts.lato(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade700,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // — Email field —
                      TextFormField(
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        style: GoogleFonts.lato(),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.teal,
                          ),
                          labelText: 'Email',
                          labelStyle: GoogleFonts.lato(),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Enter your email';
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(v))
                            return 'Invalid email';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // — Password field —
                      TextFormField(
                        controller: _passCtrl,
                        obscureText: _obscure,
                        style: GoogleFonts.lato(),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.teal,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () =>
                                setState(() => _obscure = !_obscure),
                          ),
                          labelText: 'Password',
                          labelStyle: GoogleFonts.lato(),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty)
                            return 'Enter your password';
                          if (v.length < 6) return 'Min. 6 characters';
                          return null;
                        },
                      ),

                      // — Forgot Password link —
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => context.push('/forgot-password'),
                          child: Text(
                            'Forgot Password?',
                            style: GoogleFonts.lato(
                              color: Colors.teal.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // — Login button —
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  'Log In',
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // — Social buttons (black background) —
                      SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Google Sign-In
                          },
                          icon: Image.asset(
                            'assets/images/google_logo.png',
                            height: 20,
                          ),
                          label: Text(
                            'Continue with Google',
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Apple Sign-In
                          },
                          icon: Image.asset(
                            'assets/images/apple_logo.png',
                            height: 20,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Continue with Apple',
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // — Sign up link —
                      TextButton(
                        onPressed: () => context.push('/signup'),
                        child: Text(
                          'Don’t have an account? Sign Up',
                          style: GoogleFonts.lato(
                            color: Colors.teal.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
