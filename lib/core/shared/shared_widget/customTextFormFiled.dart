
import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/theme/app_theme.dart';
import 'package:tcw/core/theme/app_colors.dart';


class CustomTextField extends StatefulWidget {
  final Color? fillColor;
  final double? height;
  final double? width;
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? errorMessage;
  final TextStyle? hintStyle;
  final bool obscureText;


  const CustomTextField({
    super.key,
    this.fillColor,
    this.height,
    this.width,
    this.hintText,
    this.labelText,
    this.controller,
    this.keyboardType,
    this.validator,
    this.errorMessage,
    required this.hintStyle,
    required this.obscureText,

  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {


  @override
  void initState() {
    super.initState();

   
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          TextFormField(
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            validator: widget.validator,
            obscureText: widget.obscureText,
            style: AppTheme(context)
                .theme
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColors.primaryTextColor),
            decoration: InputDecoration(
              errorStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.red,
              ),
              fillColor:
                 Colors.white,
              filled: true,
              hintText: widget.hintText,
              hintStyle: widget.hintStyle,
              labelText: widget.labelText,
             
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.red, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                  color:    Colors.grey ,
                    width: 1.0,
                  )),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              contentPadding: EdgeInsets.only(
                bottom: context.propHeight(15),
                right: context.propWidth(14),
                left: context.propWidth(14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}