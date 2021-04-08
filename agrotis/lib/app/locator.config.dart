// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

import '../service/network/api_service.dart';
import '../service/localization/localization_service.dart';
import '../service/crop_service.dart';
import '../service/device_service.dart';
import '../service/fcm_service.dart';
import '../service/auth/firebase_auth_service.dart';
import '../service/third_party_service_module.dart';
import '../service/tts_service.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  gh.lazySingleton<ApiService>(() => ApiService());
  gh.lazySingleton<BottomSheetService>(
      () => thirdPartyServicesModule.bottomSheetService);
  gh.lazySingleton<CropService>(() => CropService(get<ApiService>()));
  gh.lazySingleton<DeviceService>(() => DeviceService());
  gh.lazySingleton<DialogService>(() => thirdPartyServicesModule.dialogService);
  gh.lazySingleton<FcmService>(() => FcmService());
  gh.lazySingleton<FirebaseAuthService>(() => FirebaseAuthService());
  gh.lazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  gh.lazySingleton<SnackbarService>(
      () => thirdPartyServicesModule.snackBarService);
  gh.lazySingleton<TtsService>(() => TtsService());

  // Eager singletons must be registered in the right order
  gh.singleton<AppLanguageService>(AppLanguageService());
  return get;
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  BottomSheetService get bottomSheetService => BottomSheetService();
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
  @override
  SnackbarService get snackBarService => SnackbarService();
}
