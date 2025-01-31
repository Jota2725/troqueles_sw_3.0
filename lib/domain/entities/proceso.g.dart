// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proceso.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetProcesoCollection on Isar {
  IsarCollection<Proceso> get procesos => this.collection();
}

const ProcesoSchema = CollectionSchema(
  name: r'Proceso',
  id: 3624272438564820450,
  properties: {
    r'cliente': PropertySchema(
      id: 0,
      name: r'cliente',
      type: IsarType.string,
    ),
    r'estado': PropertySchema(
      id: 1,
      name: r'estado',
      type: IsarType.byte,
      enumMap: _ProcesoestadoEnumValueMap,
    ),
    r'fechaEstimada': PropertySchema(
      id: 2,
      name: r'fechaEstimada',
      type: IsarType.dateTime,
    ),
    r'fechaIngreso': PropertySchema(
      id: 3,
      name: r'fechaIngreso',
      type: IsarType.dateTime,
    ),
    r'ingeniero': PropertySchema(
      id: 4,
      name: r'ingeniero',
      type: IsarType.string,
    ),
    r'maquina': PropertySchema(
      id: 5,
      name: r'maquina',
      type: IsarType.string,
    ),
    r'ntroquel': PropertySchema(
      id: 6,
      name: r'ntroquel',
      type: IsarType.string,
    ),
    r'observaciones': PropertySchema(
      id: 7,
      name: r'observaciones',
      type: IsarType.string,
    ),
    r'planta': PropertySchema(
      id: 8,
      name: r'planta',
      type: IsarType.string,
    )
  },
  estimateSize: _procesoEstimateSize,
  serialize: _procesoSerialize,
  deserialize: _procesoDeserialize,
  deserializeProp: _procesoDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _procesoGetId,
  getLinks: _procesoGetLinks,
  attach: _procesoAttach,
  version: '3.1.0+1',
);

int _procesoEstimateSize(
  Proceso object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.cliente.length * 3;
  bytesCount += 3 + object.ingeniero.length * 3;
  bytesCount += 3 + object.maquina.length * 3;
  bytesCount += 3 + object.ntroquel.length * 3;
  bytesCount += 3 + object.observaciones.length * 3;
  bytesCount += 3 + object.planta.length * 3;
  return bytesCount;
}

void _procesoSerialize(
  Proceso object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.cliente);
  writer.writeByte(offsets[1], object.estado.index);
  writer.writeDateTime(offsets[2], object.fechaEstimada);
  writer.writeDateTime(offsets[3], object.fechaIngreso);
  writer.writeString(offsets[4], object.ingeniero);
  writer.writeString(offsets[5], object.maquina);
  writer.writeString(offsets[6], object.ntroquel);
  writer.writeString(offsets[7], object.observaciones);
  writer.writeString(offsets[8], object.planta);
}

Proceso _procesoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Proceso(
    cliente: reader.readString(offsets[0]),
    estado: _ProcesoestadoValueEnumMap[reader.readByteOrNull(offsets[1])] ??
        Estado.suspendido,
    fechaEstimada: reader.readDateTimeOrNull(offsets[2]),
    fechaIngreso: reader.readDateTime(offsets[3]),
    ingeniero: reader.readString(offsets[4]),
    maquina: reader.readString(offsets[5]),
    ntroquel: reader.readString(offsets[6]),
    observaciones: reader.readString(offsets[7]),
    planta: reader.readString(offsets[8]),
  );
  object.isarId = id;
  return object;
}

P _procesoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (_ProcesoestadoValueEnumMap[reader.readByteOrNull(offset)] ??
          Estado.suspendido) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ProcesoestadoEnumValueMap = {
  'suspendido': 0,
  'enProceso': 1,
  'completado': 2,
  'pendiente': 3,
};
const _ProcesoestadoValueEnumMap = {
  0: Estado.suspendido,
  1: Estado.enProceso,
  2: Estado.completado,
  3: Estado.pendiente,
};

