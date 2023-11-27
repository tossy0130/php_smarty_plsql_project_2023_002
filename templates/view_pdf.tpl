<!DOCTYPE html>
<html>
<head>
    <title>PDF 表示一覧</title>

<body>

<p>
     view_pdf 表示<br />

     <a href="../public_html/index.php">TOP</a>
</p>

 <table class="list">
                <col width="40%" />
                <col width="40%" />
                 <tr>
                    <th class="alignL">ファイル名</th>
                    <th class="alignL">PDFを確認</th>
                 </tr>

{foreach $arr_pdf_v as $pdf_val} 
            <tr>
                <td class="alignL">
                    {$pdf_val.PDF_NAME}
                </td>

                <td class="alignL">
                    <a href="{$pdf_val.PDF_PATH}" target="_blank">PDFを表示</a>
                <td class="alignL">

                <td>
                    <form method="post" action="../public_html/pdf_delete.php">
                            <input type="hidden" name="delete_pdf" value="{$pdf_val.PDF_NAME}">
                        <button type="submit">削除</button>
                    </form>
                </td>

             </td>
{/foreach}
    
</table>

</body>
</html>

