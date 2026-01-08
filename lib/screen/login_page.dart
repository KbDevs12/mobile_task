import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text(
            "Log in",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const Text(
            "Enter your email and password to securely access\n"
            "your account and manage your services.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          _buildTextField(hint: "Email address", icon: Icons.mail_outline),
        ],
      ),
    );
  }
}

Widget _buildTextField({
  required String hint,
  required IconData icon,
  bool obscure = false,
  Widget? suffixIcon,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon,
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 20,
        ),
      ),
    ),
  );
}
