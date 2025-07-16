// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumo.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetConsumoCollection on Isar {
  IsarCollection<Consumo> get consumos => this.collection();
}

const ConsumoSchema = CollectionSchema(
  name: r'Consumo',
  id: -6107959095797373155,
  properties: {
    r'cantidad': PropertySchema(
      id: 0,
      name: r'cantidad',
      type: IsarType.long,
    ),
    r'cliente': PropertySchema(
      id: 1,
      name: r'cliente',
      type: IsarType.string,
    ),
    r'nTroquel': PropertySchema(
      id: 2,
      name: r'nTroquel',
      type: IsarType.string,
    ),
    r'planta': PropertySchema(
      id: 3,
      name: r'planta',
      type: IsarType.string,
    ),
    r'tipo': PropertySchema(
      id: 4,
      name: r'tipo',
      type: IsarType.string,
    )
  },
  estimateSize: _consumoEstimateSize,
  serialize: _consumoSerialize,
  deserialize: _consumoDeserialize,
  deserializeProp: _consumoDeserializeProp,
  idName: r'isarid',
  indexes: {},
  links: {
    r'materiales': LinkSchema(
      id: 9174623488223896951,
      name: r'materiales',
      target: r'Materiales',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _consumoGetId,
  getLinks: _consumoGetLinks,
  attach: _consumoAttach,
  version: '3.1.0+1',
);

int _consumoEstimateSize(
  Consumo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.cliente.length * 3;
  bytesCount += 3 + object.nTroquel.length * 3;
  bytesCount += 3 + object.planta.length * 3;
  bytesCount += 3 + object.tipo.length * 3;
  return bytesCount;
}

void _consumoSerialize(
  Consumo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.cantidad);
  writer.writeString(offsets[1], object.cliente);
  writer.writeString(offsets[2], object.nTroquel);
  writer.writeString(offsets[3], object.planta);
  writer.writeString(offsets[4], object.tipo);
}

Consumo _consumoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Consumo(
    cantidad: reader.readLong(offsets[0]),
    cliente: reader.readString(offsets[1]),
    nTroquel: reader.readString(offsets[2]),
    planta: reader.readString(offsets[3]),
    tipo: reader.readString(offsets[4]),
  );
  object.isarid = id;
  return object;
}

P _consumoDeserializeProp<P>(
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
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _consumoGetId(Consumo object) {
  return object.isarid ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _consumoGetLinks(Consumo object) {
  return [object.materiales];
}

void _consumoAttach(IsarCollection<dynamic> col, Id id, Consumo object) {
  object.isarid = id;
  object.materiales
      .attach(col, col.isar.collection<Materiales>(), r'materiales', id);
}

extension ConsumoQueryWhereSort on QueryBuilder<Consumo, Consumo, QWhere> {
  QueryBuilder<Consumo, Consumo, QAfterWhere> anyIsarid() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ConsumoQueryWhere on QueryBuilder<Consumo, Consumo, QWhereClause> {
  QueryBuilder<Consumo, Consumo, QAfterWhereClause> isaridEqualTo(Id isarid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarid,
        upper: isarid,
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterWhereClause> isaridNotEqualTo(
      Id isarid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarid, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarid, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarid, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarid, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterWhereClause> isaridGreaterThan(Id isarid,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarid, includeLower: include),
      );
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterWhereClause> isaridLessThan(Id isarid,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarid, includeUpper: include),
      );
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterWhereClause> isaridBetween(
    Id lowerIsarid,
    Id upperIsarid, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarid,
        includeLower: includeLower,
        upper: upperIsarid,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ConsumoQueryFilter
    on QueryBuilder<Consumo, Consumo, QFilterCondition> {
  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> cantidadEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cantidad',
        value: value,
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> cantidadGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cantidad',
        value: value,
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> cantidadLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cantidad',
        value: value,
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> cantidadBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cantidad',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> clienteEqualTo(
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

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> clienteGreaterThan(
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

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> clienteLessThan(
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

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> clienteBetween(
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

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> clienteStartsWith(
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

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> clienteEndsWith(
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

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> clienteContains(
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

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> clienteMatches(
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

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> clienteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cliente',
        value: '',
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> clienteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cliente',
        value: '',
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> isaridIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isarid',
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> isaridIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isarid',
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> isaridEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarid',
        value: value,
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> isaridGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarid',
        value: value,
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> isaridLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarid',
        value: value,
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> isaridBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> nTroquelEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nTroquel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> nTroquelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nTroquel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> nTroquelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nTroquel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> nTroquelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nTroquel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> nTroquelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nTroquel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> nTroquelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nTroquel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> nTroquelContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nTroquel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> nTroquelMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nTroquel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> nTroquelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nTroquel',
        value: '',
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> nTroquelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nTroquel',
        value: '',
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> plantaEqualTo(
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

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> plantaGreaterThan(
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

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> plantaLessThan(
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

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> plantaBetween(
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

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> plantaStartsWith(
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

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> plantaEndsWith(
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

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> plantaContains(
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

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> plantaMatches(
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

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> plantaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'planta',
        value: '',
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> plantaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'planta',
        value: '',
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> tipoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> tipoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> tipoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> tipoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tipo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> tipoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> tipoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> tipoContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> tipoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tipo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> tipoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipo',
        value: '',
      ));
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> tipoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipo',
        value: '',
      ));
    });
  }
}

extension ConsumoQueryObject
    on QueryBuilder<Consumo, Consumo, QFilterCondition> {}

extension ConsumoQueryLinks
    on QueryBuilder<Consumo, Consumo, QFilterCondition> {
  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> materiales(
      FilterQuery<Materiales> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'materiales');
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> materialesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'materiales', length, true, length, true);
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> materialesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'materiales', 0, true, 0, true);
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> materialesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'materiales', 0, false, 999999, true);
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition>
      materialesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'materiales', 0, true, length, include);
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition>
      materialesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'materiales', length, include, 999999, true);
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterFilterCondition> materialesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'materiales', lower, includeLower, upper, includeUpper);
    });
  }
}

extension ConsumoQuerySortBy on QueryBuilder<Consumo, Consumo, QSortBy> {
  QueryBuilder<Consumo, Consumo, QAfterSortBy> sortByCantidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidad', Sort.asc);
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterSortBy> sortByCantidadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidad', Sort.desc);
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterSortBy> sortByCliente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cliente', Sort.asc);
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterSortBy> sortByClienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cliente', Sort.desc);
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterSortBy> sortByNTroquel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nTroquel', Sort.asc);
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterSortBy> sortByNTroquelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nTroquel', Sort.desc);
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterSortBy> sortByPlanta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planta', Sort.asc);
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterSortBy> sortByPlantaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planta', Sort.desc);
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterSortBy> sortByTipo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.asc);
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterSortBy> sortByTipoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.desc);
    });
  }
}

