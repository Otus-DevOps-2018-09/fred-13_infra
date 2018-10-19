# fred-13_infra
fred-13 Infra repository

#                            Homework 4

testapp_IP = 35.240.22.197
testapp_port = 9292

# Инсталим хомяка запуская скрипт с локальной директории:

gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup-script=/home/startup.sh

# Инсталим хомяка запуская скрипт из бакета:

gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata startup-script-url=https://console.cloud.google.com/storage/browser/cloud-testapp/startup.sh

# Открываем порт 9292 на входящие подключения из вне:
gcloud compute firewall-rules create default-puma-server \
    --action allow \
    --direction ingress \
    --rules tcp:9292 \
    --source-ranges 0.0.0.0/0 \
    --target-tags puma-server
