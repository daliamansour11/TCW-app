import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/core/shared/shared_widget/custom_button.dart';
import 'package:tcw/core/shared/shared_widget/custom_container.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/shared/shared_widget/custom_text_form_field.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/chat/presentation/chat_viewmodel.dart';
import 'package:zapx/zapx.dart';

class NewGroupScreen extends StatefulWidget {
  const NewGroupScreen({super.key});

  @override
  State<NewGroupScreen> createState() => _NewGroupScreenState();
}

class _NewGroupScreenState extends State<NewGroupScreen> {
  late final ChatViewmodel viewmodel;
  @override
  void initState() {
    super.initState();
    viewmodel = ChatViewmodel(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'New Group',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            const CustomContainer(
              width: double.infinity,
              padding: 15,
              color: Colors.white,
              boxShadow: AppColors.cardShadow,
              child: Column(
                spacing: 20,
                children: [
                  Icon(
                    CupertinoIcons.photo,
                    size: 40,
                    color: Colors.grey,
                  ),
                  CustomText(
                    'Add Group Cover',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
            const CustomText('Group title',
                fontSize: 16, fontWeight: FontWeight.bold),
            const CustomTextField(
              hintText: 'Enter group title',
            ),
            const CustomText('Coach',
                fontSize: 16, fontWeight: FontWeight.bold),
            CustomTextField(
              hintText: 'Select coach',
              fieldType: FieldType.dropdown,
              onChanged: (v) {},
              items: const [
                'Coach 1',
                'Coach 2',
                'Coach 3',
              ],
            ),
            const CustomText('Date', fontSize: 16, fontWeight: FontWeight.bold),
            const CustomTextField(
              hintText: 'Select date',
              fieldType: FieldType.date,
            ),
            // Task Status
            const CustomText(
              'Task Status',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            CustomTextField(
              hintText: 'Select task status',
              fieldType: FieldType.dropdown,
              items: const [
                'Active',
                'Inactive',
              ],
              onChanged: (v) {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomButton(
        title: 'Create',
        onPressed: viewmodel.onCreateGroup,
      ).paddingSymmetric(horizontal: 10),
    );
  }
}
