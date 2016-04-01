# TV Recorder on PT2

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
knife solo prepare root@{REMOTE SERVER}
```

1回目

```
cd /vagrant/chef-repo
knife solo cook root@{REMOTE SERVER}
```

2回目移行（root権限でsshできなくなるため）

```
cd /vagrant/chef-repo
knife solo cook admin@{REMOTE SERVER}
```

# ディスクマウント

## OS起動時のマウント設定

/etc/fstabに以下を追加

```
/dev/sda                /home/share/data       ext3    defaults        1 3
/dev/sdb                /home/share/tv         ext3    defaults        1 3
```

## 手動マウント
```
sudo mount -t ext3 /dev/sda /home/share/data/
sudo mount -t ext3 /dev/sdb /home/share/tv/
```

# twonkyの設定

## サーバー起動
```
$ sudo /usr/local/twonky/twonkymedia.sh start
```

## ライセンス認証
```
http://192.168.0.3:9000/
```

## プレーヤー設定

「Sony Bravia」を「Generic DLNA 1.0」に変更

## 共有設定

コンテンツディレクトリに「/home/share/tv」を設定



## トラブルシューティング

番組表を取得できていないケース

1. 実行ファイルの、実行コマンドの改行コードがCR+LFになっている
2. do_record.shのRECORDERのパスがおかしい
3. 実行ユーザーがおかしい /var/mail/rootあたりにシェルスクリプトのエラーログがのこる