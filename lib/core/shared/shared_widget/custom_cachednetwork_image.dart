

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zap_sizer/zap_sizer.dart';


Widget buildCustomNetworkImage(BuildContext context, String imageUrl,) {
  return SizedBox(

    child: CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(

          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        color: Colors.transparent,
        child: const Center(
          child: CupertinoActivityIndicator(radius: 12),
        ),
      ),
      errorWidget: (context, url, error) =>
      const Icon(Icons.error, color: Colors.red),
    ),
  );
}
