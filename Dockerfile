FROM ubuntu:latest

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN apt-get update

# Installing OpenJdk
RUN apt-get -y install openjdk-8-jdk

# Installing Android SDK
RUN apt-get -y install android-sdk

# Installing build tools, ruby and fastlane
RUN apt-get install -y \
  build-essential \
  ruby \
  ruby-dev

# Installing fastlane
RUN gem install fastlane

# Installing bundle
RUN gem install bundle
