abstract class MusicPlaybackStates {}

class MusicPlaybackInitialState extends MusicPlaybackStates {}

class MusicPlaybackPlaySuccessState extends MusicPlaybackStates {}
class MusicPlaybackPauseSuccessState extends MusicPlaybackStates {}
class MusicPlaybackPlayErrorState extends MusicPlaybackStates {}

class MusicPlaybackMoveSliderState extends MusicPlaybackStates {}
class MusicPlaybackLoadPlaylistState extends MusicPlaybackStates {}

class MusicPlaybackGetPositionState extends MusicPlaybackStates {}

class MusicPlaybackPlaylistsLoadedSuccessState extends MusicPlaybackStates {}
class MusicPlaybackUpdatePlaylistSuccessState extends MusicPlaybackStates {}
class MusicPlaybackUpdatePlaylistErrorState extends MusicPlaybackStates {}
class MusicPlaybackAddPlaylistErrorState extends MusicPlaybackStates {}

class MusicPlaybackPlaylistNavigationState extends MusicPlaybackStates {}

class MusicPlaybackStillPlayingState extends MusicPlaybackStates {}