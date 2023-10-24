import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MyGeolocator extends StatefulWidget {
  @override
  _MyGeolocatorState createState() => _MyGeolocatorState();
}

class _MyGeolocatorState extends State<MyGeolocator> {
  GoogleMapController? _mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  int _markerIdCounter = 1;
  var locationMessage = '';
  CameraPosition _initialPosition = CameraPosition(
    target: LatLng(0, 0), // 초기 위치 설정
    zoom: 10, // 줌 레벨 설정
  );

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    // _checkLocationPermission();
  }

  void _getCurrentLocation() async {
    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // 위치 정보를 가져와서 지도에 표시
    setState(() {
      _initialPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 15,
      );
    });

    // 위치 마커를 추가
    _addMarker(LatLng(position.latitude, position.longitude));
  }

  void _addMarker(LatLng position) {
    final int markerCount = markers.length;

    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;

    final MarkerId markerId = MarkerId(markerIdVal);
    Marker marker = Marker(
      markerId: markerId,
      position: position,
      infoWindow: InfoWindow(title: '내 위치'),
    );

    setState(() {
      markers[markerId] = marker;
    });

  }

  void _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always) {
      locationMessage = '항상 위치 접근 권한이 허용되었습니다.';
    } else if (permission == LocationPermission.whileInUse) {
      locationMessage = '앱을 사용하는 동안 위치 접근 권한이 허용되었습니다.';
    } else if (permission == LocationPermission.denied) {
      locationMessage = '위치 접근 권한이 거부되었습니다. 권한을 설정하세요.';
    } else if (permission == LocationPermission.deniedForever) {
      locationMessage = '위치 접근 권한이 영구적으로 거부되었습니다. 설정에서 권한을 활성화하세요.';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 위치 지도'),
      ),
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        markers: Set<Marker>.of(markers.values),
      ),
    );
  }
}
