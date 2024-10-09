import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinpin/common/assets/assets.gen.dart';
import 'package:pinpin/common/extension/string_extension.dart';
import 'package:pinpin/common/utils/app_utils.dart';
import 'package:pinpin/data/models/chat_model.dart';
import 'package:pinpin/presentation/journey/chat_detail/chat_detail_constants.dart';
import 'package:pinpin/presentation/journey/chat_detail/cubit/chat_detail_cubit.dart';

import '../../widgets/button_widget/icon_button_widget.dart';
import '../../widgets/chat_view/chatview.dart';
import 'common/theme.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.model}) : super(key: key);
  final ChatModel model;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  AppTheme theme = LightTheme();
  bool isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChatView(
        chatController: context.read<ChatDetailCubit>().chatController,
        onSendTap: context.read<ChatDetailCubit>().onSendTap,
        featureActiveConfig: const FeatureActiveConfig(
          lastSeenAgoBuilderVisibility: true,
          receiptsBuilderVisibility: true,
          enableScrollToBottomButton: true,
        ),
        scrollToBottomButtonConfig: ScrollToBottomButtonConfig(
          backgroundColor: theme.textFieldBackgroundColor,
          border: Border.all(
            color: isDarkTheme ? Colors.transparent : Colors.grey,
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: theme.themeIconColor,
            weight: 10,
            size: 30,
          ),
        ),
        chatViewState: ChatViewState.hasMessages,
        chatViewStateConfig: ChatViewStateConfiguration(
          loadingWidgetConfig: ChatViewStateWidgetConfiguration(
            loadingIndicatorColor: theme.outgoingChatBubbleColor,
          ),
          onReloadButtonTap: () {},
        ),
        typeIndicatorConfig: TypeIndicatorConfiguration(
          flashingCircleBrightColor: theme.flashingCircleBrightColor,
          flashingCircleDarkColor: theme.flashingCircleDarkColor,
        ),
        appBar: ChatViewAppBar(
          actions: [
            IconButtonWidget(
              onPressed: () {},
              icon: (Assets.icons.navbarTrailingIcon.svg(
                width: 30.sp,
                height: 30.sp,
              )),
            ),
          ],
          elevation: theme.elevation,
          backGroundColor: theme.appBarColor,
          profilePicture: isNullEmpty(widget.model.chatAvatar)
              ? 'https://firebasestorage.googleapis.com/v0/b/learning-english-6441b.appspot.com/o/default_avatar.png?alt=media&token=ed0a9b16-2d40-446b-8f27-7f353c5e230e'
              : widget.model.chatAvatar,
          backArrowColor: theme.backArrowColor,
          chatTitle: widget.model.chatName ?? '',
          chatTitleTextStyle: TextStyle(
            color: theme.appBarTitleTextStyle,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 0.25,
          ),
          userStatus: 'online',
          userStatusTextStyle: const TextStyle(color: Colors.grey),
        ),
        chatBackgroundConfig: ChatBackgroundConfiguration(
          messageTimeIconColor: theme.messageTimeIconColor,
          messageTimeTextStyle: TextStyle(color: theme.messageTimeTextColor),
          defaultGroupSeparatorConfig: DefaultGroupSeparatorConfiguration(
            textStyle: TextStyle(
              color: theme.chatHeaderColor,
              fontSize: 17,
            ),
          ),
          backgroundColor: theme.backgroundColor,
        ),
        sendMessageConfig: SendMessageConfiguration(
          imagePickerIconsConfig: ImagePickerIconsConfiguration(
            cameraIconColor: theme.cameraIconColor,
            galleryIconColor: theme.galleryIconColor,
          ),
          replyMessageColor: theme.replyMessageColor,
          defaultSendButtonColor: theme.sendButtonColor,
          replyDialogColor: theme.replyDialogColor,
          replyTitleColor: theme.replyTitleColor,
          textFieldBackgroundColor: theme.textFieldBackgroundColor,
          closeIconColor: theme.closeIconColor,
          textFieldConfig: TextFieldConfiguration(
            onMessageTyping: (status) {
              /// Do with status
              debugPrint(status.toString());
            },
            compositionThresholdTime: const Duration(seconds: 1),
            textStyle: TextStyle(color: theme.textFieldTextColor),
          ),
        ),
        chatBubbleConfig: ChatBubbleConfiguration(
          outgoingChatBubbleConfig: ChatBubble(
            linkPreviewConfig: LinkPreviewConfiguration(
              backgroundColor: theme.linkPreviewOutgoingChatColor,
              bodyStyle: theme.outgoingChatLinkBodyStyle,
              titleStyle: theme.outgoingChatLinkTitleStyle,
            ),
            receiptsWidgetConfig:
                const ReceiptsWidgetConfig(showReceiptsIn: ShowReceiptsIn.all),
            color: theme.outgoingChatBubbleColor,
          ),
          inComingChatBubbleConfig: ChatBubble(
            linkPreviewConfig: LinkPreviewConfiguration(
              linkStyle: TextStyle(
                color: theme.inComingChatBubbleTextColor,
                decoration: TextDecoration.underline,
              ),
              backgroundColor: theme.linkPreviewIncomingChatColor,
              bodyStyle: theme.incomingChatLinkBodyStyle,
              titleStyle: theme.incomingChatLinkTitleStyle,
            ),
            textStyle: TextStyle(color: theme.inComingChatBubbleTextColor),
            onMessageRead: (message) {
              /// send your message reciepts to the other client
              debugPrint('Message Read');
            },
            senderNameTextStyle:
                TextStyle(color: theme.inComingChatBubbleTextColor),
            color: theme.inComingChatBubbleColor,
          ),
        ),
        replyPopupConfig: ReplyPopupConfiguration(
          onUnsendTap: (message) async {
            await context.read<ChatDetailCubit>().delete(message.id);
            setState(() {});
          },
          backgroundColor: theme.replyPopupColor,
          buttonTextStyle: TextStyle(color: theme.replyPopupButtonColor),
          topBorderColor: theme.replyPopupTopBorderColor,
        ),
        reactionPopupConfig: ReactionPopupConfiguration(
          shadow: BoxShadow(
            color: isDarkTheme ? Colors.black54 : Colors.grey.shade400,
            blurRadius: 20,
          ),
          backgroundColor: theme.reactionPopupColor,
        ),
        messageConfig: MessageConfiguration(
          messageReactionConfig: MessageReactionConfiguration(
            backgroundColor: theme.messageReactionBackGroundColor,
            borderColor: theme.messageReactionBackGroundColor,
            reactedUserCountTextStyle:
                TextStyle(color: theme.inComingChatBubbleTextColor),
            reactionCountTextStyle:
                TextStyle(color: theme.inComingChatBubbleTextColor),
            reactionsBottomSheetConfig: ReactionsBottomSheetConfiguration(
              backgroundColor: theme.backgroundColor,
              reactedUserTextStyle: TextStyle(
                color: theme.inComingChatBubbleTextColor,
              ),
              reactionWidgetDecoration: BoxDecoration(
                color: theme.inComingChatBubbleColor,
                boxShadow: [
                  BoxShadow(
                    color: isDarkTheme ? Colors.black12 : Colors.grey.shade200,
                    offset: const Offset(0, 20),
                    blurRadius: 40,
                  )
                ],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          imageMessageConfig: ImageMessageConfiguration(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            shareIconConfig: ShareIconConfiguration(
              defaultIconBackgroundColor: theme.shareIconBackgroundColor,
              defaultIconColor: theme.shareIconColor,
            ),
          ),
        ),
        profileCircleConfig: ProfileCircleConfiguration(
          profileImageUrl: isNullEmpty(widget.model.chatAvatar)
              ? 'https://firebasestorage.googleapis.com/v0/b/learning-english-6441b.appspot.com/o/default_avatar.png?alt=media&token=ed0a9b16-2d40-446b-8f27-7f353c5e230e'
              : widget.model.chatAvatar,
        ),
        repliedMessageConfig: RepliedMessageConfiguration(
          backgroundColor: theme.repliedMessageColor,
          verticalBarColor: theme.verticalBarColor,
          repliedMsgAutoScrollConfig: RepliedMsgAutoScrollConfig(
            enableHighlightRepliedMsg: true,
            highlightColor: Colors.pinkAccent.shade100,
            highlightScale: 1.1,
          ),
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.25,
          ),
          replyTitleTextStyle: TextStyle(color: theme.repliedTitleTextColor),
        ),
        swipeToReplyConfig: SwipeToReplyConfiguration(
          replyIconColor: theme.swipeToReplyIconColor,
        ),
        replySuggestionsConfig: ReplySuggestionsConfig(
          itemConfig: SuggestionItemConfig(
            decoration: BoxDecoration(
              color: theme.textFieldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.outgoingChatBubbleColor ?? Colors.white,
              ),
            ),
            textStyle: TextStyle(
              color: isDarkTheme ? Colors.white : Colors.black,
            ),
          ),
          onTap: (item) => context
              .read<ChatDetailCubit>()
              .onSendTap(item.text, const ReplyMessage(), MessageType.text),
        ),
      ),
    );
  }
}

class MoreWidget extends StatelessWidget {
  const MoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButtonWidget(
          onPressed: () {},
          icon: Assets.icons.profile.svg(
            width: 30.sp,
            height: 30.sp,
          ),
          title: ChatDetailConstants.members.tr,
        ),
        IconButtonWidget(
          onPressed: () {},
          icon: Assets.icons.trash.svg(
            width: 30.sp,
            height: 30.sp,
          ),
          title: ChatDetailConstants.deleteChat.tr,
        ),
        IconButtonWidget(
          onPressed: () {},
          icon: Assets.icons.infoCircle.svg(
            width: 30.sp,
            height: 30.sp,
          ),
          title: ChatDetailConstants.info.tr,
        ),
        IconButtonWidget(
          onPressed: () {},
          icon: Assets.icons.logout.svg(
            width: 30.sp,
            height: 30.sp,
          ),
          title: ChatDetailConstants.leaveGroup.tr,
        ),
      ],
    );
  }
}
