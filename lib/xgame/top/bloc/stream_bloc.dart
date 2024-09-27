import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:tournament_client/screen/admin/model/rankingList.dart';
import '../../../service/service_api.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'stream_event.dart';
part 'stream_state.dart';

final service_api = ServiceAPIs();
const throttleDuration = Duration(milliseconds: 200);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class StreamBloc extends Bloc<StreamMEvent, StreamMState> {
  final http.Client httpClient;
  StreamBloc({required this.httpClient}) : super(const StreamMState()){
    on<StreamFeteched>(
      _onListFetched,
      transformer: throttleDroppable(throttleDuration)
    );
  }

  Future<void> _onListFetched(StreamFeteched event,Emitter<StreamMState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == StreamStatus.initial) {
        final posts = await service_api.fetchRanking();
        return emit(
          state.copyWith(
            status: StreamStatus.success,
            posts: posts,
            hasReachedMax: false,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: StreamStatus.failure));
    }
  }

}
