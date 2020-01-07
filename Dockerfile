FROM ubuntu:latest

ARG ANDROID_COMPILE_SDK="28"
ARG ANDROID_BUILD_TOOLS="28.0.3"
ARG ANDROID_SDK_TOOLS="4333796"

RUN apt-get update

# Installing Android SDK
RUN apt-get -y install openjdk-8-jdk wget unzip tar lib32stdc++6 lib32z1
RUN wget --quiet --output-document=android-sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip
RUN unzip -d android-sdk android-sdk-tools.zip && rm android-sdk-tools.zip
RUN echo y | /android-sdk/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" > /dev/null
RUN echo y | /android-sdk/tools/bin/sdkmanager "platform-tools" > /dev/null
RUN echo y | /android-sdk/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" > /dev/null
RUN yes | /android-sdk/tools/bin/sdkmanager --licenses
ENV ANDROID_HOME /android-sdk

# Installing build tools, ruby and fastlane
RUN apt-get install -y \
  build-essential \
  ruby \
  ruby-dev

# Installing bundle
RUN gem install bundle
RUN gem install bundler

# Installing fastlane
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
RUN gem install fastlane
