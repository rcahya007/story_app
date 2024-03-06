import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:story_app/presentation/home/bloc/get_detail_stories/get_detail_stories_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:geocoding/geocoding.dart' as geo;

import 'package:story_app/core/assets/assets.gen.dart';
import 'package:story_app/core/constants/styles.dart';

class DetailStories extends StatefulWidget {
  final String storiesId;
  const DetailStories({
    super.key,
    required this.storiesId,
  });

  @override
  State<DetailStories> createState() => _DetailStoriesState();
}

class _DetailStoriesState extends State<DetailStories> {
  String? dataLocaiton;
  bool readMore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<GetDetailStoriesBloc, GetDetailStoriesState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const SizedBox();
                },
                loading: () => SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                loaded: (data) {
                  String timeString = data.story!.createdAt.toString();
                  DateTime dateTime = DateTime.parse(timeString);
                  DateTime now = DateTime.now();
                  String timeAgo =
                      timeago.format(now.subtract(now.difference(dateTime)));
                  if (data.story!.lat == null || data.story!.lon == null) {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.goNamed('Home');
                                },
                                child: SvgPicture.asset(
                                  Assets.icon.arrowLeft1.path,
                                  height: 24,
                                  width: 24,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.amber,
                                    backgroundImage: NetworkImage(
                                      'https://ui-avatars.com/api/?name=${data.story!.name}',
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      data.story!.name!,
                                      style: body3,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    timeAgo,
                                    style: body4.copyWith(
                                      color: const Color(0xffBDBDBD),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Image.network(
                          data.story!.photoUrl!,
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width,
                          height: 400,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '125',
                                    style: body4.copyWith(
                                      color: const Color(0xffBDBDBD),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  SvgPicture.asset(
                                    Assets.icon.eye.path,
                                    height: 20,
                                    width: 20,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '125',
                                    style: body4.copyWith(
                                      color: const Color(0xffBDBDBD),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  SvgPicture.asset(
                                    Assets.icon.chatFill.path,
                                    height: 20,
                                    width: 20,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '125',
                                    style: body4.copyWith(
                                      color: const Color(0xffBDBDBD),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  SvgPicture.asset(
                                    Assets.icon.heartFill.path,
                                    height: 20,
                                    width: 20,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(
                            top: 10.25,
                            bottom: 16,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Description',
                                style: title1,
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                data.story!.description!,
                                style: body4.copyWith(
                                  color: const Color(0xffBDBDBD),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    final home = LatLng(data.story!.lat, data.story!.lon);
                    getDataLocation(home);
                    return Column(
                      children: [
                        Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  top: 5,
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        context.goNamed('Home');
                                      },
                                      child: const Icon(
                                        Icons.close,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                data.story!.name!,
                                style: body3,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 5,
                                ),
                                child: Column(
                                  children: [
                                    Image.network(
                                      data.story!.photoUrl!,
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                      height: 200,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          readMore = !readMore;
                                        });
                                      },
                                      child: Column(
                                        children: [
                                          Text(
                                            data.story!.description!,
                                            maxLines: readMore ? null : 2,
                                            overflow: readMore
                                                ? TextOverflow.visible
                                                : TextOverflow.ellipsis,
                                          ),
                                          data.story!.description!.length > 50
                                              ? Text(
                                                  readMore
                                                      ? 'Read Less'
                                                      : 'Read More',
                                                  style: body4.copyWith(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              width: MediaQuery.of(context).size.width,
                              color: whiteColor,
                              child: const Text(
                                'Location',
                                style: title1,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: 500,
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: home,
                                  zoom: 18,
                                ),
                                markers: {
                                  Marker(
                                    markerId: const MarkerId('home'),
                                    position: home,
                                    infoWindow: InfoWindow(
                                      title: 'Lokasi',
                                      snippet: dataLocaiton,
                                    ),
                                  ),
                                },
                                zoomControlsEnabled: false,
                                mapToolbarEnabled: false,
                                myLocationButtonEnabled: false,
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            )
                          ],
                        ),
                        // Expanded(
                        //   child: GoogleMap(
                        //     initialCameraPosition: CameraPosition(
                        //       target: home,
                        //       zoom: 18,
                        //     ),
                        //     markers: {
                        //       Marker(
                        //         markerId: const MarkerId('home'),
                        //         position: home,
                        //         infoWindow: InfoWindow(
                        //           title: 'Lokasi',
                        //           snippet: dataLocaiton,
                        //         ),
                        //       ),
                        //     },
                        //     zoomControlsEnabled: false,
                        //     mapToolbarEnabled: false,
                        //     myLocationButtonEnabled: false,
                        //   ),
                        // ),
                      ],
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  getDataLocation(LatLng dataLocation) async {
    try {
      final info = await geo.placemarkFromCoordinates(
          dataLocation.latitude, dataLocation.longitude);
      final place = info[0];
      final street = place.street!;
      final address =
          '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
      setState(() {
        dataLocaiton = '$street, $address';
      });
    } catch (e) {
      setState(() {
        dataLocaiton = 'Location not available';
      });
    }
  }
}
