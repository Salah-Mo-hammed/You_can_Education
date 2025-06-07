import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project_ver_1/features/chat/presintation/bloc/chat_bloc.dart';
import 'package:grad_project_ver_1/features/chat/presintation/pages/chat_page.dart';
import 'package:grad_project_ver_1/features/chat/presintation/pages/trainer_chat_page_final.dart';

class TrainerChatsPage extends StatefulWidget {
  final String trainerId;

  TrainerChatsPage({required this.trainerId});

  @override
  State<TrainerChatsPage> createState() => _TrainerChatsPageState();
}

class _TrainerChatsPageState extends State<TrainerChatsPage> {
  @override
  void initState() {
    context.read<ChatBloc>().add(
      GetTrainerChatRoomsEvent(trianerId: widget.trainerId),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
        backgroundColor: Colors.teal,
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is ChatRoomsLoaded) {
            final chatRooms = state.chatRooms;
            return ListView.builder(
              itemCount: chatRooms.length,
              itemBuilder: (context, index) {
                final chatRoom = chatRooms[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text(' ${chatRoom.studentId}'),
                  subtitle: Text(
                    'Last message preview...',
                  ), // Display last message preview here
                  trailing: Text(
                    '12:30 PM',
                  ), // Display last message time here
                  onTap: () {
                    // Navigate to the chat channel
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ChatPage(
                              studentId: chatRoom.studentId,
                              trainerId: chatRoom.trainerId,
                              currentUserId: chatRoom.trainerId,
                              currentUserName: "trainer name here",
                            ),
                      ),
                    );
                  },
                );
              },
            );
          }

          if (state is ChatError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          return Center(child: Text('No chat rooms available.'));
        },
      ),
    );
  }
}
