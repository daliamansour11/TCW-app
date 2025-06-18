import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/Custom_button.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/core/shared/shared_widget/customTextFormFiled.dart';
import 'package:tcw/core/shared/shared_widget/large_text_filed.dart';
import 'package:tcw/features/setting/presentation/widgets/label_widget.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final _formKey = GlobalKey<FormState>();

  final _complaintTitle = TextEditingController();
  final _Complainttype = TextEditingController();
  final _details = TextEditingController();

  @override
  void dispose() {
    _complaintTitle.dispose();
    _Complainttype.dispose();
    _details.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: context.propHeight(27)),
                CustomAppBar(
                  title: 'Support &\n Complaints',
                 
                ),
                SizedBox(height: context.propHeight(24)),
                Label(label: 'Complaint title',
                  context: context,
                ),
                CustomTextField(
                  controller: _complaintTitle,
                  hintStyle: const TextStyle(color: Colors.grey),
                  hintText: 'Enter your complaint title',
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  errorMessage: "Please enter complaint title",
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter complaint title' : null,
                ),
                const SizedBox(height: 16),
                Label(label: 'Complaint Type',
                  context: context,
                ),
                CustomTextField(
                  controller: _Complainttype,
                  hintText: 'Technical issue',
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  errorMessage: 'Please enter complaint type',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter complaint type' : null,
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Label(label: 'Details',
                  context: context,
                ),
                LargeTextField(
                  controller: _details,
                 
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(
                    style: context.textTheme.headlineLarge?.copyWith(
                      fontSize: context.propWidth(16),
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Changes saved successfully!')),
                        );
                      }
                    },
                    title: 'Submit',
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
