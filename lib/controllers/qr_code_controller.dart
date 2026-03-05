import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:async';

class QrCodeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var isEWallet = true.obs;
  var qrData = "Initial QR Code Data".obs;
  var timer = (2 * 60).obs;
  final totalTime = 2 * 60;
  double corporateBalance = 750.00;
  double personalBalance = 250.00; // Example

  double get totalBalance => corporateBalance + personalBalance;

  // Add this for smooth progress
  var progress = 0.0.obs;

  late AnimationController progressAnimationController;

  /// Add expansion states for each transaction
  var expandedStates = <bool>[].obs;

  /// Transactions list
  var transactions =
      <TransactionModel>[
        TransactionModel(
          title: "Salary",
          type: "Credit",
          amount: 50000,
          details: "Monthly salary credited",
        ),
        TransactionModel(
          title: "Electric Bill",
          type: "Debit",
          amount: 8000,
          details: "Paid electricity bill",
        ),
        TransactionModel(
          title: "Freelance Project",
          type: "Credit",
          amount: 15000,
          details: "Project payment received",
        ),
        TransactionModel(
          title: "Grocery",
          type: "Debit",
          amount: 6000,
          details: "Supermarket shopping",
        ),
      ].obs;

  // Filter type
  var selectedFilter = 'All'.obs;

  // Filtered list based on selectedFilter
  List<TransactionModel> get filteredTransactions {
    if (selectedFilter.value == 'All') {
      return transactions;
    } else {
      return transactions
          .where((tx) => tx.type == selectedFilter.value)
          .toList();
    }
  }

  @override
  void onInit() {
    super.onInit();

    // existing animation controller setup
    progressAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Start QR Timer
    _startQrTimer();

    // initialize expansion states
    expandedStates.value = List.generate(transactions.length, (index) => false);

    // reset expansion states on filter change
    ever(selectedFilter, (_) {
      expandedStates.value = List.generate(
        filteredTransactions.length,
        (index) => false,
      );
    });
  }

  /// Toggle one tile
  void toggleExpansion(int index, bool value) {
    expandedStates[index] = value;
    expandedStates.refresh();
  }

  void toggleScreen() {
    isEWallet.value = !isEWallet.value;
  }

  void _startQrTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (this.timer.value > 0) {
        this.timer.value--;
        // Update progress smoothly
        _updateProgress();
      } else {
        _updateQrCode();
        this.timer.value = 2 * 60;
        _updateProgress();
      }
    });
  }

  // Add this method for smooth progress update
  void _updateProgress() {
    double newProgress = 1 - (timer.value / totalTime.toDouble());
    progress.value = newProgress;
  }

  void _updateQrCode() {
    qrData.value = "New QR Code Data: ${DateTime.now().toString()}";
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "$minutes:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  @override
  void onClose() {
    progressAnimationController.dispose();
    super.onClose();
  }

  void changeFilter(String filter) {
    selectedFilter.value = filter;
  }
}

class TransactionModel {
  final String title;
  final String type; // "Credit" or "Debit"
  final double amount;
  final String details;

  TransactionModel({
    required this.title,
    required this.type,
    required this.amount,
    required this.details,
  });
}
