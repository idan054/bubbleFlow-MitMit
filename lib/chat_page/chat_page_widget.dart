import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPageWidget extends StatefulWidget {
  ChatPageWidget({
    Key key,
    this.localToID,
    this.localToEmail,
    this.chatRecord,
  }) : super(key: key);

  final String localToID;
  final String localToEmail;
  final DocumentReference chatRecord;

  @override
  _ChatPageWidgetState createState() => _ChatPageWidgetState();
}

class _ChatPageWidgetState extends State<ChatPageWidget> {
  TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Align(
        alignment: Alignment(0.05, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'U get this data from fireBase',
              style: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Poppins',
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  currentUserDisplayName,
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  currentUserEmail,
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  currentUserUid,
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                  ),
                )
              ],
            ),
            Expanded(
              child: StreamBuilder<List<MassagesRecord>>(
                stream: queryMassagesRecord(
                  queryBuilder: (massagesRecord) => massagesRecord
                      .where('fromEmail', isEqualTo: currentUserEmail)
                      .where('toID', isEqualTo: widget.localToEmail)
                      .orderBy('timeIndex'),
                ),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  List<MassagesRecord> listViewMassagesRecordList =
                      snapshot.data;
                  // Customize what your widget looks like with no query results.
                  if (snapshot.data.isEmpty) {
                    // return Container();
                    // For now, we'll just include some dummy data.
                    listViewMassagesRecordList =
                        createDummyMassagesRecord(count: 4);
                  }
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: listViewMassagesRecordList.length,
                    itemBuilder: (context, listViewIndex) {
                      final listViewMassagesRecord =
                          listViewMassagesRecordList[listViewIndex];
                      return Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: Color(0xFFF5F5F5),
                        elevation: 10,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      'fromID',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      listViewMassagesRecord.fromID,
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      'fromEmail',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      listViewMassagesRecord.fromEmail,
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      'toID',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      listViewMassagesRecord.toID,
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      'toEmail',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      listViewMassagesRecord.toEmail,
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      'msgValue',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(11, 0, 0, 0),
                                    child: Text(
                                      listViewMassagesRecord.msgValue,
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      'timeIndex',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: AutoSizeText(
                                      'timeIndex PlaceHolder',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      'indexInList',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      listViewIndex.toString(),
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      'chatRecor',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      listViewIndex.toString(),
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: TextFormField(
                      controller: textController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'msg to firebase',
                        hintStyle: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                      ),
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final fromID = currentUserUid;
                    final fromEmail = currentUserEmail;
                    final toID = widget.localToID;
                    final toEmail = widget.localToEmail;
                    final msgValue = textController.text;
                    final timeIndex = getCurrentTimestamp;
                    final chatRecord = widget.chatRecord;

                    final massagesRecordData = {
                      ...createMassagesRecordData(
                        fromID: fromID,
                        fromEmail: fromEmail,
                        toID: toID,
                        toEmail: toEmail,
                        msgValue: msgValue,
                        timeIndex: timeIndex,
                        chatRecord: chatRecord,
                      ),
                      'chatFromToEmails':
                          FieldValue.arrayUnion([currentUserEmail]),
                    };

                    await MassagesRecord.collection
                        .doc()
                        .set(massagesRecordData);
                    final massagesRecordData = {
                      'chatFromToEmails':
                          FieldValue.arrayUnion([widget.localToEmail]),
                    };

                    await widget.chatRecord.update(massagesRecordData);
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.black,
                    size: 30,
                  ),
                  iconSize: 30,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
