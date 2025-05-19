/// author TDSSS
/// datetime 2025/5/12
enum AppRoute {
  home('/', url: '/'),
  splash('splash',url: '/splash'),
  globalError('404',url: '/404'),

  //settings
  settings('settings',url: '/settings'),
  settingsGeneral('settingsGeneral',url: '/settingsGeneral'),

  lottie('lottie',url: '/lottie'),

  heroDemo('heroDemo',url: '/heroDemo'),
  heroDetail('heroDetail',url: '/heroDetail'),

  loadMore('loadMore',url: '/loadMore'),
  loadMoreList('loadMore_list',url: '/loadMore/loadMore_list'),
  loadMoreGrid('loadMore_grid',url: '/loadMore/loadMore_grid'),
  loadMoreSliverList('loadMore_sliver_list',url: '/loadMore/loadMore_sliver_list'),
  loadMoreWaterfallFlow('loadMore_sliver_grid',url: '/loadMore/loadMore_sliver_grid'),

  loginPage('loginPage',url: '/loginPage'),

  book('book',url: '/book'),

  calendar('calendar',url: '/calendar'),

  audioWaveforms('audioWaveforms',url: '/audioWaveforms'),

  //chart
  chart('chart',url: '/chart'),
  chartOfSales('salesChart',url: '/chart/salesChart'),
  chartOfWebTraffic('webTrafficChart',url: '/chart/webTrafficChart'),
  chartOfWeather('weatherChart',url: '/chart/weatherChart'),

  lockScreen('lockScreen',url: '/lockScreen'),
  audioPlayer('audioPlayer',url: '/audioPlayer'),
  videoPlayer('videoPlayer',url: '/videoPlayer'),
  gallery('gallery',url: '/gallery'),

  ;

  final String path;
  final String url;
  const AppRoute(this.path,{required this.url});
}