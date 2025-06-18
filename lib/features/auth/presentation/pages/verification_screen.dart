// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/theme/app_colors.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;
  bool isValid = true;
  int _secondsRemaining = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(4, (_) => FocusNode());
    _controllers = List.generate(4, (_) => TextEditingController());
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _onContinuePressed() {
    String otp = _controllers.map((c) => c.text).join();
    setState(() {
      isValid = otp.length == 4 && otp.runes.every((code) => code >= 48 && code <= 57);
    });

    if (isValid) {
      // Handle OTP verification here
      print("OTP Entered: $otp");
    }
  }

  void _onResendPressed() {
    setState(() {
      _secondsRemaining = 30;
    });
    startTimer();
  }

  Widget _buildOTPField(int index) {
    return Container(
      width: context.propWidth(55)  ,
      height: context.propHeight(65),
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(fontSize: 24),
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: '',
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 3) {
            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppColors.primaryColor;

    return Scaffold(
      backgroundColor: Colors.white,
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: context.propHeight(32)),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 20),
                  Text(
                    'Verification',
                    style: context.textTheme.headlineMedium,
                  ),
                ],
              ),
              SizedBox(height: context.propHeight(40)),
              Text("OTP has been sent sent to", style: TextStyle(fontSize: 16)),
              Text("+1235802310", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: context.propHeight(40)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, _buildOTPField),
              ),
              SizedBox(height: 12),
              Text(
                _secondsRemaining > 0
                    ? "00:${_secondsRemaining.toString().padLeft(2, '0')} Sec"
                    : "",
                style: TextStyle(color: Colors.grey),
              ),
              if (!isValid)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text("Please enter a valid 4-digit code",
                      style: TextStyle(color: Colors.red)),
                ),
              SizedBox(height: context.propHeight(32)),
              ElevatedButton(
                onPressed: _onContinuePressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                child: Text("Continue", style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 16),
              Text.rich(
                TextSpan(
                  text: "Don’t receive code ? ",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Re-send",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = _secondsRemaining == 0 ? _onResendPressed : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
