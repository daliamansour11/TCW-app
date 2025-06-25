import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/custom_button.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/core/shared/shared_widget/custom_text_form_field.dart';
import 'package:tcw/core/shared/shared_widget/large_text_filed.dart';
import 'package:tcw/features/setting/presentation/settings_viewmodel.dart';
import 'package:tcw/features/setting/presentation/widgets/label_widget.dart';
import 'package:zapx/zapx.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final _formKey = GlobalKey<FormState>();

  final _complaintTitle = TextEditingController();
  final complaintType = TextEditingController();
  final _details = TextEditingController();
  late final SettingsViewmodel viewmodel;

  @override
  void initState() {
    super.initState();
    viewmodel = SettingsViewmodel(context);
  }

  @override
  void dispose() {
    _complaintTitle.dispose();
    complaintType.dispose();
    _details.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Support & Complaints',
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Label(
                      label: 'Complaint title',
                      context: context,
                    ),
                    CustomTextField(
                      controller: _complaintTitle,
                      hintStyle: const TextStyle(color: Colors.grey),
                      hintText: 'Enter your complaint title',
                      keyboardType: TextInputType.name,
                      obscureText: false,
                      errorMessage: 'Please enter complaint title',
                      validator: (value) => value!.isEmpty
                          ? 'Please enter complaint title'
                          : null,
                    ),
                    Label(
                      label: 'Complaint Type',
                      context: context,
                    ),
                    CustomTextField(
                      controller: complaintType,
                      hintText: 'Technical issue',
                      keyboardType: TextInputType.name,
                      obscureText: false,
                      errorMessage: 'Please enter complaint type',
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter complaint type' : null,
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
                    Label(
                      label: 'Details',
                      context: context,
                    ),
                    LargeTextField(
                      controller: _details,
                    ),
                    const Row(
                      spacing: 5,
                      children: [
                        Icon(Icons.camera),
                        Icon(Icons.attach_file),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          CustomButton(
            style: context.textTheme.headlineLarge?.copyWith(
              fontSize: context.propWidth(16),
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            onPressed: () {
              viewmodel.showSuccessDialog('Your complaint has been submitted!');
            },
            title: 'Submit',
          ),
        ],
      ).paddingAll(10),
    );
  }
}
