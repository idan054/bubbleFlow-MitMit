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
  String get fromID;

  @nullable
  String get fromEmail;

  @nullable
  String get toID;

  @nullable
  String get toEmail;

  @nullable
  String get msgValue;

  @nullable
  Timestamp get timeIndex;

  @nullable
  BuiltList<String> get chatFromToEmails;

  @nullable
  DocumentReference get chatRecord;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(MassagesRecordBuilder builder) => builder
    ..fromID = ''
    ..fromEmail = ''
    ..toID = ''
    ..toEmail = ''
    ..msgValue = ''
    ..chatFromToEmails = ListBuilder();

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
  String fromID,
  String fromEmail,
  String toID,
  String toEmail,
  String msgValue,
  Timestamp timeIndex,
  DocumentReference chatRecord,
}) =>
    serializers.serializeWith(
        MassagesRecord.serializer,
        MassagesRecord((m) => m
          ..fromID = fromID
          ..fromEmail = fromEmail
          ..toID = toID
          ..toEmail = toEmail
          ..msgValue = msgValue
          ..timeIndex = timeIndex
          ..chatFromToEmails = null
          ..chatRecord = chatRecord));

MassagesRecord get dummyMassagesRecord {
  final builder = MassagesRecordBuilder()
    ..fromID = dummyString
    ..fromEmail = dummyString
    ..toID = dummyString
    ..toEmail = dummyString
    ..msgValue = dummyString
    ..timeIndex = dummyTimestamp
    ..chatFromToEmails = ListBuilder([dummyString, dummyString]);
  return builder.build();
}

List<MassagesRecord> createDummyMassagesRecord({int count}) =>
    List.generate(count, (_) => dummyMassagesRecord);
