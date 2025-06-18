import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcw/core/constansts/asset_manger.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/Custom_button.dart';
import 'package:tcw/core/theme/app_colors.dart';

class SubscriptionSection extends StatelessWidget {
  const SubscriptionSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('My Subscription',
            style: GoogleFonts.lato(fontWeight: FontWeight.w600)),
        SizedBox(height: 12),
        SizedBox(
          height: context.propHeight(300),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Container(
                width: 280,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: context.propWidth(8),
                          height: context.propHeight(8),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF175941),
                            shape: CircleBorder(),
                          ),
                        ),
                        SizedBox(width: 6),
                        Text('Paid',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text('Understanding Concept Of React',
                        style: GoogleFonts.lato(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        CircleAvatar(
                            radius: 14,
                            backgroundImage: AssetImage(AssetManger.ex_1)),
                        SizedBox(width: 8),
                        Text('Ramy Badr', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    SizedBox(height: context.propHeight(10)),
                    const Text('Your Plan: 30 \$ Monthly'),
                    const Text('Subscription Date: 13/1/2024'),
                    const Text('Renewal Date: 13/1/2024'),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: const Color(0xFFB7924F) /* Color-3 */,
                            ),
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: CustomButton(
                          onPressed: () {},
                          backgroundColor: Colors.transparent,
                          title: 'View Course',
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color:AppColors.primaryColor /* color-primary */,
                          ),
                        ),
                      ),
                    )
                    // child: Text('Manage',
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
