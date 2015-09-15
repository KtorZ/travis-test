#!/bin/sh

# Constant
ANDROID_SDK_FILE=android-sdk_r24.3.4-macosx.zip
ANDROID_VERSION=19
ANDROID_HOME=$PWD
ANDROID_SDK=$ANDROID_HOME/android-sdk-macosx
PLATFORM=android
PATH=$PATH:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools

# Utility
function log_error {
    echo "\n\033[1;31m$1\033[0m$2\n"
}

function log_info  {
    echo "\n\033[1;34m======= $1\033[0m$2\n"
}

function log_warn  {
    echo "\n\033[1;33m======= $1\033[0m$2\n"
}

# Extract SDK version from tiapp.xml
TI_SDK_VERSION=$(grep tiapp.xml -e "<sdk-version>" | grep -oE "\d+.\d+.\d+")
log_info "Titanium SDK version: " $TI_SDK_VERSION

# Extract the build url
TI_SDK_FILE=$(curl http://builds.appcelerator.com/mobile/master/index.json -X GET | \
    grep -oE "mobilesdk-${TI_SDK_VERSION}.\w+-osx.zip" | tail -1)
log_info "Titanium SDK file: " $TI_SDK_FILE

# Install the sdk
log_info "Install Titanium SDK"
titanium login travisci@appcelerator.com travisci
titanium sdk install $TI_SDK_FILE --no-progress-bars

# Install Android
if [ $PLATFORM = "android" ]; then
    log_info "Install Android SDK v" $ANDROID_VERSION
    titanium config android.sdkPath $ANDROID_HOME
    curl -o $ANDROID_SDK_FILE http://dl.google.com/android/${ANDROID_SDK_FILE}
    unzip -q $ANDROID_SDK_FILE -d $ANDROID_HOME
    echo yes | android -s update sdk --no-ui --all --filter sys-img-armeabi-v7a-android-$ANDROID_VERSION
    echo yes | android -s update sdk --no-ui --all --filter addon-google_apis-google-$ANDROID_VERSION
    echo yes | android -s update sdk --no-ui --all --filter android-$ANDROID_VERSION
    echo yes | android -s update sdk --no-ui --all --filter extra-android-support
    echo yes | android -s update sdk --no-ui --all --filter build-tools-22.0.0
    echo yes | android -s update sdk --no-ui --all --filter tools
    echo yes | android -s update sdk --no-ui --all --filter platform-tools
fi
