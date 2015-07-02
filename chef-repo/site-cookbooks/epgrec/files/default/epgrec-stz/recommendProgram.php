#!/usr/bin/php
<?php

include_once( 'config.php' );
include_once( 'Settings.class.php' );

$settings = Settings::factory();

$link = mysql_connect($settings->db_host, $settings->db_user, $settings->db_pass);
if (!$link) {
    die('接続できませんでした: ' . mysql_error());
}

mysql_select_db($settings->db_name, $link) or die('Could not select database.');

$sql = 'select id, title, description, starttime from Recorder_programTbl where category_id = 9 AND starttime >= now();';

$res = mysql_query($sql);
if (!$res) {
    die('Invalid query: ' . mysql_error());
}

$body='';
while($row = mysql_fetch_assoc($res)) {
    $body .= '【' . $row['title'] . '】' . "\n";
    $body .= '時間：' . $row['starttime'] . '('. getWeek($row['starttime']) .')' . "\n";
    $body .= $row['description'] . "\n\n";
    $body .= '[http://tv.sky-apart.com/simpleReservation.php?program_id=' . $row['id'] . ']' . "\n\n\n";
}

mb_language("Ja") ;
mb_internal_encoding("UTF-8") ;
$mailto="kunii0929@softbank.ne.jp,kuniiskywalker@gmail.com";
$subject="今週の映画ラインナップ！！";
$mailfrom="From:" .mb_encode_mimeheader("カスパー") ."<admin@sky-apart.com>";
mb_send_mail($mailto,$subject,$body,$mailfrom);

mysql_close($link);

function getWeek($date) {
    $weekAry = array( '日', '月', '火', '水', '木', '金', '土' );
    $time    = strtotime($date);
    $weekNo  = date('w', $time);

    return $weekAry[$weekNo];
}