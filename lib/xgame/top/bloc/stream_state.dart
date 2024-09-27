part of 'stream_bloc.dart';


enum StreamStatus { initial, success, failure }

class StreamMState extends Equatable{
  const StreamMState({
    this.status = StreamStatus.initial,
    this.posts = const <Ranking>[],
    this.hasReachedMax = false,
  });
  final StreamStatus status;
  final List<Ranking> posts;
  final bool hasReachedMax;

  StreamMState copyWith({
    StreamStatus? status,
    List<Ranking>? posts,
    bool? hasReachedMax,
  }) {
    return StreamMState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
  @override
  String toString() {
    return 'StreamMState { status: $status, hasReachedMax: $hasReachedMax, posts: ${posts.length} }';
  }

  @override
  List<Object> get props => [status, posts, hasReachedMax];
}

