
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'boardingList.dart';


abstract class boardingController extends GetxController{
  next();
  DotChanged(int pageNumber);

}

class boarding extends boardingController{
  late PageController nextPage;
  int currentPage = 0;


  @override
  next() {
    currentPage++;
    if ( currentPage> BoardingList.length -1)
    {
      Get.offAllNamed("/more");
    }
    else {
      nextPage.animateToPage(currentPage, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    }
  }



  @override
  DotChanged(int pageNumber) {
    currentPage = pageNumber;
    update();
  }

  @override

  void onInit(){
    nextPage = PageController();
    super.onInit();

  }

/*@override
  skip()
  {
    service.shared.setString("/step", "1");
    Get.offAllNamed("/login");
  }*/
}
