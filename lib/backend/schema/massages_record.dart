import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'massages_record.g.dart';

abstract class MassagesRecord
    implements Built<MassagesRecord, MassagesRecordBuilder> {
  static Serializer<MassagesRecord> get serializer =>
      _$massagesRecordSerializer;

  @nullable
  DocumentReference get activeUser;

  @nullable
  DocumentReference get guestUser;

  @nullable
  @BuiltValueField(wireName: 'sent_time')
  Timestamp get sentTime;

  @nullable
  @BuiltValueField(wireName: 'massage_value')
  String get massageValue;

  @nullable
  @BuiltValueField(wireName: 'message_id')
  BuiltList<int> get messageId;

  @nullable
  @BuiltValueField(wireName: 'from_messges_collection')
  BuiltList<DocumentReference> get fromMessgesCollection;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(MassagesRecordBuilder builder) => builder
    ..massageValue = ''
    ..messageId = ListBuilder()
    ..fromMessgesCollection = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('massages');

  static Stream<MassagesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  MassagesRecord._();
  factory MassagesRecord([void Function(MassagesRecordBuilder) updates]) =
      _$MassagesRecord;
}

Map<String, dynamic> createMassagesRecordData({
  DocumentReference activeUser,
  DocumentReference guestUser,
  Timestamp sentTime,
  String massageValue,
}) =>
    serializers.serializeWith(
        MassagesRecord.serializer,
        MassagesRecord((m) => m
          ..activeUser = activeUser
          ..guestUser = guestUser
          ..sentTime = sentTime
          ..massageValue = massageValue
          ..messageId = null
          ..fromMessgesCollection = null));

MassagesRecord get dummyMassagesRecord {
  final builder = MassagesRecordBuilder()
    ..sentTime = dummyTimestamp
    ..massageValue = dummyString
    ..messageId = ListBuilder([dummyInteger, dummyInteger]);
  return builder.build();
}

List<MassagesRecord> createDummyMassagesRecord({int count}) =>
    List.generate(count, (_) => dummyMassagesRecord);
