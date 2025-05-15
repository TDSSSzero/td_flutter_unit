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
  loadMore('loadMore',url: '/loadMore'),
  loadMoreList('loadMore_list',url: '/loadMore/loadMore_list'),
  keyboard('keyboard',url: '/keyboard'),
  book('book',url: '/book'),
  audioWaveforms('audioWaveforms',url: '/audioWaveforms'),
  chart('chart',url: '/chart'),
  lockScreen('lockScreen',url: '/lockScreen'),
  audioPlayer('audioPlayer',url: '/audioPlayer'),
  videoPlayer('videoPlayer',url: '/videoPlayer'),
  gallery('gallery',url: '/gallery'),

  ;

  final String path;
  final String url;
  const AppRoute(this.path,{required this.url});
}