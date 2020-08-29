### Стенд для занятия по NFS

![](docs/nfs.jpg)

Установим и настротм NFS - сетевой файловой системы на сервере с установленным CentOS 7. NFS позволяет использовать файлы или каталоги удаленной рабочей машины, так, как будто они находятся на локальной машине.

Vagrant стенд для NFS:

vagrant up должен поднимать 2 виртуалки: сервер и клиент на сервер должна быть расшарена директория
на клиента она должна автоматически монтироваться при старте в шаре должна быть папка upload с правами на запись
- требования для NFS: NFSv3 по UDP, включенный firewall

#### nfss_script.sh
```
#установка nfs
yum install nfs-utils -y

cp /etc/nfs.conf /etc/nfs.conf.bak
echo -e "[exportfs] \ndebug=all \n[mountd] \ndebug=all \nthreads=1 \n[nfsd]\ndebug=all \nthreads=4 \nudp=y \ntcp=n \nvers2=n \nvers3=y \nvers4=n \nvers4.0=n \nvers4.1=n \nvers4.2=n \n[statd] \ndebug=all" > /etc/nfs.conf
systemctl enable rpcbind nfs-server
systemctl start rpcbind nfs-server
mkdir /opt/nfs_share
mkdir /opt/nfs_share/upload
chown -R  nfsnobody:nfsnobody /opt/nfs_share/upload
echo "/opt/nfs_share 192.168.50.11(rw,root_squash,all_squash)" > /etc/exports
systemctl restart rpcbind nfs-server
systemctl enable firewalld
systemctl start firewalld
firewall-cmd --permanent --zone=public --add-port=111/udp
firewall-cmd --permanent --zone=public --add-port=2049/udp
firewall-cmd --permanent --zone=public --add-port=20048/udp
firewall-cmd --permanent --zone=public --add-service=nfs
firewall-cmd --permanent --zone=public --add-service=mountd
firewall-cmd --permanent --zone=public --add-service=rpc-bind
firewall-cmd --reload
```







#### Установка NFS


#### Запуск служб и автозагрузка
Ставим службы rpcbind и nfs сервер в автозагрузку:
```
# systemctl enable rpcbind nfs-server
```
Запускаем службы:
```
# systemctl start rpcbind nfs-server
```




- [nfs](https://yvision.kz/post/664247)
