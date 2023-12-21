abstract class HomeLocationState {
  String locationFetched = "false";
  final double? latitude;
  final double? longitude;
  HomeLocationState({required this.locationFetched,this.latitude,this.longitude});
}


class HomeLocationLoadingState extends HomeLocationState{
  HomeLocationLoadingState(): super(locationFetched: "Loading");
}

class LocationLoaded extends HomeLocationState {
  LocationLoaded(double latitude, double longitude):super(locationFetched: "true",latitude: latitude, longitude: longitude);
}

class LocationError extends HomeLocationState {
  LocationError():super(locationFetched: "Something went wrong");
}