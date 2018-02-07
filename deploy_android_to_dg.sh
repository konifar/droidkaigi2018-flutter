openssl aes-256-cbc -k $KEY_JKS_DECRYPT_PASSWORD -d -in android/encrypted-key.jks -out android/key.jks -md md5
openssl aes-256-cbc -k $KEY_PROPERTIES_DECRYPT_PASSWORD -d -in android/encrypted-key.properties -out android/key.properties -md md5

flutter build apk

GIT_HASH=`git rev-parse --short HEAD`
curl -F "file=@build/app/outputs/apk/release/app-release.apk" -F "token=${DEPLOY_GATE_API_KEY}" -F "message=https://github.com/konifar/droidkaigi2018-flutter/tree/${GIT_HASH} Travis build number:${TRAVIS_BUILD_NUMBER}" -F "distribution_key=51302839f98cd8daa76844d60e76168589022e07" -F "release_note=https://github.com/konifar/droidkaigi2018-flutter/tree/${GIT_HASH} Travis build number:${TRAVIS_BUILD_NUMBER}" https://deploygate.com/api/users/konifar/apps