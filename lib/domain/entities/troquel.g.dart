// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'troquel.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTroquelCollection on Isar {
  IsarCollection<Troquel> get troquels => this.collection();
}

const TroquelSchema = CollectionSchema(
  name: r'Troquel',
  id: -3475962824799753735,
  properties: {
    r'alto': PropertySchema(
      id: 0,
      name: r'alto',
      type: IsarType.long,
    ),
    r'ancho': PropertySchema(
      id: 1,
      name: r'ancho',
      type: IsarType.long,
    ),
    r'cabida': PropertySchema(
      id: 2,
      name: r'cabida',
      type: IsarType.long,
    ),
    r'clave': PropertySchema(
      id: 3,
      name: r'clave',
      type: IsarType.string,
    ),
    r'cliente': PropertySchema(
      id: 4,
      name: r'cliente',
      type: IsarType.string,
    ),
    r'descripcion': PropertySchema(
      id: 5,
      name: r'descripcion',
      type: IsarType.string,
    ),
    r'estilo': PropertySchema(
      id: 6,
      name: r'estilo',
      type: IsarType.string,
    ),
    r'gico': PropertySchema(
      id: 7,
      name: r'gico',
      type: IsarType.long,
    ),
    r'largo': PropertySchema(
      id: 8,
      name: r'largo',
      type: IsarType.long,
    ),
    r'maquina': PropertySchema(
      id: 9,
      name: r'maquina',
      type: IsarType.string,
    ),
    r'nota': PropertySchema(
      id: 10,
      name: r'nota',
      type: IsarType.string,
    ),
    r'referencia': PropertySchema(
      id: 11,
      name: r'referencia',
      type: IsarType.long,
    ),
    r'ubicacion': PropertySchema(
      id: 12,
      name: r'ubicacion',
      type: IsarType.string,
    )
  },
  estimateSize: _troquelEstimateSize,
  serialize: _troquelSerialize,
  deserialize: _troquelDeserialize,
  deserializeProp: _troquelDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _troquelGetId,
  getLinks: _troquelGetLinks,
  attach: _troquelAttach,
  version: '3.1.0+1',
);

