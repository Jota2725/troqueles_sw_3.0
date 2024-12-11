// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'materiales.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMaterialesCollection on Isar {
  IsarCollection<Materiales> get materiales => this.collection();
}

const MaterialesSchema = CollectionSchema(
  name: r'Materiales',
  id: 4101931933247461375,
  properties: {
    r'cantidad': PropertySchema(
      id: 0,
      name: r'cantidad',
      type: IsarType.long,
    ),
    r'codigo': PropertySchema(
      id: 1,
      name: r'codigo',
      type: IsarType.long,
    ),
    r'conversion': PropertySchema(
      id: 2,
      name: r'conversion',
      type: IsarType.double,
    ),
    r'descripcion': PropertySchema(
      id: 3,
      name: r'descripcion',
      type: IsarType.string,
    ),
    r'tipo': PropertySchema(
      id: 4,
      name: r'tipo',
      type: IsarType.byte,
      enumMap: _MaterialestipoEnumValueMap,
    ),
    r'unidad': PropertySchema(
      id: 5,
      name: r'unidad',
      type: IsarType.byte,
      enumMap: _MaterialesunidadEnumValueMap,
    )
  },
  estimateSize: _materialesEstimateSize,
  serialize: _materialesSerialize,
  deserialize: _materialesDeserialize,
  deserializeProp: _materialesDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {
    r'consumo': LinkSchema(
      id: 7796452970767472076,
      name: r'consumo',
      target: r'Consumo',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _materialesGetId,
  getLinks: _materialesGetLinks,
  attach: _materialesAttach,
  version: '3.1.0+1',
);

int _materialesEstimateSize(
  Materiales object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.descripcion.length * 3;
  return bytesCount;
}

void _materialesSerialize(
  Materiales object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.cantidad);
  writer.writeLong(offsets[1], object.codigo);
  writer.writeDouble(offsets[2], object.conversion);
  writer.writeString(offsets[3], object.descripcion);
  writer.writeByte(offsets[4], object.tipo.index);
  writer.writeByte(offsets[5], object.unidad.index);
}

Materiales _materialesDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Materiales(
    cantidad: reader.readLong(offsets[0]),
    codigo: reader.readLong(offsets[1]),
    conversion: reader.readDouble(offsets[2]),
    descripcion: reader.readString(offsets[3]),
    tipo: _MaterialestipoValueEnumMap[reader.readByteOrNull(offsets[4])] ??
        Tipo.maderas,
    unidad: _MaterialesunidadValueEnumMap[reader.readByteOrNull(offsets[5])] ??
        Unidad.mts,
  );
  object.isarId = id;
  return object;
}

P _materialesDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (_MaterialestipoValueEnumMap[reader.readByteOrNull(offset)] ??
          Tipo.maderas) as P;
    case 5:
      return (_MaterialesunidadValueEnumMap[reader.readByteOrNull(offset)] ??
          Unidad.mts) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _MaterialestipoEnumValueMap = {
  'maderas': 0,
  'cuchillas': 1,
  'escores': 2,
  'gomas': 3,
  'herramientas': 4,
  'prealistamientos': 5,
};
const _MaterialestipoValueEnumMap = {
  0: Tipo.maderas,
  1: Tipo.cuchillas,
  2: Tipo.escores,
  3: Tipo.gomas,
  4: Tipo.herramientas,
  5: Tipo.prealistamientos,
};
const _MaterialesunidadEnumValueMap = {
  'mts': 0,
  'par': 1,
  'plancha': 2,
  'rollo': 3,
  'und': 4,
  'cm': 5,
};
const _MaterialesunidadValueEnumMap = {
  0: Unidad.mts,
  1: Unidad.par,
  2: Unidad.plancha,
  3: Unidad.rollo,
  4: Unidad.und,
  5: Unidad.cm,
};

