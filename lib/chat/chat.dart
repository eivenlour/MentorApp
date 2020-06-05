import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import './new_matches.dart';
import './user_message_rows.dart';
import '../constants/chat_constants.dart';

class Chat extends StatelessWidget {
  const Chat({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.all(0),
            child: Center(
              child: Column(
                children: buildChatView()
              )
            )
          )
        ),
      ]
    );
  }
}

buildHeader() {
  return Container (
    margin: const EdgeInsets.all(30.0),
    child: Column(
      children: <Text>[
        Text(
          CHAT_HEADER_TITLE, 
          style: GoogleFonts.muli(
            textStyle: TextStyle(
              color: Colors.black, 
              letterSpacing: .5, 
              fontSize: 30.0, 
              fontWeight: FontWeight.bold
            )
          )
        ), 
        Text(
          CHAT_HEADER_SUBTITLE, 
          style: GoogleFonts.muli(
            textStyle: TextStyle(
              color: Colors.grey, 
              letterSpacing: .5, 
              fontSize: 18, 
              fontWeight: FontWeight.w600
            )
          )
        ), 
      ]
    )
  );
}

buildChatView() {
  return (
    <Widget>[
      buildHeader(),
      NewMatches(),
      Flexible(
        child: UserMessageRows(),
      )
    ]
  );
}