import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/Chat/ChatBloc.dart';
import 'package:food_delivery/bloc/Chat/ChatEvent.dart';
import 'package:food_delivery/bloc/Chat/ChatState.dart';
import 'package:rxdart/rxdart.dart';

import 'package:dialogflow_grpc/dialogflow_grpc.dart';
import 'package:dialogflow_grpc/generated/google/cloud/dialogflow/v2beta1/session.pb.dart';
import 'package:sound_stream/sound_stream.dart';

import 'chatmessage.dart';
// TODO import Dialogflow

class Chat extends StatefulWidget {
  Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
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

  // void handleStream() async {
  //   _recorder.start();

  //   _audioStream = BehaviorSubject<List<int>>();
  //   _audioStreamSubscription = _recorder.audioStream.listen((data) {
  //     //print(data);
  //     _audioStream!.add(data);
  //   });

  //   // TODO Create SpeechContexts
  //   // Create an audio InputConfig
  //   var biasList = SpeechContextV2Beta1(phrases: [
  //     'Dialogflow CX',
  //     'Dialogflow Essentials',
  //     'Action Builder',
  //     'HIPAA'
  //   ], boost: 20.0);

  //   var config = InputConfigV2beta1(
  //       encoding: 'AUDIO_ENCODING_LINEAR_16',
  //       languageCode: 'en-US',
  //       sampleRateHertz: 16000,
  //       singleUtterance: false,
  //       speechContexts: [biasList]);

  //   // TODO Make the streamingDetectIntent call, with the InputConfig and the audioStream
  //   final responseStream =
  //       dialogflow!.streamingDetectIntent(config, _audioStream!);
  //   responseStream.listen((data) {
  //     //print('----');
  //     setState(() {
  //       //print(data);
  //       String transcript = data.recognitionResult.transcript;
  //       String queryText = data.queryResult.queryText;
  //       String fulfillmentText = data.queryResult.fulfillmentText;

  //       if (fulfillmentText.isNotEmpty) {
  //         ChatMessage message = new ChatMessage(
  //           text: queryText,
  //           name: "You",
  //           type: true,
  //         );

  //         ChatMessage botMessage =
  //             new ChatMessage(text: fulfillmentText, name: "Bot", type: false);

  //         _messages.insert(0, message);
  //         _textController.clear();
  //         _messages.insert(0, botMessage);
  //       }
  //       if (transcript.isNotEmpty) {
  //         _textController.text = transcript;
  //       }
  //     });
  //   }, onError: (e) {
  //     //print(e);
  //   }, onDone: () {
  //     //print('done');
  //   });
  //   // TODO Get the transcript and detectedIntent and show on screen
  // }

  Widget _loadedState(BuildContext context, ChatLoadedState state) {
    return Column(children: <Widget>[
      Flexible(
          child: ListView.builder(
        padding: EdgeInsets.all(8.0),
        reverse: true,
        itemBuilder: (_, int index) => state.messages[index],
        itemCount: state.messages.length,
      )),
      Divider(height: 1.0),
      Container(
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
          child: IconTheme(
            data: IconThemeData(color: Theme.of(context).accentColor),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      controller: _textController,
                      onSubmitted: (message) =>
                          handleSubmitted(message, context),
                      decoration:
                          InputDecoration.collapsed(hintText: "Gửi tin nhắn"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () =>
                          handleSubmitted(_textController.text, context),
                    ),
                  ),
                  // IconButton(
                  //   iconSize: 30.0,
                  //   icon: Icon(_isRecording ? Icons.mic_off : Icons.mic),
                  //   onPressed: _isRecording ? stopStream : handleStream,
                  // ),
                ],
              ),
            ),
          )),
    ]);
  }

  // The chat interface
  //
  //------------------------------------------------------------------------------------
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

//------------------------------------------------------------------------------------
// The chat message balloon
//
//------------------------------------------------------------------------------------

