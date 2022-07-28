abstract class MusicManagerStates{}

class SoundCloudMusicManagerInitialState extends MusicManagerStates{}
class SoundCloudMusicManagerLoadingState extends MusicManagerStates{}
class SoundCloudPlayingNowState extends MusicManagerStates{}
class SoundCloudPausedState extends MusicManagerStates{}
class SoundCloudGotTrackAndPlaylistsState extends MusicManagerStates{}
class SoundCloudMoveSliderState extends MusicManagerStates{}


class SoundCloudBoolState extends MusicManagerStates{}

class SoundCloudPlaylistsLoadedSuccessState extends MusicManagerStates{}
class SoundCloudPlaylistsLoadedErrorState extends MusicManagerStates{}


class SoundCloudAddPlaylistSuccessState extends MusicManagerStates{}
class SoundCloudAddPlaylistErrorState extends MusicManagerStates{}

class SoundCloudUpdatePlaylistSuccessState extends MusicManagerStates{}
class SoundCloudUpdatePlaylistErrorState extends MusicManagerStates{}

class SoundCloudSearchSuccessState extends MusicManagerStates{}
class SoundCloudSearchErrorState extends MusicManagerStates{}

class SoundCloudMainScreenLoadedState extends MusicManagerStates{}
class SoundCloudMainScreenErrorState extends MusicManagerStates{}


class SoundCloudTogglePlayerBtnIconState extends MusicManagerStates{}