// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBudgetModelCollection on Isar {
  IsarCollection<BudgetModel> get budgetModels => this.collection();
}

const BudgetModelSchema = CollectionSchema(
  name: r'BudgetModel',
  id: 7247118153370490723,
  properties: {
    r'actualIncome': PropertySchema(
      id: 0,
      name: r'actualIncome',
      type: IsarType.double,
    ),
    r'isActive': PropertySchema(
      id: 1,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'month': PropertySchema(
      id: 2,
      name: r'month',
      type: IsarType.dateTime,
    ),
    r'plannedIncome': PropertySchema(
      id: 3,
      name: r'plannedIncome',
      type: IsarType.double,
    ),
    r'savingsRate': PropertySchema(
      id: 4,
      name: r'savingsRate',
      type: IsarType.double,
    ),
    r'totalAllocated': PropertySchema(
      id: 5,
      name: r'totalAllocated',
      type: IsarType.double,
    ),
    r'totalSpent': PropertySchema(
      id: 6,
      name: r'totalSpent',
      type: IsarType.double,
    )
  },
  estimateSize: _budgetModelEstimateSize,
  serialize: _budgetModelSerialize,
  deserialize: _budgetModelDeserialize,
  deserializeProp: _budgetModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _budgetModelGetId,
  getLinks: _budgetModelGetLinks,
  attach: _budgetModelAttach,
  version: '3.1.0+1',
);

int _budgetModelEstimateSize(
  BudgetModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _budgetModelSerialize(
  BudgetModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.actualIncome);
  writer.writeBool(offsets[1], object.isActive);
  writer.writeDateTime(offsets[2], object.month);
  writer.writeDouble(offsets[3], object.plannedIncome);
  writer.writeDouble(offsets[4], object.savingsRate);
  writer.writeDouble(offsets[5], object.totalAllocated);
  writer.writeDouble(offsets[6], object.totalSpent);
}

BudgetModel _budgetModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BudgetModel(
    actualIncome: reader.readDoubleOrNull(offsets[0]) ?? 0,
    isActive: reader.readBoolOrNull(offsets[1]) ?? true,
    month: reader.readDateTime(offsets[2]),
    plannedIncome: reader.readDoubleOrNull(offsets[3]) ?? 0,
    savingsRate: reader.readDoubleOrNull(offsets[4]) ?? 0,
    totalAllocated: reader.readDoubleOrNull(offsets[5]) ?? 0,
    totalSpent: reader.readDoubleOrNull(offsets[6]) ?? 0,
  );
  object.id = id;
  return object;
}

