import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/chat_room_entity.dart';

class ChatRoomModel extends ChatRoomEntity {
  ChatRoomModel({
    required String id,
    required String studentId,
    required String trainerId,
    // required String courseId,
    required DateTime createdAt,
  }) : super(
          id: id,
          studentId: studentId,
          trainerId: trainerId,
          // courseId: courseId,
          createdAt: createdAt,
        );

  factory ChatRoomModel.fromMap(Map<String, dynamic> map, String id) {
    return ChatRoomModel(
      id: id,
      studentId: map['studentId'],
      trainerId: map['trainerId'],
      // courseId: map['courseId'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'trainerId': trainerId,
      // 'courseId': courseId,
      'createdAt': createdAt,
    };
  }

  ChatRoomModel copyWith({
    String? id,
    String? studentId,
    String? trainerId,
    // String? courseId,
    DateTime? createdAt,
  }) {
    return ChatRoomModel(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      trainerId: trainerId ?? this.trainerId,
      // courseId: courseId ?? this.courseId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}