// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCategoryModelCollection on Isar {
  IsarCollection<CategoryModel> get categoryModels => this.collection();
}

const CategoryModelSchema = CollectionSchema(
  name: r'CategoryModel',
  id: 2062173352312629051,
  properties: {
    r'actualAmount': PropertySchema(
      id: 0,
      name: r'actualAmount',
      type: IsarType.double,
    ),
    r'isActive': PropertySchema(
      id: 1,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'isScalable': PropertySchema(
      id: 2,
      name: r'isScalable',
      type: IsarType.bool,
    ),
    r'month': PropertySchema(
      id: 3,
      name: r'month',
      type: IsarType.dateTime,
    ),
    r'name': PropertySchema(
      id: 4,
      name: r'name',
      type: IsarType.string,
    ),
    r'plannedAmount': PropertySchema(
      id: 5,
      name: r'plannedAmount',
      type: IsarType.double,
    ),
    r'priority': PropertySchema(
      id: 6,
      name: r'priority',
      type: IsarType.long,
    ),
    r'spentAmount': PropertySchema(
      id: 7,
      name: r'spentAmount',
      type: IsarType.double,
    ),
    r'type': PropertySchema(
      id: 8,
      name: r'type',
      type: IsarType.string,
    )
  },
  estimateSize: _categoryModelEstimateSize,
  serialize: _categoryModelSerialize,
  deserialize: _categoryModelDeserialize,
  deserializeProp: _categoryModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _categoryModelGetId,
  getLinks: _categoryModelGetLinks,
  attach: _categoryModelAttach,
  version: '3.1.0+1',
);

int _categoryModelEstimateSize(
  CategoryModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.type.length * 3;
  return bytesCount;
}

void _categoryModelSerialize(
  CategoryModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.actualAmount);
  writer.writeBool(offsets[1], object.isActive);
  writer.writeBool(offsets[2], object.isScalable);
  writer.writeDateTime(offsets[3], object.month);
  writer.writeString(offsets[4], object.name);
  writer.writeDouble(offsets[5], object.plannedAmount);
  writer.writeLong(offsets[6], object.priority);
  writer.writeDouble(offsets[7], object.spentAmount);
  writer.writeString(offsets[8], object.type);
}

CategoryModel _categoryModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CategoryModel(
    actualAmount: reader.readDoubleOrNull(offsets[0]) ?? 0,
    isActive: reader.readBoolOrNull(offsets[1]) ?? true,
    isScalable: reader.readBoolOrNull(offsets[2]) ?? true,
    month: reader.readDateTime(offsets[3]),
    name: reader.readString(offsets[4]),
    plannedAmount: reader.readDoubleOrNull(offsets[5]) ?? 0,
    priority: reader.readLongOrNull(offsets[6]) ?? 3,
    spentAmount: reader.readDoubleOrNull(offsets[7]) ?? 0,
    type: reader.readString(offsets[8]),
  );
  object.id = id;
  return object;
}

