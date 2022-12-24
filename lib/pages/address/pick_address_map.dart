import 'package:flutter/material.dart';
import 'package:foodapp/base/custom_button.dart';
import 'package:foodapp/controllers/location_controller.dart';
import 'package:foodapp/pages/address/widgets/search_location_dialogue_page.dart';
import 'package:foodapp/routes/route_helper.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;

  const PickAddressMap({Key? key,
    required this.fromSignup,
    required this.fromAddress,
    this .googleMapController
  }) : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initalPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(Get.find<LocationController>().addressList.isEmpty){
      _initalPosition = LatLng(45.521563, -122.677433);
      _cameraPosition = CameraPosition(target: _initalPosition, zoom: 17);
    }else{
      if(Get.find<LocationController>().addressList.isNotEmpty){
        _initalPosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress["latitude"]),
            double.parse(Get.find<LocationController>().getAddress["longtude"]));
        _cameraPosition = CameraPosition(target: _initalPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController){
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: Stack(
                children: [
                  GoogleMap(initialCameraPosition: CameraPosition(
                      target: _initalPosition, zoom: 17),
                    zoomControlsEnabled: false,
                    onCameraMove: (CameraPosition cameraPosition){
                      _cameraPosition = cameraPosition;
                    },
                    onCameraIdle: (){
                      Get.find<LocationController>().updatePosition(_cameraPosition, false);
                    },
                    onMapCreated: (GoogleMapController mapController){
                      _mapController = mapController;
                    },
                  ),
                  Center(
                    child: !locationController.loading
                        ? Image.asset("assets/image/pick_markder.jpg",
                      height: Dimensions.height10*5,
                      width: Dimensions.height10*5,) : CircularProgressIndicator(),
                  ),

                  /*showing and selecting address*/
                  Positioned(top: Dimensions.height45,
                  left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: InkWell(
                      onTap: ()=> Get.dialog(LocationDialogue(mapController: _mapController)),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.width10,
                        ),
                        height: Dimensions.height10*5,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(Dimensions.radius20/2),
                        ),
                        child: Row(
                          children: [
                          Icon(Icons.location_on,
                            size: Dimensions.iconSize24,
                            color: AppColors.yellowColor),
                          Expanded(
                              child: Text(
                                '${locationController.pickPlacemark.name??''}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.font16
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                          ),
                            SizedBox(width: Dimensions.width10),
                            Icon(Icons.search, size: Dimensions.iconSize24, color: AppColors.yellowColor)
                        ]),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: Dimensions.width20*4,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      child: locationController.isLoading
                          ? Center(child: CircularProgressIndicator())
                          : CustomButton(
                        //width: Dimensions.width20*10,
                        buttonText: locationController.inZone
                            ? widget.fromAddress
                              ? 'Pick Address'
                              : 'Pick Location'
                            : 'Service is not availabel in your area',
                        onPressed: (locationController.buttonDisabled || locationController.loading) ? null : (){
                          if(locationController.pickPosition.latitude != 0 &&
                              locationController.pickPlacemark.name != null){
                            if(widget.fromAddress){
                              if(widget.googleMapController != null){
                                print("now you can clicked on this ");
                                widget.googleMapController!.moveCamera(
                                    CameraUpdate.newCameraPosition(CameraPosition(
                                        target: LatLng(
                                            locationController.pickPosition.latitude,
                                            locationController.pickPosition.longitude
                                        ))));
                                locationController.setAddAddressData();
                              }
                              //Get.
                              Get.toNamed(RouteHelper.getAddressPage());
                            }
                          }
                        },
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
