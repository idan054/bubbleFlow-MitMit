import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'chats_record.g.dart';

abstract class ChatsRecord implements Built<ChatsRecord, ChatsRecordBuilder> {
  static Serializer<ChatsRecord> get serializer => _$chatsRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'auth_uid')
  String get authUid;

  @nullable
  @BuiltValueField(wireName: 'guest_uid')
  String get guestUid;

  @nullable
  @BuiltValueField(wireName: 'chat_token')
  String get chatToken;

  @nullable
  @BuiltValueField(wireName: 'msgs_ref')
  DocumentReference get msgsRef;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(ChatsRecordBuilder builder) => builder
    ..authUid = ''
    ..guestUid = ''
    ..chatToken = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('chats');

  static Stream<ChatsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  ChatsRecord._();
  factory ChatsRecord([void Function(ChatsRecordBuilder) updates]) =
      _$ChatsRecord;
}

Map<String, dynamic> createChatsRecordData({
  String authUid,
  String guestUid,
  String chatToken,
  DocumentReference msgsRef,
}) =>
    serializers.serializeWith(
        ChatsRecord.serializer,
        ChatsRecord((c) => c
          ..authUid = authUid
          ..guestUid = guestUid
          ..chatToken = chatToken
          ..msgsRef = msgsRef));

ChatsRecord get dummyChatsRecord {
  final builder = ChatsRecordBuilder()
    ..authUid = dummyString
    ..guestUid = dummyString
    ..chatToken = dummyString;
  return builder.build();
}

List<ChatsRecord> createDummyChatsRecord({int count}) =>
    List.generate(count, (_) => dummyChatsRecord);