int _troquelEstimateSize(
  Troquel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.clave;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.cliente.length * 3;
  {
    final value = object.descripcion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.estilo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.maquina.length * 3;
  {
    final value = object.nota;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.ubicacion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _troquelSerialize(
  Troquel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.alto);
  writer.writeLong(offsets[1], object.ancho);
  writer.writeLong(offsets[2], object.cabida);
  writer.writeString(offsets[3], object.clave);
  writer.writeString(offsets[4], object.cliente);
  writer.writeString(offsets[5], object.descripcion);
  writer.writeString(offsets[6], object.estilo);
  writer.writeLong(offsets[7], object.gico);
  writer.writeLong(offsets[8], object.largo);
  writer.writeString(offsets[9], object.maquina);
  writer.writeString(offsets[10], object.nota);
  writer.writeLong(offsets[11], object.referencia);
  writer.writeString(offsets[12], object.ubicacion);
}

Troquel _troquelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Troquel(
    alto: reader.readLongOrNull(offsets[0]),
    ancho: reader.readLongOrNull(offsets[1]),
    cabida: reader.readLongOrNull(offsets[2]),
    clave: reader.readStringOrNull(offsets[3]),
    cliente: reader.readString(offsets[4]),
    descripcion: reader.readStringOrNull(offsets[5]),
    estilo: reader.readStringOrNull(offsets[6]),
    gico: reader.readLong(offsets[7]),
    largo: reader.readLongOrNull(offsets[8]),
    maquina: reader.readString(offsets[9]),
    nota: reader.readStringOrNull(offsets[10]),
    referencia: reader.readLong(offsets[11]),
    ubicacion: reader.readStringOrNull(offsets[12]),
  );
  object.isarId = id;
  return object;
}

P _troquelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _troquelGetId(Troquel object) {
  return object.isarId ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _troquelGetLinks(Troquel object) {
  return [];
}

void _troquelAttach(IsarCollection<dynamic> col, Id id, Troquel object) {
  object.isarId = id;
}

extension TroquelQueryWhereSort on QueryBuilder<Troquel, Troquel, QWhere> {
  QueryBuilder<Troquel, Troquel, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TroquelQueryWhere on QueryBuilder<Troquel, Troquel, QWhereClause> {
  QueryBuilder<Troquel, Troquel, QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterWhereClause> isarIdNotEqualTo(
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

  QueryBuilder<Troquel, Troquel, QAfterWhereClause> isarIdGreaterThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterWhereClause> isarIdLessThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterWhereClause> isarIdBetween(
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

extension TroquelQueryFilter
    on QueryBuilder<Troquel, Troquel, QFilterCondition> {
  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> altoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'alto',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> altoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'alto',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> altoEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'alto',
        value: value,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> altoGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'alto',
        value: value,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> altoLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'alto',
        value: value,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> altoBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'alto',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> anchoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ancho',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> anchoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ancho',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> anchoEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ancho',
        value: value,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> anchoGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ancho',
        value: value,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> anchoLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ancho',
        value: value,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> anchoBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ancho',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> cabidaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cabida',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> cabidaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cabida',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> cabidaEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cabida',
        value: value,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> cabidaGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cabida',
        value: value,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> cabidaLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cabida',
        value: value,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> cabidaBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cabida',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> claveIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'clave',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> claveIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'clave',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> claveEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clave',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> claveGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clave',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> claveLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clave',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> claveBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clave',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> claveStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'clave',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> claveEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'clave',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> claveContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'clave',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> claveMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'clave',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> claveIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clave',
        value: '',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> claveIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'clave',
        value: '',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> clienteEqualTo(
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

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> clienteGreaterThan(
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

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> clienteLessThan(
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

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> clienteBetween(
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

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> clienteStartsWith(
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

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> clienteEndsWith(
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

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> clienteContains(
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

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> clienteMatches(
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

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> clienteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cliente',
        value: '',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> clienteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cliente',
        value: '',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> descripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'descripcion',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> descripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'descripcion',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> descripcionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> descripcionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'descripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> descripcionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'descripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> descripcionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'descripcion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> descripcionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'descripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> descripcionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'descripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> descripcionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'descripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> descripcionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'descripcion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> descripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition>
      descripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'descripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> estiloIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'estilo',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> estiloIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'estilo',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> estiloEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estilo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> estiloGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'estilo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> estiloLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'estilo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> estiloBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'estilo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> estiloStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'estilo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> estiloEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'estilo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> estiloContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'estilo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> estiloMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'estilo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> estiloIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estilo',
        value: '',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> estiloIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'estilo',
        value: '',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> gicoEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gico',
        value: value,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> gicoGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gico',
        value: value,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> gicoLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gico',
        value: value,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> gicoBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gico',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> isarIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isarId',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> isarIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isarId',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> isarIdEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> isarIdGreaterThan(
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

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> largoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'largo',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> largoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'largo',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> largoEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'largo',
        value: value,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> largoGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'largo',
        value: value,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> largoLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'largo',
        value: value,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> largoBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'largo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> maquinaEqualTo(
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

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> maquinaGreaterThan(
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

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> maquinaLessThan(
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

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> maquinaBetween(
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

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> maquinaStartsWith(
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

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> maquinaEndsWith(
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

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> maquinaContains(
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

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> maquinaMatches(
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

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> maquinaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maquina',
        value: '',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> maquinaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'maquina',
        value: '',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> notaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nota',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> notaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nota',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> notaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nota',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> notaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nota',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> notaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nota',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> notaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nota',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> notaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nota',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> notaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nota',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> notaContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nota',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> notaMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nota',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> notaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nota',
        value: '',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> notaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nota',
        value: '',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> referenciaEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'referencia',
        value: value,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> referenciaGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'referencia',
        value: value,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> referenciaLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'referencia',
        value: value,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> referenciaBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'referencia',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> ubicacionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ubicacion',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> ubicacionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ubicacion',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> ubicacionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ubicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> ubicacionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ubicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> ubicacionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ubicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> ubicacionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ubicacion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> ubicacionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ubicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> ubicacionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ubicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> ubicacionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ubicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> ubicacionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ubicacion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> ubicacionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ubicacion',
        value: '',
      ));
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterFilterCondition> ubicacionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ubicacion',
        value: '',
      ));
    });
  }
}

extension TroquelQueryObject
    on QueryBuilder<Troquel, Troquel, QFilterCondition> {}

extension TroquelQueryLinks
    on QueryBuilder<Troquel, Troquel, QFilterCondition> {}

extension TroquelQuerySortBy on QueryBuilder<Troquel, Troquel, QSortBy> {
  QueryBuilder<Troquel, Troquel, QAfterSortBy> sortByAlto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alto', Sort.asc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> sortByAltoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alto', Sort.desc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> sortByAncho() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ancho', Sort.asc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> sortByAnchoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ancho', Sort.desc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> sortByCabida() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cabida', Sort.asc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> sortByCabidaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cabida', Sort.desc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> sortByClave() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clave', Sort.asc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> sortByClaveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clave', Sort.desc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> sortByCliente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cliente', Sort.asc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> sortByClienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cliente', Sort.desc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> sortByDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcion', Sort.asc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> sortByDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcion', Sort.desc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> sortByEstilo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estilo', Sort.asc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> sortByEstiloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estilo', Sort.desc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> sortByGico() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gico', Sort.asc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> sortByGicoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gico', Sort.desc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> sortByLargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'largo', Sort.asc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> sortByLargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'largo', Sort.desc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> sortByMaquina() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maquina', Sort.asc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> sortByMaquinaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maquina', Sort.desc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> sortByNota() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nota', Sort.asc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> sortByNotaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nota', Sort.desc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> sortByReferencia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referencia', Sort.asc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> sortByReferenciaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referencia', Sort.desc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> sortByUbicacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ubicacion', Sort.asc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> sortByUbicacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ubicacion', Sort.desc);
    });
  }
}

extension TroquelQuerySortThenBy
    on QueryBuilder<Troquel, Troquel, QSortThenBy> {
  QueryBuilder<Troquel, Troquel, QAfterSortBy> thenByAlto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alto', Sort.asc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> thenByAltoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alto', Sort.desc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> thenByAncho() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ancho', Sort.asc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> thenByAnchoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ancho', Sort.desc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> thenByCabida() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cabida', Sort.asc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> thenByCabidaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cabida', Sort.desc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> thenByClave() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clave', Sort.asc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> thenByClaveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clave', Sort.desc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> thenByCliente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cliente', Sort.asc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> thenByClienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cliente', Sort.desc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> thenByDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcion', Sort.asc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> thenByDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcion', Sort.desc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> thenByEstilo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estilo', Sort.asc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> thenByEstiloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estilo', Sort.desc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> thenByGico() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gico', Sort.asc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> thenByGicoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gico', Sort.desc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> thenByLargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'largo', Sort.asc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> thenByLargoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'largo', Sort.desc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> thenByMaquina() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maquina', Sort.asc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> thenByMaquinaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maquina', Sort.desc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> thenByNota() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nota', Sort.asc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> thenByNotaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nota', Sort.desc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> thenByReferencia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referencia', Sort.asc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> thenByReferenciaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referencia', Sort.desc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> thenByUbicacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ubicacion', Sort.asc);
    });
  }

  QueryBuilder<Troquel, Troquel, QAfterSortBy> thenByUbicacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ubicacion', Sort.desc);
    });
  }
}

extension TroquelQueryWhereDistinct
    on QueryBuilder<Troquel, Troquel, QDistinct> {
  QueryBuilder<Troquel, Troquel, QDistinct> distinctByAlto() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'alto');
    });
  }

  QueryBuilder<Troquel, Troquel, QDistinct> distinctByAncho() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ancho');
    });
  }

  QueryBuilder<Troquel, Troquel, QDistinct> distinctByCabida() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cabida');
    });
  }

  QueryBuilder<Troquel, Troquel, QDistinct> distinctByClave(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clave', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Troquel, Troquel, QDistinct> distinctByCliente(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cliente', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Troquel, Troquel, QDistinct> distinctByDescripcion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'descripcion', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Troquel, Troquel, QDistinct> distinctByEstilo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estilo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Troquel, Troquel, QDistinct> distinctByGico() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gico');
    });
  }

  QueryBuilder<Troquel, Troquel, QDistinct> distinctByLargo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'largo');
    });
  }

  QueryBuilder<Troquel, Troquel, QDistinct> distinctByMaquina(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maquina', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Troquel, Troquel, QDistinct> distinctByNota(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nota', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Troquel, Troquel, QDistinct> distinctByReferencia() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'referencia');
    });
  }

  QueryBuilder<Troquel, Troquel, QDistinct> distinctByUbicacion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ubicacion', caseSensitive: caseSensitive);
    });
  }
}

