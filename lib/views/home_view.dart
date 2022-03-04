import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:universiting/controllers/map_controller.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final MapController _mapController = Get.put(MapController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      OverlayImage.fromAssetImage(
        assetName: 'assets/icons/marker.png',
      ).then((image) {
        _mapController.markers.add(Marker(
            markerId: 'id',
            position: LatLng(37.563600, 126.962370),
            captionText: '한양대학교',
            captionColor: Colors.indigo,
            captionTextSize: 14.0,
            icon: image,
            anchor: AnchorPoint(0.5, 1),
            width: 45,
            height: 45,
            onMarkerTab: onMarkerTap));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
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
    );
  }

  void onMapCreated(NaverMapController controller) {
    _mapController.nMapController.complete(controller);
    setState(() {});
  }

  void onMarkerTap(Marker? marker, Map<String, int?>? iconSize) {
    int pos = _mapController.markers
        .indexWhere((m) => m.markerId == marker?.markerId);
    _mapController.markers[pos].captionText = '선택됨';
    setState(() {});
    // _name.value = '선택됨';
    // Get.dialog(Container(
    //   child: Text('as'),
    // ));
    // if (currentMode.value == MODE_REMOVE) {
    //   markers.removeWhere((m) => m.markerId == marker?.markerId);
    // }
  }
}
