import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geo;

part 'get_location_event.dart';
part 'get_location_state.dart';
part 'get_location_bloc.freezed.dart';

class GetLocationBloc extends Bloc<GetLocationEvent, GetLocationState> {
  GetLocationBloc() : super(const _Initial()) {
    on<_GetLocation>((event, emit) async {
      if (event.latLng == null) {
        emit(const _Loaded(null, 'No Location'));
      } else {
        final info = await geo.placemarkFromCoordinates(
            event.latLng!.latitude, event.latLng!.longitude);
        final place = info[0];
        final street = place.street!;
        final address =
            '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
        emit(_Loaded(event.latLng, '$street, $address'));
      }
    });
  }
}
