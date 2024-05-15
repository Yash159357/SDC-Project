import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formState = GlobalKey<FormState>();
  bool isLogin = true;
  // var _enteredUsername = "";
  var _enteredEmail = "";
  var _enteredPassword = "";

  void submit() async {
    final isValid = _formState.currentState!.validate();
    if (isValid) {
      _formState.currentState!.save();
      try {
        if (isLogin) {
          final userCredentials = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: _enteredEmail, password: _enteredPassword);
        } else {
          final userCredentials = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _enteredEmail, password: _enteredPassword);
        }
      } on FirebaseAuthException catch (error) {
        if (error.code == 'email-already-in-use') {
          // ...
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? 'Authentication failed.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Form(
                key: _formState,
                child: Column(
                  children: [
                    // Username field (uncomment if needed)
                    // ...

                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text("Email"),
                      ),
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (newValue) {
                        _enteredEmail = newValue!;
                      },
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            !value.contains('@')) {
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        label: Text("Password"),
                      ),
                      autocorrect: false,
                      keyboardType: TextInputType.visiblePassword,
                      onSaved: (newValue) {
                        _enteredPassword = newValue!;
                      },
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.trim().length < 5) {
                          return 'Please enter a valid password.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: submit,
                      child: const Text("Submit"),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = false;
                        });
                      },
                      child: isLogin
                          ? const Text("I don't have an account")
                          : const Text("I have an account"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
