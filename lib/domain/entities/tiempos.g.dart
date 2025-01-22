// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tiempos.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTiemposCollection on Isar {
  IsarCollection<Tiempos> get tiempos => this.collection();
}

const TiemposSchema = CollectionSchema(
  name: r'Tiempos',
  id: -7248363328922220888,
  properties: {
    r'actividad': PropertySchema(
      id: 0,
      name: r'actividad',
      type: IsarType.byte,
      enumMap: _TiemposactividadEnumValueMap,
    ),
    r'fecha': PropertySchema(
      id: 1,
      name: r'fecha',
      type: IsarType.dateTime,
    ),
    r'ntroquel': PropertySchema(
      id: 2,
      name: r'ntroquel',
      type: IsarType.string,
    ),
    r'tiempo': PropertySchema(
      id: 3,
      name: r'tiempo',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _tiemposEstimateSize,
  serialize: _tiemposSerialize,
  deserialize: _tiemposDeserialize,
  deserializeProp: _tiemposDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {
    r'operario': LinkSchema(
      id: -2464893099689157114,
      name: r'operario',
      target: r'Operario',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _tiemposGetId,
  getLinks: _tiemposGetLinks,
  attach: _tiemposAttach,
  version: '3.1.0+1',
);

int _tiemposEstimateSize(
  Tiempos object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.ntroquel.length * 3;
  return bytesCount;
}

void _tiemposSerialize(
  Tiempos object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.actividad.index);
  writer.writeDateTime(offsets[1], object.fecha);
  writer.writeString(offsets[2], object.ntroquel);
  writer.writeDateTime(offsets[3], object.tiempo);
}

Tiempos _tiemposDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Tiempos(
    actividad:
        _TiemposactividadValueEnumMap[reader.readByteOrNull(offsets[0])] ??
            Actividad.Dibujo,
    fecha: reader.readDateTime(offsets[1]),
    ntroquel: reader.readString(offsets[2]),
    tiempo: reader.readDateTime(offsets[3]),
  );
  object.isarId = id;
  return object;
}

P _tiemposDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_TiemposactividadValueEnumMap[reader.readByteOrNull(offset)] ??
          Actividad.Dibujo) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _TiemposactividadEnumValueMap = {
  'Dibujo': 0,
  'Encuchillado': 1,
  'Punteado': 2,
  'Calado': 3,
  'Serrapid': 4,
  'Engomado': 5,
  'Prueba': 6,
  'Empaque': 7,
};
const _TiemposactividadValueEnumMap = {
  0: Actividad.Dibujo,
  1: Actividad.Encuchillado,
  2: Actividad.Punteado,
  3: Actividad.Calado,
  4: Actividad.Serrapid,
  5: Actividad.Engomado,
  6: Actividad.Prueba,
  7: Actividad.Empaque,
};

Id _tiemposGetId(Tiempos object) {
  return object.isarId ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _tiemposGetLinks(Tiempos object) {
  return [object.operario];
}

void _tiemposAttach(IsarCollection<dynamic> col, Id id, Tiempos object) {
  object.isarId = id;
  object.operario.attach(col, col.isar.collection<Operario>(), r'operario', id);
}

extension TiemposQueryWhereSort on QueryBuilder<Tiempos, Tiempos, QWhere> {
  QueryBuilder<Tiempos, Tiempos, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TiemposQueryWhere on QueryBuilder<Tiempos, Tiempos, QWhereClause> {
  QueryBuilder<Tiempos, Tiempos, QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterWhereClause> isarIdNotEqualTo(
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

  QueryBuilder<Tiempos, Tiempos, QAfterWhereClause> isarIdGreaterThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterWhereClause> isarIdLessThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterWhereClause> isarIdBetween(
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

extension TiemposQueryFilter
    on QueryBuilder<Tiempos, Tiempos, QFilterCondition> {
  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> actividadEqualTo(
      Actividad value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'actividad',
        value: value,
      ));
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> actividadGreaterThan(
    Actividad value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'actividad',
        value: value,
      ));
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> actividadLessThan(
    Actividad value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'actividad',
        value: value,
      ));
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> actividadBetween(
    Actividad lower,
    Actividad upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'actividad',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> fechaEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fecha',
        value: value,
      ));
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> fechaGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fecha',
        value: value,
      ));
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> fechaLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fecha',
        value: value,
      ));
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> fechaBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fecha',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> isarIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isarId',
      ));
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> isarIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isarId',
      ));
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> isarIdEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> isarIdGreaterThan(
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

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> ntroquelEqualTo(
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

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> ntroquelGreaterThan(
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

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> ntroquelLessThan(
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

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> ntroquelBetween(
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

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> ntroquelStartsWith(
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

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> ntroquelEndsWith(
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

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> ntroquelContains(
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

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> ntroquelMatches(
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

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> ntroquelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ntroquel',
        value: '',
      ));
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> ntroquelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ntroquel',
        value: '',
      ));
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> tiempoEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tiempo',
        value: value,
      ));
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> tiempoGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tiempo',
        value: value,
      ));
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> tiempoLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tiempo',
        value: value,
      ));
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> tiempoBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tiempo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TiemposQueryObject
    on QueryBuilder<Tiempos, Tiempos, QFilterCondition> {}

