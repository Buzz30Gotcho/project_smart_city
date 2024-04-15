import 'dart:io';

import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';

class ImageCard extends CardButton {
  ImageCard(BuildContext context,
      {Key? key, required dynamic image, GestureTapCallback? removeImage})
      : super(
            key: key,
            onPressed: null,
            margin: EdgeInsets.zero,
            child: SizedBox(
                width: (MediaQuery.of(context).size.width - normal_100 * 4) / 3,
                height:
                    (MediaQuery.of(context).size.width - normal_100 * 4) / 3,
                child: Stack(alignment: Alignment.topRight, children: [
                  Positioned.fill(
                      child: ClipRRect(
                          borderRadius: const BorderRadius.all(normalRadius),
                          child: FittedBox(
                              fit: BoxFit.cover,
                              child: (image is File)
                                  ? Image.file(image)
                                  : Image.network(image)))),
                  GestureDetector(
                      onTap: removeImage,
                      child: Container(
                          margin: const EdgeInsets.all(small_50),
                          padding: const EdgeInsets.all(small_100),
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(2 / 3),
                              borderRadius:
                                  const BorderRadius.all(normalRadius)),
                          child: const Icon(ProximityIcons.remove,
                              size: normal_100)))
                ])));
}
