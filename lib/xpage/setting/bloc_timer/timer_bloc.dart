import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'timer_state.dart';
part 'timer_event.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static const int _defaultDuration = 300; // 5 minutes in seconds
  Timer? _timer;
  bool _isPaused = false;

  TimerBloc() : super(TimerState.initial()) {
    // Start timer with custom or default duration
    on<StartTimer>((event, emit) {
      emit(state.copyWith(
        duration: event.durationInSeconds ?? _defaultDuration, // Use custom or default duration
        status: TimerStatus.ticking,
      ));
      _startTimer();
    });

    // Pause timer
    on<PauseTimer>((event, emit) {
      _isPaused = true;
      _timer?.cancel();
      emit(state.copyWith(status: TimerStatus.paused));
    });

    // Resume timer
    on<ResumeTimer>((event, emit) {
      if (_isPaused) {
        _isPaused = false;
        emit(state.copyWith(status: TimerStatus.ticking));
        _startTimer();
      }
    });

    // Stop timer
    on<StopTimer>((event, emit) {
      _timer?.cancel();
      emit(state.copyWith(
        status: TimerStatus.finish,
        duration: _defaultDuration, // Reset timer to default duration
      ));
    });

    // Tick event
    on<Tick>((event, emit) {
      if (event.duration > 0) {
        emit(state.copyWith(
          duration: event.duration,
          status: TimerStatus.ticking,
        ));
      } else {
        _timer?.cancel();
        emit(state.copyWith(
          duration: 0,
          status: TimerStatus.finish,
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