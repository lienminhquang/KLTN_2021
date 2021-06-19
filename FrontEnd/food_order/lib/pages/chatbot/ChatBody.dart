import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:food_delivery/bloc/Chat/ChatBloc.dart';
import 'package:food_delivery/bloc/Chat/ChatEvent.dart';
import 'package:food_delivery/bloc/Chat/ChatState.dart';
import 'package:rxdart/rxdart.dart';

import 'package:dialogflow_grpc/dialogflow_grpc.dart';
import 'package:sound_stream/sound_stream.dart';

import 'MessageWidget.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatBody extends StatefulWidget {
  ChatBody({Key? key}) : super(key: key);

  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  //final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();

  bool _isRecording = false;

  RecorderStream _recorder = RecorderStream();
  StreamSubscription? _recorderStatus;
  StreamSubscription<List<int>>? _audioStreamSubscription;
  BehaviorSubject<List<int>>? _audioStream;

  // TODO DialogflowGrpc class instance
  DialogflowGrpcV2Beta1? dialogflow;

  @override
  void initState() {
    super.initState();
    initPlugin();
  }

  @override
  void dispose() {
    _recorderStatus?.cancel();
    _audioStreamSubscription?.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlugin() async {
    _recorderStatus = _recorder.status.listen((status) {
      if (mounted)
        setState(() {
          _isRecording = status == SoundStreamStatus.Playing;
        });
    });

    await Future.wait([_recorder.initialize()]);

    //  Get a Service account
    final serviceAccount = ServiceAccount.fromString(
        '${(await rootBundle.loadString('assets/amee2.json'))}');
    // Create a DialogflowGrpc Instance
    dialogflow = DialogflowGrpcV2Beta1.viaServiceAccount(serviceAccount);
  }

  void stopStream() async {
    await _recorder.stop();
    await _audioStreamSubscription?.cancel();
    await _audioStream?.close();
  }

  void handleSubmitted(String text, BuildContext context) async {
    context.read<ChatBloc>().add(ChatSendMessEvent(text));
    print(text);
    _textController.clear();
  }

  Widget _loadedState(BuildContext context, ChatLoadedState state) {
    return Chat(
      messages: state.messages,
      onSendPressed: _handleSendPressed,
      user: state.user,
      showUserAvatars: true,
      showUserNames: true,
    );
  }

  void _handleSendPressed(types.PartialText message) {
    context.read<ChatBloc>().add(ChatSendMessEvent(message.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      if (state is ChatLoadedState) {
        return _loadedState(context, state);
      }
      if (state is ChatLoadingState) {
        return Container(
            child: Center(
          child: CircularProgressIndicator(),
        ));
      }
      throw "Unknow state!";
    });
  }
}
