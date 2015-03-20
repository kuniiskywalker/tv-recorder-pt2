
# 仮想環境

## Guest Additions Versionのバージョンアップ

Guest Additions Versionと
VirtualBox Versionが違うと上手くマウントできない

```
vagrant plugin install vagrant-vbguest
```

VMのVagrantfileのあるディレクトリに移動して以下を実行

```
vagrant vbguest
```




