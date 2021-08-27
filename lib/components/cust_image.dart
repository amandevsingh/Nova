import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';
import 'package:flutter_auth/components/spinner.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class CustImage extends StatelessWidget {
  final String imgURL;
  final double height;
  final double width;
  final double cornerRadius;
  final String errorImage;
  final String imageFile;
  final String placeholderTitle;
  final bool zoomablePhoto;
  final String assetString;
  //final String? heroTag;

  CustImage({
    this.imgURL = "",
    this.cornerRadius = 0,
    this.height = 0.0,
    this.width = 0.0,
    this.errorImage = ImgName.novaIconWhite,
    this.imageFile = "",
    this.placeholderTitle = "",
    this.zoomablePhoto = false,
    this.assetString = "",
    // this.heroTag = "",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.grey.withOpacity(0.2)),
          borderRadius: BorderRadius.all(Radius.circular(cornerRadius))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadius),
        child: Container(
          color: Color(0xFFEEF0F2),
          height: height,
          width: width,
          child: imageFile.isNotEmpty
              ? Image.file(
                  File(imageFile),
                  height: height,
                  width: width,
                  fit: BoxFit.fill,
                )
              : imgURL.isEmpty
                  ? Image.asset(
                      assetString,
                      fit: BoxFit.fill,
                      height: height,
                      width: width,
                    )
                  : zoomablePhoto
                      ? _buildZoomablePhoto(context)
                      : cacheImage(context),
        ),
      ),
    );
  }

  Widget cacheImage(BuildContext context) {
    return CachedNetworkImage(
      fadeInDuration: const Duration(milliseconds: 10),
      fadeOutDuration: const Duration(milliseconds: 10),
      fit: BoxFit.scaleDown,
      imageUrl: imgURL,
      placeholder: (context, url) => Spinner(progressColor: Color(0xff90244c)),
      errorWidget: (ctx, url, obj) => Image.asset(errorImage),
    );
  }

  Widget _buildZoomablePhoto(BuildContext context) {
    return PhotoViewGallery(
      pageOptions: [
        PhotoViewGalleryPageOptions(
          heroAttributes: null,
          imageProvider: CachedNetworkImageProvider(
            imgURL,
          ),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
        )
      ],
      loadingBuilder: (context, url) =>
          Spinner(progressColor: Color(0xff90244c)),
      enableRotation: false,
    );
  }
}
