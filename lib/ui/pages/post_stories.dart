import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:story_app/core/styles.dart';
import 'package:story_app/gen/assets.gen.dart';
import 'package:story_app/provider/post_page_provider.dart';
import 'package:story_app/provider/stories_provider.dart';
import 'package:story_app/provider/upload_provider.dart';

class PostStories extends StatefulWidget {
  final dynamic Function() onUpload;
  const PostStories({
    super.key,
    required this.onUpload,
  });

  @override
  State<PostStories> createState() => _PostStoriesState();
}

class _PostStoriesState extends State<PostStories> {
  late final TextEditingController descC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    descC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              widget.onUpload();
                              context.read<StoriesProvider>().getStories();
                            },
                            child: SvgPicture.asset(
                              Assets.icon.x1,
                              width: 25,
                              height: 25,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          const Text(
                            'New Stories',
                            style: heading,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await _onUpload();
                          if (context.mounted) {
                            context.read<StoriesProvider>().getStories();
                            widget.onUpload();
                          }
                        }
                      },
                      child: context.watch<UploadProvider>().isUploading
                          ? const CircularProgressIndicator()
                          : SvgPicture.asset(
                              Assets.icon.upload,
                              width: 25,
                              height: 25,
                              fit: BoxFit.contain,
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 3,
                child: context.watch<PostPageProvider>().imagePath == null
                    ? const Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.image,
                          size: 100,
                        ),
                      )
                    : _showImage(),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter description';
                      }
                      return null;
                    },
                    controller: descC,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description',
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => _onGalleryView(),
                      child: const Text("Gallery"),
                    ),
                    ElevatedButton(
                      onPressed: () => _onCameraView(),
                      child: const Text("Camera"),
                    ),
                    ElevatedButton(
                      onPressed: () => _onCustomCameraView(),
                      child: const Text("Custom Camera"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onUpload() async {
    final ScaffoldMessengerState scaffoldMessengerState =
        ScaffoldMessenger.of(context);

    final postPageProvider = context.read<PostPageProvider>();
    final uploadProvider = context.read<UploadProvider>();

    final imagePath = postPageProvider.imagePath;
    final imageFile = postPageProvider.imageFile;
    if (imagePath == null || imageFile == null) {
      return scaffoldMessengerState.showSnackBar(
        const SnackBar(content: Text("Please select image")),
      );
    }
    final fileName = imageFile.name;
    final bytes = await imageFile.readAsBytes();

    final newBytes = await uploadProvider.compressImage(bytes);

    await uploadProvider.upload(
      newBytes,
      fileName,
      descC.text,
    );

    if (uploadProvider.uploadResponse != null) {
      postPageProvider.setImageFile(null);
      postPageProvider.setImagePath(null);
    }

    scaffoldMessengerState.showSnackBar(
      SnackBar(content: Text(uploadProvider.message)),
    );
    descC.clear();
  }

  _onGalleryView() async {
    final provider = context.read<PostPageProvider>();

    final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
    final isLinux = defaultTargetPlatform == TargetPlatform.linux;
    if (isMacOS || isLinux) return;

    final ImagePicker picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

  _onCameraView() async {
    final provider = context.read<PostPageProvider>();

    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
    final isNotMobile = !(isAndroid || isiOS);
    if (isNotMobile) return;

    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

  _onCustomCameraView() async {}

  Widget _showImage() {
    final imagePath = context.read<PostPageProvider>().imagePath;
    return kIsWeb
        ? Image.network(
            imagePath.toString(),
            fit: BoxFit.contain,
          )
        : Image.file(
            File(imagePath.toString()),
            fit: BoxFit.contain,
          );
  }
}