extension ConsumoQuerySortThenBy
    on QueryBuilder<Consumo, Consumo, QSortThenBy> {
  QueryBuilder<Consumo, Consumo, QAfterSortBy> thenByCantidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidad', Sort.asc);
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterSortBy> thenByCantidadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidad', Sort.desc);
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterSortBy> thenByCliente() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cliente', Sort.asc);
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterSortBy> thenByClienteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cliente', Sort.desc);
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterSortBy> thenByIsarid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarid', Sort.asc);
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterSortBy> thenByIsaridDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarid', Sort.desc);
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterSortBy> thenByNTroquel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nTroquel', Sort.asc);
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterSortBy> thenByNTroquelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nTroquel', Sort.desc);
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterSortBy> thenByPlanta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planta', Sort.asc);
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterSortBy> thenByPlantaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planta', Sort.desc);
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterSortBy> thenByTipo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.asc);
    });
  }

  QueryBuilder<Consumo, Consumo, QAfterSortBy> thenByTipoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.desc);
    });
  }
}

extension ConsumoQueryWhereDistinct
    on QueryBuilder<Consumo, Consumo, QDistinct> {
  QueryBuilder<Consumo, Consumo, QDistinct> distinctByCantidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cantidad');
    });
  }

  QueryBuilder<Consumo, Consumo, QDistinct> distinctByCliente(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cliente', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Consumo, Consumo, QDistinct> distinctByNTroquel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nTroquel', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Consumo, Consumo, QDistinct> distinctByPlanta(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'planta', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Consumo, Consumo, QDistinct> distinctByTipo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipo', caseSensitive: caseSensitive);
    });
  }
}

extension ConsumoQueryProperty
    on QueryBuilder<Consumo, Consumo, QQueryProperty> {
  QueryBuilder<Consumo, int, QQueryOperations> isaridProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarid');
    });
  }

  QueryBuilder<Consumo, int, QQueryOperations> cantidadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cantidad');
    });
  }

  QueryBuilder<Consumo, String, QQueryOperations> clienteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cliente');
    });
  }

  QueryBuilder<Consumo, String, QQueryOperations> nTroquelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nTroquel');
    });
  }

  QueryBuilder<Consumo, String, QQueryOperations> plantaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'planta');
    });
  }

  QueryBuilder<Consumo, String, QQueryOperations> tipoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipo');
    });
  }
}
