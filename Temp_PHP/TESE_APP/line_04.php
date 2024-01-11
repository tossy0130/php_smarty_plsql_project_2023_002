<?php

lineBroadcast('〇〇家 様 火葬が終了致しました。');

function lineBroadcast($text)
{
    $channelToken = 'チャンネルトークン';
    $headers = [
        'Authorization: Bearer ' . $channelToken,
        'Content-Type: application/json; charset=utf-8',
    ];

    $post = [
        'messages' => [
            [
                'type' => 'text',
                'text' => $text,
            ],
        ],
    ];

    $url = 'https://api.line.me/v2/bot/message/broadcast';
    $post = json_encode($post);

    $ch = curl_init($url);
    $options = [
        CURLOPT_CUSTOMREQUEST => 'POST',
        CURLOPT_HTTPHEADER => $headers,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_BINARYTRANSFER => true,
        CURLOPT_HEADER => true,
        CURLOPT_POSTFIELDS => $post,
    ];
    curl_setopt_array($ch, $options);

    $result = curl_exec($ch);
    $errno = curl_errno($ch);

    // =========== エラー処理 
    if ($errno) {
        print_r($errno);
    } else {
        echo '火葬終了 通知 送信完了しました。';
    }
}
