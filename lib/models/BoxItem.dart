/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the BoxItem type in your schema. */
@immutable
class BoxItem extends Model {
  static const classType = const _BoxItemModelType();
  final String id;
  final String? _name;
  final String? _description;
  final bool? _complete;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get name {
    return _name;
  }
  
  String? get description {
    return _description;
  }
  
  bool? get complete {
    return _complete;
  }
  
  const BoxItem._internal({required this.id, name, description, complete}): _name = name, _description = description, _complete = complete;
  
  factory BoxItem({String? id, String? name, String? description, bool? complete}) {
    return BoxItem._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      description: description,
      complete: complete);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BoxItem &&
      id == other.id &&
      _name == other._name &&
      _description == other._description &&
      _complete == other._complete;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("BoxItem {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("complete=" + (_complete != null ? _complete!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  BoxItem copyWith({String? id, String? name, String? description, bool? complete}) {
    return BoxItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      complete: complete ?? this.complete);
  }
  
  BoxItem.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _description = json['description'],
      _complete = json['complete'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'description': _description, 'complete': _complete
  };

  static final QueryField ID = QueryField(fieldName: "boxItem.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField COMPLETE = QueryField(fieldName: "complete");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "BoxItem";
    modelSchemaDefinition.pluralName = "BoxItems";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: BoxItem.NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: BoxItem.DESCRIPTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: BoxItem.COMPLETE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
  });
}

class _BoxItemModelType extends ModelType<BoxItem> {
  const _BoxItemModelType();
  
  @override
  BoxItem fromJson(Map<String, dynamic> jsonData) {
    return BoxItem.fromJson(jsonData);
  }
}