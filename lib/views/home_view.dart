import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:universiting/controllers/map_controller.dart';

class HomeView extends StatelessWidget {
  final MapController _mapController = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  NaverMap(
                    initialCameraPosition:
                        CameraPosition(target: LatLng(37.563600, 126.962370)),
                    onMapCreated: onMapCreated,
                    // onMapTap: _onMapTap,
                    markers: _mapController.markers,
                    initLocationTrackingMode: LocationTrackingMode.Follow,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onMapCreated(NaverMapController controller) {
    _mapController.nMapController.complete(controller);
  }
}
