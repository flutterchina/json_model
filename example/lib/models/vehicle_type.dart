import 'package:json_annotation/json_annotation.dart';

part 'vehicle_type.g.dart';

@JsonSerializable()
class VehicleType {
    VehicleType();

    String name;
    String description;
    
    factory VehicleType.fromJson(Map<String,dynamic> json) => _$VehicleTypeFromJson(json);
    Map<String, dynamic> toJson() => _$VehicleTypeToJson(this);
}
