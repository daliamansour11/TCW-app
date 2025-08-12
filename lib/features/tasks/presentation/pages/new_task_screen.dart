import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/date_extensions.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/core/shared/shared_widget/custom_button.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/shared/shared_widget/custom_text_form_field.dart';
import 'package:tcw/features/courses/data/models/task_model.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key, this.task});
  final Task? task;

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.task == null ? 'New Task' : 'Edit Task',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            const CustomText('Date'),
            CustomTextField(
              controller: TextEditingController(
                  text: selectedDate?.formatDateByYears.toString()),
              fieldType: FieldType.date,
              prefixIcon: const Icon(Icons.calendar_month),
              hintText: 'Select Date',
              onDateSelected: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
            ),
            const CustomText('Title'),
            CustomTextField(
              controller: TextEditingController(text: widget.task?.title),
              hintText: 'Enter Title',
            ),
            const CustomText('Description'),
            CustomTextField(
              controller: TextEditingController(text: widget.task?.description),
              hintText: 'Enter Description',
              maxLines: 3,
            ),
            // Task Status
            const CustomText('Task Status'),
            CustomTextField(
              fieldType: FieldType.dropdown,
              items: const ['Pending', 'Completed'],
              onChanged: (value) {
                setState(() {});
              },
            ),
            // final deadline
            const CustomText('Final Deadline'),
            CustomTextField(
              fieldType: FieldType.date,
              prefixIcon: const Icon(Icons.calendar_month),
              hintText: 'Select Date',
              onDateSelected: (date) {
                setState(() {});
              },
            ),
            // Details
            const CustomText('Details'),
            CustomTextField(
              controller: TextEditingController(text: widget.task?.details),
              hintText: 'Enter Details',
              maxLines: 3,
            ),

            CustomButton(
              title: widget.task == null ? 'Add Task' : 'Save Changes',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
