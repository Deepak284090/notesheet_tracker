// lib/utils/enums.dart

enum UserRole { admin, proposer, reviewer, hod }

enum EventStatus {
  pendingReview,
  underReview,
  changesRequested,
  rejected,
  approved,
  upcoming,
}

enum HODDecision { accepted, rejected, suggestedChanges }
