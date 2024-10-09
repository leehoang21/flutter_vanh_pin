import 'package:auto_route/auto_route.dart';
import '../../widgets/provider/provider_widget.dart';
import 'cubit/chat_cubit.dart';
import 'chat_screen.dart';

@RoutePage()
class ChatScreenProvider extends ProviderWidget<ChatCubit> {
  const ChatScreenProvider({super.key})
      : super(child: const ChatScreen(), params: const []);
}
