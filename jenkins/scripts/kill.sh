#!/usr/bin/env sh


echo 'The following command terminates the "my-app-1.0-SNAPSHOT.jar" process using its PID'
APP_NAME="my-app-1.0-SNAPSHOT.jar"

PID=$(ps aux | grep "java -jar target/${APP_NAME}" | grep -v grep | awk '{print $2}')

set -x

# if [ -z "$PID" ]; then
#     echo "Aplikasi ${APP_NAME} tidak ditemukan."
# else
echo "Menghentikan aplikasi ${APP_NAME} dengan PID: ${PID}..."
kill -9 ${PID}
echo "Aplikasi ${APP_NAME} dihentikan."
# fi

set +x