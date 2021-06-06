import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivateChatsWidget extends StatefulWidget {
  PrivateChatsWidget({Key key}) : super(key: key);

  @override
  _PrivateChatsWidgetState createState() => _PrivateChatsWidgetState();
}

class _PrivateChatsWidgetState extends State<PrivateChatsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
    );
  }
}
