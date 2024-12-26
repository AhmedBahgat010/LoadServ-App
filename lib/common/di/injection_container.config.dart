// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/cart/presentation/cubit/cart_cubit.dart' as _i499;
import '../../features/categories/data/datasources/categories_datasource.dart'
    as _i102;
import '../../features/categories/data/datasources/productDetails_datasource.dart'
    as _i833;
import '../../features/categories/data/repositories/categoies_repository_impl.dart'
    as _i98;
import '../../features/categories/data/repositories/productDetails_repository_impl.dart'
    as _i342;
import '../../features/categories/domain/repositories/categories_repository.dart'
    as _i488;
import '../../features/categories/domain/repositories/productDetails_repository.dart'
    as _i24;
import '../../features/categories/domain/usecases/get_categories_usecase.dart'
    as _i76;
import '../../features/categories/domain/usecases/get_productDetails_usecase.dart'
    as _i719;
import '../../features/categories/presentation/cubit/categories_cubit.dart'
    as _i802;
import '../../features/categories/presentation/cubit/ProductDetails_cubit.dart'
    as _i379;
import '../data/remote/api_basehelper.dart' as _i273;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i499.CartCubit>(() => _i499.CartCubit());
    gh.singleton<_i273.ApiBaseHelper>(() => _i273.ApiBaseHelper());
    gh.factory<_i102.CategoriesDatasource>(() =>
        _i102.CategoriesDatasourceImpl(helper: gh<_i273.ApiBaseHelper>()));
    gh.factory<_i833.ProductDetailsDatasource>(() =>
        _i833.ProductDetailsDatasourceImpl(helper: gh<_i273.ApiBaseHelper>()));
    gh.factory<_i488.CategoriesRepository>(() => _i98.CategoriesRepositoryImpl(
        dataSource: gh<_i102.CategoriesDatasource>()));
    gh.factory<_i24.ProductDetailsRepository>(() =>
        _i342.ProductDetailsRepositoryImpl(
            dataSource: gh<_i833.ProductDetailsDatasource>()));
    gh.factory<_i719.GetProductDetailsUseCase>(() =>
        _i719.GetProductDetailsUseCase(gh<_i24.ProductDetailsRepository>()));
    gh.factory<_i76.GetCategoriesUseCase>(
        () => _i76.GetCategoriesUseCase(gh<_i488.CategoriesRepository>()));
    gh.factory<_i802.CategoriesCubit>(
        () => _i802.CategoriesCubit(gh<_i76.GetCategoriesUseCase>()));
    gh.factory<_i379.ProductDetailsCubit>(
        () => _i379.ProductDetailsCubit(gh<_i719.GetProductDetailsUseCase>()));
    return this;
  }
}