extension TroquelQueryProperty
    on QueryBuilder<Troquel, Troquel, QQueryProperty> {
  QueryBuilder<Troquel, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<Troquel, int?, QQueryOperations> altoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'alto');
    });
  }

  QueryBuilder<Troquel, int?, QQueryOperations> anchoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ancho');
    });
  }

  QueryBuilder<Troquel, int?, QQueryOperations> cabidaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cabida');
    });
  }

  QueryBuilder<Troquel, String?, QQueryOperations> claveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clave');
    });
  }

  QueryBuilder<Troquel, String, QQueryOperations> clienteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cliente');
    });
  }

  QueryBuilder<Troquel, String?, QQueryOperations> descripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'descripcion');
    });
  }

  QueryBuilder<Troquel, String?, QQueryOperations> estiloProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estilo');
    });
  }

  QueryBuilder<Troquel, int, QQueryOperations> gicoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gico');
    });
  }

  QueryBuilder<Troquel, int?, QQueryOperations> largoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'largo');
    });
  }

  QueryBuilder<Troquel, String, QQueryOperations> maquinaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maquina');
    });
  }

  QueryBuilder<Troquel, String?, QQueryOperations> notaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nota');
    });
  }

  QueryBuilder<Troquel, int, QQueryOperations> referenciaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'referencia');
    });
  }

  QueryBuilder<Troquel, String?, QQueryOperations> ubicacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ubicacion');
    });
  }
}
