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
  String get chatUser;

  @nullable
  String get chatEmail;

  @nullable
  DocumentReference get activeUser;

  @nullable
  String get chatIDx;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(ChatsRecordBuilder builder) => builder
    ..chatUser = ''
    ..chatEmail = ''
    ..chatIDx = '';

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
  String chatUser,
  String chatEmail,
  DocumentReference activeUser,
  String chatIDx,
}) =>
    serializers.serializeWith(
        ChatsRecord.serializer,
        ChatsRecord((c) => c
          ..chatUser = chatUser
          ..chatEmail = chatEmail
          ..activeUser = activeUser
          ..chatIDx = chatIDx));

ChatsRecord get dummyChatsRecord {
  final builder = ChatsRecordBuilder()
    ..chatUser = dummyString
    ..chatEmail = dummyString
    ..chatIDx = dummyString;
  return builder.build();
}

List<ChatsRecord> createDummyChatsRecord({int count}) =>
    List.generate(count, (_) => dummyChatsRecord);
