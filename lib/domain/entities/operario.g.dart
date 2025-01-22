// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operario.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetOperarioCollection on Isar {
  IsarCollection<Operario> get operarios => this.collection();
}

const OperarioSchema = CollectionSchema(
  name: r'Operario',
  id: -2916044979221219081,
  properties: {
    r'ficha': PropertySchema(
      id: 0,
      name: r'ficha',
      type: IsarType.long,
    ),
    r'nombre': PropertySchema(
      id: 1,
      name: r'nombre',
      type: IsarType.string,
    )
  },
  estimateSize: _operarioEstimateSize,
  serialize: _operarioSerialize,
  deserialize: _operarioDeserialize,
  deserializeProp: _operarioDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _operarioGetId,
  getLinks: _operarioGetLinks,
  attach: _operarioAttach,
  version: '3.1.0+1',
);

int _operarioEstimateSize(
  Operario object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.nombre.length * 3;
  return bytesCount;
}

void _operarioSerialize(
  Operario object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.ficha);
  writer.writeString(offsets[1], object.nombre);
}

Operario _operarioDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Operario(
    ficha: reader.readLong(offsets[0]),
    nombre: reader.readString(offsets[1]),
  );
  object.isarId = id;
  return object;
}

P _operarioDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _operarioGetId(Operario object) {
  return object.isarId ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _operarioGetLinks(Operario object) {
  return [];
}

void _operarioAttach(IsarCollection<dynamic> col, Id id, Operario object) {
  object.isarId = id;
}

extension OperarioQueryWhereSort on QueryBuilder<Operario, Operario, QWhere> {
  QueryBuilder<Operario, Operario, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension OperarioQueryWhere on QueryBuilder<Operario, Operario, QWhereClause> {
  QueryBuilder<Operario, Operario, QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<Operario, Operario, QAfterWhereClause> isarIdNotEqualTo(
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

  QueryBuilder<Operario, Operario, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<Operario, Operario, QAfterWhereClause> isarIdLessThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<Operario, Operario, QAfterWhereClause> isarIdBetween(
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

extension OperarioQueryFilter
    on QueryBuilder<Operario, Operario, QFilterCondition> {
  QueryBuilder<Operario, Operario, QAfterFilterCondition> fichaEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ficha',
        value: value,
      ));
    });
  }

  QueryBuilder<Operario, Operario, QAfterFilterCondition> fichaGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ficha',
        value: value,
      ));
    });
  }

  QueryBuilder<Operario, Operario, QAfterFilterCondition> fichaLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ficha',
        value: value,
      ));
    });
  }

  QueryBuilder<Operario, Operario, QAfterFilterCondition> fichaBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ficha',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Operario, Operario, QAfterFilterCondition> isarIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isarId',
      ));
    });
  }

  QueryBuilder<Operario, Operario, QAfterFilterCondition> isarIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isarId',
      ));
    });
  }

  QueryBuilder<Operario, Operario, QAfterFilterCondition> isarIdEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<Operario, Operario, QAfterFilterCondition> isarIdGreaterThan(
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

  QueryBuilder<Operario, Operario, QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<Operario, Operario, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<Operario, Operario, QAfterFilterCondition> nombreEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operario, Operario, QAfterFilterCondition> nombreGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operario, Operario, QAfterFilterCondition> nombreLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operario, Operario, QAfterFilterCondition> nombreBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nombre',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operario, Operario, QAfterFilterCondition> nombreStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operario, Operario, QAfterFilterCondition> nombreEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operario, Operario, QAfterFilterCondition> nombreContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operario, Operario, QAfterFilterCondition> nombreMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operario, Operario, QAfterFilterCondition> nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<Operario, Operario, QAfterFilterCondition> nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nombre',
        value: '',
      ));
    });
  }
}

extension OperarioQueryObject
    on QueryBuilder<Operario, Operario, QFilterCondition> {}

extension OperarioQueryLinks
    on QueryBuilder<Operario, Operario, QFilterCondition> {}

extension OperarioQuerySortBy on QueryBuilder<Operario, Operario, QSortBy> {
  QueryBuilder<Operario, Operario, QAfterSortBy> sortByFicha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ficha', Sort.asc);
    });
  }

  QueryBuilder<Operario, Operario, QAfterSortBy> sortByFichaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ficha', Sort.desc);
    });
  }

  QueryBuilder<Operario, Operario, QAfterSortBy> sortByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<Operario, Operario, QAfterSortBy> sortByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }
}

extension OperarioQuerySortThenBy
    on QueryBuilder<Operario, Operario, QSortThenBy> {
  QueryBuilder<Operario, Operario, QAfterSortBy> thenByFicha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ficha', Sort.asc);
    });
  }

  QueryBuilder<Operario, Operario, QAfterSortBy> thenByFichaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ficha', Sort.desc);
    });
  }

  QueryBuilder<Operario, Operario, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<Operario, Operario, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<Operario, Operario, QAfterSortBy> thenByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<Operario, Operario, QAfterSortBy> thenByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }
}

extension OperarioQueryWhereDistinct
    on QueryBuilder<Operario, Operario, QDistinct> {
  QueryBuilder<Operario, Operario, QDistinct> distinctByFicha() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ficha');
    });
  }

  QueryBuilder<Operario, Operario, QDistinct> distinctByNombre(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombre', caseSensitive: caseSensitive);
    });
  }
}

extension OperarioQueryProperty
    on QueryBuilder<Operario, Operario, QQueryProperty> {
  QueryBuilder<Operario, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<Operario, int, QQueryOperations> fichaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ficha');
    });
  }

  QueryBuilder<Operario, String, QQueryOperations> nombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombre');
    });
  }
}
