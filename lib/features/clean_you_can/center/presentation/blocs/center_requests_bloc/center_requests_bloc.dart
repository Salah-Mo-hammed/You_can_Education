import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/usecases/approve_join_request_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/usecases/get_center_requests_usecase.dart';

part 'center_requests_event.dart';
part 'center_requests_state.dart';

class CenterRequestsBloc
    extends Bloc<CenterRequestsEvent, CenterRequestsState> {
  GetCenterRequestsUsecase getCenterRequestsUsecase;
  ApproveJoinRequestUsecase approveJoinRequestUsecase;
  CenterRequestsBloc({required this.approveJoinRequestUsecase,required this.getCenterRequestsUsecase})
    : super(CenterRequestsInitial()) {
    on<GetCenterRequestsEvent>(onGetRequests);
    on<ApproveJoinRequestEvent>(onApproveJoinRequests);
  }

  FutureOr<void> onGetRequests(
    GetCenterRequestsEvent event,
    Emitter<CenterRequestsState> emit,
  ) async {
    emit(CenterRequestsLoadingState());
    print("before result await requests");
    final result = await getCenterRequestsUsecase.call(
      event.centerId,
    );
    print("after result await requests");
    result.fold(
      (failure) {
        emit(CenterRequestsExceptionState(message: failure.message));
      },
      (requests) {
        emit(CenterRequestsDoneState(requests: requests));
      },
    );
  }

  FutureOr<void> onApproveJoinRequests(ApproveJoinRequestEvent event, Emitter<CenterRequestsState> emit) async{
      emit(CenterRequestsLoadingState());
final result=await approveJoinRequestUsecase.call(event.requestMap);
result.fold((failure){
          emit(CenterRequestsExceptionState(message: failure.message));

},(unit){
  emit(CenterRequestsInitial());
});
  }
}
