<?php

// === lineのユーザIDを取得する

// ======== ***************************
// ====== composer で　classをインストールしないと使えない
// ======== ***************************

$channelSecret = '2359e2afb127e05d2aa5a6e3215e5663';
$httpClient = new \LINE\LINEBot\HTTPClient\CurlHTTPClient('チェンネルトークン');
$bot = new \LINE\LINEBot($httpClient, ['channelSecret' => $channelSecret]);

$content = file_get_contents('php://input');
$events = $bot->parseEventRequest($content, $_SERVER['HTTP_X_LINE_SIGNATURE']);

foreach ($events as $event) {
    if ($event instanceof \LINE\LINEBot\Event\MessageEvent) {
        $userId = $event->getUserId();

        // ここで取得した$userIdを保存や利用するなどの処理を行う
        // 例えば、データベースに保存するなど
        print($userId);
    }
}
