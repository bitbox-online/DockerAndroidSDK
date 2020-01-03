FROM ubuntu:latest

RUN apt-get update

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