Id _materialesGetId(Materiales object) {
  return object.isarId ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _materialesGetLinks(Materiales object) {
  return [object.consumo];
}

void _materialesAttach(IsarCollection<dynamic> col, Id id, Materiales object) {
  object.isarId = id;
  object.consumo.attach(col, col.isar.collection<Consumo>(), r'consumo', id);
}

extension MaterialesQueryWhereSort
    on QueryBuilder<Materiales, Materiales, QWhere> {
  QueryBuilder<Materiales, Materiales, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MaterialesQueryWhere
    on QueryBuilder<Materiales, Materiales, QWhereClause> {
  QueryBuilder<Materiales, Materiales, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterWhereClause> isarIdNotEqualTo(
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

  QueryBuilder<Materiales, Materiales, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterWhereClause> isarIdBetween(
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

extension MaterialesQueryFilter
    on QueryBuilder<Materiales, Materiales, QFilterCondition> {
  QueryBuilder<Materiales, Materiales, QAfterFilterCondition> cantidadEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cantidad',
        value: value,
      ));
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition>
      cantidadGreaterThan(
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

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition> cantidadLessThan(
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

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition> cantidadBetween(
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

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition> codigoEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'codigo',
        value: value,
      ));
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition> codigoGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'codigo',
        value: value,
      ));
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition> codigoLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'codigo',
        value: value,
      ));
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition> codigoBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'codigo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition> conversionEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'conversion',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition>
      conversionGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'conversion',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition>
      conversionLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'conversion',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition> conversionBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'conversion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition>
      descripcionEqualTo(
    String value, {
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

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition>
      descripcionGreaterThan(
    String value, {
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

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition>
      descripcionLessThan(
    String value, {
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

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition>
      descripcionBetween(
    String lower,
    String upper, {
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

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition>
      descripcionStartsWith(
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

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition>
      descripcionEndsWith(
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

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition>
      descripcionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'descripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition>
      descripcionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'descripcion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition>
      descripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition>
      descripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'descripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition> isarIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isarId',
      ));
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition>
      isarIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isarId',
      ));
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition> isarIdEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition> isarIdGreaterThan(
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

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition> tipoEqualTo(
      Tipo value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipo',
        value: value,
      ));
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition> tipoGreaterThan(
    Tipo value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tipo',
        value: value,
      ));
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition> tipoLessThan(
    Tipo value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tipo',
        value: value,
      ));
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition> tipoBetween(
    Tipo lower,
    Tipo upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tipo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition> unidadEqualTo(
      Unidad value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unidad',
        value: value,
      ));
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition> unidadGreaterThan(
    Unidad value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unidad',
        value: value,
      ));
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition> unidadLessThan(
    Unidad value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unidad',
        value: value,
      ));
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition> unidadBetween(
    Unidad lower,
    Unidad upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unidad',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MaterialesQueryObject
    on QueryBuilder<Materiales, Materiales, QFilterCondition> {}

extension MaterialesQueryLinks
    on QueryBuilder<Materiales, Materiales, QFilterCondition> {
  QueryBuilder<Materiales, Materiales, QAfterFilterCondition> consumo(
      FilterQuery<Consumo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'consumo');
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterFilterCondition> consumoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'consumo', 0, true, 0, true);
    });
  }
}

extension MaterialesQuerySortBy
    on QueryBuilder<Materiales, Materiales, QSortBy> {
  QueryBuilder<Materiales, Materiales, QAfterSortBy> sortByCantidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidad', Sort.asc);
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterSortBy> sortByCantidadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidad', Sort.desc);
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterSortBy> sortByCodigo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codigo', Sort.asc);
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterSortBy> sortByCodigoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codigo', Sort.desc);
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterSortBy> sortByConversion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversion', Sort.asc);
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterSortBy> sortByConversionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversion', Sort.desc);
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterSortBy> sortByDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcion', Sort.asc);
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterSortBy> sortByDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcion', Sort.desc);
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterSortBy> sortByTipo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.asc);
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterSortBy> sortByTipoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.desc);
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterSortBy> sortByUnidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unidad', Sort.asc);
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterSortBy> sortByUnidadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unidad', Sort.desc);
    });
  }
}

extension MaterialesQuerySortThenBy
    on QueryBuilder<Materiales, Materiales, QSortThenBy> {
  QueryBuilder<Materiales, Materiales, QAfterSortBy> thenByCantidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidad', Sort.asc);
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterSortBy> thenByCantidadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidad', Sort.desc);
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterSortBy> thenByCodigo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codigo', Sort.asc);
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterSortBy> thenByCodigoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codigo', Sort.desc);
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterSortBy> thenByConversion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversion', Sort.asc);
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterSortBy> thenByConversionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversion', Sort.desc);
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterSortBy> thenByDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcion', Sort.asc);
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterSortBy> thenByDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcion', Sort.desc);
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterSortBy> thenByTipo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.asc);
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterSortBy> thenByTipoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.desc);
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterSortBy> thenByUnidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unidad', Sort.asc);
    });
  }

  QueryBuilder<Materiales, Materiales, QAfterSortBy> thenByUnidadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unidad', Sort.desc);
    });
  }
}

extension MaterialesQueryWhereDistinct
    on QueryBuilder<Materiales, Materiales, QDistinct> {
  QueryBuilder<Materiales, Materiales, QDistinct> distinctByCantidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cantidad');
    });
  }

  QueryBuilder<Materiales, Materiales, QDistinct> distinctByCodigo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'codigo');
    });
  }

  QueryBuilder<Materiales, Materiales, QDistinct> distinctByConversion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'conversion');
    });
  }

  QueryBuilder<Materiales, Materiales, QDistinct> distinctByDescripcion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'descripcion', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Materiales, Materiales, QDistinct> distinctByTipo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipo');
    });
  }

  QueryBuilder<Materiales, Materiales, QDistinct> distinctByUnidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unidad');
    });
  }
}

extension MaterialesQueryProperty
    on QueryBuilder<Materiales, Materiales, QQueryProperty> {
  QueryBuilder<Materiales, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<Materiales, int, QQueryOperations> cantidadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cantidad');
    });
  }

  QueryBuilder<Materiales, int, QQueryOperations> codigoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'codigo');
    });
  }

  QueryBuilder<Materiales, double, QQueryOperations> conversionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'conversion');
    });
  }

  QueryBuilder<Materiales, String, QQueryOperations> descripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'descripcion');
    });
  }

  QueryBuilder<Materiales, Tipo, QQueryOperations> tipoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipo');
    });
  }

  QueryBuilder<Materiales, Unidad, QQueryOperations> unidadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unidad');
    });
  }
}
