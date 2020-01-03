FROM ubuntu:latest

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN apt-get update

# Installing Android SDK
RUN apt-get -y install android-sdk

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