P _categoryModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 1:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 2:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 6:
      return (reader.readLongOrNull(offset) ?? 3) as P;
    case 7:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _categoryModelGetId(CategoryModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _categoryModelGetLinks(CategoryModel object) {
  return [];
}

void _categoryModelAttach(
    IsarCollection<dynamic> col, Id id, CategoryModel object) {
  object.id = id;
}

extension CategoryModelQueryWhereSort
    on QueryBuilder<CategoryModel, CategoryModel, QWhere> {
  QueryBuilder<CategoryModel, CategoryModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CategoryModelQueryWhere
    on QueryBuilder<CategoryModel, CategoryModel, QWhereClause> {
  QueryBuilder<CategoryModel, CategoryModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CategoryModelQueryFilter
    on QueryBuilder<CategoryModel, CategoryModel, QFilterCondition> {
  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      actualAmountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'actualAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      actualAmountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'actualAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      actualAmountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'actualAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      actualAmountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'actualAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      isActiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      isScalableEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isScalable',
        value: value,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      monthEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'month',
        value: value,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      monthGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'month',
        value: value,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      monthLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'month',
        value: value,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      monthBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'month',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      plannedAmountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plannedAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      plannedAmountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'plannedAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      plannedAmountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'plannedAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      plannedAmountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'plannedAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      priorityEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'priority',
        value: value,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      priorityGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'priority',
        value: value,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      priorityLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'priority',
        value: value,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      priorityBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'priority',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      spentAmountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'spentAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      spentAmountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'spentAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      spentAmountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'spentAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      spentAmountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'spentAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition> typeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      typeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      typeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition> typeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension CategoryModelQueryObject
    on QueryBuilder<CategoryModel, CategoryModel, QFilterCondition> {}

extension CategoryModelQueryLinks
    on QueryBuilder<CategoryModel, CategoryModel, QFilterCondition> {}

extension CategoryModelQuerySortBy
    on QueryBuilder<CategoryModel, CategoryModel, QSortBy> {
  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy>
      sortByActualAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualAmount', Sort.asc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy>
      sortByActualAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualAmount', Sort.desc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy> sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy>
      sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy> sortByIsScalable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isScalable', Sort.asc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy>
      sortByIsScalableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isScalable', Sort.desc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy> sortByMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.asc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy> sortByMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.desc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy>
      sortByPlannedAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plannedAmount', Sort.asc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy>
      sortByPlannedAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plannedAmount', Sort.desc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy> sortByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy>
      sortByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy> sortBySpentAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spentAmount', Sort.asc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy>
      sortBySpentAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spentAmount', Sort.desc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension CategoryModelQuerySortThenBy
    on QueryBuilder<CategoryModel, CategoryModel, QSortThenBy> {
  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy>
      thenByActualAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualAmount', Sort.asc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy>
      thenByActualAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualAmount', Sort.desc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy> thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy>
      thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy> thenByIsScalable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isScalable', Sort.asc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy>
      thenByIsScalableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isScalable', Sort.desc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy> thenByMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.asc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy> thenByMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.desc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy>
      thenByPlannedAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plannedAmount', Sort.asc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy>
      thenByPlannedAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plannedAmount', Sort.desc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy> thenByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy>
      thenByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy> thenBySpentAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spentAmount', Sort.asc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy>
      thenBySpentAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spentAmount', Sort.desc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension CategoryModelQueryWhereDistinct
    on QueryBuilder<CategoryModel, CategoryModel, QDistinct> {
  QueryBuilder<CategoryModel, CategoryModel, QDistinct>
      distinctByActualAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'actualAmount');
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QDistinct> distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QDistinct> distinctByIsScalable() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isScalable');
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QDistinct> distinctByMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'month');
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QDistinct>
      distinctByPlannedAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'plannedAmount');
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QDistinct> distinctByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'priority');
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QDistinct>
      distinctBySpentAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'spentAmount');
    });
  }

  QueryBuilder<CategoryModel, CategoryModel, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }
}

extension CategoryModelQueryProperty
    on QueryBuilder<CategoryModel, CategoryModel, QQueryProperty> {
  QueryBuilder<CategoryModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CategoryModel, double, QQueryOperations> actualAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'actualAmount');
    });
  }

  QueryBuilder<CategoryModel, bool, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<CategoryModel, bool, QQueryOperations> isScalableProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isScalable');
    });
  }

  QueryBuilder<CategoryModel, DateTime, QQueryOperations> monthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'month');
    });
  }

  QueryBuilder<CategoryModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<CategoryModel, double, QQueryOperations>
      plannedAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'plannedAmount');
    });
  }

  QueryBuilder<CategoryModel, int, QQueryOperations> priorityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'priority');
    });
  }

  QueryBuilder<CategoryModel, double, QQueryOperations> spentAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'spentAmount');
    });
  }

  QueryBuilder<CategoryModel, String, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
