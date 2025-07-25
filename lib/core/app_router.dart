// lib/core/app_router.dart
import 'package:fitness_app/core/pose_detection/exercise_classifier.dart';
import 'package:fitness_app/features/Settings/manage_subscription.dart';
import 'package:fitness_app/features/Settings/presentation/app_settings.dart';
import 'package:fitness_app/features/Settings/presentation/login_page.dart';
import 'package:fitness_app/features/Settings/presentation/plan_settings.dart' show PlanSettingsPage;
import 'package:fitness_app/features/Settings/presentation/privacy_policy.dart';
import 'package:fitness_app/features/Settings/presentation/sign_up_page.dart';
import 'package:fitness_app/features/Settings/presentation/terms_conditions_page.dart';
import 'package:fitness_app/features/camera/presentation/camera_page.dart';
import 'package:fitness_app/features/onboard/onboarding.dart';
import 'package:fitness_app/features/profile/profile_page.dart' show ProfilePage;
import 'package:fitness_app/features/workout/presentation/add_exercise_page.dart';
import 'package:fitness_app/features/workout/presentation/all_exercises_page.dart';
import 'package:fitness_app/features/workout/presentation/equipment_exercises_page.dart';
import 'package:fitness_app/features/workout/presentation/exercise_detail_page.dart';
import 'package:fitness_app/features/workout/presentation/exercises_by_equipment.dart';
import 'package:fitness_app/features/workout/presentation/exercises_by_muscles_page.dart';
import 'package:fitness_app/features/workout/presentation/muscles_exercise_page.dart';
import 'package:fitness_app/features/workout/presentation/replace_exercise_page.dart';
import 'package:fitness_app/features/workout/presentation/sample_report.dart';
import 'package:fitness_app/features/workout/presentation/workout_page.dart';
import 'package:fitness_app/features/workout/presentation/workout_plan_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/analytics/presentation/analytics_page.dart';
import '../features/coach/presentation/coach_page.dart';
import '../features/home/presentation/main_page.dart';


/// ref.watch(appRouterProvider(initialLocation))
final appRouterProvider = Provider.family<GoRouter, String>((
  ref,
  initialLocation,
) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (ctx, state) => const OnboardingScreen(),
      ),
      GoRoute(path: '/main', builder: (ctx, state) => const MainPage()),
       GoRoute(
        path: '/plan-settings',
        builder: (context, state) => const PlanSettingsPage(),
      ),
      GoRoute(path: '/coach', builder: (context, state) => const CoachPage()),
      GoRoute(
        path: '/analytics',
        builder: (context, state) => const AnalyticsScreen(),
      ),
      GoRoute(
        path: '/workout',
        builder: (context, state) => const WorkoutPage(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: '/app-settings',
        builder: (context, state) => const AppSettingsPage(),
      ),
      GoRoute(
        path: '/privacy-policy',
        builder: (context, state) => const PrivacyPolicyScreen(),
      ),
      GoRoute(
        path: '/terms-conditions',
        builder: (context, state) => const TermsConditionsScreen(),
      ),
      GoRoute(
        path: '/manage-subscription',
        builder: (context, state) => const ManageSubscriptionPage(),
      ),
      GoRoute(
        path: '/body-scan-report',
        builder: (context, state) => const BodyScanReportPage(),
      ),
      GoRoute(
        path: '/workout-plan',
        builder: (context, state) => const WorkoutPlanPage(),
      ),
      GoRoute(
        path: '/add-exercise',
        builder: (context, state) => const AddExercisePage(),
      ),
      GoRoute(
        path: '/replace-exercise',
        builder: (context, state) => const ReplaceExercisePage(),
      ),
      GoRoute(
        path: '/all-exercises',
        builder: (context, state) => const AllExercisesPage(),
      ),
      GoRoute(
        path: '/exercises-by-equipement',
        builder: (context, state) => const ExercisesByEquipmentPage(),
      ),
      GoRoute(
        path: '/exercises-by-muscles',
        builder: (context, state) => const ExercisesByMusclesPage(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        name: 'muscleExercises',
        path: '/muscles/:muscle',
        builder: (BuildContext context, GoRouterState state) {
          final muscle = state.pathParameters['muscle']!;
          return MuscleExercisesPage(muscle: muscle);
        },
      ),
      GoRoute(
        name: 'equipmentExercises',
        path: '/equipment/:equipment',
        builder: (BuildContext context, GoRouterState state) {
          final equipment = state.pathParameters['equipment']!;
          return EquipmentExercisesPage(equipment: equipment);
        },
      ),
      GoRoute(
        name: 'exerciseDetail',
        path: '/exercise/:exerciseId',
        builder: (BuildContext context, GoRouterState state) {
          final exerciseId = state.pathParameters['exerciseId']!;
          return ExerciseDetailPage(exerciseId: exerciseId);
        },),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/camera/:exercise',
        builder: (ctx, state) {
          final ex = state.pathParameters['exercise'];
          final type = ex == 'pushUp'
              ? ExerciseType.pushUp
              : ExerciseType.squat;
          return CameraPage(exerciseType: type);
        },
      ),
    ],

  );
});


// final appRouterProvider = Provider<GoRouter>((ref) {
//   return GoRouter(
//     initialLocation: '/',
//     routes: [
//       GoRoute(path: '/', builder: (context, state) => const MainPage()),
      
     


      
//     ],
//   );
// });
