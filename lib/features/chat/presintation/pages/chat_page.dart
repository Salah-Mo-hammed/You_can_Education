import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:grad_project_ver_1/features/chat/domain/entities/message_entity.dart';
import 'package:grad_project_ver_1/features/chat/presintation/bloc/chat_bloc.dart';

class ChatPage extends StatefulWidget {
  final String studentId;
  final String trainerId;
  // final String courseId;
  final String currentUserId;
  final String currentUserName;

  const ChatPage({
    Key? key,
    required this.studentId,
    required this.trainerId,
    // required this.courseId,
    required this.currentUserId,
    required this.currentUserName,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final ChatUser chatUser;

  @override
  void initState() {
    super.initState();
    chatUser = ChatUser(
      id: widget.currentUserId,
      firstName: widget.currentUserName,
    );

    // Load chat room
    context.read<ChatBloc>().add(
      LoadChatRoomEvent(
        studentId: widget.studentId,
        trainerId: widget.trainerId,
        // courseId: widget.courseId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat with Trainer')),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          print(" state now is ${state}");
          if (state is ChatLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ChatLoaded) {
            return StreamBuilder<List<MessageEntity>>(
              stream: state.messagesStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());

                final messages =
                    snapshot.data!
                        .map(
                          (msg) => ChatMessage(
                            text: msg.text,
                            createdAt: msg.createdAt,
                            user: ChatUser(id: msg.senderId),
                          ),
                        )
                        .toList()
                      ..sort(
                        (a, b) => b.createdAt.compareTo(a.createdAt),
                      ); // latest on top

                return DashChat(
                  currentUser: chatUser,
                  onSend: (ChatMessage message) {
                    MessageEntity entity = MessageEntity(
                      id: '', // Firestore will assign it
                      text: message.text,
                      senderId: widget.currentUserId,
                      recieverId:
                          widget.currentUserId == widget.studentId
                              ? widget.trainerId
                              : widget.studentId,
                      createdAt: DateTime.now(),
                    );
                    print("befor the read send message event ");
                    context.read<ChatBloc>().add(
                      SendMessageEvent(message: entity),
                    );
                    print("after the read send message event ");

                  },
                  messages: messages,
                  
                );
              },
            );
          } else if (state is ChatError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:flutter/material.dart';
// import 'package:grad_project_ver_1/features/chat/presintation/bloc/chat_bloc.dart';

// class Basic extends StatefulWidget {
//   @override
//   _BasicState createState() => _BasicState();
// }

// class _BasicState extends State<Basic> {
//   ChatUser user = ChatUser(
//     id: '1',
//     firstName: 'Charles',
//     lastName: 'Leclerc',
//   );

//   late ChatBloc chatBloc;

//   @override
//   void initState() {
//     super.initState();
//     chatBloc = BlocProvider.of<ChatBloc>(context);
//     chatBloc.add(LoadMessagesEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("${user.firstName!} ${user.lastName!}"),
//       ),
//       body: BlocBuilder<ChatBloc, ChatState>(
//         builder: (context, state) {
//           if (state is ChatLoadingState) {
//             return Center(child: CircularProgressIndicator());
//           } else if (state is ChatLoadedState) {
//             return DashChat(
//               currentUser: user,
//               onSend: (ChatMessage m) {
//                 final chatMessageEntity = ChatMessageEntity(
//                   id: m.id,
//                   text: m.text,
//                   userId: m.user.id,
//                   createdAt: m.createdAt,
//                 );
//                 chatBloc.add(SendMessageEvent(chatMessageEntity));
//               },
//               messages: state.messages.map((e) => ChatMessage(
//                 id: e.id,
//                 text: e.text,
//                 user: ChatUser(id: e.userId),
//                 createdAt: e.createdAt,
//               )).toList(),
//             );
//           } else {
//             return Center(child: Text('Something went wrong!'));
//           }
//         },
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     chatBloc.close();
//     super.dispose();
//   }
// }
