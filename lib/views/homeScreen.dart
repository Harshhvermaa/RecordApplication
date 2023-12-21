import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heartztask/bloc/homeScreen/home_bloc.dart';
import 'package:heartztask/bloc/homeScreen/home_event.dart';
import 'package:heartztask/bloc/homeScreen/home_state.dart';
import 'package:heartztask/constants/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heartztask/views/recordScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final Completer<GoogleMapController> _controller =  Completer<GoogleMapController>();
  late CameraPosition _kGooglePlex;
  double lat = 27.1751;
  double long = 78.0421;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeLocationBloc>().add(HomeGetLocationEvent());
    _kGooglePlex = CameraPosition(
        target: LatLng(lat, long),
        zoom: 25
    );
  }

  final List<Marker> _marker =  <Marker>[
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(27.1751, 78.0421),
        infoWindow: InfoWindow(title: "Your Current Position")
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  _appBar(context),
      body: BlocBuilder<HomeLocationBloc,HomeLocationState>(
        builder: (context, state) {
          if(state is LocationLoaded){
            lat = state.latitude!;
            long = state.longitude!;
            print("Location Loaded ${state.latitude} ${state.longitude}");
            _kGooglePlex = CameraPosition(
              target: LatLng(lat, long),
              zoom: 18, // Zoom level for the new location
            );
            _goToNewLocation();
            print("Location Loaded ${state.latitude} ${state.longitude}");
            return Container(
              height: Utils().SCREEN_HEIGHT(context),
              width: Utils().SCREEN_WIDTH(context),
              child: GoogleMap(
                initialCameraPosition: _kGooglePlex,
                markers: Set<Marker>.of(
                  [
                    Marker(
                        markerId: MarkerId("1"),
                        position: LatLng(state.latitude!, state.longitude!),
                        infoWindow: InfoWindow(title: "Your Current Position")
                    )
                  ]
                ),
                myLocationEnabled: true,
                compassEnabled: true,
                zoomControlsEnabled: false,
                mapToolbarEnabled: true,
                onCameraMove: (position) {
                },
                onMapCreated: (controller2) {
                },
              ),
            );
          }
          else{
            return Column(
              children: [
                SizedBox(height: 30,),
                Text("Fetching Location...",style: TextStyle(fontSize: 20),),
                SizedBox(height: 10,),
                Container(
                  height: Utils().SCREEN_HEIGHT(context)*0.7,
                  width: Utils().SCREEN_WIDTH(context),
                  child: GoogleMap(
                    initialCameraPosition: _kGooglePlex,
                    markers: Set<Marker>.of(_marker),
                    myLocationEnabled: true,
                    compassEnabled: true,

                    zoomControlsEnabled: false,
                    mapToolbarEnabled: true,
                    onCameraMove: (position) {
                    },
                    onMapCreated: (controller2) {
                    },
                  ),
                ),
              ],
            );
          }
        },
      )
    );
  }

  Future<void> _goToNewLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }

}

PreferredSizeWidget _appBar(BuildContext context) {
  return AppBar(
    title: Text("HomeScreen"),
    actions: [
      InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => RecordScreen(),));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 100,
            child: Center(child: Text("Record")),
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(18)
            ),
          ),
        ),
      )
    ],
  );
}


