enum RequestState { initial, loading, success, error, empty }

class BaseState<T> {
  final RequestState requestState;
  final T? data;
  final String? errorMessage;

  const BaseState({
    this.requestState = RequestState.initial,
    this.data,
    this.errorMessage,
  });

  BaseState<T> copyWith({
    RequestState? requestState,
    T? data,
    String? errorMessage,
  }) {
    return BaseState<T>(
      requestState: requestState ?? this.requestState,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
