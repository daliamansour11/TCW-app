import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/custom_button.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/core/shared/shared_widget/custom_image.dart';
import 'package:tcw/core/shared/shared_widget/custom_text_form_field.dart';
import 'package:tcw/core/utils/toast_util.dart';
import 'package:tcw/features/auth/data/models/user_model.dart';
import 'package:tcw/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:tcw/features/profile/presentation/profile_viewmodel.dart';
import 'package:tcw/features/setting/presentation/widgets/label_widget.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  late ProfileViewmodel viewModel;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    viewModel = ProfileViewmodel(context);
    if (userData!.image != null) {
      viewModel.imagePath = userData!.validImage;
    }
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Personal Details',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    BlocBuilder<ProfileCubit, ProfileState>(
                      buildWhen: (previous, current) =>
                          current is ProfileLoaded,
                      builder: (context, state) => CircleAvatar(
                        backgroundColor: Colors.black.withValues(alpha: 0.5),
                        backgroundImage: viewModel.imagePath == null
                            ? null
                            : CustomImage.provider(viewModel.imagePath!),
                        radius: 50,
                        child: viewModel.imagePath != null
                            ? null
                            : userData!.imageWidget.child,
                      ),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: Material(
                        elevation: 3,
                        shape: const CircleBorder(),
                        color: Colors.transparent,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white.withValues(alpha: 0.5),
                          child: IconButton(
                            icon:
                                const Icon(Icons.camera_alt_outlined, size: 20),
                            onPressed: viewModel.pickImage,
                            splashRadius: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Label(
                context: context,
                label: 'First name',
              ),
              CustomTextField(
                controller: viewModel.firstNameController,
                hintStyle: const TextStyle(color: Colors.grey),
                hintText: 'First name',
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 16),
              Label(context: context, label: 'Last name'),
              CustomTextField(
                controller: viewModel.lastNameController,
                hintText: 'Last name',
                keyboardType: TextInputType.name,
                hintStyle: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Label(context: context, label: 'Phone number'),
              CustomTextField(
                hintStyle: const TextStyle(color: Colors.grey),
                controller: viewModel.phoneController,
                hintText: '0121564548',
                keyboardType: TextInputType.phone,
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
                  onPressed: viewModel.saveChanges,
                  title: 'Save Changes',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
