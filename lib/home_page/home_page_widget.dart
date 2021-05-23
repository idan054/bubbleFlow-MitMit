import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../chat_page/chat_page_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageWidget extends StatefulWidget {
  HomePageWidget({
    Key key,
    this.searchedUser,
  }) : super(key: key);

  final String searchedUser;

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
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
      backgroundColor: FlutterFlowTheme.tertiaryColor,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: Alignment(0, 0.05),
              child: Text(
                currentUserEmail,
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePageWidget(
                          searchedUser: textController.text,
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 30,
                  ),
                  iconSize: 30,
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Search for user...',
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
                )
              ],
            ),
            Expanded(
              child: StreamBuilder<List<UsersRecord>>(
                stream: queryUsersRecord(
                  queryBuilder: (usersRecord) => usersRecord.where('email',
                      isEqualTo: widget.searchedUser),
                ),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  List<UsersRecord> listViewUsersRecordList = snapshot.data;
                  // Customize what your widget looks like with no query results.
                  if (snapshot.data.isEmpty) {
                    // return Container();
                    // For now, we'll just include some dummy data.
                    listViewUsersRecordList = createDummyUsersRecord(count: 4);
                  }
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: listViewUsersRecordList.length,
                    itemBuilder: (context, listViewIndex) {
                      final listViewUsersRecord =
                          listViewUsersRecordList[listViewIndex];
                      return StreamBuilder<List<MassagesRecord>>(
                        stream: queryMassagesRecord(
                          singleRecord: true,
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                          List<MassagesRecord> cardMassagesRecordList =
                              snapshot.data;
                          // Customize what your widget looks like with no query results.
                          if (snapshot.data.isEmpty) {
                            // return Container();
                            // For now, we'll just include some dummy data.
                            cardMassagesRecordList =
                                createDummyMassagesRecord(count: 1);
                          }
                          final cardMassagesRecord =
                              cardMassagesRecordList.first;
                          return Padding(
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatPageWidget(
                                      localToID: listViewUsersRecord.uid,
                                      localToEmail: listViewUsersRecord.email,
                                      chatRecord: cardMassagesRecord.reference,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color: Color(0xFFF5F5F5),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                                  child: Text(
                                    listViewUsersRecord.email,
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
