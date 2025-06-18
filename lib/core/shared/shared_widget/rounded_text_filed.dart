import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/context_extensions.dart';

class RoundedTextField extends StatefulWidget {
  final String hint;
  final IconData icon;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const RoundedTextField({
    super.key,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    required this.controller,
    this.validator,
  });

  @override
  State<RoundedTextField> createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  bool _obscure = true;

  void _toggleVisibility() {
    setState(() {
      _obscure = !_obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscure : false,
      validator: widget.validator,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon, color: Colors.grey),
        hintText: widget.hint,
        hintStyle: context.textTheme.headlineSmall?.copyWith(
          color: Colors.grey,
        ),
        filled: true,
        fillColor: const Color(0xFFF6F6F6),
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscure ? Icons.visibility_off_outlined : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: _toggleVisibility,
              )
            : null,
      ),
    );
  }
}
