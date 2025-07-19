// lib/models/notesheet.dart

import 'event.dart';
import 'review_entry.dart';
import '../utils/enums.dart';

class NoteSheet {
  final String id;
  final Event event;
  final List<ReviewEntry> reviews;
  final EventStatus status;
  final String? acceptingHODId; // null until accepted
  final String? hodComment; // comment from HOD (optional)
  final DateTime createdAt;

  const NoteSheet({
    required this.id,
    required this.event,
    required this.reviews,
    required this.status,
    this.acceptingHODId,
    this.hodComment,
    required this.createdAt,
  });

  bool hasReachedThreshold(int threshold) {
    return reviews.length >= threshold;
  }

  NoteSheet copyWith({
    List<ReviewEntry>? reviews,
    EventStatus? status,
    String? acceptingHODId,
    String? hodComment,
  }) {
    return NoteSheet(
      id: id,
      event: event,
      reviews: reviews ?? this.reviews,
      status: status ?? this.status,
      acceptingHODId: acceptingHODId ?? this.acceptingHODId,
      hodComment: hodComment ?? this.hodComment,
      createdAt: createdAt,
    );
  }
}
