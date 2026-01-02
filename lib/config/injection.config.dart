// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../core/di/register_module.dart' as _i796;
import '../core/services/currency_service.dart' as _i485;
import '../core/theme/theme_cubit.dart' as _i596;
import '../features/auth/data/repositories/auth_repository_impl.dart' as _i570;
import '../features/auth/domain/repositories/auth_repository.dart' as _i869;
import '../features/auth/presentation/bloc/auth_bloc.dart' as _i59;
import '../features/chat/data/repositories/chat_repository_impl.dart' as _i330;
import '../features/chat/domain/repositories/chat_repository.dart' as _i394;
import '../features/chat/presentation/bloc/chat_detail_bloc.dart' as _i95;
import '../features/chat/presentation/bloc/chat_list_bloc.dart' as _i576;
import '../features/feeds/data/repositories/feed_repository_impl.dart' as _i579;
import '../features/feeds/domain/repositories/feed_repository.dart' as _i493;
import '../features/feeds/presentation/bloc/feed_bloc.dart' as _i219;
import '../features/market/data/repositories/market_repository_impl.dart'
    as _i27;
import '../features/market/domain/repositories/market_repository.dart' as _i852;
import '../features/market/presentation/bloc/market_bloc.dart' as _i955;
import '../features/settings/data/repositories/settings_repository_impl.dart'
    as _i1064;
import '../features/settings/domain/repositories/settings_repository.dart'
    as _i89;
import '../features/settings/presentation/bloc/settings_bloc.dart' as _i419;
import '../features/wallet/data/repositories/wallet_repository_impl.dart'
    as _i89;
import '../features/wallet/domain/repositories/wallet_repository.dart' as _i620;
import '../features/wallet/presentation/bloc/wallet_bloc.dart' as _i469;
import 'firebase_module.dart' as _i616;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    final firebaseModule = _$FirebaseModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i596.ThemeCubit>(() => _i596.ThemeCubit());
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.lazySingleton<_i457.FirebaseStorage>(() => firebaseModule.storage);
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i485.CurrencyService>(() => _i485.CurrencyService());
    gh.lazySingleton<_i89.SettingsRepository>(
      () => _i1064.SettingsRepositoryImpl(),
    );
    gh.lazySingleton<_i869.AuthRepository>(
      () => _i570.AuthRepositoryImpl(
        gh<_i59.FirebaseAuth>(),
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i852.MarketRepository>(() => _i27.MarketRepositoryImpl());
    gh.factory<_i59.AuthBloc>(() => _i59.AuthBloc(gh<_i869.AuthRepository>()));
    gh.factory<_i419.SettingsBloc>(
      () => _i419.SettingsBloc(gh<_i89.SettingsRepository>()),
    );
    gh.lazySingleton<_i620.WalletRepository>(
      () => _i89.WalletRepositoryImpl(
        gh<_i59.FirebaseAuth>(),
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i394.ChatRepository>(
      () => _i330.ChatRepositoryImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.lazySingleton<_i493.FeedRepository>(
      () => _i579.FeedRepositoryImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i955.MarketBloc>(
      () => _i955.MarketBloc(gh<_i852.MarketRepository>()),
    );
    gh.factory<_i95.ChatDetailBloc>(
      () => _i95.ChatDetailBloc(gh<_i394.ChatRepository>()),
    );
    gh.factory<_i576.ChatListBloc>(
      () => _i576.ChatListBloc(gh<_i394.ChatRepository>()),
    );
    gh.factory<_i219.FeedBloc>(
      () => _i219.FeedBloc(gh<_i493.FeedRepository>()),
    );
    gh.factory<_i469.WalletBloc>(
      () => _i469.WalletBloc(gh<_i620.WalletRepository>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i796.RegisterModule {}

class _$FirebaseModule extends _i616.FirebaseModule {}
