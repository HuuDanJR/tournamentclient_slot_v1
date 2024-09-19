import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'timerbottom_state.dart';
part 'timerbottom_event.dart';

class TimerBottomBloc extends Bloc<TimerBottomEvent, TimerBottomState> {
  static const int _defaultDuration = 300; // 5 minutes in seconds
  Timer? _timer;
  bool _isPaused = false;

  TimerBottomBloc() : super(TimerBottomState.initial()) {
    // Start timer with custom or default duration
    on<StartTimer>((event, emit) {
      emit(state.copyWith(
        duration: event.durationInSeconds ?? _defaultDuration, // Use custom or default duration
        status: TimerBottomStatus.ticking,
      ));
      _startTimer();
    });

    // Pause timer
    on<PauseTimer>((event, emit) {
      _isPaused = true;
      _timer?.cancel();
      emit(state.copyWith(status: TimerBottomStatus.paused));
    });

    // Resume timer
    on<ResumeTimer>((event, emit) {
      if (_isPaused) {
        _isPaused = false;
        emit(state.copyWith(status: TimerBottomStatus.ticking));
        _startTimer();
      }
    });

    // Stop timer
    on<StopTimer>((event, emit) {
      _timer?.cancel();
      emit(state.copyWith(
        status: TimerBottomStatus.finish,
        duration: _defaultDuration, // Reset timer to default duration
      ));
    });

    // Tick event
    on<Tick>((event, emit) {
      if (event.duration > 0) {
        emit(state.copyWith(
          duration: event.duration,
          status: TimerBottomStatus.ticking,
        ));
      } else {
        _timer?.cancel();
        emit(state.copyWith(
          duration: 0,
          status: TimerBottomStatus.finish,
        ));
      }
    });
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final newDuration = state.duration - 1;
      add(Tick(newDuration));
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}