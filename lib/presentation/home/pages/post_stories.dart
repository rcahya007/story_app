import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_app/core/assets/assets.gen.dart';

import 'package:story_app/core/constants/styles.dart';
import 'package:story_app/flavor_config.dart';
import 'package:story_app/presentation/home/bloc/get_all_stories/get_all_stories_bloc.dart';
import 'package:story_app/presentation/home/bloc/get_location/get_location_bloc.dart';
import 'package:story_app/presentation/home/bloc/show_image/show_image_bloc.dart';
import 'package:story_app/presentation/home/bloc/upload_image/upload_image_bloc.dart';

class PostStories extends StatefulWidget {
  const PostStories({
    super.key,
  });

  @override
  State<PostStories> createState() => _PostStoriesState();
}

class _PostStoriesState extends State<PostStories> {
  late final TextEditingController descC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  LatLng? location;

  @override
  void dispose() {
    descC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                              context.goNamed('Home');
                              context.read<GetAllStoriesBloc>().add(
                                  const GetAllStoriesEvent.getAllStories(null));
                              context
                                  .read<ShowImageBloc>()
                                  .add(const ShowImageEvent.setImage(null));
                              context.read<GetLocationBloc>().add(
                                  const GetLocationEvent.getLocation(null));
                            },
                            child: SvgPicture.asset(
                              Assets.icon.x1.path,
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
                    BlocConsumer<UploadImageBloc, UploadImageState>(
                      listener: (context, state) {
                        state.maybeWhen(
                          orElse: () {},
                          loadedUpload: (message) {
                            descC.clear();
                            context.goNamed('Home');
                            context.read<GetAllStoriesBloc>().add(
                                const GetAllStoriesEvent.getAllStories(null));
                            context
                                .read<GetLocationBloc>()
                                .add(const GetLocationEvent.getLocation(null));
                            context
                                .read<ShowImageBloc>()
                                .add(const ShowImageEvent.setImage(null));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(milliseconds: 500),
                                content: Text(message!),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          error: (message) =>
                              ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                            ),
                          ),
                        );
                      },
                      builder: (context, state) {
                        return state.maybeWhen(
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          orElse: () {
                            return BlocBuilder<ShowImageBloc, ShowImageState>(
                              builder: (context, state) {
                                return state.maybeWhen(
                                  orElse: () => GestureDetector(
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        await _onUpload(null, null);
                                      }
                                    },
                                    child: SvgPicture.asset(
                                      Assets.icon.upload.path,
                                      width: 24,
                                      height: 24,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  loaded: (imageFile) {
                                    return BlocListener<GetLocationBloc,
                                        GetLocationState>(
                                      listener: (context, state) {
                                        state.maybeWhen(
                                            orElse: () {},
                                            loaded: (latLng, address) {
                                              if (latLng != null) {
                                                location = latLng;
                                              }
                                            });
                                      },
                                      child: GestureDetector(
                                        onTap: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            await _onUpload(
                                                imageFile, location);
                                          }
                                        },
                                        child: SvgPicture.asset(
                                          Assets.icon.upload.path,
                                          width: 24,
                                          height: 24,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 3,
                child: BlocBuilder<ShowImageBloc, ShowImageState>(
                    builder: (context, state) {
                  return state.maybeWhen(
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    orElse: () => const Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.image,
                        size: 100,
                      ),
                    ),
                    loaded: (imagePath) {
                      if (imagePath == null) {
                        return const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.image,
                            size: 100,
                          ),
                        );
                      } else {
                        return _showImage(imagePath.path);
                      }
                    },
                  );
                }),
                // : _showImage(),
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () => _onGalleryView(),
                            child: const Text("Gallery"),
                          ),
                          ElevatedButton(
                            onPressed: () => _onCameraView(),
                            child: const Text("Camera"),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FlavorConfig.instance.flavor.name == 'free'
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child:
                                BlocBuilder<GetLocationBloc, GetLocationState>(
                              builder: (context, state) {
                                return state.maybeWhen(
                                    orElse: () => Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Expanded(
                                                child: Text(
                                              'No Location',
                                            )),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                context.goNamed('Gmaps');
                                              },
                                              child: const Text("Location"),
                                            ),
                                          ],
                                        ),
                                    loaded: (latLng, address) {
                                      if (latLng == null) {
                                        return Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Expanded(
                                                child: Text(
                                              'No Location',
                                            )),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                context.goNamed('Gmaps');
                                              },
                                              child: const Text("Location"),
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: Text(
                                              address,
                                            )),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                context.goNamed('Gmaps');
                                              },
                                              child:
                                                  const Text("Change Location"),
                                            ),
                                          ],
                                        );
                                      }
                                    });
                              },
                            ),
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

  _onUpload(XFile? image, LatLng? location) async {
    final ScaffoldMessengerState scaffoldMessengerState =
        ScaffoldMessenger.of(context);
    if (image == null) {
      return scaffoldMessengerState.showSnackBar(
        const SnackBar(content: Text("Please select image")),
      );
    }

    final imageFile = image;

    final fileName = imageFile.name;
    final bytes = await imageFile.readAsBytes();

    if (mounted) {
      context.read<UploadImageBloc>().add(UploadImageEvent.upload(
            bytes,
            fileName,
            descC.text,
            location,
          ));
    }
  }

  _onGalleryView() async {
    final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
    final isLinux = defaultTargetPlatform == TargetPlatform.linux;
    if (isMacOS || isLinux) return;

    final ImagePicker picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      if (mounted) {
        context.read<ShowImageBloc>().add(ShowImageEvent.setImage(pickedFile));
      }
    }
  }

  _onCameraView() async {
    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
    final isNotMobile = !(isAndroid || isiOS);
    if (isNotMobile) return;

    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      if (mounted) {
        context.read<ShowImageBloc>().add(ShowImageEvent.setImage(pickedFile));
      }
    }
  }

  Widget _showImage(String path) {
    return kIsWeb
        ? Image.network(
            path.toString(),
            fit: BoxFit.contain,
          )
        : Image.file(
            File(path.toString()),
            fit: BoxFit.contain,
          );
  }
}
