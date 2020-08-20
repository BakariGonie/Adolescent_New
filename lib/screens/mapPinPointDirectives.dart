import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PopupController _popupController = PopupController();

  List<Marker> markers;
  int pointIndex;
  List points = [
    LatLng(-6.7856693,39.2532623),
    LatLng(-6.8253978,39.2379426),
    LatLng(-6.8255787,39.3059719),
  ];

  @override
  void initState() {
    pointIndex = 0;
    markers = [
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: points[pointIndex],
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(-6.7856693,39.2532623),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(-6.8253978,39.2379426),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(-6.8255787,39.3059719),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
//      Marker(
//        anchorPos: AnchorPos.align(AnchorAlign.center),
//        height: 30,
//        width: 30,
//        point: LatLng(48.8566, 2.3522),
//        builder: (ctx) => Icon(Icons.pin_drop),
//      ),
//      Marker(
//        anchorPos: AnchorPos.align(AnchorAlign.center),
//        height: 30,
//        width: 30,
//        point: LatLng(49.8566, 3.3522),
//        builder: (ctx) => Icon(Icons.pin_drop),
//      ),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          pointIndex++;
          if (pointIndex >= points.length) {
            pointIndex = 0;
          }
          setState(() {
            markers[0] = Marker(

              point: points[pointIndex],
              anchorPos: AnchorPos.align(AnchorAlign.center),
              height: 30,
              width: 30,
              builder: (ctx) => Icon(Icons.pin_drop),
            );

            // one of this
            markers = List.from(markers);
            // markers = [...markers];
            // markers = []..addAll(markers);
          });
        },
      ),
      body: FlutterMap(
        options: MapOptions(
          center: points[0],
          zoom: 5,
          plugins: [
            MarkerClusterPlugin(),
          ],
          onTap: (_) => _popupController
              .hidePopup(), // Hide popup when the map is tapped.
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerClusterLayerOptions(
            maxClusterRadius: 120,
            size: Size(40, 40),
            anchor: AnchorPos.align(AnchorAlign.center),
            fitBoundsOptions: FitBoundsOptions(
              padding: EdgeInsets.all(50),
            ),
            markers: markers,
            polygonOptions: PolygonOptions(
                borderColor: Colors.blueAccent,
                color: Colors.black12,
                borderStrokeWidth: 3),
            popupOptions: PopupOptions(
                popupSnap: PopupSnap.top,
                popupController: _popupController,
                popupBuilder: (_, marker) => Container(
                  width: 200,
                  height: 100,
                  color: Colors.white,
                  child: GestureDetector(
                    onTap: () => debugPrint("Popup tap!"),
                    child: Text(
                      "Container popup for marker at ${marker.point}",
                    ),
                  ),
                )),
            builder: (context, markers) {
              return FloatingActionButton(
                child: Text(markers.length.toString()),
                onPressed: null,
              );
            },
          ),
        ],
      ),
    );
  }
}
