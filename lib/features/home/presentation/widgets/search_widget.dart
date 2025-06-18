
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcw/core/constansts/context_extensions.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search your course here....',
                      hintStyle: GoogleFonts.poppins(fontSize: 12),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
         SizedBox(width: context.propWidth(12)),
        const Icon(Icons.filter_alt_outlined,  size: 30),
      ],
    );
  }
}
