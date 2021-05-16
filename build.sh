#!/usr/bin/env bash
if [[ -d flutter ]]
then
    cd flutter || exit
    git pull
    cd ..
else
    git clone https://github.com/flutter/flutter.git
fi

flutter/bin/flutter config --enable-web
flutter/bin/flutter build web --release
