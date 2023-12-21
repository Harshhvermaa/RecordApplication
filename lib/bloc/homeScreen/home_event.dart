abstract class HomeLocationEvent {}

class HomeGetLocationEvent extends HomeLocationEvent {}

class LocationFetchedEvent extends HomeLocationEvent {}

class LocationFailedEvent extends HomeLocationEvent {}