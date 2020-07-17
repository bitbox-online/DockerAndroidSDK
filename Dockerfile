FROM ubuntu:18.04

ARG ANDROID_SDK_TOOLS="4333796"

RUN apt-get update

# Installing Android SDK
RUN apt-get -y install openjdk-8-jdk wget unzip tar lib32stdc++6 lib32z1
RUN wget --quiet --output-document=android-sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip
RUN unzip -d android-sdk android-sdk-tools.zip && rm android-sdk-tools.zip
RUN echo "platforms" && \
    yes | /android-sdk/tools/bin/sdkmanager \
        "platforms;android-30" \
        "platforms;android-29" \
        "platforms;android-28" > /dev/null
RUN echo y | /android-sdk/tools/bin/sdkmanager "platform-tools" > /dev/null
RUN echo "build tools 25-30" && \
    yes | /android-sdk/tools/bin/sdkmanager \
        "build-tools;30.0.0" \
        "build-tools;29.0.3" "build-tools;29.0.2" \
        "build-tools;28.0.3" "build-tools;28.0.2" > /dev/null
RUN yes | /android-sdk/tools/bin/sdkmanager --licenses
ENV ANDROID_HOME /android-sdk
ENV PATH "$PATH:/android-sdk/platform-tools/"
ENV PATH "$PATH:/android-sdk/build-tools/30.0.0/"

# Installing ruby
RUN apt-get install -y \
  build-essential \
  ruby \
  ruby-dev

# Installing bundle
RUN gem install bundle
RUN gem install bundler

# Fix locales
RUN apt-get -y install locales
RUN touch /usr/share/locale/locale.alias
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Installing fastlane
RUN gem install fastlane

# Installing Firebase CLI
RUN mkdir firebase && cd firebase && wget --quiet --output-document=firebase https://firebase.tools/bin/linux/latest && chmod +x firebase
ENV PATH "$PATH:/firebase"

# Installing GIT
RUN apt-get install -y git

# Installing curl
RUN apt-get -y install curl
