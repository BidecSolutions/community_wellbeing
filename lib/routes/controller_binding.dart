import 'package:get/get.dart';
import '../controllers/budget_management_controller.dart';
import '../controllers/debt_controller.dart';
import '../controllers/finance_controller.dart';
import '../controllers/login_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/financial_summary.dart';
import '../controllers/signup_controller.dart';

class LoginControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}

class SignupControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignupController());
  }
}

class HomeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class FinanceControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FinanceController());
  }
}

class BudgetManagementControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BudgetManagementController());
  }
}

class DebtManagementControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DebtManagement());
  }
}

class FinanceSummaryControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FinanceSummaryController());
  }
}

// class KnowWhatToDoWhenSickBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.put(KnowWhatToDoWhenSickController());
//   }
// }
