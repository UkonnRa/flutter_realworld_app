import 'package:built_value/serializer.dart';

class DateTimeSerializerPlugin implements SerializerPlugin {
  Object beforeSerialize(Object object, FullType specifiedType) {
    if (specifiedType.root != DateTime) return object;
    return DateTime.parse(object as String).toUtc().microsecondsSinceEpoch;
  }

  Object afterSerialize(Object object, FullType specifiedType) => object;
  Object beforeDeserialize(Object object, FullType specifiedType) => object;
  Object afterDeserialize(Object object, FullType specifiedType) => object;
}
