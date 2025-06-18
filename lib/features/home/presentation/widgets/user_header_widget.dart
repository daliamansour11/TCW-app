import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/asset_manger.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/theme/app_colors.dart';

class UserHeader extends StatelessWidget {
  bool? isAside = false;
  VoidCallback? onTap;
   UserHeader({
    super.key,
    required this.context,
    this.onTap,
    this.isAside
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: isAside == true ? context.propHeight(9) : context.propHeight(12),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
               Icon(Icons.calendar_today_outlined, size: isAside == true ? 18 : 25, ),
              const SizedBox(width: 8),
              isAside == true ?  const SizedBox(
                width: 6
              ): IconButton(icon: Icon(Icons.more_vert), onPressed: onTap)
             
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: isAside == true ? context.propWidth(50) : context.propWidth(70),
                height: isAside == true ? context.propHeight(50) : context.propHeight(70),
             
                child: CircularProgressIndicator(
                  value: 0.6,
                  strokeWidth: 4,
                  backgroundColor: Colors.grey.shade300,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                ),
              ),
               CircleAvatar(
                radius: isAside == true ? 18 : 30,
                backgroundImage: AssetImage(AssetManger.ex_1),
              ),
            ],
          ),
          SizedBox(
            height: isAside == true ? context.propHeight(9) : context.propHeight(12),
          ),
          Text('Good Morning, Ahmed',
              style: context.textTheme.headlineLarge?.copyWith(
                fontSize:isAside == true ? 12 : 16,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: context.propHeight(12)),
          Text('Continue Your Journey And Achieve',
              style: context.textTheme.headlineLarge?.copyWith(
                fontSize: isAside == true ? 12 : 16,
                fontWeight: FontWeight.w200,
                color: Colors.grey.shade600,
              )),
          Text('Your Goals',
              style: context.textTheme.headlineLarge?.copyWith(
                fontSize: isAside == true ? 12 : 16,
                fontWeight: FontWeight.w200,
                color: Colors.grey.shade600,
              )),
        ],
      ),
    );
  }
}
