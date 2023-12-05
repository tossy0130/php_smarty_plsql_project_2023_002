<!DOCTYPE html>
<html>
<head>
    <title>ラジオボタン</title>

<body>

<table>

    <!--{assign var=kasou_idx value=0}-->
    <!--{assign var=key1 value="kasou_type"}-->
    <tr>
        <th class="alignC w_20">
        火葬区分
        </th>

        <td colspan="7">
        <!--{html_radios name="$key1" options=$arrKsou_K selected=$kasou_idx}-->
        </td>

     </tr>

</tabe>

</body>
</html>