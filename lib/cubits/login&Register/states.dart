abstract class SoundCloudLoginAndRegStates{}
class SoundCloudLoginInitialState extends SoundCloudLoginAndRegStates{}
class SoundCloudLoginLoadingState extends SoundCloudLoginAndRegStates{}
class SoundCloudLoginSuccessState extends SoundCloudLoginAndRegStates{}
class SoundCloudLoginErrorState extends SoundCloudLoginAndRegStates{}
class SoundCloudLoginChangeVisibilityState extends SoundCloudLoginAndRegStates{}

class SoundCloudRegisterLoadingState extends SoundCloudLoginAndRegStates{}
class SoundCloudRegisterSuccessState extends SoundCloudLoginAndRegStates{}
class SoundCloudRegisterErrorState extends SoundCloudLoginAndRegStates{}


class SoundCloudCreateUserLoadingState extends SoundCloudLoginAndRegStates{}
class SoundCloudCreateUserSuccessState extends SoundCloudLoginAndRegStates{}
class SoundCloudCreateUserErrorState extends SoundCloudLoginAndRegStates{}
class SoundCloudNowPlayingState extends SoundCloudLoginAndRegStates{}
class SoundCloudLoadingState extends SoundCloudLoginAndRegStates{}


class SoundCloudUpdateUserLoadingState extends SoundCloudLoginAndRegStates{}
class SoundCloudUpdateUserSuccessState extends SoundCloudLoginAndRegStates{}
class SoundCloudUpdateUserErrorState extends SoundCloudLoginAndRegStates{}