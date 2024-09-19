part of 'timerbottom_bloc.dart';


enum TimerBottomStatus { initial, ticking, paused, finish }

class TimerBottomState extends Equatable {
  final int duration;
  final TimerBottomStatus status;

  const TimerBottomState({
    required this.duration,
    required this.status,
  });

  factory TimerBottomState.initial() {
    return const TimerBottomState(
      duration: TimerBottomBloc._defaultDuration, // Default duration
      status: TimerBottomStatus.initial,
    );
  }

  TimerBottomState copyWith({
    int? duration,
    TimerBottomStatus? status,
  }) {
    return TimerBottomState(
      duration: duration ?? this.duration,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [duration, status];
}