
# 仮想環境

## Guest Additions Versionのバージョンアップ

Guest Additions Versionと
VirtualBox Versionが違うと上手くマウントできない

```
vagrant plugin install vagrant-vbguest
```

VMのVagrantfileのあるディレクトリに移動して以下を実行

```
cd /vagrant/chef-repo
```

```
knife solo prepare root@122.249.239.253
```

```
knife solo cook root@122.249.239.253
```

# サーバー

adminでログインしてreboot

```
$ reboot
```

