
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/theme/app_colors.dart';

class PaymentMethodSection extends StatelessWidget {
  const PaymentMethodSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Payment Method', style: GoogleFonts.lato(fontWeight: FontWeight.w600)),
            Text('Change', style: GoogleFonts.lato(color: AppColors.primaryColor)),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: context.propHeight(180),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Container(
                width: context.propWidth(280),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF434343), Color(0xFF000000)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Finaci', style: GoogleFonts.lato(color: Colors.white, fontSize: 14)),
                    const Spacer(),
                    Text('**** **** **** 2345',
                        style: GoogleFonts.lato(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Card Holder', style: GoogleFonts.lato(color: Colors.grey.shade400, fontSize: 12)),
                            Text('Noman Manzoor',
                                style: GoogleFonts.lato(color: Colors.white, fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Expiry', style: GoogleFonts.lato(color: Colors.grey.shade400, fontSize: 12)),
                            Text('02/30',
                                style: GoogleFonts.lato(color: Colors.white, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    )
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
