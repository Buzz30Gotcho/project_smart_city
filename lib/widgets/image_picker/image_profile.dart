import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proximity/config/config.dart';
import 'package:proximity/l10n/app_localizations.dart';
import 'package:proximity/widgets/buttons/tertiary_button.dart';
import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';

import 'image_card.dart';
import 'image_adder_card.dart';

class ImageProfile extends StatefulWidget {
  final int maxImages;
  final List<dynamic>? images;
  final ValueChanged<File> onImageAdded;
  // final ValueChanged<List<dynamic>> onImageAdded;
  final ValueChanged<int> onImageRemoved;
  final bool centered;

  const ImageProfile(
      {Key? key,
      this.maxImages = 0,
      required this.images,
      required this.onImageAdded,
      required this.onImageRemoved,
      this.centered = false})
      : super(key: key);

  @override
  _ImageProfileState createState() => _ImageProfileState();
}

class _ImageProfileState extends State<ImageProfile> {
  // Active image file
  final List<dynamic> _images = [];

  // Select an image from either the gallery or the camera
  Future<void> _pickImage(ImageSource source) async {
    ImagePicker _picker = ImagePicker();
    XFile? _selected = await _picker.pickImage(source: source);
    if (_selected != null) {
      setState(() {
        widget.onImageAdded.call(File(_selected.path));
        // _images.add(File(_selected.path));

        // widget.onImageAdded.call(_images);
      });
    }
  }

  // Remove an image
  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
      widget.onImageRemoved.call(index);
    });
  }

  List<Widget> _gridBuilder(List<dynamic> images) {
    List<Widget> _list = [];
    for (int i = 0; i < images.length; i++) {
      _list.add(ImageCard(context, image: _images[i], removeImage: () {
        _removeImage(i);
      }));
    }

    return _list;
  }

  @override
  void initState() {
    super.initState();
    if (widget.images != null || widget.images != []) {
      _images.addAll(widget.images!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images!.isNotEmpty && widget.images!.first != null) {
      return Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(normal_100),
              child: Wrap(
                  spacing: normal_100,
                  runSpacing: normal_100,
                  alignment: widget.centered
                      ? WrapAlignment.center
                      : WrapAlignment.start,
                  children: [
                    ImageProfileCard(context, image: widget.images!.first)
                  ])),
          Padding(
            padding: const EdgeInsets.all(normal_100).copyWith(top: 0),
            child: TertiaryButton(
                onPressed: () {
                  _pickImage(ImageSource.gallery);
                  //await userEditValidation.getBottomSheet(context);
                },
                title: AppLocalizations.of(context)!.editProfileImage),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(normal_100),
              child: Wrap(
                  spacing: normal_100,
                  runSpacing: normal_100,
                  alignment: widget.centered
                      ? WrapAlignment.center
                      : WrapAlignment.start,
                  children: [
                    ImageCard(
                      context,
                      image:
                          "https://cdn-icons-png.flaticon.com/512/5853/5853761.png",
                    )
                  ])),
          Padding(
            padding: const EdgeInsets.all(normal_100).copyWith(top: 0),
            child: TertiaryButton(
                onPressed: () {
                  _pickImage(ImageSource.gallery);

                  //await userEditValidation.getBottomSheet(context);
                },
                title: AppLocalizations.of(context)!.editProfileImage),
          ),
        ],
      );
    }
  }
}

class ImageProfileCard extends CardButton {
  ImageProfileCard(BuildContext context,
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
                ])));
}

/// Old good ImageCapture
/*
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/variant_creator.dart';
import 'package:ishop_package/config/config.dart';
import 'package:ishop_package/widgets/image_picker/image_adder_button.dart';
import 'package:ishop_package/widgets/image_picker/variant_card.dart';
class ImageCapture extends StatefulWidget {
  final int maxImages;
  final ValueChanged<List<File>> onImageAdded;
  final ValueChanged<int> onImageRemoved;
  final bool centered;
  const ImageCapture(
      {Key key,
      this.maxImages = 0,
      this.onImageAdded,
      this.onImageRemoved,
      this.centered = false})
      : super(key: key);
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}
class _ImageCaptureState extends State<ImageCapture> {
  // Active image file
  List<File> _imageFiles = [];
  // Select an image from either the gallery or the camera
  Future<void> _pickImage(ImageSource source) async {
    ImagePicker _picker = ImagePicker();
    XFile _selected = await _picker.pickImage(source: source);
    if (_selected != null)
      setState(() {
        _imageFiles.add(File(_selected.path));
        this.widget.onImageAdded?.call(_imageFiles);
      });
  }
  // Remove an image
  void _removeImage(int index) {
    this.widget.onImageRemoved?.call(index);
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(normal_100),
      child: Wrap(
        spacing: small_100,
          runSpacing: small_100,
          alignment: this.widget.centered? WrapAlignment.center : WrapAlignment.start,
          /*shrinkWrap: true,
          primary: false,
          padding: const EdgeInsets.all(normal_100),
          crossAxisSpacing: normal_100,
          mainAxisSpacing: normal_100,
          crossAxisCount: 3,*/
          children: _gridBuilder(_imageFiles)),
    );
  }
  List<Widget> _gridBuilder(List<File> imageFiles) {
    List<Widget> _list = [];
    for (int i = 0; i < imageFiles.length; i++)
      _list.add(
        ImageCard(
          context,
          imageFile: _imageFiles[i],
          removeImage: () {
            _removeImage(i);
          },
        ),
      );
    if (this.widget.maxImages > imageFiles.length)
      _list.add(
        ImageAdderButton(
          context,
          onPressed: () => _pickImage(ImageSource.gallery),
        ),
      );
    return _list;
  }
}
 */
