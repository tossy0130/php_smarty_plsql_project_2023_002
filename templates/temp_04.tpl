<!DOCTYPE html>
<html>
<head>
    <title>日付表示</title>

<body>


    <td class="alignL">
                        <!--{assign var=key value="yoyakubi_date"}-->
                        <input type="hidden" name="<!--{$key}-->" value="<!--{$arrForm[$key]}-->" />
                        
                        <!--{if $yoyakubi_Flg == 0}-->
                            <!--{$yoyakubi_string}-->
                        <!--{elseif $yoyakubi_Flg == 1}-->
                            <!--{assign var="lastDigit" value=$yoyakubi_string|mb_substr:-1}-->
                            <!--{assign var="yoyakubi_string_R" value=$yoyakubi_string|mb_substr:0:10}-->

                            <span>
                            <!--{assign var="key0" value="(日)"}-->
                            <!--{assign var="key1" value="(月)"}-->
                            <!--{assign var="key2" value="(火)"}-->
                            <!--{assign var="key3" value="(水)"}-->
                            <!--{assign var="key4" value="(木)"}-->
                            <!--{assign var="key5" value="(金)"}-->
                            <!--{assign var="key6" value="(土)"}-->

                            <!--{assign var="key7" value="yoyakubi_date_ERR"}-->
                           

                            <!--{ if $lastDigit == 0}-->
                                <!--{$yoyakubi_string_R}--> <!--{$key0}--> 
                            <!--{elseif $lastDigit == 1}-->
                                <!--{$yoyakubi_string_R}--> <!--{$key1}-->  
                            <!--{elseif $lastDigit == 2}-->
                                <!--{$yoyakubi_string_R}--> <!--{$key2}-->  
                            <!--{elseif $lastDigit == 3}-->
                                <!--{$yoyakubi_string_R}--> <!--{$key3}-->  
                            <!--{elseif $lastDigit == 4}-->
                                <!--{$yoyakubi_string_R}--> <!--{$key4}-->  
                            <!--{elseif $lastDigit == 5}-->
                                <!--{$yoyakubi_string_R}--> <!--{$key5}-->  
                            <!--{elseif $lastDigit == 6}-->
                                <!--{$yoyakubi_string_R}--> <!--{$key6}-->  
                            <!--{else}-->
                                <!--{$yoyakubi_string_R}--> <!--{$key7}--> 
                            <!--{/if}--> 
                            </span>
                        <!--{/if}-->
                        
                    </td>


</body>
</html>