Id _procesoGetId(Proceso object) {
  return object.isarId ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _procesoGetLinks(Proceso object) {
  return [];
}

void _procesoAttach(IsarCollection<dynamic> col, Id id, Proceso object) {
  object.isarId = id;
}

extension ProcesoQueryWhereSort on QueryBuilder<Proceso, Proceso, QWhere> {
  QueryBuilder<Proceso, Proceso, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ProcesoQueryWhere on QueryBuilder<Proceso, Proceso, QWhereClause> {
  QueryBuilder<Proceso, Proceso, QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterWhereClause> isarIdNotEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterWhereClause> isarIdGreaterThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterWhereClause> isarIdLessThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ProcesoQueryFilter
    on QueryBuilder<Proceso, Proceso, QFilterCondition> {
  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> clienteEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cliente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> clienteGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cliente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> clienteLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cliente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> clienteBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cliente',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> clienteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cliente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> clienteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cliente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> clienteContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cliente',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> clienteMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cliente',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> clienteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cliente',
        value: '',
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> clienteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cliente',
        value: '',
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> estadoEqualTo(
      Estado value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estado',
        value: value,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> estadoGreaterThan(
    Estado value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'estado',
        value: value,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> estadoLessThan(
    Estado value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'estado',
        value: value,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> estadoBetween(
    Estado lower,
    Estado upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'estado',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> fechaEstimadaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fechaEstimada',
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition>
      fechaEstimadaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fechaEstimada',
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> fechaEstimadaEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaEstimada',
        value: value,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition>
      fechaEstimadaGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fechaEstimada',
        value: value,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> fechaEstimadaLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fechaEstimada',
        value: value,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> fechaEstimadaBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fechaEstimada',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> fechaIngresoEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaIngreso',
        value: value,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> fechaIngresoGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fechaIngreso',
        value: value,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> fechaIngresoLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fechaIngreso',
        value: value,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> fechaIngresoBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fechaIngreso',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> ingenieroEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ingeniero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> ingenieroGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ingeniero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> ingenieroLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ingeniero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> ingenieroBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ingeniero',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> ingenieroStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ingeniero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> ingenieroEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ingeniero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> ingenieroContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ingeniero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> ingenieroMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ingeniero',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> ingenieroIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ingeniero',
        value: '',
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> ingenieroIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ingeniero',
        value: '',
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> isarIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isarId',
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> isarIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isarId',
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> isarIdEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> isarIdGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> isarIdLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> isarIdBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> maquinaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maquina',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> maquinaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maquina',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> maquinaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maquina',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> maquinaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maquina',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> maquinaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'maquina',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> maquinaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'maquina',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> maquinaContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'maquina',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> maquinaMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'maquina',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> maquinaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maquina',
        value: '',
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> maquinaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'maquina',
        value: '',
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> ntroquelEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ntroquel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> ntroquelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ntroquel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> ntroquelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ntroquel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> ntroquelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ntroquel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> ntroquelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ntroquel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> ntroquelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ntroquel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> ntroquelContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ntroquel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> ntroquelMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ntroquel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> ntroquelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ntroquel',
        value: '',
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> ntroquelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ntroquel',
        value: '',
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> observacionesEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'observaciones',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition>
      observacionesGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'observaciones',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> observacionesLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'observaciones',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> observacionesBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'observaciones',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> observacionesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'observaciones',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> observacionesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'observaciones',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> observacionesContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'observaciones',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> observacionesMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'observaciones',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> observacionesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'observaciones',
        value: '',
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition>
      observacionesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'observaciones',
        value: '',
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> plantaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'planta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> plantaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'planta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> plantaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'planta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> plantaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'planta',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> plantaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'planta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> plantaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'planta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> plantaContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'planta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> plantaMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'planta',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> plantaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'planta',
        value: '',
      ));
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterFilterCondition> plantaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'planta',
        value: '',
      ));
    });
  }
}

extension ProcesoQueryObject
    on QueryBuilder<Proceso, Proceso, QFilterCondition> {}

extension ProcesoQueryLinks
    on QueryBuilder<Proceso, Proceso, QFilterCondition> {}

