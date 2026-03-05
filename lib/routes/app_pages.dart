import 'package:community_app/screens/e_store/cartscreen.dart';
import 'package:community_app/screens/e_store/checkoutscreen.dart';
import 'package:community_app/screens/e_store/e_store.dart';
import 'package:community_app/screens/e_store/orders.dart';
import 'package:community_app/screens/e_store/product_detail.dart';
import 'package:community_app/screens/e_store/trackingorderscreen.dart';
import 'package:community_app/screens/education_employment/coach_profile.dart';
import 'package:community_app/screens/education_employment/coaches.dart';
import 'package:community_app/screens/education_employment/license_quiz_start.dart';
import 'package:community_app/screens/education_employment/ready_for_license.dart';
import 'package:community_app/screens/education_employment/real_stories.dart';
import 'package:community_app/screens/education_employment/real_stories_inspire.dart';
import 'package:community_app/screens/education_employment/scholarship_form.dart';
import 'package:community_app/screens/education_employment/scholarship_hub.dart';
import 'package:community_app/screens/History/history_details.dart';
import 'package:community_app/screens/History/history.dart';
import 'package:community_app/screens/culture/culture_community.dart';
import 'package:community_app/screens/culture/do_you_know_your_culture.dart';
import 'package:community_app/screens/culture/host_an__event.dart';
import 'package:community_app/screens/culture/language_corner.dart';
import 'package:community_app/screens/disability/articles.dart';
import 'package:community_app/screens/disability/disabiity_jobs.dart';
import 'package:community_app/screens/disability/disability_content.dart';
import 'package:community_app/screens/disability/disability_support.dart';
import 'package:community_app/screens/disability/request_suport_form.dart';
import 'package:community_app/screens/education_employment/browse_playlist.dart';
import 'package:community_app/screens/education_employment/education.dart';
import 'package:community_app/screens/education_employment/education_video_player.dart';
import 'package:community_app/screens/education_employment/first_job_kit.dart';
import 'package:community_app/screens/education_employment/interview_confidence.dart';
import 'package:community_app/screens/education_employment/learning_module.dart';
import 'package:community_app/screens/education_employment/professional_resume.dart';
import 'package:community_app/screens/education_employment/resume_template.dart';
import 'package:community_app/screens/education_employment/scholarship_hub_details.dart';
import 'package:community_app/screens/education_employment/upcoming_opportunities.dart';
import 'package:community_app/screens/food_support/food_parcel.dart';
import 'package:community_app/screens/food_support/food_support.dart';
import 'package:community_app/screens/internet_support/appliances_repair.dart';
import 'package:community_app/screens/internet_support/apply_for_internet_support.dart';
import 'package:community_app/screens/internet_support/book_a_setup_visit.dart';
import 'package:community_app/screens/internet_support/digital_learning.dart';
import 'package:community_app/screens/internet_support/internet_support.dart';
import 'package:community_app/screens/otp.dart';
import 'package:community_app/screens/Health/healthy_living_prevention.dart';
import 'package:community_app/screens/change_pass.dart';
import 'package:community_app/screens/finance/budget_management.dart';
import 'package:community_app/screens/justice/child_safety.dart';
import 'package:community_app/screens/justice/custom_bottom_sheet.dart';
import 'package:community_app/screens/justice/jobs.dart';
import 'package:community_app/screens/justice/mcqs.dart';
import 'package:community_app/screens/justice/mental_health_support.dart';
import 'package:community_app/screens/preloved/EssentialsRequestFormScreen.dart';
import 'package:community_app/screens/preloved/donate_appliances.dart';
import 'package:community_app/screens/preloved/prelove.dart';
import 'package:community_app/screens/preloved/request.dart';
import 'package:community_app/screens/qrcode/scan.dart';
import 'package:community_app/screens/qrcode/transaction_history.dart';
import 'package:get/get.dart';
import 'package:community_app/screens/onboard_view.dart';
import 'package:community_app/screens/login_view.dart';
import 'package:community_app/screens/signup_view.dart';
import '../controllers/disability/disability_content_controller.dart';
import '../screens/Health/care_options.dart';
import '../screens/Health/health.dart';
import '../screens/Health/know_what_to_do_when_sick.dart';
import '../screens/Health/not_sure.dart';
import '../screens/Health/stay_connected.dart';
import '../screens/Health/youth_wellbeing.dart';
import '../screens/Housing/available_shelter.dart';
import '../screens/social_support/community_navigator.dart';
import '../screens/social_support/community_waste_support_request.dart';
import '../screens/Housing/emergency_housing.dart';
import '../screens/Housing/healthy_homes_application.dart';
import '../screens/Housing/home_repair_support.dart';
import '../screens/Housing/internet_support_setup_help.dart';
import '../screens/Housing/overcrowidng_support_request.dart';
import '../screens/Housing/request_trustie_community_tradie.dart';
import '../screens/Housing/shelter_detail.dart';
import '../screens/Housing/shelter_request.dart';
import '../screens/Housing/urgent_housing.dart';
import '../screens/Housing/winter_warmth_energy_support.dart';
import '../screens/apply_for_help/apply_for_help.dart';
import '../screens/apply_for_help/report_crime.dart';
import '../screens/apply_for_help/request_mentor.dart';
import '../screens/apply_for_help/someone_know.dart';
import '../screens/doctor/find_a_provider.dart';
import '../screens/doctor/profile.dart';
import '../screens/finance/add_fixed_expense.dart';
import '../screens/finance/debt_management.dart';
import '../screens/finance/finance.dart';
import '../screens/forget_password.dart';
import 'package:community_app/screens/home_view.dart';
import '../screens/justice/job_apply_foam.dart';
import '../screens/justice/justice.dart';
import '../screens/justice/rebuild_foam.dart';
import '../screens/parenting/child_care_learning.dart';
import '../screens/parenting/confict_resolution.dart';
import '../screens/parenting/councelling_therapy.dart';
import '../screens/parenting/culturall_specific.dart';
import '../screens/parenting/early_learning_resources.dart';
import '../screens/parenting/helpline_schedule.dart';
import '../screens/parenting/milestone_checklist.dart';
import '../screens/parenting/parenting.dart';
import '../screens/parenting/parenting_support_program.dart';
import '../screens/parenting/pediatric_health.dart';
import '../screens/parenting/resource_video.dart';
import '../screens/privacy_policy.dart';
import '../screens/profile/change_password.dart';
import '../screens/profile/personal_info.dart';
import '../screens/profile/your_profile.dart';
import '../screens/social_support/i_want_to_help.dart';
import '../screens/social_support/request_a_social_worker.dart';
import '../screens/social_support/social_support.dart';
import 'controller_binding.dart';
import 'package:community_app/screens/finance/monthly_summary.dart';
import 'package:community_app/screens/finance/yearly_summary.dart';
import 'package:community_app/screens/finance/fifty_last_all_week.dart';
import 'package:community_app/screens/Housing/housing.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.onboard;
  static final routes = [
    GetPage(name: Routes.onboard, page: () => OnboardingScreen()),
    GetPage(
      // Route for the login screen
      name: Routes.login,
      page: () => const LoginScreen(),
      binding: LoginControllerBinding(),
    ),
    GetPage(
      // Add this GetPage for the signup route
      name: Routes.signup,
      page: () => const SignupScreen(),
      binding: SignupControllerBinding(), // Create SignupBinding if needed
    ),
    GetPage(
      // Add this GetPage for the signup route
      name: Routes.newPasswordScreen,
      page: () => NewPasswordScreen(),
      // binding: SignupBinding(), // Create SignupBinding if needed
    ),
    GetPage(
      // Add this GetPage for the signup route
      name: Routes.forgetPassword,
      page: () => ForgetPassword(),
      // binding: SignupBinding(), // Create SignupBinding if needed
    ),
    GetPage(
      // Add this GetPage for the signup route
      name: Routes.otpScreen,
      page: () {
        final args = Get.arguments as Map<String, dynamic>? ?? {};
        return OtpScreen(email: args['email'] ?? '');
      },
      // binding: SignupBinding(), // Create SignupBinding if needed
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.home,
      page: () => HomeScreen(),
      binding: HomeControllerBinding(), // Create HomeBinding
    ),

    // --- Finance routes --
    GetPage(
      // Add the GetPage for the home route
      name: Routes.finance,
      page: () => FinancialSupportScreen(),
      binding: FinanceControllerBinding(), // Create HomeBinding
    ),

    GetPage(
      // Add the GetPage for the home route
      name: Routes.budgetManagement,
      page: () => BudgetManagement(),
      binding: BudgetManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.fixedExpense,
      page: () => FixedExpenseFoam(),
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.monthlySummaryFinance,
      page: () => FinanceSummaryPage(),
      binding: FinanceSummaryControllerBinding(),
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.yearlySummaryFinance,
      page: () => FinanceYearlySummary(),
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.fiftyLastAllWeek,
      page: () => FiftyLastAllWeek(),
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.debtManagement,
      page: () => DebtListScreen(),
      binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),

    //--- Housing routes --
    GetPage(
      // Add the GetPage for the home route
      name: Routes.housing,
      page: () => HousingPage(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.healthyHomeApplication,
      page: () => HealthyHomesApplication(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.healthyHomeApplication,
      page: () => HealthyHomesApplication(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.homeRepairSupport,
      page: () => HomeRepairSupport(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),

    GetPage(
      // Add the GetPage for the home route
      name: Routes.internetSupportSetup,
      page: () => InternetSupportSetupHelp(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.overcrowdingSupport,
      page: () => OverCrowdingSupportRequest(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.trustedHomeRepairing,
      page: () => RequestTrustyCommunity(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.winterWarmthEnergySupport,
      page: () => WinterWarmthEnergySupport(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.emergencyHousing,
      page: () => EmergencyHousing(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.urgentHousing,
      page: () => UrgentHousing(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.shelterDetail,
      page: () => ShelterDetail(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.shelterRequest,
      page: () => ShelterRequest(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.availableShelter,
      page: () => AvailableShelter(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),

    //--- apply for help--
    GetPage(
      // Add the GetPage for the home route
      name: Routes.applyForHelp,
      page: () => ApplyForHelp(),
      binding: FinanceControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.someoneKnow,
      page: () => SomeoneKnow(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.requestMentor,
      page: () => RequestMentor(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.reportCrime,
      page: () => ReportCrime(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),

    // --- Parenting Routes --
    GetPage(
      // Add the GetPage for the home route
      name: Routes.parenting,
      page: () => ParentingPage(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.helplineSchedule,
      page: () => HelplineSchedule(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.childCareLearning,
      page: () => ChildCareLearning(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.parentingSupportProgram,
      page: () => ParentingSupportProgram(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.counselingTherapy,
      page: () => CounselingTherapy(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.conflictResolution,
      page: () => ConflictResolution(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.culturalSpecific,
      page: () => CulturalSpecific(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),

    GetPage(
      // Add the GetPage for the home route
      name: Routes.pediatricHealth,
      page: () => PediatricHealth(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.milestoneChecklist,
      page: () => MilestoneChecklist(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.earlyLearningResource,
      page: () => EarlyLearningResources(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.resourceVideos,
      page: () => ResourceVideo(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),

    //--- Doctor Routes --
    GetPage(
      // Add the GetPage for the home route
      name: Routes.findProvider,
      page: () => FindAProvider(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.doctorProfile,
      page: () => Profile(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),

    //--- Health Routes --
    GetPage(
      // Add the GetPage for the home route
      name: Routes.health,
      page: () => HealthPage(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.notSure,
      page: () => NotSure(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.careOptions,
      page: () => CareOptions(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.knowWhenSicks,
      page: () => KnowWhatToDoWhenSick(),
      // binding: KnowWhatToDoWhenSickBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.knowWhenSicks,
      page: () => KnowWhatToDoWhenSick(),
      // binding: KnowWhatToDoWhenSickBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.youthWellbeing,
      page: () => YouthWellbeing(),
      // binding: KnowWhatToDoWhenSickBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.stayConnected,
      page: () => StayConnected(),
      // binding: KnowWhatToDoWhenSickBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.healthyLivingPrevention,
      page: () => HealthyLivingPrevention(),
      // binding: KnowWhatToDoWhenSickBinding(), // Create HomeBinding
    ),

    //--- Justice Routes --
    GetPage(
      // Add the GetPage for the home route
      name: Routes.justiceAndSafety,
      page: () => Justice(),
      // binding: KnowWhatToDoWhenSickBinding(), // Create HomeBinding
    ),

    GetPage(
      // Add the GetPage for the home route
      name: Routes.rebuildLifeFoam,
      page: () => Rebuild(),
      // binding: KnowWhatToDoWhenSickBinding(), // Create HomeBinding
    ),

    GetPage(
      // Add the GetPage for the home route
      name: Routes.mentalHealthSupport,
      page: () => MentalHealthSupport(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),

    GetPage(
      // Add the GetPage for the home route
      name: Routes.childSafety,
      page: () => ChildSafety(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      name: '/quizscreen',
      page: () {
        final args = Get.arguments as Map<String, String>;
        return QuizScreen(
          title: args['title'] ?? 'Default Title',
          subtitle: args['subtitle'] ?? '',
        );
      },
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.jobs,
      page: () => Jobs(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.customBottomSheet,

      page: () {
        final args = Get.arguments as Map<String, String>;
        return CustomBottomSheet(
          title: args['title'] ?? 'Bidec',
          company: args['company'] ?? 'Bidec',
          imagePath: args[''] ?? '',
          jobType: args[''] ?? '',
          posted: args[''] ?? '',
          // hours: args[''] ?? '',
          experience: args[''] ?? '',
          clicks: int.tryParse(args['clicks'] ?? '') ?? 5,
          details: args[''] ?? '',
          jobId: int.tryParse(args['jobId'] ?? '') ?? 0,
          index: int.tryParse(args['index'] ?? '') ?? 0,
          applied: (args['applied'] == 'true'),
        );
      },
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),

    // social support
    GetPage(
      // Add the GetPage for the home route
      name: Routes.socialSupport,
      page: () => SocialSupport(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.communityWasteSupport,
      page: () => CommunityWasteSupportRequest(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.requestSocialWorker,
      page: () => RequestASocialWorker(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.iWantToHelp,
      page: () => IWantToHelp(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),

    GetPage(
      // Add the GetPage for the home route
      name: Routes.communityNavigator,
      page: () => CommunityNavigator(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),

    // privacy policy
    GetPage(
      // Add the GetPage for the home route
      name: Routes.privacyPolicy,
      page: () => PrivacyPolicy(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),

    // Your Profile
    GetPage(
      // Add the GetPage for the home route
      name: Routes.yourProfile,
      page: () => YourProfile(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.personalInfo,
      page: () => PersonalInfo(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.changePassword,
      page: () => ChangePassword(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.applyForJob,
      page: () => ApplyForJob(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),

    //Food Support
    GetPage(
      // Add the GetPage for the home route
      name: Routes.foodSupport,
      page: () => FoodSupport(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.requestAFoodParcel,
      page: () => RequestAFoodParcel(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),

    // Internet Support
    GetPage(
      // Add the GetPage for the home route
      name: Routes.internetSupport,
      page: () => InternetSupport(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.applyForInternetSupport,
      page: () => ApplyForInternetSupport(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.bookASetupVisit,
      page: () => BookASetupVisit(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.digitalLearning,
      page: () => DigitalLearning(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.appliancesRepair,
      page: () => AppliancesRepair(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),

    //Culture Community
    GetPage(
      // Add the GetPage for the home route
      name: Routes.cultureCommunity,
      page: () => CultureCommunity(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.hostAnEvent,
      page: () => HostAnEvent(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.languageCorner,
      page: () => LanguageCorner(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.doYouKnowYourCulture,
      page:
          () => DoYouKnowYourCulture(
            Get.arguments['title'] ?? 'Do You Know Your Culture',
          ),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),

    // Disability Support
    GetPage(
      // Add the GetPage for the home route
      name: Routes.disabilitySupport,
      page: () => DisabilitySupport(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.disabilityJobs,
      page: () => DisabilityJobs(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      // Add the GetPage for the home route
      name: Routes.requestSupportForm,
      page: () => RequestSupportForm(),
      // binding: DebtManagementControllerBinding(), // Create HomeBinding
    ),
    GetPage(
      name: Routes.articles,
      page: () {
        return Articles();
      },
    ),
    GetPage(
      name: Routes.disabilityAwareness,
      page: () => DisabilityContent(),
      binding: BindingsBuilder(() {
        Get.put(DisabilityContentController());
      }),
    ),

    // Pre-loved
    GetPage(name: Routes.preLoved, page: () => PreLoved()),
    GetPage(name: Routes.donateAppliances, page: () => DonateAppliances()),
    GetPage(name: Routes.request, page: () => RequestScreen()),
    GetPage(
      name: Routes.essentialsRequest,
      page: () => EssentialsRequestFormScreen(),
    ),

    // History
    GetPage(name: Routes.history, page: () => ActivityAndHistory()),
    GetPage(name: Routes.historyForms, page: () => HistoryFoams()),

    // Education
    GetPage(name: Routes.education, page: () => Education()),
    GetPage(name: Routes.learningModule, page: () => LearningModule()),
    GetPage(
      name: Routes.educationVideoPlayer,
      page: () => EducationVideoPlayer(videoId: ''),
    ),
    GetPage(name: Routes.browsePlaylist, page: () => BrowsePlaylist()),
    GetPage(
      name: Routes.interviewConfidence,
      page: () => InterviewConfidence(),
    ),
    GetPage(name: Routes.resumeTemplate, page: () => ResumeTemplate()),
    GetPage(name: Routes.professionalResume, page: () => ProfessionalResume()),
    GetPage(name: Routes.firstJobKit, page: () => FirstJobKit()),
    GetPage(name: Routes.scholarshipHub, page: () => ScholarshipHub()),
    GetPage(
      name: Routes.scholarshipHubDetails,
      page: () => ScholarshipHubDetails(),
    ),
    GetPage(name: Routes.scholarshipForm, page: () => ScholarshipForm()),
    GetPage(name: Routes.licenseQuizStart, page: () => LicenseQuizStart()),
    GetPage(name: Routes.readyForLicense, page: () => ReadyForLicense()),
    GetPage(name: Routes.realStories, page: () => RealStories()),
    GetPage(name: Routes.realStoriesInspire, page: () => RealStoriesInspire()),
    GetPage(
      name: Routes.upcomingOpportunities,
      page: () => UpcomingOpportunities(),
    ),
    GetPage(name: Routes.coaches, page: () => Coaches()),
    GetPage(name: Routes.coachProfile, page: () => CoachProfile()),

    // scan
    GetPage(name: Routes.scan, page: () => Scan()),
    GetPage(name: Routes.transactionHistory, page: () => TransactionHistory()),

    //E-Store
    GetPage(name: Routes.eStore, page: () => EStore()),
    // GetPage(name: Routes.productDetailScreen, page: () => ProductDetailScreen(product: ,)),
    GetPage(name: Routes.cartScreen, page: () => CartScreen()),
    // GetPage(
    //   name: Routes.checkoutScreen,
    //   page: () => CheckoutScreen(),
    // ),
    // GetPage(name: Routes.trackOrderScreen, page: () => TrackOrderScreen()),
    GetPage(name: Routes.orderScreen, page: () => OrderScreen()),
  ];
}
