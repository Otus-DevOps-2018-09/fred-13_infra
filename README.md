# fred-13_infra
fred-13 Infra repository

# Если возникла необходиммость сократить время ввода форвардинга через промужточный сервер,
# то можно создать файл (если такого нет) с конфигурацией для SSH конекта в корне nano ~/.ssh/config:

Host someinternalhost
	HostName 10.132.0.4
	User appuser
	ProxyCommand ssh -l appuser 35.240.108.74 -W %h:%p

# Теперь при подключении используем команду: 

ssh someinternalhost

