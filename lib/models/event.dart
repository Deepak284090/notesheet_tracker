// lib/models/event.dart

class Event {
  final String id;
  final String title;
  final String description;
  final String venue;
  final DateTime date;
  final String startTime;
  final String endTime;
  final String mode;
  final String type;
  final String audience;
  final double budget;
  final String fundSource;
  final List<String> resourcesRequested;
  final String proposerId;

  const Event({
    required this.id,
    required this.title,
    required this.description,
    required this.venue,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.mode,
    required this.type,
    required this.audience,
    required this.budget,
    required this.fundSource,
    required this.resourcesRequested,
    required this.proposerId,
  });
}
