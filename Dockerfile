FROM ubuntu:18.04

ARG ANDROID_COMPILE_SDK="29"
ARG ANDROID_BUILD_TOOLS="29.0.2"
ARG ANDROID_SDK_TOOLS="4333796"

RUN apt-get update

# Fix locales
RUN apt-get -y install locales
RUN touch /usr/share/locale/locale.alias
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Installing Android SDK
RUN apt-get -y install openjdk-8-jdk wget unzip tar lib32stdc++6 lib32z1
RUN wget --quiet --output-document=android-sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip
RUN unzip -d android-sdk android-sdk-tools.zip && rm android-sdk-tools.zip
RUN echo y | /android-sdk/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" > /dev/null
RUN echo y | /android-sdk/tools/bin/sdkmanager "platform-tools" > /dev/null
RUN echo y | /android-sdk/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" > /dev/null
RUN yes | /android-sdk/tools/bin/sdkmanager --licenses
ENV ANDROID_HOME /android-sdk
ENV PATH "$PATH:/android-sdk/platform-tools/"
ENV PATH "$PATH:/android-sdk/build-tools/${ANDROID_BUILD_TOOLS}/"

# Installing build tools, ruby and fastlane
RUN apt-get install -y \
  build-essential \
  ruby \
  ruby-dev

# Installing bundle
RUN gem install bundle
RUN gem install bundler

# Installing fastlane
RUN gem install fastlane

# Installing Firebase CLI
RUN mkdir firebase && cd firebase && wget --quiet --output-document=firebase https://firebase.tools/bin/linux/latest && chmod +x firebase
ENV PATH "$PATH:/firebase"

# Installing GIT
RUN apt-get install -y git
