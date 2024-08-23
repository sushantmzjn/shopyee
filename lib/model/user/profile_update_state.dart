class ProfileUpdateState {
  final bool isError;
  final String errMessage;
  final bool isSuccess;
  final bool isLoad;

  ProfileUpdateState({
    required this.errMessage,
    required this.isError,
    required this.isLoad,
    required this.isSuccess,
  });

  ProfileUpdateState copyWith({
    bool? isError,
    String? errMessage,
    bool? isSuccess,
    bool? isLoad,
  }) {
    return ProfileUpdateState(
      errMessage: errMessage ?? this.errMessage,
      isError: isError ?? this.isError,
      isLoad: isLoad ?? this.isLoad,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
