import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';
import 'package:redeem/custom_widget/CustomInfoWindow.dart';
import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/json_db/utils.dart';
import 'package:redeem/screens/home_screen/home_screen.dart';
import 'package:redeem/screens/providers/providers.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:redeem/globals.dart' as globals;
import 'package:location/location.dart';
import 'package:google_maps_flutter_platform_interface/src/types/marker_updates.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'dart:ui'
    as ui; // imported as ui to prevent conflict between ui.Image and the Image widget
import 'dart:math'
    as math; // imported as ui to prevent conflict between ui.Image and the Image widget

// ignore: must_be_immutable
class MapScreen extends StatefulWidget {
  String? providername;
  MapScreen({super.key, this.providername});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int? category_id;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey();
  String mapStyle = "";
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  bool pressMarker = false;
  SimpleProvider? selectedProvider;
  List<Marker> markers = [];
  int MapId = 0;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(23.885942, 45.079162),
    zoom: 14.4746,
  );

  // Set<Marker> myMarker = {
  //   Marker(
  //     markerId: MarkerId("1"),
  //     position: LatLng(37.42796133580664, -122.085749655962),
  //     infoWindow: InfoWindow(title: "${}"),
  //   )
  // };
  double default_lat = 23.885942;
  double default_lng = 45.079162;
  double default_zoom = 14;

  double lat = 0;
  double lng = 0;
  double zoom = 0;
  bool is_init_location = false;

  _getLocation() async {
    var location = new Location();
    try {
      location.requestPermission();
      location.getLocation().then((value) {
        lat = value.latitude ?? default_lat;
        lng = value.longitude ?? default_lng;
        zoom = default_zoom;

        _kGooglePlex = CameraPosition(
          target: LatLng(lat, lng),
          zoom: zoom,
        );
        is_init_location = true;
        setState(() {});
        getData();
      }).catchError((err) {
        lat = default_lat;
        lng = default_lng;
        zoom = default_zoom;
        _kGooglePlex = CameraPosition(
          target: LatLng(default_lat, default_lng),
          zoom: zoom,
        );
        is_init_location = true;
        setState(() {});
        getData();
      });
    } on Exception {
      lat = default_lat;
      lng = default_lng;
      zoom = default_zoom;
      _kGooglePlex = CameraPosition(
        target: LatLng(default_lat, default_lng),
        zoom: zoom,
      );
      is_init_location = true;
      setState(() {});
      getData();
    }
  }

  @override
  void initState() {
    globals.categories.forEach((cat) async {
      final pictureInfo = await vg.loadPicture(
          SvgNetworkLoader(
            cat.icon!,
          ),
          null);

      // double devicePixelRatio = ui.window.devicePixelRatio;
      // int width = (60).toInt();
      // int height = (60).toInt();

      // final scaleFactor = math.min(
      //   width / pictureInfo.size.width,
      //   height / pictureInfo.size.height,
      // );

      // final recorder = ui.PictureRecorder();

      // ui.Canvas(recorder)
      //   ..scale(scaleFactor)
      //   ..drawPicture(pictureInfo.picture);

      // final rasterPicture = recorder.endRecording();

      // final image = rasterPicture.toImageSync(width, height);
      // final bytes = (await image.toByteData(format: ui.ImageByteFormat.png))!;
      // globals.bytesMarkerCatgories
      //     .addAll({cat.id!: bytes.buffer.asUint8List()});
      // return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());

      String iconurl =
          'https://cdn.mapmarker.io/api/v1/font-awesome/v4/pin?icon=fa-circle&size=80&hoffset=0&voffset=-1&background=${cat.color!.replaceAll("#", "")}';
      var request = await http.get(Uri.parse(iconurl));
      var bytes = request.bodyBytes;
      globals.bytesMarkerCatgories
          .addAll({cat.id!: bytes.buffer.asUint8List()});
      // DrawableRoot sd=
    });
    super.initState();
    _getLocation();
    rootBundle.loadString('assets/mapStyle.txt').then((string) {
      mapStyle = string;
    });
  }

  String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  bool getting_data = false;
  List<SimpleProvider> providers = [];

  getData() {
    print("getting_data ${getting_data} ${lat} ${lng}");
    if (getting_data == false) {
      getting_data = true;
      JsonDb().getProviderByLocation(lat, lng, category_id).then((res) {
        List<Marker> updatedMarkers = [];
        if (res.success) {
          providers = res.data;
          providers.forEach((element) {
            String markerIdx = "${element.id!}marker${getRandomString(25)}";
            final MarkerId markerId = MarkerId(markerIdx);
            updatedMarkers.add(
              Marker(
                  markerId: MarkerId(markerIdx),
                  flat: true,
                  anchor: Offset(0, 0),
                  consumeTapEvents: true,
                  icon: BitmapDescriptor.fromBytes(
                      globals.bytesMarkerCatgories[element.providerCategoryId]),
                  /* icon :BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hue), */
                  zIndex: 111,
                  position:
                      LatLng(element.lattitude ?? 0, element.longtude ?? 0),
                  onTap: () {
                    pressMarker = true;
                    selectedProvider = element;
                    setState(() {});
                  }),
            );
          });
          print("markers.length ${markers.length}");
        } else {
          providers = [];
          /* markers = []; */
        }

        setState(() {
          var updates = MarkerUpdates.from(
              Set<Marker>.from(markers), Set<Marker>.from(updatedMarkers));
          markers = [];
          markers = updatedMarkers;

          /*    GoogleMapsFlutterPlatform.instance
              .updateMarkers(updates, mapId: MapId);
 */
          getting_data = false;
          //swap of markers so that on next marker update the previous marker would be the one which you updated now.
// And even on the next app startup, it takes the updated markers to show on the map.
        });
      }).catchError((onError) {
        getting_data = false;
      });
    }
  }

  openMarker(markerId) {
    print("provider_id");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: CustomBackButton(),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          SizedBox(
            width: 142,
            child: Center(
              child: SmartSelect<int>.single(
                choiceActiveStyle:
                    const S2ChoiceStyle(color: CustomColors.primarycolor),
                selectedValue: category_id ?? 0,
                title: "",
                tileBuilder: (context, value) {
                  return InkWell(
                      onTap: () {
                        value.showModal();
                      },
                      child: Padding(
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 2),
                        child: value.selected.title != null
                            ? Text(
                                "${value.selected.title}",
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.black),
                              )
                            : Text(
                                S.of(context).category,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                      ));
                },
                modalHeaderStyle: S2ModalHeaderStyle(
                    iconTheme: IconThemeData(color: CustomColors.primarycolor),
                    backgroundColor: CustomColors.backgroundcolor_for_Ticket),
                choiceStyle: S2ChoiceStyle(
                    color: CustomColors.backgroundcolor_for_Ticket),
                placeholder: "",
                choiceItems: [
                  ...globals.categories.map((e) {
                    return S2Choice(
                        title: e.getPropertyEffectedByLang(
                            "name_${globals.SelectedLang}"),
                        value: e.id!);
                  })
                ],
                onChange: (res) {
                  category_id = res.value;
                  getData();
                },
              ),
            ),
          ),
        ],
        title: SizedBox(
          width: 130,
          height: 40,
          child: TextFormField(
            onEditingComplete: () async {},
            decoration: InputDecoration(
              contentPadding: const EdgeInsetsDirectional.symmetric(
                  vertical: 5, horizontal: 5),
              hintText: S.of(context).search,
              hintStyle: CustomTheme.text_grey15theme.copyWith(
                  fontWeight: FontWeight.normal, color: Colors.grey.shade500),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: CustomColors.backgroundcolor_for_Ticket)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: CustomColors.backgroundcolor_for_Ticket)),
              filled: true,
              fillColor: CustomColors.backgroundcolor_for_Ticket,
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(10),
              // )
            ),
            onChanged: (value) async {},
            onSaved: (newValue) {},
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          key: refreshIndicatorKey,
          onRefresh: () async {
            await getData();
          },
          child: Stack(
            children: [
              !is_init_location
                  ? Container()
                  : GoogleMap(
                      compassEnabled: true,
                      trafficEnabled: false,
                      tiltGesturesEnabled: true,
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      mapToolbarEnabled: true,
                      markers: Set<Marker>.of(markers),
                      mapType: MapType.normal,
                      onTap: (position) {
                        pressMarker = false;
                        setState(() {});
                      },
                      onCameraMove: (position) {
                        //_customInfoWindowController.onCameraMove!();
                        lat = position.target.latitude;
                        lng = position.target.longitude;

                        getData();
                      },
                      initialCameraPosition: _kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                      //  controller.animateCamera(CameraUpdate.newLatLng(LatLng(latitude, longitude)))
                        controller.setMapStyle(mapStyle);
                        MapId = controller.mapId;
                        _controller.complete(controller);
                        _customInfoWindowController.googleMapController =
                            controller;
                      },
                    ),
              Positioned(
                top: 20,
                left: 15,
                child: pressMarker == true
                    ? MyCustomInfoWindow(selectedProvider!)
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
