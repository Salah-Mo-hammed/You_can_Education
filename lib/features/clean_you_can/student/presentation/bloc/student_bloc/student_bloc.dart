import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/usecases/enroll_in_course_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/usecases/get_available_courses_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/bloc/student_bloc/student_event.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/bloc/student_bloc/student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  
  final GetAvailableAndMineCoursesUsecase getAvailableCoursesUsecase;
  final EnrollInCourseUsecase enrollInCourseUsecase;
  
  StudentBloc({
    required this.enrollInCourseUsecase,
    
    required this.getAvailableCoursesUsecase,

  }) : super(const StudentInitialState()) {

    on<GetAvailableAndMineCoursesEvent>(onGetAvailableCourses);
    on<EnrollInCourseEvent>(onEnrollInCourse);


  }

  

  FutureOr<void> onGetAvailableCourses(
    GetAvailableAndMineCoursesEvent event,
    Emitter<StudentState> emit,
  ) async {
    emit(StudentLoadingState());
    final result = await getAvailableCoursesUsecase.call(
      event.studentId,
    );

    result.fold(
      (failure) =>
          emit(StudentExceptionState(message: failure.message)),
      (availableAndMineCourses) => emit(
        StudentGotAvailableAndHisCoursesState(
          allCourses: availableAndMineCourses,
        ),
      ),
    );
  }

  FutureOr<void> onEnrollInCourse(
    EnrollInCourseEvent event,
    Emitter<StudentState> emit,
  ) async {
    emit(StudentLoadingState());
    final result = await enrollInCourseUsecase.call(
      event.centerId,
      event.studentUid,
      event.courseUid,
      event.courseName
      // event.proofImageUrl
    );
    result.fold(
      (failure) {
        emit(StudentExceptionState(message: failure.message));
      },
      (unit) {
        emit(StudentRefreshState());
      },
    );
  }
 
}
