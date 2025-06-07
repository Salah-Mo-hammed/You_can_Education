class ChatRoomEntity {
  final String id;
  final String studentId;
  final String trainerId;
  // final String courseId;
  final DateTime createdAt;

  ChatRoomEntity({
    required this.id,
    required this.studentId,
    required this.trainerId,
    // required this.courseId,
    required this.createdAt,
  });
}