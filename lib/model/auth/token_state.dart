class TokenState {
  final bool isError;
  final String errMessage;
  final bool isSuccess;
  final bool isLoad;

  TokenState(
      {required this.errMessage,
      required this.isError,
      required this.isLoad,
      required this.isSuccess});

  TokenState copyWith({
    bool? isError,
    String? errMessage,
    bool? isSuccess,
    bool? isLoad,
  }) {
    return TokenState(
        errMessage: errMessage ?? this.errMessage,
        isError: isError ?? this.isError,
        isLoad: isLoad ?? this.isLoad,
        isSuccess: isSuccess ?? this.isSuccess);
  }
}
