import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:story_app/presentation/home/bloc/get_location/get_location_bloc.dart';

class GmapsPage extends StatefulWidget {
  const GmapsPage({super.key});

  @override
  State<GmapsPage> createState() => _GmapsPageState();
}

class _GmapsPageState extends State<GmapsPage> {
  @override
  void initState() {
    super.initState();

    final marker = Marker(
      markerId: const MarkerId("home"),
      position: home,
      onTap: () {
        mapController.animateCamera(
          CameraUpdate.newLatLngZoom(home, 18),
        );
      },
    );
    markers.add(marker);
  }

  final home = const LatLng(-7.3549414, 112.7211254);
  late GoogleMapController mapController;
  late final Set<Marker> markers = {};
  MapType selectedMapType = MapType.normal;
  geo.Placemark? placemark;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  zoom: 18,
                  target: home,
                ),
                markers: markers,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                myLocationButtonEnabled: false,
                onMapCreated: (controller) async {
                  final info = await geo.placemarkFromCoordinates(
                      home.latitude, home.longitude);
                  final place = info[0];
                  final street = place.street!;
                  final address =
                      '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
                  setState(() {
                    placemark = place;
                  });
                  defineMarker(home, street, address);

                  setState(() {
                    mapController = controller;
                  });
                },
                onLongPress: (LatLng latLng) {
                  onLongPressGoogleMap(latLng);
                },
              ),
              Positioned(
                top: 16,
                right: 16,
                child: FloatingActionButton(
                  heroTag: "myLocation",
                  child: const Icon(Icons.my_location),
                  onPressed: () {
                    onMyLocationButtonPress();
                  },
                ),
              ),
              Positioned(
                top: 80,
                right: 16,
                child: Column(
                  children: [
                    FloatingActionButton.small(
                      heroTag: "zoom-in",
                      onPressed: () {
                        mapController.animateCamera(
                          CameraUpdate.zoomIn(),
                        );
                      },
                      child: const Icon(Icons.add),
                    ),
                    FloatingActionButton.small(
                      heroTag: "zoom-out",
                      onPressed: () {
                        mapController.animateCamera(
                          CameraUpdate.zoomOut(),
                        );
                      },
                      child: const Icon(Icons.remove),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 16,
                left: 16,
                child: FloatingActionButton.small(
                  heroTag: "close",
                  onPressed: () {
                    context.pop();
                    context
                        .read<GetLocationBloc>()
                        .add(const GetLocationEvent.getLocation(null));
                  },
                  child: const Icon(Icons.close),
                ),
              ),
              if (placemark == null)
                const SizedBox()
              else
                Positioned(
                  bottom: 16,
                  right: 16,
                  left: 16,
                  child: Column(
                    children: [
                      PlacemarkWidget(
                        placemark: placemark!,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        onPressed: () {
                          // print(markers.first.position);
                          context.goNamed('Upload');
                          context.read<GetLocationBloc>().add(
                              GetLocationEvent.getLocation(
                                  markers.first.position));
                        },
                        child: const Text(
                          'Get Location',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
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

  void defineMarker(LatLng latLng, String street, String address) {
    final marker = Marker(
      markerId: const MarkerId("home"),
      position: latLng,
      infoWindow: InfoWindow(
        title: street,
        snippet: address,
      ),
    );
    setState(() {
      markers.clear();
      markers.add(marker);
    });
  }

  void onMyLocationButtonPress() async {
    final Location location = Location();
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;
    late LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    final latLng = LatLng(locationData.latitude!, locationData.longitude!);

    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    final place = info[0];
    final street = place.street!;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {
      placemark = place;
    });

    defineMarker(latLng, street, address);

    mapController.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }

  void onLongPressGoogleMap(LatLng latLng) async {
    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    final place = info[0];
    final street = place.street!;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {
      placemark = place;
    });
    defineMarker(latLng, street, address);
    mapController.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }
}

class PlacemarkWidget extends StatelessWidget {
  const PlacemarkWidget({
    super.key,
    required this.placemark,
  });
  final geo.Placemark placemark;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      constraints: const BoxConstraints(maxWidth: 700),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 20,
            offset: Offset.zero,
            color: Colors.grey.withOpacity(0.5),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  placemark.street!,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  '${placemark.subLocality}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
