# fred-13_infra
fred-13 Infra repository

#                            Homework 3

# Если возникла необходиммость сократить время ввода форвардинга через промужточный сервер,
# то можно создать файл (если такого нет) с конфигурацией для SSH конекта в корне
# nano ~/.ssh/config:

Host someinternalhost
	HostName 10.132.0.4
	User appuser
	ProxyCommand ssh -l appuser 35.240.108.74 -W %h:%p

# Теперь при подключении используем команду: 

ssh someinternalhost

# Данные для подключения к серверам:

bastion_IP = 35.240.108.74
someinternalhost_IP = 10.132.0.4

#                            Homework 4

# Открываем порт 9292 на входящие подключения из вне:
gcloud compute firewall-rules create default-puma-server \
    --action allow \
    --direction ingress \
    --rules tcp:9292 \
    --source-ranges 0.0.0.0/0 \
    --target-tags puma-server


