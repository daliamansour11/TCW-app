import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/routes/routes_names.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Country _selectedCountry = Country(
    phoneCode: '20',
    countryCode: 'EG',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Egypt',
    example: '0100 000 0000',
    displayName: 'Egypt',
    displayNameNoCountryCode: 'EG',
    e164Key: '',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
     
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    const SizedBox(width: 8),
                    Text(
                      'Forgot Password',
                      style: context.textTheme.headlineMedium
                    ),
                  ],
                ),
                 SizedBox(height: context.propHeight(32)),
                 Text(
                  'Enter the phone number we will send the OTP in this phone number to reset your password',
                  style: context.textTheme.headlineSmall
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            showPhoneCode: true,
                            onSelect: (Country country) {
                              setState(() {
                                _selectedCountry = country;
                              });
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                          child: Row(
                            children: [
                              Text(_selectedCountry.flagEmoji, style: const TextStyle(fontSize: 20)),
                              const SizedBox(width: 4),
                              Text(
                                '+${_selectedCountry.phoneCode}',
                                style: const TextStyle(fontSize: 16, color: Colors.black),
                              ),
                              const Icon(Icons.arrow_drop_down, color: Colors.black),
                            ],
                          ),
                        ),
                      ),
                      const VerticalDivider(color: Colors.grey),
                      Expanded(
                        child: TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            hintText: '1235802310',
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your phone number';
                            }
                            if (!RegExp(r'^\d{6,15}$').hasMatch(value.trim())) {
                              return 'Enter a valid phone number';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final fullPhone = '+${_selectedCountry.phoneCode}${_phoneController.text.trim()}';
                        debugPrint("Sending OTP to: $fullPhone");
                        // Trigger OTP logic here
                        Modular.to.pushNamed(AppRoutes.oTPVerificationScreen);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFBD954F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
