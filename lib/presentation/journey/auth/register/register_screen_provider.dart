import 'package:auto_route/auto_route.dart';
import '../../../widgets/provider/provider_widget.dart';
import 'cubit/register_cubit.dart';
import 'register_screen.dart';

@RoutePage()
class RegisterScreenProvider extends ProviderWidget<RegisterCubit> {
  const RegisterScreenProvider({super.key})
      : super(child: const RegisterScreen(), params: const []);
}
