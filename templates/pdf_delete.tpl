<!DOCTYPE html>
<html>
<head>
    <title>PDF 削除</title>

<body>

    {if $PDF_Delete_Flg === 1}
        <p>削除完了しました。</p>
        <a href="./index.tpl">top</a>
    {elseif $PDF_Delete_Flg === 2}
         <p>削除に失敗しました。（pathなどを確認してください）</p>
    {else}
        <p>削除に失敗しました。（POST 送信に失敗しました）</p>
    {/if}

</body>
</html>
