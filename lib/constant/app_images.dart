import 'constant.dart';

class AppImages{
  static  String profile=getProfile();

  static String getProfile() {

      if(myModel!.role=='user'){
        return 'images/profile.jpg';
      }else{
        return 'images/profileCrafts.jpg';
      }
  }
}