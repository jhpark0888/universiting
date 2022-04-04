// import 'package:get/get.dart';
// import 'package:universiting/controllers/profile_controller.dart';
// import 'package:universiting/models/host_model.dart';
// import 'package:universiting/models/profile_model.dart';

// class ProfileImageWidgetController extends GetxController{
//   ProfileImageWidgetController({required this.host,required this.profile});
//   Rx<Host?> host;
//   Rx<Profile?> profile;

//   @override
//   void onInit() {
//     checkMyProfile();
//     super.onInit();
//   }

//   void checkMyProfile() {
//     if (host.value != null) {
//       if (host.value!.userId == ProfileController.to.profile.value.userId) {
//         host = Host(
//             userId: ProfileController.to.profile.value.userId,
//             profileImage: ProfileController.to.profile.value.profileImage,
//             gender: 'M').obs;
//       }
//     }
//     if (profile.value != null) {
//       if (profile.value!.userId == ProfileController.to.profile.value.userId) {
//         profile = ProfileController.to.profile;
//       }
//     }
//   }
// }