extension TiemposQueryLinks
    on QueryBuilder<Tiempos, Tiempos, QFilterCondition> {
  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> operario(
      FilterQuery<Operario> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'operario');
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> operarioLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'operario', length, true, length, true);
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> operarioIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'operario', 0, true, 0, true);
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> operarioIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'operario', 0, false, 999999, true);
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> operarioLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'operario', 0, true, length, include);
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition>
      operarioLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'operario', length, include, 999999, true);
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterFilterCondition> operarioLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'operario', lower, includeLower, upper, includeUpper);
    });
  }
}

extension TiemposQuerySortBy on QueryBuilder<Tiempos, Tiempos, QSortBy> {
  QueryBuilder<Tiempos, Tiempos, QAfterSortBy> sortByActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actividad', Sort.asc);
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterSortBy> sortByActividadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actividad', Sort.desc);
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterSortBy> sortByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterSortBy> sortByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterSortBy> sortByNtroquel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ntroquel', Sort.asc);
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterSortBy> sortByNtroquelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ntroquel', Sort.desc);
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterSortBy> sortByTiempo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempo', Sort.asc);
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterSortBy> sortByTiempoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempo', Sort.desc);
    });
  }
}

extension TiemposQuerySortThenBy
    on QueryBuilder<Tiempos, Tiempos, QSortThenBy> {
  QueryBuilder<Tiempos, Tiempos, QAfterSortBy> thenByActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actividad', Sort.asc);
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterSortBy> thenByActividadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actividad', Sort.desc);
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterSortBy> thenByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterSortBy> thenByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterSortBy> thenByNtroquel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ntroquel', Sort.asc);
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterSortBy> thenByNtroquelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ntroquel', Sort.desc);
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterSortBy> thenByTiempo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempo', Sort.asc);
    });
  }

  QueryBuilder<Tiempos, Tiempos, QAfterSortBy> thenByTiempoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempo', Sort.desc);
    });
  }
}

extension TiemposQueryWhereDistinct
    on QueryBuilder<Tiempos, Tiempos, QDistinct> {
  QueryBuilder<Tiempos, Tiempos, QDistinct> distinctByActividad() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'actividad');
    });
  }

  QueryBuilder<Tiempos, Tiempos, QDistinct> distinctByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fecha');
    });
  }

  QueryBuilder<Tiempos, Tiempos, QDistinct> distinctByNtroquel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ntroquel', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Tiempos, Tiempos, QDistinct> distinctByTiempo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tiempo');
    });
  }
}

extension TiemposQueryProperty
    on QueryBuilder<Tiempos, Tiempos, QQueryProperty> {
  QueryBuilder<Tiempos, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<Tiempos, Actividad, QQueryOperations> actividadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'actividad');
    });
  }

  QueryBuilder<Tiempos, DateTime, QQueryOperations> fechaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fecha');
    });
  }

  QueryBuilder<Tiempos, String, QQueryOperations> ntroquelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ntroquel');
    });
  }

  QueryBuilder<Tiempos, DateTime, QQueryOperations> tiempoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tiempo');
    });
  }
}
