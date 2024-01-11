 <?php

    // LINEの公式アカウントのチャネルID
    $client_id = "アカウントID";

    //  LINEの公式アカウントのチャンネルシークレットキー
    $client_secret = "チャンネルシークレットキー";

    //   アクセストークンの取得処理 開始

    //   LINEのリクエスト先URL
    const API_URL = "https://api.line.me/v2/oauth/accessToken";

    //  LINEのAPIに渡す値
    $data = array(
        'grant_type' => 'client_credentials',
        'client_id' => $client_id,
        'client_secret' => $client_secret,
    );

    //  LINEのAPIに渡すヘッダーを設定
    $header = array(
        "Content-Type: application/x-www-form-urlencoded",
    );

    //   LINEのAPIに渡すオプションを設定
    $options = array(
        'http' => array(
            'method' => 'POST',
            'header' => implode("\r\n", $header),
            'content' => http_build_query($data)
        )
    );

    //  LINEののAPIへリクエスト結果を取得
    $response = file_get_contents(
        API_URL,
        false,
        stream_context_create($options)
    );

    //  LINEのレスポンスのjsonからtokenを取得
    $access_token = json_decode($response)->access_token;

    //  アクセストークンの取得処理 終了

    //  メッセージ取得処理からメッセージ返信処理 開始

    //   LINEのAPIから送信されてきたイベントオブジェクトを取得
    $json_string = file_get_contents('php://input');

    //  LINEのAPIから受け取ったJSON文字列をデコードする
    $json_obj = json_decode($json_string);

    //   LINEのAPIから受け取ったイベントオブジェクトへの応答に使用するトークンを取得
    $reply_token = $json_obj->{'events'}[0]->{'replyToken'};

    //   LINEのAPIから受けとったイベントオブジェクトの種別を取得
    //    messageならメッセージが送信されると発生
    //    postbackならポストバックオプションに返信されると発生
    $type = $json_obj->{'events'}[0]->{'type'};

    //   LINEのAPIから受けとったメッセージオブジェクトを取得
    //   textならテキストメッセージ、stickerならスタンプ、imageなら画像、locationなら位置情報
    $msg_obj = $json_obj->{'events'}[0]->{'message'}->{'type'};

    //   LINEでメッセージを受け取った場合
    if ($type === 'message') {

        //    LINEで受け取ったメッセージがテキストだった場合
        if ($msg_obj === 'text') {
            //    LINEで受け取ったメッセージ内容を取得
            $msg_text = $json_obj->{'events'}[0]->{'message'}->{'text'};
        }

        //    受け取ったメッセージ内容によって返信する内容を指定する
        if ($msg_text == 'こんにちは') {
            //    返信するメッセージを指定
            $text = 'こんにちは';

            //    返信するメッセージの種別を指定
            $messageType = "text";
        } else if ($msg_text == 'おはようございます') {
            //    返信するメッセージを指定
            $text = 'おはようございます';

            //    返信するメッセージの種別を指定
            $messageType = "text";
        }
    }

    //    LINEで送信するメッセージを生成する
    //    ※ 色々な場所で呼び出す場合は関数化すると楽です。
    $post_data = LinePostAPI($messageType, $text, $reply_token);

    //    CURLでメッセージを返信する
    $ch = curl_init('https://api.line.me/v2/bot/message/reply');
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($post_data));
    curl_setopt($ch, CURLOPT_HTTPHEADER, array(
        'Content-Type: application/json; charser=UTF-8',
        'Authorization: Bearer ' . $access_token
    ));

    $result = curl_exec($ch);
    curl_close($ch);


    function LinePostAPI($messageType, $text, $reply_token)
    {

        $message = array(
            'type' => $messageType,
            'text' => $text
        );

        $post_data = array(
            'replyToken' => $reply_token,
            'messages' => array($message)
        );

        return $post_data;
    }
