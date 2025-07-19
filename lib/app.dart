import 'package:flutter/material.dart';
import 'screens/dashboard/admin_dashboard.dart';
import 'screens/dashboard/hod_dashboard.dart';
import 'screens/dashboard/proposer_dashboard.dart';
import 'screens/dashboard/reviewer_dashboard.dart';
import 'screens/role_selector_screen.dart';

class AppRoutes {
  static const roleSelector = '/';
  static const adminDashboard = '/admin';
  static const proposerDashboard = '/proposer';
  static const reviewerDashboard = '/reviewer';
  static const hodDashboard = '/hod';
}

Map<String, WidgetBuilder> routes = {
  AppRoutes.roleSelector: (context) => const RoleSelectorScreen(),
  AppRoutes.adminDashboard: (context) => const AdminDashboard(),
  AppRoutes.proposerDashboard: (context) => const ProposerDashboard(),
  AppRoutes.reviewerDashboard: (context) => const ReviewerDashboard(),
  AppRoutes.hodDashboard: (context) => const HodDashboard(),
};
