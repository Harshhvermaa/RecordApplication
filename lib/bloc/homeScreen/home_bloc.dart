import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:heartztask/bloc/homeScreen/home_event.dart';
import 'package:heartztask/bloc/homeScreen/home_state.dart';

class HomeLocationBloc extends Bloc<HomeLocationEvent, HomeLocationState> {
  HomeLocationBloc() : super(HomeLocationLoadingState()){
    on<HomeGetLocationEvent>((event, emit) async{
      emit(HomeLocationLoadingState());
      try {
        bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          print("Location services are disabled.");
          throw 'Location services are disabled.';
        }
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            print("Location permissions are denied.");
            throw 'Location permissions are denied.';
          }
        }

        if (permission == LocationPermission.deniedForever) {
          print("Location permissions are permanently denied, we cannot request permissions.");
          throw 'Location permissions are permanently denied, we cannot request permissions.';
        }

        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        print("Positon $position");
        emit( LocationLoaded( position.latitude, position.longitude));
      } catch (e) {
        emit(LocationError()) ;
      }
    });
  }
}