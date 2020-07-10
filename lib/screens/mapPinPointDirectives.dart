import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart';

class MapPinPointDirectives extends StatefulWidget {
  @override
  _MapPinPointDirectivesState createState() => _MapPinPointDirectivesState();
}

class _MapPinPointDirectivesState extends State<MapPinPointDirectives> {

  final PopupController _popupController = PopupController();

  @override
  Widget build(BuildContext context) {
    return flutterMap();
  }

  Widget flutterMap(){

    return FlutterMap(
      mapController: MapController(),

      options: MapOptions(
          plugins: [MarkerClusterPlugin()],
          onTap: (_)=>_popupController.hidePopup(),
          center: LatLng(-6.768142, 39.240166), zoom: 12.0),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
            tileProvider: CachedNetworkTileProvider()
        ),
        MarkerClusterLayerOptions(

          maxClusterRadius: 120,
          size: Size(40, 40),
          anchor: AnchorPos.align(AnchorAlign.center),
          fitBoundsOptions: FitBoundsOptions(
            padding: EdgeInsets.all(50),
          ),
          markers: <Marker>[
          Marker(
              anchorPos: AnchorPos.align(AnchorAlign.center),
              height: 30.0,
              width: 30.0,
              point: LatLng(-6.768142, 39.240166),
              builder: (context) => Container(
                child: Icon(
                  Icons.location_on,
                  size: 50,
                ),
              )),
        ],
          polygonOptions: PolygonOptions(
              borderColor: Colors.blueAccent,
              color: Colors.black12,
              borderStrokeWidth: 3),
          popupOptions: PopupOptions(
              popupSnap: PopupSnap.top,
              popupController: _popupController,
              popupBuilder: (_, marker) => Text("Location Name")),
          builder: (context, markers) {
            return FloatingActionButton(
              child: Text("markers.length.toString()"),
              onPressed: null,
            );
          },
        ),
      ],
    );
  }
}
