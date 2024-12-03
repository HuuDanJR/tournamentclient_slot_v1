import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tournament_client/lib/models/jackpotDropModel.dart';
import '../../../service/service_api.dart';
import 'package:stream_transform/stream_transform.dart' as streamTransform;
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'jackpot_event.dart';
part 'jackpot_state.dart';

final ServiceAPIs service_api = ServiceAPIs();
const throttleDuration = Duration(milliseconds: 200);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class JackpotDropBloc extends Bloc<JackpotDropEvent, JackpotDropState> {
  final http.Client httpClient;
  JackpotDropBloc({required this.httpClient}) : super(const JackpotDropState()){
    on<JackpotDropFetched>(
      _onListFetched,
      transformer: throttleDroppable(throttleDuration)
    );
  }

  Future<void> _onListFetched(JackpotDropFetched event, Emitter<JackpotDropState> emit) async {
  debugPrint('_onListFetched called');
  if (state.hasReachedMax) {
    debugPrint('No more data to fetch, reached max.');
    return;
  }
    try {
      if (state.status == JackpotDropStatus.initial) {
      // Initial load
      debugPrint('Fetching initial posts...');
      final posts = await service_api.listJPHistory();
      return emit(
        state.copyWith(
          status: JackpotDropStatus.success,
          posts: posts,
          hasReachedMax: false,
        ),
      );
      }
      // Fetch more posts
      debugPrint('Fetching more posts...');
      final additionalPosts = await service_api.listJPHistory(state.posts!.data.length);
      if (additionalPosts != null && additionalPosts.data.isNotEmpty) {
        emit(
          state.copyWith(
            status: JackpotDropStatus.success,
            posts: JackpotHistoryModel(
              status: true,
              message: 'success',
              data: List.of(state.posts!.data)..addAll(additionalPosts.data),
            ),
            hasReachedMax: false,
          ),
        );
        debugPrint('New data added: total posts count = ${state.posts!.data.length}');
      } else {
        emit(state.copyWith(hasReachedMax: true));
        debugPrint('No additional data fetched, reached max.');
      }
      } catch (e) {
        emit(state.copyWith(status: JackpotDropStatus.failure));
      }
}

}



