<?php

$channelAccessToken = 'チャンネルトークン';
$userId = 'ユーザID'; // === 取得しないとだめ
$url = 'https://api.line.me/v2/bot/message/push';

$messageData = array(
    'to' => $userId,
    'messages' => array(
        array(
            'type' => 'text',
            'text' => 'Hello, world'
        )
    )
);

$data = json_encode($messageData);

$ch = curl_init($url);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');
curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_HTTPHEADER, array(
    'Content-Type: application/json',
    'Authorization: Bearer ' . $channelAccessToken
));

$response = curl_exec($ch);

if (curl_errno($ch)) {
    echo 'Curl error: ' . curl_error($ch);
}

curl_close($ch);

// エラーハンドリングなど必要に応じて処理を追加

echo 'Response: ' . $response;
