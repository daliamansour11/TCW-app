
import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/courses/data/models/reel_model.dart';

class TCWMediaScreen extends StatelessWidget {
  final List<Reel> reels;

  const TCWMediaScreen({super.key, required this.reels});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Color(0xFF2B195C);
    final Color goldColor = AppColors.primaryColor;

    return Scaffold(
      backgroundColor: Colors.white,
     
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(height: context.propHeight(32)),
              Row(
               
                children: [
                   IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                   SizedBox(width: context.propWidth(20)),
                  Text(
                    "TCW Media",
                   style: context.textTheme.headlineMedium,
                  ),
                  //back
                 
                  
                ],
              ),
              SizedBox(height: context.propHeight(32)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "TCW Reels",
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      // Handle create reel
                    },
                    icon: Icon(Icons.add_circle_outline, color: goldColor, size: 18),
                    label: Text("Create a Reel",style: context. textTheme.headlineMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: goldColor,
                    )),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: goldColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.propHeight(32)),
              // Reels list
              Expanded(
                child: ListView.builder(
                  itemCount: reels.length,
                  itemBuilder: (context, index) {
                    final reel = reels[index];
                    return Padding(
                      padding:  EdgeInsets.only(
                        left: context.propWidth(8),
                        right: context.propWidth(8),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              children: [
                                // Reel thumbnail
                                Image.asset(
                                  reel.thumbnail,
                                  width: double.infinity,
                                  height: 350,
                                  fit: BoxFit.fill,
                                ),
                                // Play icon + view count
                                Positioned(
                                  left: 12,
                                  bottom: 12,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.play_arrow, size: 16, color: Colors.black),
                                        SizedBox(width: 4),
                                        Text(
                                          '${reel.views}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                       SizedBox(height: 8),
                          // 
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      // Floating chatbot button
      floatingActionButton: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: primaryColor,
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: IconButton(
          icon: Icon(Icons.android, color: Colors.white),
          onPressed: () {},
        ),
      ),
    );
  }
}