P _budgetModelDeserializeProp<P>(
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
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 4:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 5:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 6:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _budgetModelGetId(BudgetModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _budgetModelGetLinks(BudgetModel object) {
  return [];
}

void _budgetModelAttach(
    IsarCollection<dynamic> col, Id id, BudgetModel object) {
  object.id = id;
}

extension BudgetModelQueryWhereSort
    on QueryBuilder<BudgetModel, BudgetModel, QWhere> {
  QueryBuilder<BudgetModel, BudgetModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension BudgetModelQueryWhere
    on QueryBuilder<BudgetModel, BudgetModel, QWhereClause> {
  QueryBuilder<BudgetModel, BudgetModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<BudgetModel, BudgetModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterWhereClause> idBetween(
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

extension BudgetModelQueryFilter
    on QueryBuilder<BudgetModel, BudgetModel, QFilterCondition> {
  QueryBuilder<BudgetModel, BudgetModel, QAfterFilterCondition>
      actualIncomeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'actualIncome',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterFilterCondition>
      actualIncomeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'actualIncome',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterFilterCondition>
      actualIncomeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'actualIncome',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterFilterCondition>
      actualIncomeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'actualIncome',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<BudgetModel, BudgetModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<BudgetModel, BudgetModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<BudgetModel, BudgetModel, QAfterFilterCondition> isActiveEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
      ));
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterFilterCondition> monthEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'month',
        value: value,
      ));
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterFilterCondition>
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

  QueryBuilder<BudgetModel, BudgetModel, QAfterFilterCondition> monthLessThan(
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

  QueryBuilder<BudgetModel, BudgetModel, QAfterFilterCondition> monthBetween(
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

  QueryBuilder<BudgetModel, BudgetModel, QAfterFilterCondition>
      plannedIncomeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plannedIncome',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterFilterCondition>
      plannedIncomeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'plannedIncome',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterFilterCondition>
      plannedIncomeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'plannedIncome',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterFilterCondition>
      plannedIncomeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'plannedIncome',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterFilterCondition>
      savingsRateEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'savingsRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterFilterCondition>
      savingsRateGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'savingsRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterFilterCondition>
      savingsRateLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'savingsRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterFilterCondition>
      savingsRateBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'savingsRate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterFilterCondition>
      totalAllocatedEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalAllocated',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterFilterCondition>
      totalAllocatedGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalAllocated',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterFilterCondition>
      totalAllocatedLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalAllocated',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterFilterCondition>
      totalAllocatedBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalAllocated',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterFilterCondition>
      totalSpentEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalSpent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterFilterCondition>
      totalSpentGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalSpent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterFilterCondition>
      totalSpentLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalSpent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterFilterCondition>
      totalSpentBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalSpent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension BudgetModelQueryObject
    on QueryBuilder<BudgetModel, BudgetModel, QFilterCondition> {}

extension BudgetModelQueryLinks
    on QueryBuilder<BudgetModel, BudgetModel, QFilterCondition> {}

extension BudgetModelQuerySortBy
    on QueryBuilder<BudgetModel, BudgetModel, QSortBy> {
  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy> sortByActualIncome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualIncome', Sort.asc);
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy>
      sortByActualIncomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualIncome', Sort.desc);
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy> sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy> sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy> sortByMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.asc);
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy> sortByMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.desc);
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy> sortByPlannedIncome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plannedIncome', Sort.asc);
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy>
      sortByPlannedIncomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plannedIncome', Sort.desc);
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy> sortBySavingsRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savingsRate', Sort.asc);
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy> sortBySavingsRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savingsRate', Sort.desc);
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy> sortByTotalAllocated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAllocated', Sort.asc);
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy>
      sortByTotalAllocatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAllocated', Sort.desc);
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy> sortByTotalSpent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSpent', Sort.asc);
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy> sortByTotalSpentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSpent', Sort.desc);
    });
  }
}

extension BudgetModelQuerySortThenBy
    on QueryBuilder<BudgetModel, BudgetModel, QSortThenBy> {
  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy> thenByActualIncome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualIncome', Sort.asc);
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy>
      thenByActualIncomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualIncome', Sort.desc);
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy> thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy> thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy> thenByMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.asc);
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy> thenByMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.desc);
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy> thenByPlannedIncome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plannedIncome', Sort.asc);
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy>
      thenByPlannedIncomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plannedIncome', Sort.desc);
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy> thenBySavingsRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savingsRate', Sort.asc);
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy> thenBySavingsRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savingsRate', Sort.desc);
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy> thenByTotalAllocated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAllocated', Sort.asc);
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy>
      thenByTotalAllocatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAllocated', Sort.desc);
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy> thenByTotalSpent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSpent', Sort.asc);
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QAfterSortBy> thenByTotalSpentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSpent', Sort.desc);
    });
  }
}

extension BudgetModelQueryWhereDistinct
    on QueryBuilder<BudgetModel, BudgetModel, QDistinct> {
  QueryBuilder<BudgetModel, BudgetModel, QDistinct> distinctByActualIncome() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'actualIncome');
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QDistinct> distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QDistinct> distinctByMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'month');
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QDistinct> distinctByPlannedIncome() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'plannedIncome');
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QDistinct> distinctBySavingsRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'savingsRate');
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QDistinct> distinctByTotalAllocated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalAllocated');
    });
  }

  QueryBuilder<BudgetModel, BudgetModel, QDistinct> distinctByTotalSpent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalSpent');
    });
  }
}

extension BudgetModelQueryProperty
    on QueryBuilder<BudgetModel, BudgetModel, QQueryProperty> {
  QueryBuilder<BudgetModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<BudgetModel, double, QQueryOperations> actualIncomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'actualIncome');
    });
  }

  QueryBuilder<BudgetModel, bool, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<BudgetModel, DateTime, QQueryOperations> monthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'month');
    });
  }

  QueryBuilder<BudgetModel, double, QQueryOperations> plannedIncomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'plannedIncome');
    });
  }

  QueryBuilder<BudgetModel, double, QQueryOperations> savingsRateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'savingsRate');
    });
  }

  QueryBuilder<BudgetModel, double, QQueryOperations> totalAllocatedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalAllocated');
    });
  }

  QueryBuilder<BudgetModel, double, QQueryOperations> totalSpentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalSpent');
    });
  }
}
