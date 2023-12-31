import 'package:card_swiper/card_swiper.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../services/server.dart';

class LoanController extends GetxController {
  var loanApplications = [].obs;
  var totalLoanAmount = 0.obs;
  SwiperController cardController = SwiperController();
  var currentCard = 1;

  getLoanApplications() async {
    if (GetStorage().read('accessToken') != null) {
      loanApplications.value = await Server.fetchLoans();
      totalLoanAmount.value = loanApplications.fold(
          0,
          (previousValue, element) =>
              int.parse(element['outstanding_balance']));
    }
  }

  @override
  void onInit() {
    getLoanApplications();

    super.onInit();
  }
}
