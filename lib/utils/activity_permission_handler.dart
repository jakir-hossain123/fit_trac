import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestActivityPermission() async {

  // physical activity permission
  PermissionStatus activityStatus = await Permission.activityRecognition.request();
  bool activityGranted = activityStatus.isGranted;

  if (!activityGranted) {
    print("Physical Activity Permission Denied.");
  }


  // foreground permission (gps)
  LocationPermission locationPermission = await Geolocator.requestPermission();
  bool locationGranted = (locationPermission == LocationPermission.whileInUse ||
      locationPermission == LocationPermission.always);

  if (!locationGranted) {
    print("Foreground Location Permission Denied.");
    return false;
  }


  // background permission (Android)
  if (await Geolocator.checkPermission() == LocationPermission.whileInUse) {
    PermissionStatus backgroundStatus = await Permission.locationAlways.request();

    if (backgroundStatus.isGranted) {
      print("Background Location Permission Granted.");
      return true;
    } else {
      print("Background Location Permission Denied, proceeding with Foreground only.");
      return true;
    }
  }

  return activityGranted && locationGranted;
}