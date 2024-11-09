part of 'google_authenticator_cubit.dart';

class GoogleAuthenticatorState extends Equatable {
  final String content;
  const GoogleAuthenticatorState({
    this.content = '',
  });

  GoogleAuthenticatorState copyWith({
    String? content,
  }) {
    return GoogleAuthenticatorState(
      content: content ?? this.content,
    );
  }

  @override
  List<Object?> get props => [content];
}
