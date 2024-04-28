import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_setup/firebase_auth/firebase_auth_service.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Text editing controllers for user input
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  final FirebaseAuthService _auth = FirebaseAuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _repasswordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Form validation flag
  bool _isValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          // Set autovalidate mode to check for errors while typing
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sign-Up',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    hintText: 'Enter your username',
                    errorText: _isValid ? 'Invalid username format' : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    // Add validation for username format (optional)
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _isValid = false; // Reset validation on change
                    });
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    errorText: _isValid ? 'Invalid email format' : null,
                    // Add border using OutlineInputBorder
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // Adjust as desired
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email is required';
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return 'Invalid email format';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _isValid = false; // Reset validation on change
                    });
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    errorText: _isValid
                        ? 'Password must be at least 6 characters'
                        : null,
                    // Add border using OutlineInputBorder
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // Adjust as desired
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is required';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _isValid = false; // Reset validation on change
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _repasswordController,
                  decoration: InputDecoration(
                    labelText: 'Re-Password',
                    hintText: 'Confirm your password',
                    errorText: _isValid ? 'password do not match' : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 're-enter your password';
                    } else if (value != _passwordController.text) {
                      return 'password do not match';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _isValid = false;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _signUp,
                    child: Text('Sign Up'),
                    style: ElevatedButton.styleFrom(
                      // Set background color based on _isValid
                      backgroundColor: _isValid ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Text('Already have a account? Login'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpwithEmailAndPassword(email, password);

    if (user != null) {
      print("user is succesfully created");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      print('Some error occured');
    }
  }
}