extension ProcesoQuerySortBy on QueryBuilder<Proceso, Proceso, QSortBy> {
  QueryBuilder<Proceso, Proceso, QAfterSortBy> sortByCliente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cliente', Sort.asc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> sortByClienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cliente', Sort.desc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> sortByEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.asc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> sortByEstadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.desc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> sortByFechaEstimada() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaEstimada', Sort.asc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> sortByFechaEstimadaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaEstimada', Sort.desc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> sortByFechaIngreso() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaIngreso', Sort.asc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> sortByFechaIngresoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaIngreso', Sort.desc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> sortByIngeniero() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ingeniero', Sort.asc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> sortByIngenieroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ingeniero', Sort.desc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> sortByMaquina() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maquina', Sort.asc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> sortByMaquinaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maquina', Sort.desc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> sortByNtroquel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ntroquel', Sort.asc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> sortByNtroquelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ntroquel', Sort.desc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> sortByObservaciones() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observaciones', Sort.asc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> sortByObservacionesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observaciones', Sort.desc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> sortByPlanta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planta', Sort.asc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> sortByPlantaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planta', Sort.desc);
    });
  }
}

extension ProcesoQuerySortThenBy
    on QueryBuilder<Proceso, Proceso, QSortThenBy> {
  QueryBuilder<Proceso, Proceso, QAfterSortBy> thenByCliente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cliente', Sort.asc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> thenByClienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cliente', Sort.desc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> thenByEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.asc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> thenByEstadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.desc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> thenByFechaEstimada() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaEstimada', Sort.asc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> thenByFechaEstimadaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaEstimada', Sort.desc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> thenByFechaIngreso() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaIngreso', Sort.asc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> thenByFechaIngresoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaIngreso', Sort.desc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> thenByIngeniero() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ingeniero', Sort.asc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> thenByIngenieroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ingeniero', Sort.desc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> thenByMaquina() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maquina', Sort.asc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> thenByMaquinaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maquina', Sort.desc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> thenByNtroquel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ntroquel', Sort.asc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> thenByNtroquelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ntroquel', Sort.desc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> thenByObservaciones() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observaciones', Sort.asc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> thenByObservacionesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observaciones', Sort.desc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> thenByPlanta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planta', Sort.asc);
    });
  }

  QueryBuilder<Proceso, Proceso, QAfterSortBy> thenByPlantaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planta', Sort.desc);
    });
  }
}

extension ProcesoQueryWhereDistinct
    on QueryBuilder<Proceso, Proceso, QDistinct> {
  QueryBuilder<Proceso, Proceso, QDistinct> distinctByCliente(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cliente', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Proceso, Proceso, QDistinct> distinctByEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estado');
    });
  }

  QueryBuilder<Proceso, Proceso, QDistinct> distinctByFechaEstimada() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaEstimada');
    });
  }

  QueryBuilder<Proceso, Proceso, QDistinct> distinctByFechaIngreso() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaIngreso');
    });
  }

  QueryBuilder<Proceso, Proceso, QDistinct> distinctByIngeniero(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ingeniero', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Proceso, Proceso, QDistinct> distinctByMaquina(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maquina', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Proceso, Proceso, QDistinct> distinctByNtroquel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ntroquel', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Proceso, Proceso, QDistinct> distinctByObservaciones(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'observaciones',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Proceso, Proceso, QDistinct> distinctByPlanta(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'planta', caseSensitive: caseSensitive);
    });
  }
}

extension ProcesoQueryProperty
    on QueryBuilder<Proceso, Proceso, QQueryProperty> {
  QueryBuilder<Proceso, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<Proceso, String, QQueryOperations> clienteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cliente');
    });
  }

  QueryBuilder<Proceso, Estado, QQueryOperations> estadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estado');
    });
  }

  QueryBuilder<Proceso, DateTime?, QQueryOperations> fechaEstimadaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaEstimada');
    });
  }

  QueryBuilder<Proceso, DateTime, QQueryOperations> fechaIngresoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaIngreso');
    });
  }

  QueryBuilder<Proceso, String, QQueryOperations> ingenieroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ingeniero');
    });
  }

  QueryBuilder<Proceso, String, QQueryOperations> maquinaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maquina');
    });
  }

  QueryBuilder<Proceso, String, QQueryOperations> ntroquelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ntroquel');
    });
  }

  QueryBuilder<Proceso, String, QQueryOperations> observacionesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'observaciones');
    });
  }

  QueryBuilder<Proceso, String, QQueryOperations> plantaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'planta');
    });
  }
}
