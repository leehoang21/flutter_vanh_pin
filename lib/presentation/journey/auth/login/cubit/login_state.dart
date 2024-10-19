part of 'login_cubit.dart';

class LoginState extends Equatable {
  final bool isObscurePassword;
  final bool canAuthBiometric;
  final bool isNewDevice;

  const LoginState({
    this.isObscurePassword = false,
    this.canAuthBiometric = false,
    this.isNewDevice = false,
  });

  LoginState copyWith({
    bool? isObscurePassword,
    bool? canAuthBiometric,
    bool? isNewDevice,
  }) {
    return LoginState(
      isObscurePassword: isObscurePassword ?? this.isObscurePassword,
      canAuthBiometric: canAuthBiometric ?? this.canAuthBiometric,
      isNewDevice: isNewDevice ?? this.isNewDevice,
    );
  }

  @override
  List<Object?> get props => [isObscurePassword, canAuthBiometric, isNewDevice];
}
