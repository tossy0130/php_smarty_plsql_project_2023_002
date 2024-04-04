<!--{include file=$html_start_tpl}-->
<!-- ▼BODY部 スタート -->
<!--{strip}-->
<body class="frame_outer">
    <!--{$GLOBAL_ERR}-->
    <noscript>
        <p>JavaScript を有効にしてご利用下さい.</p>
    </noscript>
    <script type="text/javascript" src="<!--{$TPL_JS_PATH}-->/ajaxzip3-https.js"></script>
    <!--{* ▼HEADER *}-->
    <div id="header">
        <!--{include file=$header_tpl}-->
    </div>
    <!--{* ▲HEADER *}-->
    <!--{* ▼MAIN部 *}-->
    <div id="main">
        <span class="strong"><!--{$tpl_title}--></span><br>
        <!--{if $tpl_error != ""}-->
            <span class="attention"><!--{$tpl_error}--></span><br>
        <!--{/if}-->
            
        <form name="form1" id="form1" method="post" action="?">
            <input type="hidden" name="<!--{$smarty.const.TRANSACTION_ID_NAME}-->" value="<!--{$transactionid}-->" />
            <input type="hidden" name="mode" value="" />
            <div class="btn">
                <!--{* ログイン済み *}-->
                <!--{if $tpl_login == 1 }-->
                    <a class="btn_default" href="javascript:;" onclick="main.setModeAndSubmit('form1', 'logout'); return false;">ログアウト</a>
                    <a class="btn_default" href="javascript:;" onclick="main.setModeAndSubmit('form1', 'view_list'); return false;">空き状況確認</a>
                    <a class="btn_default" href="javascript:;" onclick="main.setModeAndSubmit('form1', 'reserve_list'); return false;">予約状況確認</a>
                <!--{else}-->
                    <a class="btn_default" href="javascript:;" onclick="main.setModeAndSubmit('form1', 'login'); return false;">ログイン</a>
                    <a class="btn_default" href="javascript:;" onclick="main.setModeAndSubmit('form1', 'view_list'); return false;">空き状況確認</a>
                <!--{/if}-->
            </div>

        <!-- 23_11_24 追加 夏目 -->
        <!--{if $dispDetailFlag == 1}-->

        <!--{assign var=key value="uke_nend"}-->
            <input type="hidden" name="<!--{$key}-->" value="<!--{$arrForm[$key]}-->" />
        <!--{assign var=key2 value="uke_no"}-->
            <input type="hidden" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]}-->" />


        <!--{assign var=WAKU_f value="$waku_no_v"}-->

        <!--{assign var=key2 value="KASO_KB"}-->
        
            <table class="list_edit">
                <caption class="strong">■予約情報</caption>
                <col width="25%" />
                <col width="75%" />
                <tr>
                    <th class="alignL sp_title_01">火葬予約日時</th>
                    <td class="alignL sp_content_01">

                        
                        <!--{assign var=key value="yoyakubi_date"}-->
                        <input type="hidden" id="yoyakubi_date_id" name="<!--{$key}-->" value="<!--{$arrForm[$key]}-->" />
                        
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
                </tr>

                  <tr>
                    <th class="alignL sp_title_01">通夜式利用</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="tsuya_type"}-->
                        <!--{assign var=key2 value="tsuya_dtkb"}-->
                        <!--{assign var=key3 value="tsuya_time"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--><!--{$arrErr[$key3]}--></span>
                        <span style="<!--{$arrErr[$key1]|getErrorColor}-->">
                            <!--{html_radios name="$key1" options=$arrTsuyaType selected=$arrForm[$key1]|default:0}-->
                        </span>
                        <span style="margin-left:20px;"></span>

                        <span class="sp_block">
                        開始時刻：
                        <select name="<!--{$key2}-->" id="<!--{$key2}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->">
                            <!--{*<option value="" selected="">指定なし</option>*}-->
                            <!--{assign var=selected_value value=$arrForm[$key2]}-->
                            <!--{html_options options=$arrTsuyaDtkb selected=$selected_value|default:-1}-->
                        </select>
                        <select name="<!--{$key3}-->" id="<!--{$key3}-->" style="<!--{$arrErr[$key3]|getErrorColor}-->">
                            <!--{*　*}-->
                            <option value="" selected="">未選択</option>
                            <!--{assign var=tsuya_time_value value=$arrForm[$key3]}-->
                            <!--{html_options options=$arrTsuyaTime selected=$tsuya_time_value}-->
                        </select>
                        </span>

                    </td>
                </tr>
                
                <!--{if $WAKU_f >= 1000 }-->
                <tr>
                    <th class="alignL sp_title_01"> 式場利用</th>
                    <td class="alignL sp_content_01">
                       <!--{assign var=key1 value="shiki_type"}-->
                        <!--{assign var=key2 value="shiki_dtkb"}-->
                        <!--{assign var=key3 value="shiki_time"}-->
                     
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--><!--{$arrErr[$key3]}--></span>
                        <span style="<!--{$arrErr[$key1]|getErrorColor}-->">
                        </span>

                        <span style="display:none;">
                            <!--{html_radios name="$key1" options=$arrShikiType selected=$arrForm[$key1]|default:0}-->
                        </span>
                        <!--{if $arrForm[$key1] == 0}-->
                        <p><span class="siki_riyou_result">利用しない</span></p>
                        <!--{/if}-->

                   
                    </td>
                </tr>

                <!--{elseif $WAKU_f == 100 || $WAKU_f == 200 || $WAKU_f == 120 || $WAKU_f == 220}-->
                 <tr>
                    <th class="alignL sp_title_01">式場利用</th>
                    <td class="alignL sp_content_01">
                       <!--{assign var=key1 value="shiki_type"}-->
                       <!--{assign var=key2 value="shiki_dtkb"}-->
                       <!--{assign var=key3 value="shiki_time"}-->
                     
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--><!--{$arrErr[$key3]}--></span>
                        <span style="<!--{$arrErr[$key1]|getErrorColor}-->">
                        </span>

                        <span style="display:none;">
                            <!--{html_radios name="$key1" options=$arrShikiType selected=$arrForm[$key1]|default:1}-->
                        </span>

                   
                       
                        
                        <div><span class="siki_riyou_result">利用する</span><br />
                           <!--{if $WAKU_f == 120}-->
                           <span class="siki_riyou_result">午前</span><br />
                            <!--{elseif $WAKU_f == 220}-->
                            <span class="siki_riyou_result">午後</span><br />
                            <!--{/if}-->

                           <span class="siki_riyou_result">大式場</span>
                        </div>
                        
                    </td>
                </tr>

                <!--{elseif $WAKU_f == 121 || $WAKU_f == 122 || $WAKU_f == 123}-->

             
                 <tr>
                    <th class="alignL sp_title_01">式場利用</th>
                    <td class="alignL sp_content_01">
                       <!--{assign var=key1 value="shiki_type"}-->
                       <!--{assign var=key2 value="shiki_dtkb"}-->
                       <!--{assign var=key3 value="shiki_time"}-->
                     
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--><!--{$arrErr[$key3]}--></span>
                        <span style="<!--{$arrErr[$key1]|getErrorColor}-->">
                        </span>

                        <span style="display:none;">
                            <!--{html_radios name="$key1" options=$arrShikiType selected=$arrForm[$key1]|default:2}-->
                        </span>

                        
                        <div><span class="siki_riyou_result">利用する</span><br />
                           <span class="siki_riyou_result">午前</span><br />
                           <!--{if $WAKU_f == 121}-->
                           <span class="siki_riyou_result">式場１</span>
                            
                            <!--{assign var=add_sno_v value="add_sno"}-->
                            <span style="display:none;">
                            <!--{html_radios name="$add_sno_v" options=$arrSno selected=$arrForm[$add_suo_v]|default:21}-->
                            </span>

                             <span style="display:none;">
                            <!--{html_radios name="$key2" options=$arrShikiDtkb selected=$arrForm[$key2]|default:0}-->
                            </span>

                           <!--{elseif $WAKU_f == 122}-->
                           <span class="siki_riyou_result">式場2</span>

                            <span style="display:none;">
                            <!--{html_radios name="$add_sno_v" options=$arrSno selected=$arrForm[$add_suo_v]|default:22}-->
                            </span>

                             <span style="display:none;">
                            <!--{html_radios name="$key2" options=$arrShikiDtkb selected=$arrForm[$key2]|default:0}-->
                            </span>

                            <!--{elseif $WAKU_f == 123}-->
                           <span class="siki_riyou_result">式場3</span>

                            <span style="display:none;">
                            <!--{html_radios name="$add_sno_v" options=$arrSno selected=$arrForm[$add_suo_v]|default:23}-->
                            </span>

                             <span style="display:none;">
                            <!--{html_radios name="$key2" options=$arrShikiDtkb selected=$arrForm[$key2]|default:0}-->
                            </span>

                            <!--{else}-->

                            <span style="display:none;">
                            <!--{html_radios name="$add_sno_v" options=$arrSno selected=$arrForm[$add_suo_v]|default:0}-->
                            </span>

                             <span style="display:none;">
                            <!--{html_radios name="$key2" options=$arrShikiDtkb selected=$arrForm[$key2]|default:0}-->
                            </span>


                           <!--{/if}-->
                        </div>
                        
                    </td>
                </tr>

                <!--{elseif $WAKU_f == 221 || $WAKU_f == 222 || $WAKU_f == 223}--> 

                <!--{assign var=add_sno_v value="add_sno"}-->
                <tr>    
                    <th class="alignL sp_title_01">式場利用</th>
                    <td class="alignL sp_content_01">
                       <!--{assign var=key1 value="shiki_type"}-->
                       <!--{assign var=key2 value="shiki_dtkb"}-->
                       <!--{assign var=key3 value="shiki_time"}-->
                     
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--><!--{$arrErr[$key3]}--></span>
                        <span style="<!--{$arrErr[$key1]|getErrorColor}-->">
                        </span>

                        <span style="display:none;">
                            <!--{html_radios name="$key1" options=$arrShikiType selected=$arrForm[$key1]|default:2}-->
                        </span>
                        
                        <div><span class="siki_riyou_result">利用する</span><br />
                           <span class="siki_riyou_result">午後</span><br />
                           <!--{if $WAKU_f == 221}-->
                           <span class="siki_riyou_result">式場１</span>

                            <span style="display:none;">
                            <!--{html_radios name="$add_sno_v" options=$arrSno selected=$arrForm[$add_suo_v]|default:21}-->
                            </span>

                           <!--{elseif $WAKU_f == 222}-->
                           <span class="siki_riyou_result">式場2</span>

                            <span style="display:none;">
                            <!--{html_radios name="$add_sno_v" options=$arrSno selected=$arrForm[$add_suo_v]|default:22}-->
                            </span>

                            <!--{elseif $WAKU_f == 223}-->
                           <span class="siki_riyou_result">式場3</span>

                            <span style="display:none;">
                            <!--{html_radios name="$add_sno_v" options=$arrSno selected=$arrForm[$add_suo_v]|default:23}-->
                            </span>

                            <!--{else}-->
                            <span style="display:none;">
                            <!--{html_radios name="$add_sno_v" options=$arrSno selected=$arrForm[$add_suo_v]|default:0}-->
                            </span>

                           <!--{/if}-->
                        </div>
                        
                    </td>
                </tr>

                 <!--{elseif $WAKU_f == 300 || $WAKU_f == 320}-->

                 <tr>
                    <th class="alignL sp_title_01">式場利用</th>
                    <td class="alignL sp_content_01">
                       <!--{assign var=key1 value="shiki_type"}-->
                       <!--{assign var=key2 value="shiki_dtkb"}-->
                       <!--{assign var=key3 value="shiki_time"}-->
                     
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--><!--{$arrErr[$key3]}--></span>
                        <span style="<!--{$arrErr[$key1]|getErrorColor}-->">
                        </span>

                        <span style="display:none;">
                            <!--{html_radios name="$key1" options=$arrShikiType selected=$arrForm[$key1]|default:1}-->
                        </span>
                        
                        <div><span class="siki_riyou_result">利用する</span><br />
                           <span class="siki_riyou_result">全日</span><br />
                           <span class="siki_riyou_result">大式場</span>
                        </div>
                        
                    </td>
                </tr>

                <!--{else}-->

                <!--{assign var=siki_Val value=$shiki_type_vv}-->
                <!--{assign var=Siki_01 value=$shiki_type}-->

                <!--{assign var=key1 value="shiki_type"}-->
                <!--{assign var=key2 value="shiki_dtkb"}-->
                <!--{assign var=key3 value="shiki_time"}-->
                <tr>
                    <th class="alignL sp_title_01">式場利用</th>
                    <td class="alignL sp_content_01">
                    
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--><!--{$arrErr[$key3]}--></span>

                        <!--{if $arrForm[$key1] == 0}-->
                        <div>
                        <span class="siki_riyou_result">利用しない <!--{$siki_Val}--></span>
                        </div>
                        <span style="display: none;">
                            <!--{html_radios name="$key1" options=$arrShikiType selected=$arrForm[$key1]|default:0}-->
                        </span>

                        <!--{elseif $arrForm[$key1] == 1}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--><!--{$arrErr[$key3]}--></span>
                        <span style="<!--{$arrErr[$key1]|getErrorColor}-->">
                        </span>

                        <span style="display:none;">
                            <!--{html_radios name="$key1" options=$arrShikiType selected=$arrForm[$key1]|default:1}-->
                        </span>
                        
                        <div>
                        <span class="siki_riyou_result">利用する（大式場）<!--{$siki_Val}--></span>
                        </div>

                        <!--{elseif $arrForm[$key1] == 2}-->
                        
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--><!--{$arrErr[$key3]}--></span>
                        <span style="<!--{$arrErr[$key1]|getErrorColor}-->">
                        </span>

                        <span style="display:none;">
                            <!--{html_radios name="$key1" options=$arrShikiType selected=$arrForm[$key1]|default:2}-->
                        </span>

                        <span style="display:none;">
                            <!--{html_radios name="$key2" options=$arrShikiDtkb selected=$arrForm[$key2]|default:0}-->
                        </span>
                        
                        <div>
                        <span class="siki_riyou_result">利用する（小式場）<!--{$siki_Val}--> : <!--{$arrForm[$key2]}--></span>

                        <!--{assign var=add_sno_v value="add_sno"}-->
                        <!--{assign var=add_sno_v_v value=$arrForm[$add_sno_v]}-->


                        <span style="display:inline-block;"> 小式場<!--{$add_sno_v_v}--> </span>

                        <!--{if $add_sno_v_v == 21}-->
                        <span style="display:none;">
                            <!--{html_radios name="$add_sno_v" options=$arrSno selected=$arrForm[$add_sno_v_v]|default:21}-->
                        </span>
                        <!--{elseif $add_sno_v_v == 22}-->
                        <span style="display:none;">
                            <!--{html_radios name="$add_sno_v" options=$arrSno selected=$arrForm[$add_sno_v_v]|default:22}-->
                        </span>
                        <!--{elseif $add_sno_v_v == 23}-->
                        <span style="display:none;">
                            <!--{html_radios name="$add_sno_v" options=$arrSno selected=$arrForm[$add_sno_v_v]|default:23}-->
                        </span>
                        <!--{else}-->
                        <span style="display:none;">
                            <!--{html_radios name="$add_sno_v" options=$arrSno selected=$arrForm[$add_sno_v_v]|default:0}-->
                        </span>
                        <!--{/if}-->

                        </div>

                        

                         
                        <!--{/if}-->

                    
                    </td>
                </tr>
                <!--{/if}-->

                <!-- 23_11_24 追加 夏目 END -->

                <!-- 23_12_07 追加 夏目 -->

<!-------------------------------------------------------{*                 　*}-------------------------------------------->
<!-------------------------------------------------------{*  データ修正時処理 　*}-------------------------------------------->
<!-------------------------------------------------------{*                 　*}-------------------------------------------->
                <!--{assign var=key1 value="kasou_type"}-->
                <!--{assign var=key2 value="KASO_KB"}-->

               
                <!--{if $Arr_Yoyaku_Data[$key2] != $kasou_type && $Arr_Yoyaku_Data[$key2] != ""}-->

                  <tr>
                    <th class="alignL sp_title_01">火葬区分</th>

                    <!--{if $Arr_Yoyaku_Data[$key2] == 0}-->
                   
                    <!--{assign var=kasou_idx value=0}-->
                 
                    <td class="alignL sp_content_01">
                     
                        <span class="attention"><!--{$arrErr[$key]}--></span>
                        <span style="<!--{$arrErr[$key]|getErrorColor}-->"></span>

                        <span>
                             大人(12歳以上)  <!--{$arrForm[key1]}-->
                        <span style="display: none;">
                           <!--{html_radios name="$key1" options=$arrKsou_K selected=$kasou_idx|default:0}-->
                        </span>
                    </td>

                 </tr>

                <!--{assign var=key value="region_type"}-->
                <tr>
                    <th class="alignL sp_title_01">死亡者の居住地</th>
                    <td class="alignL sp_content_01">
                       
                        <span class="attention"><!--{$arrErr[$key]}--></span>
                        <span style="<!--{$arrErr[$key]|getErrorColor}-->">
                            <!--{html_radios name="$key" options=$arrRegionType selected=$arrForm[$key]}-->
                        </span>
                    </td>
                </tr>
                <tr>
                    <th class="alignL sp_title_01">受付番号</th>
                    <td class="alignL sp_content_01">
                        <!--{$uke_no}-->
                    </td>
                </tr>
            </table>

                    <!--{elseif $Arr_Yoyaku_Data[$key2] == 1}-->
                  
                    <!--{assign var=kasou_idx value=1}-->
                    <!--{assign var=key1 value="kasou_type"}-->
                    <td class="alignL sp_title_01">
                       
                        <span class="attention"><!--{$arrErr[$key]}--></span>
                        <span style="<!--{$arrErr[$key]|getErrorColor}-->"></span>

                        <span>
                             小人(12歳未満)  <!--{$arrForm[key1]}-->
                        </span>
                        <span style="display: none;">
                            <!--{html_radios name="$key1" options=$arrKsou_K selected=$kasou_idx|default:1}-->
                        </span>
                    </td>
                    
                </tr>

                <!--{assign var=key value="region_type"}-->
                <tr>
                    <th class="alignL sp_title_01">死亡者の居住地</th>
                    <td class="alignL">
                        
                        <span class="attention"><!--{$arrErr[$key]}--></span>
                        <span style="<!--{$arrErr[$key]|getErrorColor}-->">
                            <!--{html_radios name="$key" options=$arrRegionType selected=$arrForm[$key]|default:0}-->
                        </span>
                    </td>
                </tr>


                <tr>
                    <th class="alignL sp_title_01">受付番号</th>
                    <td class="alignL">
                        <!--{$uke_no}-->
                    </td>
                </tr>
            </table>

                    <!--{elseif $Arr_Yoyaku_Data[$key2] == 2}-->
                   
                    <!--{assign var=kasou_idx value=2}-->
                    <!--{assign var=key1 value="kasou_type"}-->
                     <td class="alignL sp_title_01">
                        
                        <!--{assign var=sizanzi_val value="2"}-->
                        <span class="attention"><!--{$arrErr[$key]}--></span>
                        <span style="<!--{$arrErr[$key]|getErrorColor}-->"></span>

                        <span>
                             死産児  <!--{$arrForm[key1]}-->
                        </span>
        
                        <span style="display: none;">
                        
                        <select name="<!--{$key}-->">
                           <!--{html_radios name="$key1" options=$arrKsou_K selected=$kasou_idx|default:2}-->
                        </select>

                        </span>

                        <span style="display: none;">
                        <input type="text" name="<!--{$key}-->" value="<!--{$sizanzi_val}-->" maxlength="40" size="6" class="box6" style="<!--{$arrErr[$key]|getErrorColor}-->;" />
                        </span>
                    </td>

                    </tr>

                    <!--{assign var=key value="region_type"}-->
                    <tr>
                    <th class="alignL sp_title_01">死亡者の居住地</th>
                    <td class="alignL sp_content_01">
                      
                        <span class="attention"><!--{$arrErr[$key]}--></span>
                        <span style="<!--{$arrErr[$key]|getErrorColor}-->">
                            <!--{html_radios name="$key" options=$arrRegionType selected=$arrForm[$key]|default:0}-->
                        </span>
                    </td>
                </tr>
                <tr>
                    <th class="alignL sp_title_01">受付番号</th>
                    <td class="alignL sp_content_01">
                        <!--{$uke_no}-->
                    </td>
                </tr>
            </table>

                    <!--{/if}-->


<!-------------------------------------------------------{*                 　*}-------------------------------------------->
<!-------------------------------------------------------{*        新規     　*}-------------------------------------------->
<!-------------------------------------------------------{*                 　*}-------------------------------------------->
            <!--{else}-->

            <!--{assign var=key1 value="kasou_type"}-->
            <!--{assign var=key2 value="KASO_KB"}-->

                  <tr>
                    <th class="alignL sp_title_01">火葬区分</th>

                    <!--{if $kasou_type == 0}-->
                   

                    <!--{assign var=kasou_idx value=0}-->
                 
                    <td class="alignL sp_content_01">
                     
                        <span class="attention"><!--{$arrErr[$key]}--></span>
                        <span style="<!--{$arrErr[$key]|getErrorColor}-->"></span>

                        <span>
                             大人(12歳以上)  <!--{$arrForm[key1]}-->
                        </span>
                        <span style="display: none;">
                           <!--{html_radios name="$key1" options=$arrKsou_K selected=$kasou_idx|default:0}-->
                        </span>
                    </td>

                    <!--{assign var=key value="region_type"}-->
                    <tr>
                        <th class="alignL sp_title_01">死亡者の居住地</th>
                        <td class="alignL sp_content_01">
                            
                            <span class="attention"><!--{$arrErr[$key]}--></span>
                            <span style="<!--{$arrErr[$key]|getErrorColor}-->">
                                <!--{html_radios name="$key" options=$arrRegionType selected=$arrForm[$key]|default:0}-->
                            </span>
                        </td>
                    </tr>
                  <tr>


                    <th class="alignL sp_title_01">受付番号</th>
                    <td class="alignL sp_content_01">
                        <!--{$uke_no}-->
                    </td>
                </tr>
            </table>

                    <!--{elseif $kasou_type == 1}-->
                  
                    <!--{assign var=kasou_idx value=1}-->
                    <!--{assign var=key1 value="kasou_type"}-->
                    <td class="alignL sp_title_01">
                       
                        <span class="attention"><!--{$arrErr[$key]}--></span>
                        <span style="<!--{$arrErr[$key]|getErrorColor}-->"></span>

                        <span>
                             小人(12歳未満)  <!--{$arrForm[key1]}-->
                        </span>
                        <span style="display: none;">
                            <!--{html_radios name="$key1" options=$arrKsou_K selected=$kasou_idx|default:1}-->
                        </span>
                    </td>

                <!--{assign var=key value="region_type"}-->
                <tr>
                    <th class="alignL sp_title_01">死亡者の居住地</th>
                    <td class="alignL sp_content_01">
                        
                        <span class="attention"><!--{$arrErr[$key]}--></span>
                        <span style="<!--{$arrErr[$key]|getErrorColor}-->">
                            <!--{html_radios name="$key" options=$arrRegionType selected=$arrForm[$key]|default:0}-->
                        </span>
                    </td>
                </tr>
                <tr>
                    <th class="alignL sp_title_01">受付番号</th>
                    <td class="alignL sp_content_01">
                        <!--{$uke_no}-->
                    </td>
                </tr>
            </table>

                    <!--{elseif $kasou_type == 2}-->
                   
                    <!--{assign var=kasou_idx value=2}-->
                    <!--{assign var=key1 value="kasou_type"}-->
                     <td class="alignL sp_title_01">
                        
                        <!--{assign var=sizanzi_val value="2"}-->
                        <span class="attention"><!--{$arrErr[$key]}--></span>
                        <span style="<!--{$arrErr[$key]|getErrorColor}-->"></span>

                        <span>
                             死産児  <!--{$arrForm[key1]}-->
                        </span>
        
                        <span style="display: none;">
                        
                        <select name="<!--{$key}-->">
                           <!--{html_radios name="$key1" options=$arrKsou_K selected=$kasou_idx|default:2}-->
                        </select>

                        </span>

                        <span style="display: none;">
                        <input type="text" name="<!--{$key}-->" value="<!--{$sizanzi_val}-->" maxlength="40" size="6" class="box6" style="<!--{$arrErr[$key]|getErrorColor}-->;" />
                        </span>
                    </td>

                     </tr>

                    <!--{assign var=key value="region_type"}-->
                    <tr>
                    <th class="alignL sp_title_01">死亡者の居住地</th>
                    <td class="alignL sp_content_01">
                        
                        <span class="attention"><!--{$arrErr[$key]}--></span>
                        <span style="<!--{$arrErr[$key]|getErrorColor}-->">
                            <!--{html_radios name="$key" options=$arrRegionType selected=$arrForm[$key]|default:0}-->
                        </span>
                    </td>
                </tr>
                <tr>
                    <th class="alignL sp_title_01">受付番号</th>
                    <td class="alignL sp_content_01">
                        <!--{$uke_no}-->
                    </td>
                </tr>
            </table>
                    <!--{/if}-->

                <!--{/if}-->

            
<!-------------------------------------------------------{*                 　*}-------------------------------------------->
<!-------------------------------------------------------{*  １２歳以上、１２歳以下  通常 　*}-------------------------------------------->
<!-------------------------------------------------------{*                 　*}-------------------------------------------->


<!--{assign var=key2 value="KASO_KB"}-->
<!--１２歳以上、１２歳以下 -->
            <!--{if ($kasou_type < 2 && $Arr_Yoyaku_Data[$key2] == "") || ($Arr_Yoyaku_Data[$key2] != "" && $Arr_Yoyaku_Data[$key2] < 2)}-->            
            <table class="list_edit_02">
                <caption class="strong">■申請者情報</caption>
                <col width="25%" />
                <col width="75%" />
                <tr>
                    <th class="alignL sp_title_01">申請者氏名</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="applicant_name01"}-->
                        <!--{assign var=key2 value="applicant_name02"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>

                        <span class="edit_box_01">
                        姓：<input type="text" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key1]|getErrorColor}-->;" class="box30 input_01" />
                        </span>

                         <span class="edit_box_02">
                        　名：<input type="text" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;" class="box30 input_01" />
                         </span>
                    
                    </td>
                </tr>
                <tr>
                    <th class="alignL sp_title_01">申請者カナ</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="applicant_kana01"}-->
                        <!--{assign var=key2 value="applicant_kana02"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>

                        <span class="edit_box_01">
                        姓：<input type="text" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key1]|getErrorColor}-->;" class="box30 input_01" />
                        </span>
                        
                        <span class="edit_box_02">
                        　名：<input type="text" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;" class="box30 input_01" />
                         </span>
                        <br>

                        <span class="alignL attention">※カナは、全角カタカナで入力します。</span>
                    </td>
                </tr>
                <tr>
                    <th class="alignL sp_title_01">連絡先TEL</th>
                    <td class="alignL">

                    <div class="sp_div_01">
                        <!--{assign var=key1 value="applicant_tel01"}-->
                        <!--{assign var=key2 value="applicant_tel02"}-->
                        <!--{assign var=key3 value="applicant_tel03"}-->

                        <!--{assign var=key4 value="applicant_tel"}-->
                        
                        <span class="attention" id="errorSpan_TEL"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--><!--{$arrErr[$key3]}--> <!--{$arrErr[$key4]}--></span>
                        <input type="number" id="ren_tel_01" class="w_20" name="<!--{$key1}-->" id="applicant_tel01" value="<!--{$arrForm[$key1]|h}-->" maxlength="<!--{$smarty.const.TEL_ITEM_LEN}-->" size="6" class="box6" style="<!--{$arrErr[$key1]|getErrorColor}-->;" />
                         - <input type="number" id="ren_tel_02" class="w_20" name="<!--{$key2}-->" id="applicant_tel02" value="<!--{$arrForm[$key2]|h}-->" maxlength="<!--{$smarty.const.TEL_ITEM_LEN}-->" size="6" class="box6" style="<!--{$arrErr[$key2]|getErrorColor}-->;" />
                          - <input type="number" id="ren_tel_03" class="w_20" name="<!--{$key3}-->" id="applicant_tel03" value="<!--{$arrForm[$key3]|h}-->" maxlength="<!--{$smarty.const.TEL_ITEM_LEN}-->" size="6" class="box6" style="<!--{$arrErr[$key3]|getErrorColor}-->;" />

                          <input type="hidden" name="<!--{$key4}-->" value="<!--{$arrForm[$key4]|h}-->" maxlength="<!--{$smarty.const.TEL_ITEM_LEN}-->" size="6" class="box6" style="<!--{$arrErr[$key4]|getErrorColor}-->;" />
                      </div>
                        
                    </td>
                </tr>

                <!--{assign var=key value="applicant_rel"}-->
                <!--{assign var=key_val value="親族"}-->
                <!--{assign var=key_val_02 value="その他"}-->
                <tr>
                    <th class="alignL sp_title_01">故人との続柄</th>
                    <td class="alignL">

                    <div class="sp_div_02">

                        <!--{if $KOZIN_ZOKU_Flg_Text_v == ""}-->
                        <!--{assign var=applicant_rel_text_v value="applicant_rel_text"}-->
                        
                        <span class="attention"><!--{$arrErr[$key]}--></span>
                        <span style="<!--{$arrErr[$key]|getErrorColor}-->">
                            <!--{html_radios name="$key" options=$arrApplicantRel_r selected=$arrForm[$key]|default:$key_val}-->
                        </span>

                        <span style="margin-left: 20px;">
                             <input type="text" id="applicant_rel_text_v" name="<!--{$applicant_rel_text_v}-->" value="" maxlength="30" size="20" class="box6" />
                        </span>
                        
                        <!--{else}-->
                        
                        <span class="attention"><!--{$arrErr[$key]}--></span>
                        <span style="<!--{$arrErr[$key]|getErrorColor}-->">
                            <!--{html_radios name="$key" options=$arrApplicantRel_r selected=$arrForm[$key]|default:$key_val_02}-->
                        </span>

                        <span style="margin-left: 20px;">
                             <input type="text" id="applicant_rel_text_v" name="<!--{$applicant_rel_text_v}-->" value="<!--{$GET_kozin_zoku_v}-->" maxlength="30" size="20" class="box6" />
                        </span>
                        
                        <!--{/if}-->

                    </div>

                    </td>
                </tr>
                
                <!-- 追加 前橋用 23_1129 -->
                <!-- 情報提供の確認 -->
                <tr>
                    <th class="alignL sp_title_01">情報提供の確認</th>
                        <td class="alignL">
                             <!--{assign var=key value="applicant_information_01"}-->
                             <span style="display:inline-block;" id="sp_span_01">
                             <!--{html_radios name="$key" class="$key" options=$arrSinbunType selected=$arrForm[$key]|default:0}-->
                             </span>
                        </td>
                </tr>

                <tr>
                    <th class="alignL sp_title_01">郵便番号</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="applicant_zip01"}-->
                        <!--{assign var=key2 value="applicant_zip02"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>
                        〒 <input id="yubin_number_01" type="number" class="w_15" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]|h}-->" maxlength="<!--{$smarty.const.ZIP01_LEN}-->" size="6" class="box6" style="ime-mode:disabled;<!--{$arrErr[$key1]|getErrorColor}-->" />
                         - <input id="yubin_number_02" type="number" class="w_20" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]|h}-->" maxlength="<!--{$smarty.const.ZIP02_LEN}-->" size="6" class="box6" style="ime-mode:disabled;<!--{$arrErr[$key2]|getErrorColor}-->" />

                        <span class="btn_span_01">
                        <input type="button" value="郵便→住所" onClick="main.chkCode('applicant_zip01');main.chkCode('applicant_zip02');AjaxZip3.zip2addr('applicant_zip01','applicant_zip02','applicant_address1','applicant_address1');" />
                        </span>
                    </td>
                </tr>
                <tr>
                    <th class="alignL sp_title_01">住所</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="applicant_address1"}-->
                        <!--{assign var=key2 value="applicant_address2"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>

                        <span class="edit_box_009">
                        町名まで：<input type="text" class="input_001" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]}-->" maxlength="<!--{$smarty.const.MTEXT_LEN}-->" style="<!--{$arrErr[$key1]|getErrorColor}-->;" class="box240" />
                        </span>

                        <span style="margin-left:20px;"></span>

                        <span class="edit_box_02">
                        番地以降：<input type="text" class="input_001" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]}-->" maxlength="<!--{$smarty.const.MTEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;" class="box240" />
                        </span>

                    </td>
                </tr>

<!-------------------------------------------------------{*  喪主 追加 　*}-------------------------------------------->

                <!--{assign var=key1 value="mosyu_select"}-->
                <!--{assign var=key2 value="mosyu_text"}-->
                <tr>
                    <th class="alignL sp_title_01">喪主</th>
                    <td class="alignL">
                    
                    <!--{if $Ren_Mosyu_val == ""}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>
                        <span style="display:inline-block;">
                             <!--{html_radios name="$key1" id="mosyu_select" class="$key1" options=$arrMosyu_select selected=$arrForm[$key1]|default:0}-->
                        </span>

                        <span class="edit_box_001">
                        喪主：<input type="text" id="mosyu_text" class="w_60" name="<!--{$key2}-->" value="" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;" class="box30" />
                        </span>
                    <!--{else}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>
                        <span style="display:inline-block;">
                             <!--{html_radios name="$key1" id="mosyu_select" class="$key1" options=$arrMosyu_select selected=$arrForm[$key1]|default:1}-->
                        </span>

                        <span class="edit_box_001">
                        喪主：<input type="text" id="mosyu_text" class="w_60" name="<!--{$key2}-->" value="<!--{$Ren_Mosyu_val}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;" class="box30" />
                        </span>

                    <!--{/if}-->

                    </td>
                </tr>

            </table>

<!-------------------------------------------------------{*                 　*}-------------------------------------------->
<!-------------------------------------------------------{*  死産児  通常 　*}-------------------------------------------->
<!-------------------------------------------------------{*                 　*}-------------------------------------------->

<!--{assign var=key1 value="kasou_type"}-->
<!--{assign var=key2 value="KASO_KB"}-->

<!--{elseif ($kasou_type == 2 && $Arr_Yoyaku_Data[$key2] == "") || ($kasou_type != $Arr_Yoyaku_Data[$key2] && $Arr_Yoyaku_Data[$key2] == 2)}-->
 <!-- 死産児 -->

 <table class="list_edit_02">
                <caption class="strong">■申請者情報 </caption>
                <col width="25%" />
                <col width="75%" />
                <tr>
                    <th class="alignL sp_title_01">申請者氏名</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="applicant_name01"}-->
                        <!--{assign var=key2 value="applicant_name02"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>

                        <span class="edit_box_01">
                        姓：<input type="text" class="w_60" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key1]|getErrorColor}-->;" class="box30" />
                        </span>
                        
                        <span class="edit_box_02">
                        　名：<input type="text" class="w_60" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;" class="box30" />
                        </span>
                    
                    </td>
                </tr>
                <tr>
                    <th class="alignL sp_title_01">申請者カナ</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="applicant_kana01"}-->
                        <!--{assign var=key2 value="applicant_kana02"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>

                        <span class="edit_box_01">
                        姓：<input type="text" class="w_60" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key1]|getErrorColor}-->;" class="box30" />
                        </span>

                        <span class="edit_box_02">
                        　名：<input type="text" class="w_60" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;" class="box30" />
                        </span>
                        <br>
                        <span class="alignL attention">※カナは、全角カタカナで入力します。</span>
                    </td>
                </tr>
                <tr>
                    <th class="alignL sp_title_01">連絡先TEL</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="applicant_tel01"}-->
                        <!--{assign var=key2 value="applicant_tel02"}-->
                        <!--{assign var=key3 value="applicant_tel03"}-->

                        <!--{assign var=key4 value="applicant_tel"}-->
                        
                        <span class="attention" id="errorSpan_TEL"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--><!--{$arrErr[$key3]}--> <!--{$arrErr[$key4]}--></span>
                        <input type="number" id="ren_tel_04" class="w_15" name="<!--{$key1}-->" id="applicant_tel01" value="<!--{$arrForm[$key1]|h}-->" maxlength="<!--{$smarty.const.TEL_ITEM_LEN}-->" size="6" class="box6" style="<!--{$arrErr[$key1]|getErrorColor}-->;" />
                         - <input type="number" id="ren_tel_05" class="w_15" name="<!--{$key2}-->" id="applicant_tel02" value="<!--{$arrForm[$key2]|h}-->" maxlength="<!--{$smarty.const.TEL_ITEM_LEN}-->" size="6" class="box6" style="<!--{$arrErr[$key2]|getErrorColor}-->;" />
                          - <input type="number" id="ren_tel_06" class="w_15" name="<!--{$key3}-->" id="applicant_tel03" value="<!--{$arrForm[$key3]|h}-->" maxlength="<!--{$smarty.const.TEL_ITEM_LEN}-->" size="6" class="box6" style="<!--{$arrErr[$key3]|getErrorColor}-->;" />

                          <input type="hidden" name="<!--{$key4}-->" value="<!--{$arrForm[$key4]|h}-->" maxlength="<!--{$smarty.const.TEL_ITEM_LEN}-->" size="6" class="box6" style="<!--{$arrErr[$key4]|getErrorColor}-->;" />
                    </td>
                </tr>

                <tr>
                    <th class="alignL sp_title_01">故人との続柄</th>
                    <td class="alignL">
                        <!--{assign var=key value="applicant_rel"}-->
                        <span class="attention"><!--{$arrErr[$key]}--></span>
                        <span style="<!--{$arrErr[$key]|getErrorColor}-->">
                            <!--{html_radios name="$key" options=$arrApplicantRel_r selected=$arrForm[$key]|default:0}-->
                        </span>

                        <!--{assign var=applicant_rel_text_v value="applicant_rel_text"}-->
                        <span style="margin-left: 20px;">
                             <input type="text" class="input_01" id="applicant_rel_text_v" name="<!--{$applicant_rel_text_v}-->" value="<!--{$arrForm[$applicant_rel_text_v]}-->" maxlength="30" size="20" class="box6" />
                        </span>

                    </td>
                </tr>
                
                <!-- 追加 前橋用 23_1129 -->
                <!-- 情報提供の確認 -->
                <tr>
                    <th class="alignL sp_title_01">情報提供の確認</th>
                        <td class="alignL">
                             <!--{assign var=key value="applicant_information_01"}-->
                             <span style="display:inline-block;">
                             <!--{html_radios name="$key" options=$arrSinbunType selected=$arrForm[$key]|default:0}-->
                             </span>
                        </td>
                </tr>

                <tr>
                    <th class="alignL sp_title_01">郵便番号</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="applicant_zip01"}-->
                        <!--{assign var=key2 value="applicant_zip02"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>
                        〒 <input id="yubin_number_07" type="number" class="w_15" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]|h}-->" maxlength="<!--{$smarty.const.ZIP01_LEN}-->" size="6" class="box6" style="ime-mode:disabled;<!--{$arrErr[$key1]|getErrorColor}-->" />
                         - <input id="yubin_number_08" type="number" class="w_20" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]|h}-->" maxlength="<!--{$smarty.const.ZIP02_LEN}-->" size="6" class="box6" style="ime-mode:disabled;<!--{$arrErr[$key2]|getErrorColor}-->" />
                        <input type="button" value="郵便→住所" onClick="main.chkCode('applicant_zip01');main.chkCode('applicant_zip02');AjaxZip3.zip2addr('applicant_zip01','applicant_zip02','applicant_address1','applicant_address1');" />
                    </td>
                </tr>
                <tr>
                    <th class="alignL sp_title_01">住所</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="applicant_address1"}-->
                        <!--{assign var=key2 value="applicant_address2"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>

                        <span class="edit_box_01">
                        町名まで：<input type="text" class="input_01" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]}-->" maxlength="<!--{$smarty.const.MTEXT_LEN}-->" style="<!--{$arrErr[$key1]|getErrorColor}-->;" class="box240" />
                        </span>

                        <span style="margin-left:20px;"></span>

                        <span class="edit_box_02">
                        番地以降：<input type="text" class="input_01" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]}-->" maxlength="<!--{$smarty.const.MTEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;" class="box240" />
                        </span>
                    </td>
                </tr>
            </table>


<!-------------------------------------------------------{*                 　*}-------------------------------------------->
<!-------------------------------------------------------{*  死産児  編集 　*}-------------------------------------------->
<!-------------------------------------------------------{*                 　*}-------------------------------------------->

<!--{assign var=key1 value="kasou_type"}-->
<!--{assign var=key2 value="KASO_KB"}-->

<!--{elseif ($kasou_type == 2 && $Arr_Yoyaku_Data[$key2] == 2)}-->
 <!-- 死産児 -->

 <table class="list_edit_02">
                <caption class="strong">■申請者情報</caption>
                <col width="25%" />
                <col width="75%" />
                <tr>
                    <th class="alignL sp_title_01">申請者氏名</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="applicant_name01"}-->
                        <!--{assign var=key2 value="applicant_name02"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>

                        <span class="edit_box_01">
                        姓：<input type="text" class="w_60" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key1]|getErrorColor}-->;" class="box30" />
                        </span>
                        
                        <span class="edit_box_02">
                        　名：<input type="text" class="w_60" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;" class="box30" />
                        </span>
                    
                    </td>
                </tr>
                <tr>
                    <th class="alignL sp_title_01">申請者カナ</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="applicant_kana01"}-->
                        <!--{assign var=key2 value="applicant_kana02"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>

                        <span class="edit_box_01">
                        姓：<input type="text" class="w_60" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key1]|getErrorColor}-->;" class="box30" />
                        </span>

                        <span class="edit_box_02">
                        　名：<input type="text" class="w_60" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;" class="box30" />
                        </span>
                        <br>
                        <span class="alignL attention">※カナは、全角カタカナで入力します。</span>
                    </td>
                </tr>
                <tr>
                    <th class="alignL sp_title_01">連絡先TEL</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="applicant_tel01"}-->
                        <!--{assign var=key2 value="applicant_tel02"}-->
                        <!--{assign var=key3 value="applicant_tel03"}-->

                        <!--{assign var=key4 value="applicant_tel"}-->
                        
                        <span class="attention" id="errorSpan_TEL"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--><!--{$arrErr[$key3]}--> <!--{$arrErr[$key4]}--></span>
                        <input type="number" id="ren_tel_07" class="w_15" name="<!--{$key1}-->" id="applicant_tel01" value="<!--{$arrForm[$key1]|h}-->" maxlength="<!--{$smarty.const.TEL_ITEM_LEN}-->" size="6" class="box6" style="<!--{$arrErr[$key1]|getErrorColor}-->;" />
                         - <input type="number" id="ren_tel_08" class="w_15" name="<!--{$key2}-->" id="applicant_tel02" value="<!--{$arrForm[$key2]|h}-->" maxlength="<!--{$smarty.const.TEL_ITEM_LEN}-->" size="6" class="box6" style="<!--{$arrErr[$key2]|getErrorColor}-->;" />
                          - <input type="number" id="ren_tel_09" class="w_15" name="<!--{$key3}-->" id="applicant_tel03" value="<!--{$arrForm[$key3]|h}-->" maxlength="<!--{$smarty.const.TEL_ITEM_LEN}-->" size="6" class="box6" style="<!--{$arrErr[$key3]|getErrorColor}-->;" />

                          <input type="hidden" name="<!--{$key4}-->" value="<!--{$arrForm[$key4]|h}-->" maxlength="<!--{$smarty.const.TEL_ITEM_LEN}-->" size="6" class="box6" style="<!--{$arrErr[$key4]|getErrorColor}-->;" />
                    </td>
                </tr>

                <tr>
                    <th class="alignL sp_title_01">故人との続柄</th>
                    <td class="alignL">
                        <!--{assign var=key value="applicant_rel"}-->
                        <span class="attention"><!--{$arrErr[$key]}--></span>
                        <span style="<!--{$arrErr[$key]|getErrorColor}-->">
                            <!--{html_radios name="$key" options=$arrApplicantRel_r selected=$arrForm[$key]|default:0}-->
                        </span>
                        
                        <!--{assign var=applicant_rel_text_v value="applicant_rel_text"}-->
                        <span style="margin-left: 20px;">
                             <input type="text" class="input_01" id="applicant_rel_text_v" name="<!--{$applicant_rel_text_v}-->" value="<!--{$arrForm[$applicant_rel_text_v]}-->" maxlength="30" size="20" class="box6" />
                        </span>

                    </td>
                </tr>
                
                <!-- 追加 前橋用 23_1129 -->
                <!-- 情報提供の確認 -->
                <tr>
                    <th class="alignL sp_title_01">情報提供の確認</th>
                        <td class="alignL">
                             <!--{assign var=key value="applicant_information_01"}-->
                             <span style="display:inline-block;">
                             <!--{html_radios name="$key" options=$arrSinbunType selected=$arrForm[$key]|default:0}-->
                             </span>
                        </td>
                </tr>

                <tr>
                    <th class="alignL sp_title_01">郵便番号</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="applicant_zip01"}-->
                        <!--{assign var=key2 value="applicant_zip02"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>
                        〒 <input id="yubin_number_03" type="number" class="w_15" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]|h}-->" maxlength="<!--{$smarty.const.ZIP01_LEN}-->" size="6" class="box6" style="ime-mode:disabled;<!--{$arrErr[$key1]|getErrorColor}-->" />
                         - <input id="yubin_number_04" type="number" class="w_20" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]|h}-->" maxlength="<!--{$smarty.const.ZIP02_LEN}-->" size="6" class="box6" style="ime-mode:disabled;<!--{$arrErr[$key2]|getErrorColor}-->" />
                        <input type="button" value="郵便→住所" onClick="main.chkCode('applicant_zip01');main.chkCode('applicant_zip02');AjaxZip3.zip2addr('applicant_zip01','applicant_zip02','applicant_address1','applicant_address1');" />
                    </td>
                </tr>
                <tr>
                    <th class="alignL sp_title_01">住所</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="applicant_address1"}-->
                        <!--{assign var=key2 value="applicant_address2"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>

                        <span class="edit_box_01">
                        町名まで：<input type="text" class="input_01" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]}-->" maxlength="<!--{$smarty.const.MTEXT_LEN}-->" style="<!--{$arrErr[$key1]|getErrorColor}-->;" class="box240" />
                        </span>

                        <span style="margin-left:20px;"></span>

                        <span class="edit_box_02">
                        番地以降：<input type="text" class="input_01" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]}-->" maxlength="<!--{$smarty.const.MTEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;" class="box240" />
                        </span>
                    </td>
                </tr>
            </table>

 <!--{/if}-->
            
            <!-- 前橋用　追加 23_1211 夏目 -->

<!--１２歳以上、１２歳以下 -->

<!--{assign var=key1 value="kasou_type"}-->
<!--{assign var=key2 value="KASO_KB"}-->

            <!--{if ($kasou_type < 2 && $Arr_Yoyaku_Data[$key2] == "") || ($Arr_Yoyaku_Data[$key2] != "" && $Arr_Yoyaku_Data[$key2] < 2)}--> 
            <table class="list_edit_03">
                <caption class="strong">■死亡者情報</caption>
                <col width="25%" />
                <col width="75%" />
                <tr>
                    <th class="alignL sp_title_01">死亡者氏名</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="dead_name01"}-->
                        <!--{assign var=key2 value="dead_name02"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>

                        <span class="edit_box_01">
                        姓：<input type="text" class="input_01" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key1]|getErrorColor}-->;" class="box30" />
                        </span>

                        <span class="edit_box_02">
                        　名：<input type="text" class="input_01" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;" class="box30" />
                        </span> 

                    </td>
                </tr>
                <tr>
                    <th class="alignL sp_title_01">死亡者カナ</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="dead_kana01"}-->
                        <!--{assign var=key2 value="dead_kana02"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>

                        <span class="edit_box_01">
                        姓：<input type="text" class="input_01" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key1]|getErrorColor}-->;" class="box30" />
                        </span>

                        <span class="edit_box_02">
                        　名：<input type="text" class="input_01" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;" class="box30" />
                        </span>
                        <br>
                        <span class="alignL attention">※カナは、全角カタカナで入力します。</span>                    
                    </td>
                </tr>
                <tr>
                    <th class="alignL sp_title_01">性別</th>
                    <td class="alignL sp_content_01">
                        <!--{assign var=key value="dead_sex"}-->
                        <span class="attention"><!--{$arrErr[$key]}--></span>
                        <span style="<!--{$arrErr[$key]|getErrorColor}-->">
                            <!--{assign var=dead_sex_value value="`$arrForm[$key]`"}-->
                            <!--{* html_radios name=$key options=$arrSex selected=$arrForm[$key]|default:0 *}-->
                            <!--{html_radios name=$key options=$arrSex selected=$dead_sex_value|default:''}-->
                        </span>
                    </td>
                </tr>
                <tr>
                    <th class="alignL sp_title_01">生年月日</th>
                    <td class="alignL">
                        <!--{assign var=prefix value="dead_birth_"}-->
                        <!--{assign var=key1 value="`$prefix`koyomi_type"}-->
                        <!--{assign var=key2 value="`$prefix`year"}-->
                        <!--{assign var=key3 value="`$prefix`month"}-->
                        <!--{assign var=key4 value="`$prefix`day"}-->
                        <!--{assign var=errBirth value="`$arrErr.$key1``$arrErr.$key2``$arrErr.$key3``$arrErr.$key4`"}-->
                        <!--{if $errBirth}-->
                            <span class="attention"><!--{$errBirth}--></span>
                        <!--{/if}-->
                        <select name="<!--{$key1}-->" id="dead_birth_koyomi_type" style="<!--{$errBirth|getErrorColor}-->">
                            <option value="" selected="">未選択</option>
                            <!--{* html_options options=$arrKoyomiType selected=$arrForm[$key1]|default:-1 *}-->
                            <!--{html_options options=$arrKoyomiType selected=$arrForm[$key1]}-->
                        </select>
                        <input type="text" class="w_20" name="<!--{$key2}-->" id="dead_birth_year" value="<!--{$arrForm[$key2]|default:''}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;"  size="6" class="box6" />
                        年&nbsp;
                        <select name="<!--{$key3}-->" id="dead_birth_month" style="<!--{$errBirth|getErrorColor}-->">
                            <option value="" selected="">未選択</option>
                            <!--{* html_options options=$arrBirthMonth selected=$arrForm[$key3]|default:'' *}-->
                            <!--{html_options options=$arrBirthMonth selected=$arrForm[$key3]}-->
                        </select>月&nbsp;
                        <select name="<!--{$key4}-->" id="dead_birth_day" style="<!--{$errBirth|getErrorColor}-->">
                            <option value="" selected="">未選択</option>
                            <!--{* html_options options=$arrBirthDay selected=$arrForm[$key4]|default:'' *}-->
                            <!--{html_options options=$arrBirthDay selected=$arrForm[$key4]}-->
                        </select>日
                    </td>
                </tr>
                <tr>
                    <th class="alignL sp_title_01">死亡年月日</th>
                    <td class="alignL">
                        <!--{assign var=prefix value="dead_"}-->
                        <!--{assign var=key1 value="`$prefix`koyomi_type"}-->
                        <!--{assign var=key2 value="`$prefix`year"}-->
                        <!--{assign var=key3 value="`$prefix`month"}-->
                        <!--{assign var=key4 value="`$prefix`day"}-->
                        <!--{assign var=err value="`$arrErr.$key1``$arrErr.$key2``$arrErr.$key3``$arrErr.$key4`"}-->
                        <!--{if $err}-->
                            <span class="attention"><!--{$err}--></span>
                        <!--{/if}-->
                        <select name="<!--{$key1}-->" id="dead_koyomi_type" style="<!--{$err|getErrorColor}-->">
                            <option value="" selected="">未選択</option>
                            <!--{* html_options options=$arrKoyomiType selected=$arrForm[$key1]|default:-1 *}-->
                            <!--{html_options options=$arrKoyomiType selected=$arrForm[$key1]}-->
                        </select>
                        <input type="text" class="w_20" name="<!--{$key2}-->" id="dead_year" value="<!--{$arrForm[$key2]|default:''}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;"  size="6" class="box6" />
                        年&nbsp;
                        <select name="<!--{$key3}-->" id="dead_month" style="<!--{$err|getErrorColor}-->">
                            <option value="" selected="">未選択</option>
                            <!--{* html_options options=$arrDeathMonth selected=$arrForm[$key3]|default:$current_month *}-->
                            <!--{html_options options=$arrDeathMonth selected=$arrForm[$key3]}-->
                        </select>月&nbsp;
                        <select name="<!--{$key4}-->" id="dead_day" style="<!--{$err|getErrorColor}-->">
                            <option value="" selected="">未選択</option>
                            <!--{* html_options options=$arrDeathDay selected=$arrForm[$key4]|default:$current_day *}-->
                            <!--{html_options options=$arrDeathDay selected=$arrForm[$key4]}-->
                        </select>日

                        <!-- ============  死亡時刻 追加（12歳以上） ============== -->

                        <!--{if $sibou_time_Flg_v == ""}-->

                        <!--{assign var=death_time_H value="time_of_death_hour"}-->
                        <!--{assign var=death_time_M value="time_of_death_minutes"}-->

                        <!--{assign var=time_of_death_time_V value="time_of_death_time"}-->

                        <p style="margin: 10px 0;">
                        <span>
                        死亡時刻
                        </span>
                         <!--{*  死亡時刻  時間　*}-->
                        <span id="death_time_val_01">
                        <select name="<!--{$death_time_H}-->" id="time_of_death_hour" style="<!--{$arrErr[$death_time_H]|getErrorColor}-->">
                           
                            <!--{assign var=death_time_H_V value=$Arr_Yoyaku_Data[$death_time_H]}-->
                            <!--{html_options options=$arr_death_hour_TT selected=$death_time_H_V}-->
                        </select>
                             時
                        </span>

                          <!--{*  死亡時刻  分　*}-->
                        <span id="death_time_val_02">
                        <select name="<!--{$death_time_M}-->" id="time_of_death_minutes" style="<!--{$arrErr[$death_time_M]|getErrorColor}-->">
                            
                            <!--{assign var=death_time_M_V value=$Arr_Yoyaku_Data[$death_time_M]}-->
                            <!--{html_options options=$arr_death_minute_TT selected=$death_time_M_V}-->
                        </select>
                             分
                        </span>

                        <input type="hidden" name="time_of_death_time" id="time_of_death_time" class="w_80" name="<!--{$time_of_death_time_V}-->" id="time_of_death_free" value="<!--{$arrForm[$time_of_death_free_v]}-->" maxlength="12" size="12" class="box6" />
                        </p>

                         <p class="form_info_M">※ 死亡時刻が不明の場合は、死亡時刻から「時刻不明」を選択し、下記の入力ボックスへ大枠の時刻を入力してください。</p>

                        <p>
                        <span id="death_time_free_ed">
                        死亡時刻未定の入力
                        </span>
                        <span class="death_time_free">
                             <!--{assign var=time_of_death_free_v value="time_of_death_free"}-->
                             <input type="text" class="w_80" name="<!--{$time_of_death_free_v}-->" id="time_of_death_free" value="<!--{$arrForm[$time_of_death_free_v]}-->" maxlength="60" size="40" class="box6" />

                        </span>
                        </p>

                        <!--{elseif $sibou_time_Flg_v == 1}-->

                        <!--{assign var=death_time_H value="time_of_death_hour"}-->
                        <!--{assign var=death_time_M value="time_of_death_minutes"}-->

                        <!--{assign var=time_of_death_time_V value="time_of_death_time"}-->

                        <p style="margin: 10px 0;">
                        <span>
                        死亡時刻 
                        </span>
                         <!--{*  死亡時刻  時間　*}-->
                        <span id="death_time_val_01">
                        <select name="<!--{$death_time_H}-->" id="time_of_death_hour" style="<!--{$arrErr[$death_time_H]|getErrorColor}-->">
                           
                            <!--{assign var=death_time_H_V value=$death_first_time}-->
                            <!--{html_options options=$arr_death_hour_TT selected=$death_time_H_V}-->
                        </select>
                             時
                        </span>

                          <!--{*  死亡時刻  分　*}-->
                        <span id="death_time_val_02">
                        <select name="<!--{$death_time_M}-->" id="time_of_death_minutes" style="<!--{$arrErr[$death_time_M]|getErrorColor}-->">
                            
                            <!--{assign var=death_time_M_V value=$death_second_time}-->
                            <!--{html_options options=$arr_death_minute_TT selected=$death_time_M_V}-->
                        </select>
                             分
                        </span>

                        <input type="hidden" name="time_of_death_time" id="time_of_death_time" class="w_80" name="<!--{$time_of_death_time_V}-->" id="time_of_death_free" value="<!--{$GET_sibou_time_V}-->" maxlength="12" size="12" class="box6" />
                        </p>

                         <p class="form_info_M">※ 死亡時刻が不明の場合は、死亡時刻から「時刻不明」を選択し、下記の入力ボックスへ大枠の時刻を入力してください。</p>

                        <p>
                        <span id="death_time_free_ed">
                        死亡時刻未定の入力
                        </span>
                        <span class="death_time_free">
                             <!--{assign var=time_of_death_free_v value="time_of_death_free"}-->
                             <input type="text" class="w_80" name="<!--{$time_of_death_free_v}-->" id="time_of_death_free" value="<!--{$arrForm[$time_of_death_free_v]}-->" maxlength="60" size="40" class="box6" />

                        </span>
                        </p>

                        <!--{elseif $sibou_time_Flg_v == 2}-->


                        <!--{assign var=death_time_H value="time_of_death_hour"}-->
                        <!--{assign var=death_time_M value="time_of_death_minutes"}-->

                        <!--{assign var=time_of_death_time_V value="time_of_death_time"}-->

                        <p style="margin: 10px 0;">
                        <span>
                        死亡時刻 
                        </span>
                         <!--{*  死亡時刻  時間　*}-->
                        <span id="death_time_val_01">
                        <select name="<!--{$death_time_H}-->" id="time_of_death_hour" style="<!--{$arrErr[$death_time_H]|getErrorColor}-->">
                           
                            <!--{assign var=death_time_H_V value=$death_first_time}-->
                            <!--{html_options options=$arr_death_hour_TT selected=$death_time_H_V}-->
                        </select>
                             時
                        </span>

                          <!--{*  死亡時刻  分　*}-->
                        <span id="death_time_val_02">
                        <select name="<!--{$death_time_M}-->" id="time_of_death_minutes" style="<!--{$arrErr[$death_time_M]|getErrorColor}-->">
                            
                            <!--{assign var=death_time_M_V value=$death_second_time}-->
                            <!--{html_options options=$arr_death_minute_TT selected=$death_time_M_V}-->
                        </select>
                             分
                        </span>

                        <input type="hidden" name="time_of_death_time" id="time_of_death_time" class="w_80" name="<!--{$time_of_death_time_V}-->" id="time_of_death_free" value="<!--{$GET_sibou_time_V}-->" maxlength="12" size="12" class="box6" />
                        </p>

                         <p class="form_info_M">※ 死亡時刻が不明の場合は、死亡時刻から「時刻不明」を選択し、下記の入力ボックスへ大枠の時刻を入力してください。</p>

                        <p>
                        <span id="death_time_free_ed">
                        死亡時刻未定の入力
                        </span>
                        <span class="death_time_free">
                             <!--{assign var=time_of_death_free_v value="time_of_death_free"}-->
                             <input type="text" class="w_80" name="<!--{$time_of_death_free_v}-->" id="time_of_death_free" value="<!--{$arrForm[$time_of_death_free_v]}-->" maxlength="60" size="40" class="box6" />

                        </span>
                        </p>

                        <!--{else}-->

                        
                        <!--{assign var=death_time_H value="time_of_death_hour"}-->
                        <!--{assign var=death_time_M value="time_of_death_minutes"}-->

                        <!--{assign var=time_of_death_time_V value="time_of_death_time"}-->

                        <p style="margin: 10px 0;">
                        <span>
                        死亡時刻 
                        </span>
                         <!--{*  死亡時刻  時間　*}-->
                        <span id="death_time_val_01">
                        <select name="<!--{$death_time_H}-->" id="time_of_death_hour" style="<!--{$arrErr[$death_time_H]|getErrorColor}-->">
                           
                            <!--{assign var=death_time_H_V value=$death_first_time}-->
                            <!--{html_options options=$arr_death_hour_TT selected=$death_time_H_V}-->
                        </select>
                             時
                        </span>

                          <!--{*  死亡時刻  分　*}-->
                        <span id="death_time_val_02">
                        <select name="<!--{$death_time_M}-->" id="time_of_death_minutes" style="<!--{$arrErr[$death_time_M]|getErrorColor}-->">
                            
                            <!--{assign var=death_time_M_V value=$death_second_time}-->
                            <!--{html_options options=$arr_death_minute_TT selected=$death_time_M_V}-->
                        </select>
                             分
                        </span>

                        <input type="hidden" name="time_of_death_time" id="time_of_death_time" class="w_80" name="<!--{$time_of_death_time_V}-->" id="time_of_death_free" value="<!--{$GET_sibou_time_V}-->" maxlength="12" size="12" class="box6" />
                        </p>

                         <p class="form_info_M">※ 死亡時刻が不明の場合は、死亡時刻から「時刻不明」を選択し、下記の入力ボックスへ大枠の時刻を入力してください。</p>

                        <p>
                        <span id="death_time_free_ed">
                        死亡時刻未定の入力
                        </span>
                        <span class="death_time_free">
                             <!--{assign var=time_of_death_free_v value="time_of_death_free"}-->
                             <input type="text" class="w_80" name="<!--{$time_of_death_free_v}-->" id="time_of_death_free" value="<!--{$arrForm[$time_of_death_free_v]}-->" maxlength="60" size="40" class="box6" />

                        </span>
                        </p>

                        <!--{/if}-->


                        <!-- ============  死亡時刻 追加  END ============== -->


                    </td>
                </tr>

                <!--{assign var=Age_at_Death_v value="Age_at_Death"}-->
                <tr>       
                    <th class="alignL sp_title_01">死亡時年齢</th>    
                    <td class="alignL">
                            <input type="number" class="w_15" name="<!--{$Age_at_Death_v}-->" id="Age_at_Death" value="<!--{$arrForm[$Age_at_Death_v]}-->" maxlength="5" size="5" class="box6" />
                            歳
                    </td>
                </tr>

                <tr>
                    <th class="alignL sp_title_01">郵便番号</th>
                    <td class="alignL">
                        <!--{assign var=prefix value="dead_"}-->
                        <!--{assign var=key1 value="`$prefix`zip01"}-->
                        <!--{assign var=key2 value="`$prefix`zip02"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>
                        〒 <input id="yubin_number_05" type="number" class="w_15" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]|h}-->" maxlength="<!--{$smarty.const.ZIP01_LEN}-->" size="6" class="box6" style="ime-mode:disabled;<!--{$arrErr[$key1]|getErrorColor}-->;" />
                         - <input id="yubin_number_06" type="number" class="w_20" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]|h}-->" maxlength="<!--{$smarty.const.ZIP02_LEN}-->" size="6" class="box6" style="ime-mode:disabled;<!--{$arrErr[$key2]|getErrorColor}-->;" />
                        
                        <span style="margin: 0px 10px;display: inline-block;">
                            <input type="button" id="sinsei_dead_btn" value="申請者と住所が同じ" />
                        </span>
                        
                        <span>
                            <input type="button" value="郵便→住所" onClick="main.chkCode('dead_zip01');main.chkCode('dead_zip02');AjaxZip3.zip2addr('dead_zip01','dead_zip02','dead_address1','dead_address1');" />
                        </span>
                    </td>
                </tr>
                <tr>
                    <th class="alignL sp_title_01">住所</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="dead_address1"}-->
                        <!--{assign var=key2 value="dead_address2"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>

                        <span class="edit_box_01">
                        町名まで：<input type="text" class="input_01" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]}-->" maxlength="<!--{$smarty.const.MTEXT_LEN}-->" style="<!--{$arrErr[$key1]|getErrorColor}-->;" class="box240" />
                        </span>
                            
                        <span style="margin-left:20px;"></span>

                        <span class="edit_box_02">
                        番地以降：<input type="text" class="input_01" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]}-->" maxlength="<!--{$smarty.const.MTEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;" class="box240" />
                        </span>

                    </td>
                </tr>
                
                <!--{*  死亡場所　追加  *}-->
                <!--{assign var=key1 value="death_place"}-->
                <tr>
                    <th class="alignL sp_title_01">死亡場所</th>
                    <td class="alignL">
                       

                        <!--{if $SIBOU_PLACE_Flg_v == 1}-->

                            <span class="attention"><!--{$arrErr[$key1]}--></span>
                            <input type="text" class="w_80" name="<!--{$key1}-->" value="<!--{$GET_sibou_place_get_v}-->" maxlength="<!--{$smarty.const.MTEXT_LEN}-->" style="<!--{$arrErr[$key1]|getErrorColor}-->;width:70%;"  />
                        <!--{else}-->
                            <span class="attention"><!--{$arrErr[$key1]}--></span>
                            <input type="text" class="w_80" name="<!--{$key1}-->" value="" maxlength="<!--{$smarty.const.MTEXT_LEN}-->" style="<!--{$arrErr[$key1]|getErrorColor}-->;width:70%;"  />
                        <!--{/if}-->

                    </td>
                </tr>
                <!-- 死亡場所　追加 END -->

                <tr>
                    <th class="alignL sp_title_01">郵便番号（本籍）</th>
                    <td class="alignL">
                        <!--{assign var=prefix value="dead_honseki_"}-->
                        <!--{assign var=key1 value="`$prefix`zip01"}-->
                        <!--{assign var=key2 value="`$prefix`zip02"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>
                        〒 <input id="yubin_number_09" type="number" class="w_15" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]|h}-->" maxlength="<!--{$smarty.const.ZIP01_LEN}-->" size="6" class="box6" style="ime-mode:disabled;<!--{$arrErr[$key1]|getErrorColor}-->;" />
                         - <input id="yubin_number_10" type="number" class="w_20" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]|h}-->" maxlength="<!--{$smarty.const.ZIP02_LEN}-->" size="6" class="box6" style="ime-mode:disabled;<!--{$arrErr[$key2]|getErrorColor}-->;" />

                        <span style="margin: 0px 10px;display: inline-block;">
                            <input type="button" id="dead_honseki_btn" value="死亡者住所と本籍が同じ" />
                        </span>

                        <span>
                            <input type="button" value="郵便→住所" onClick="main.chkCode('dead_honseki_zip01');main.chkCode('dead_honseki_zip02');AjaxZip3.zip2addr('dead_honseki_zip01','dead_honseki_zip02','dead_honseki_address1','dead_honseki_address1');" />
                        </span>
                    </td>
                </tr>
                <tr>
                    <th class="alignL sp_title_01">本籍</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="dead_honseki_address1"}-->
                        <!--{assign var=key2 value="dead_honseki_address2"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>

                        <span class="edit_box_01">
                        町名まで：<input type="text" class="w_60" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]}-->" maxlength="<!--{$smarty.const.MTEXT_LEN}-->" style="<!--{$arrErr[$key1]|getErrorColor}-->;" class="box240" />
                        </span>

                        <span style="margin-left:20px;"></span>

                        <span class="edit_box_01">
                        番地以降：<input type="text" class="w_60" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]}-->" maxlength="<!--{$smarty.const.MTEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;" class="box240" />
                        </span>
                    </td>
                </tr>
                
                <!--{assign var=cause_of_death_kb_v value="cause_of_death_kb"}-->
                <tr>
                    <th class="alignL sp_title_01">死因</th>
                        <td class="alignL sp_content_01">
                             
                             <span style="display:inline-block;">
                             <!--{html_radios name="$cause_of_death_kb_v" options=$arrDeath_Cause_KB selected=$arrForm[$cause_of_death_kb_v]|default:1}-->
                             </span>
                        </td>
                </tr>
                
                 <!--{assign var=dead_pacemaker_v value="dead_pacemaker"}-->
                <tr>
                    <th class="alignL sp_title_01">ペースメーカー使用</th>
                        <td class="alignL sp_content_01">
                            
                             <span style="display:inline-block;">
                             <!--{html_radios name="$dead_pacemaker_v" options=$arrDead_pacemaker selected=$arrForm[$dead_pacemaker_v]|default:0}-->
                             </span>
                        </td>
                </tr>

                <!--{assign var=coffin_wifth_v value="coffin_wifth"}-->
                <!--{assign var=coffin_height_v value="coffin_height"}-->
                <!--{assign var=coffin_hei_v value="coffin_hei"}-->
                <tr>       
                    <th class="alignL sp_title_01">棺の大きさ ※標準以外はcmで記入</th>    
                    <td class="alignL">

                            <span class="attention"><!--{$arrErr[$coffin_wifth_v]}--><!--{$arrErr[$coffin_height_v]}--><!--{$arrErr[$coffin_hei_v]}--></span>
                            <span>縦：
                                <input type="number" id="hitugi_01" class="w_20" name="<!--{$coffin_height_v}-->" value="<!--{$arrForm[$coffin_height_v]}-->" style="<!--{$arrErr[$coffin_height_v]|getErrorColor}-->;" maxlength="8" size="6" class="box6" />
                            </span>

                            <span>横：
                                <input type="number" id="hitugi_02" class="w_20" name="<!--{$coffin_wifth_v}-->" value="<!--{$arrForm[$coffin_wifth_v]}-->" style="<!--{$arrErr[$coffin_wifth_v]|getErrorColor}-->;" maxlength="8" size="6" class="box6" />
                            </span>

                            <span>高：
                                <input type="number" id="hitugi_03" class="w_20" name="<!--{$coffin_hei_v}-->" value="<!--{$arrForm[$coffin_hei_v]}-->" style="<!--{$arrErr[$coffin_hei_v]|getErrorColor}-->;" maxlength="8" size="6" class="box6" />
                            </span>

                            <!--{assign var=death_weight_tmp_v value="death_weight_tmp"}-->

                            <!--{if $Ren_Weight_F_v == 1}-->
                            <span id="weight_edit">
                                体重<br /><!--{html_radios name="$death_weight_tmp_v" options=$arrWeight_dead selected=$arrForm[$death_weight_tmp_v]|default:1}-->
                            </span>

                            <!--{elseif $Ren_Weight_F_v == 2}-->
                             <span id="weight_edit">
                                体重<br /><!--{html_radios name="$death_weight_tmp_v" options=$arrWeight_dead selected=$arrForm[$death_weight_tmp_v]|default:2}-->
                            </span>
                            
                            <!--{else}-->
                             <span id="weight_edit">
                                体重<br /><!--{html_radios name="$death_weight_tmp_v" options=$arrWeight_dead selected=$arrForm[$death_weight_tmp_v]|default:0}-->
                            </span>
                            
                            <!--{/if}-->


                    </td>
                </tr>
            </table>

<!--{assign var=key1 value="kasou_type"}-->
<!--{assign var=key2 value="KASO_KB"}-->

<!--{elseif ($kasou_type == 2 && $Arr_Yoyaku_Data[$key2] == "") || ($kasou_type != $Arr_Yoyaku_Data[$key2] && $Arr_Yoyaku_Data[$key2] == 2)}-->
   <table class="list_edit_03">
                <caption class="strong">■死産児情報<!--{$Arr_Yoyaku_Data[$key2]}--></caption>
                <col width="25%" />
                <col width="75%" />
                
                <tr>
                    <th class="alignL sp_title_01">父の氏名</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="kojinf_sei_f"}-->
                        <!--{assign var=key2 value="kojinf_mei_f"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>

                        <span class="edit_box_01">
                        姓：<input type="text" class="w_60" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key1]|getErrorColor}-->;" class="box30" />
                        </span>

                        <span class="edit_box_02">
                        　名：<input type="text" class="w_60" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;" class="box30" />
                        </span>
                          
                    </td>
                </tr>

                <tr>
                    <th class="alignL sp_title_01">父のカナ</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="kojinf_skana_f"}-->
                        <!--{assign var=key2 value="kojinf_mkana_f"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>

                        <span class="edit_box_01">
                        姓：<input type="text" class="w_60" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key1]|getErrorColor}-->;" class="box30" />
                        </span>

                        <span class="edit_box_02">
                        　名：<input type="text" class="w_60" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;" class="box30" />               
                        </span>

                    </td>
                </tr>

                <tr>
                    <th class="alignL sp_title_01">母の氏名</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="kojinm_sei_f"}-->
                        <!--{assign var=key2 value="kojinm_mei_f"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>

                        <span class="edit_box_01">
                        姓：<input type="text" class="w_60" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key1]|getErrorColor}-->;" class="box30" />
                        </span>

                        <span class="edit_box_02">
                        　名：<input type="text" class="w_60" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;" class="box30" />
                        </span>
                            
                    </td>
                </tr>

                <tr>
                    <th class="alignL sp_title_01">母のカナ</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="kojinm_skana_f"}-->
                        <!--{assign var=key2 value="kojinm_mkana_f"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>

                        <span class="edit_box_01">
                        姓：<input type="text" class="w_60" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key1]|getErrorColor}-->;" class="box30" />
                        </span>

                        <span class="edit_box_02">
                        　名：<input type="text" class="w_60" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;" class="box30" />
                        </span>                    
                    </td>
                </tr>

                <tr>
                    <th class="alignL sp_title_01">性別</th>
                    <td class="alignL">
                        <!--{assign var=key value="dead_sex"}-->
                        <span class="attention"><!--{$arrErr[$key]}--></span>
                        <span style="<!--{$arrErr[$key]|getErrorColor}-->">
                            <!--{assign var=dead_sex_value value="`$arrForm[$key]`"}-->
                            <!--{* html_radios name=$key options=$arrSex selected=$arrForm[$key]|default:0 *}-->
                            <!--{html_radios name=$key options=$arrSex selected=$dead_sex_value|default:''}-->
                        </span>
                    </td>
                </tr>
                <tr>
                    <th class="alignL sp_title_01">生年月日</th>
                    <td class="alignL">
                        <!--{assign var=prefix value="dead_birth_"}-->
                        <!--{assign var=key1 value="`$prefix`koyomi_type"}-->
                        <!--{assign var=key2 value="`$prefix`year"}-->
                        <!--{assign var=key3 value="`$prefix`month"}-->
                        <!--{assign var=key4 value="`$prefix`day"}-->
                        <!--{assign var=errBirth value="`$arrErr.$key1``$arrErr.$key2``$arrErr.$key3``$arrErr.$key4`"}-->
                        <!--{if $errBirth}-->
                            <span class="attention"><!--{$errBirth}--></span>
                        <!--{/if}-->
                        <select name="<!--{$key1}-->" style="<!--{$errBirth|getErrorColor}-->">
                            <option value="" selected="">未選択</option>
                            <!--{* html_options options=$arrKoyomiType selected=$arrForm[$key1]|default:-1 *}-->
                            <!--{html_options options=$arrKoyomiType selected=$arrForm[$key1]}-->
                        </select>
                        <input type="text" class="w_20" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]|default:''}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;"  size="6" class="box6" />
                        年&nbsp;
                        <select name="<!--{$key3}-->" style="<!--{$errBirth|getErrorColor}-->">
                            <option value="" selected="">未選択</option>
                            <!--{* html_options options=$arrBirthMonth selected=$arrForm[$key3]|default:'' *}-->
                            <!--{html_options options=$arrBirthMonth selected=$arrForm[$key3]}-->
                        </select>月&nbsp;
                        <select name="<!--{$key4}-->" style="<!--{$errBirth|getErrorColor}-->">
                            <option value="" selected="">未選択</option>
                            <!--{* html_options options=$arrBirthDay selected=$arrForm[$key4]|default:'' *}-->
                            <!--{html_options options=$arrBirthDay selected=$arrForm[$key4]}-->
                        </select>日
                    </td>
                </tr>

                <tr>
                    <th class="alignL sp_title_01">死亡年月日</th>
                    <td class="alignL">
                        <!--{assign var=prefix value="dead_"}-->
                        <!--{assign var=key1 value="`$prefix`koyomi_type"}-->
                        <!--{assign var=key2 value="`$prefix`year"}-->
                        <!--{assign var=key3 value="`$prefix`month"}-->
                        <!--{assign var=key4 value="`$prefix`day"}-->
                        <!--{assign var=err value="`$arrErr.$key1``$arrErr.$key2``$arrErr.$key3``$arrErr.$key4`"}-->
                        <!--{if $err}-->
                            <span class="attention"><!--{$err}--></span>
                        <!--{/if}-->
                        <select name="<!--{$key1}-->" style="<!--{$err|getErrorColor}-->">
                            <option value="" selected="">未選択</option>
                            <!--{* html_options options=$arrKoyomiType selected=$arrForm[$key1]|default:-1 *}-->
                            <!--{html_options options=$arrKoyomiType selected=$arrForm[$key1]}-->
                        </select>
                        <input type="text" class="w_20" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]|default:''}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;"  size="6" class="box6" />
                        年&nbsp;
                        <select name="<!--{$key3}-->" style="<!--{$err|getErrorColor}-->">
                            <option value="" selected="">未選択</option>
                            <!--{* html_options options=$arrDeathMonth selected=$arrForm[$key3]|default:$current_month *}-->
                            <!--{html_options options=$arrDeathMonth selected=$arrForm[$key3]}-->
                        </select>月&nbsp;
                        <select name="<!--{$key4}-->" style="<!--{$err|getErrorColor}-->">
                            <option value="" selected="">未選択</option>
                            <!--{* html_options options=$arrDeathDay selected=$arrForm[$key4]|default:$current_day *}-->
                            <!--{html_options options=$arrDeathDay selected=$arrForm[$key4]}-->
                        </select>日

                        <!-- ============  死亡時刻 追加（死産児） ============== -->

                        <!--{if $sibou_time_Flg_v == ""}-->

                        <!--{assign var=death_time_H value="time_of_death_hour"}-->
                        <!--{assign var=death_time_M value="time_of_death_minutes"}-->

                        <!--{assign var=time_of_death_time_V value="time_of_death_time"}-->

                        <p style="margin: 10px 0;">
                        <span>
                        死亡時刻
                        </span>
                         <!--{*  死亡時刻  時間　*}-->
                        <span id="death_time_val_01">
                        <select name="<!--{$death_time_H}-->" id="time_of_death_hour" style="<!--{$arrErr[$death_time_H]|getErrorColor}-->">
                           
                            <!--{assign var=death_time_H_V value=$Arr_Yoyaku_Data[$death_time_H]}-->
                            <!--{html_options options=$arr_death_hour_TT selected=$death_time_H_V}-->
                        </select>
                             時
                        </span>

                          <!--{*  死亡時刻  分　*}-->
                        <span id="death_time_val_02">
                        <select name="<!--{$death_time_M}-->" id="time_of_death_minutes" style="<!--{$arrErr[$death_time_M]|getErrorColor}-->">
                            
                            <!--{assign var=death_time_M_V value=$Arr_Yoyaku_Data[$death_time_M]}-->
                            <!--{html_options options=$arr_death_minute_TT selected=$death_time_M_V}-->
                        </select>
                             分
                        </span>

                        <input type="hidden" name="time_of_death_time" id="time_of_death_time" class="w_80" name="<!--{$time_of_death_time_V}-->" id="time_of_death_free" value="<!--{$arrForm[$time_of_death_free_v]}-->" maxlength="12" size="12" class="box6" />
                        </p>

                         <p class="form_info_M">※ 死亡時刻が不明の場合は、死亡時刻から「時刻不明」を選択し、下記の入力ボックスへ大枠の時刻を入力してください。</p>

                        <p>
                        <span id="death_time_free_ed">
                        死亡時刻未定の入力
                        </span>
                        <span class="death_time_free">
                             <!--{assign var=time_of_death_free_v value="time_of_death_free"}-->
                             <input type="text" class="w_80" name="<!--{$time_of_death_free_v}-->" id="time_of_death_free" value="<!--{$arrForm[$time_of_death_free_v]}-->" maxlength="60" size="40" class="box6" />

                        </span>
                        </p>

                        <!--{elseif sibou_time_Flg_v == 1}-->

                          <!--{assign var=death_time_H value="time_of_death_hour"}-->
                        <!--{assign var=death_time_M value="time_of_death_minutes"}-->

                        <!--{assign var=time_of_death_time_V value="time_of_death_time"}-->

                        <p style="margin: 10px 0;">
                        <span>
                        死亡時刻
                        </span>
                         <!--{*  死亡時刻  時間　*}-->
                        <span id="death_time_val_01">
                        <select name="<!--{$death_time_H}-->" id="time_of_death_hour" style="<!--{$arrErr[$death_time_H]|getErrorColor}-->">
                           
                            <!--{assign var=death_time_H_V value=$death_first_time}-->
                            <!--{html_options options=$arr_death_hour_TT selected=$death_time_H_V}-->
                        </select>
                             時
                        </span>

                          <!--{*  死亡時刻  分　*}-->
                        <span id="death_time_val_02">
                        <select name="<!--{$death_time_M}-->" id="time_of_death_minutes" style="<!--{$arrErr[$death_time_M]|getErrorColor}-->">
                            
                            <!--{assign var=death_time_M_V value=$death_second_time}-->
                            <!--{html_options options=$arr_death_minute_TT selected=$death_time_M_V}-->
                        </select>
                             分
                        </span>

                        <input type="hidden" name="time_of_death_time" id="time_of_death_time" class="w_80" name="<!--{$time_of_death_time_V}-->" id="time_of_death_free" value="<!--{$GET_sibou_time_V}-->" maxlength="12" size="12" class="box6" />
                        </p>

                         <p class="form_info_M">※ 死亡時刻が不明の場合は、死亡時刻から「時刻不明」を選択し、下記の入力ボックスへ大枠の時刻を入力してください。</p>

                        <p>
                        <span id="death_time_free_ed">
                        死亡時刻未定の入力
                        </span>
                        <span class="death_time_free">
                             <!--{assign var=time_of_death_free_v value="time_of_death_free"}-->
                             <input type="text" class="w_80" name="<!--{$time_of_death_free_v}-->" id="time_of_death_free" value="<!--{$arrForm[$time_of_death_free_v]}-->" maxlength="60" size="40" class="box6" />

                        </span>
                        </p>

                        <!--{/if}-->


                        <!-- ============  死亡時刻 追加  END ============== -->

                    </td>
                </tr>

                <tr>
                    <th class="alignL sp_title_01">郵便番号</th>
                    <td class="alignL">
                        <!--{assign var=prefix value="dead_"}-->
                        <!--{assign var=key1 value="`$prefix`zip01"}-->
                        <!--{assign var=key2 value="`$prefix`zip02"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>
                        〒 <input id="yubin_number_11" type="number" class="w_15" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]|h}-->" maxlength="<!--{$smarty.const.ZIP01_LEN}-->" size="6" class="box6" style="ime-mode:disabled;<!--{$arrErr[$key1]|getErrorColor}-->;" />
                         - <input id="yubin_number_12" type="number" class="w_20" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]|h}-->" maxlength="<!--{$smarty.const.ZIP02_LEN}-->" size="6" class="box6" style="ime-mode:disabled;<!--{$arrErr[$key2]|getErrorColor}-->;" />

                        <span style="margin: 0px 10px;display: inline-block;">
                            <input type="button" id="sinsei_dead_btn" value="申請者と住所が同じ" />
                        </span>

                        <span>
                            <input type="button" value="郵便→住所" onClick="main.chkCode('dead_zip01');main.chkCode('dead_zip02');AjaxZip3.zip2addr('dead_zip01','dead_zip02','dead_address1','dead_address1');" />
                        </span>
                    </td>
                </tr>
                <tr>
                    <th class="alignL sp_title_01">住所</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="dead_address1"}-->
                        <!--{assign var=key2 value="dead_address2"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>
                        町名まで：<input type="text" class="w_60" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]}-->" maxlength="<!--{$smarty.const.MTEXT_LEN}-->" style="<!--{$arrErr[$key1]|getErrorColor}-->;" class="box240" />
                        <span style="margin-left:20px;"></span>
                        番地以降：<input type="text" class="w_60" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]}-->" maxlength="<!--{$smarty.const.MTEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;" class="box240" />
                    </td>
                </tr>

                <!-- 死亡場所（分娩場所）　追加 -->
                <tr>
                    <th class="alignL sp_title_01">分娩場所</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="death_place"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--></span>
                        <input type="text" class="w_80" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]}-->" maxlength="<!--{$smarty.const.MTEXT_LEN}-->" style="<!--{$arrErr[$key1]|getErrorColor}-->;width:70%;"  />
                    </td>
                </tr>
                <!-- 死亡場所（分娩場所）　追加 END -->

                <tr>
                    <th class="alignL sp_title_01">郵便番号（本籍）</th>
                    <td class="alignL">
                        <!--{assign var=prefix value="dead_honseki_"}-->
                        <!--{assign var=key1 value="`$prefix`zip01"}-->
                        <!--{assign var=key2 value="`$prefix`zip02"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>
                        〒 <input id="yubin_number_13" type="number" class="w_15" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]|h}-->" maxlength="<!--{$smarty.const.ZIP01_LEN}-->" size="6" class="box6" style="ime-mode:disabled;<!--{$arrErr[$key1]|getErrorColor}-->;" />
                         - <input id="yubin_number_14" type="number" class="w_20" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]|h}-->" maxlength="<!--{$smarty.const.ZIP02_LEN}-->" size="6" class="box6" style="ime-mode:disabled;<!--{$arrErr[$key2]|getErrorColor}-->;" />
                        
                        
                        <span style="margin: 0px 10px;display: inline-block;">
                            <input type="button" id="dead_honseki_btn" value="死亡者住所と本籍が同じ" />
                        </span>

                        <span>
                            <input type="button" value="郵便→住所" onClick="main.chkCode('dead_honseki_zip01');main.chkCode('dead_honseki_zip02');AjaxZip3.zip2addr('dead_honseki_zip01','dead_honseki_zip02','dead_honseki_address1','dead_honseki_address1');" />
                        </span>
                    </td>
                </tr>
                <tr>
                    <th class="alignL sp_title_01">本籍</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="dead_honseki_address1"}-->
                        <!--{assign var=key2 value="dead_honseki_address2"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>
                        町名まで：<input type="text" class="w_60" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]}-->" maxlength="<!--{$smarty.const.MTEXT_LEN}-->" style="<!--{$arrErr[$key1]|getErrorColor}-->;" class="box240" />
                        <span style="margin-left:20px;"></span>
                        番地以降：<input type="text" class="w_60" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]}-->" maxlength="<!--{$smarty.const.MTEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;" class="box240" />
                    </td>
                </tr>

                
                <!--{assign var=kaisou_num value="funeral_num"}-->
                <tr>       
                    <th class="alignL sp_title_01">会葬者数</th>    
                    <td class="alignL">
                            <input type="number" class="w_15" name="<!--{$kaisou_num}-->" value="<!--{$arrForm[$kaisou_num]}-->" maxlength="5" size="5" class="box6" />
                            人位
                    </td>
                </tr>
               
                <!--{assign var=nin_weeks_f_v value="nin_weeks_f"}-->
                <tr>
                    <th class="alignL sp_title_01">妊娠週数</th>
                    <td class="alignL">

                         週：
                        <select id="nin_weeks_f" name="<!--{$nin_weeks_f_v}-->" style="<!--{$err|getErrorColor}-->">
                            <option value="" selected="">未選択</option>
                        <!--{html_options options=$arr_Nin_Week_V value=$arr_Nin_Week_V}-->
                         </select>
                
                    </td>
                </tr>

                <!--{assign var=weight_f_v value="weight_f"}-->
                <tr>       
                    <th class="alignL sp_title_01">体重</th>    
                    <td class="alignL">
                            <input type="number" class="w_15" name="<!--{$weight_f_v}-->" value="<!--{$arrForm[$weight_f_v]}-->" maxlength="5" size="5" class="box6" />
                            g
                    </td>
                </tr>

                <!--{assign var=coffin_wifth_v value="coffin_wifth"}-->
                <!--{assign var=coffin_height_v value="coffin_height"}-->
                <!--{assign var=coffin_hei_v value="coffin_hei"}-->
                <tr>       
                    <th class="alignL sp_title_01">棺の大きさ ※標準以外はcmで記入</th>    
                    <td class="alignL">

                            <span>縦：
                                <input type="number" id="hitugi_04" class="w_20" name="<!--{$coffin_height_v}-->" value="<!--{$arrForm[$coffin_height_v]}-->" maxlength="8" size="8" class="box6" />
                            </span>

                            <span>横：
                                <input type="number" id="hitugi_05" class="w_20" name="<!--{$coffin_wifth_v}-->" value="<!--{$arrForm[$coffin_wifth_v]}-->" maxlength="8" size="8" class="box6" />
                            </span>

                            <span>高：
                                <input type="number" id="hitugi_06" class="w_20" name="<!--{$coffin_hei_v}-->" value="<!--{$arrForm[$coffin_hei_v]}-->" maxlength="8" size="8" class="box6" />
                            </span>

                    </td>
                </tr>
            </table>


<!--{elseif ($kasou_type == 2 && $Arr_Yoyaku_Data[$key2] == 2)}-->
   <table class="list_edit_03">
                <caption class="strong">■死産児情報</caption>
                <col width="25%" />
                <col width="75%" />

                  <tr>
                    <th class="alignL sp_title_01">父の氏名</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="kojinf_sei_f"}-->
                        <!--{assign var=key2 value="kojinf_mei_f"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>

                        <span class="edit_box_01">
                        姓：<input type="text" class="w_60" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key1]|getErrorColor}-->;" class="box30" />
                        </span>

                        <span class="edit_box_02">
                        　名：<input type="text" class="w_60" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;" class="box30" />
                        </span>
                          
                    </td>
                </tr>

                <tr>
                    <th class="alignL sp_title_01">父のカナ</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="kojinf_skana_f"}-->
                        <!--{assign var=key2 value="kojinf_mkana_f"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>

                        <span class="edit_box_01">
                        姓：<input type="text" class="w_60" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key1]|getErrorColor}-->;" class="box30" />
                        </span>

                        <span class="edit_box_02">
                        　名：<input type="text" class="w_60" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;" class="box30" />               
                        </span>

                    </td>
                </tr>

                <tr>
                    <th class="alignL sp_title_01">母の氏名</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="kojinm_sei_f"}-->
                        <!--{assign var=key2 value="kojinm_mei_f"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>

                        <span class="edit_box_01">
                        姓：<input type="text" class="w_60" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key1]|getErrorColor}-->;" class="box30" />
                        </span>

                        <span class="edit_box_02">
                        　名：<input type="text" class="w_60" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;" class="box30" />
                        </span>
                            
                    </td>
                </tr>

              
                 <tr>
                    <th class="alignL sp_title_01">母のカナ</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="kojinm_skana_f"}-->
                        <!--{assign var=key2 value="kojinm_mkana_f"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>

                        <span class="edit_box_01">
                        姓：<input type="text" class="w_60" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key1]|getErrorColor}-->;" class="box30" />
                        </span>

                        <span class="edit_box_02">
                        　名：<input type="text" class="w_60" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;" class="box30" />
                        </span>                    
                    </td>
                </tr>
           
                <tr>
                    <th class="alignL sp_title_01">性別</th>
                    <td class="alignL">
                        <!--{assign var=key value="dead_sex"}-->
                        <span class="attention"><!--{$arrErr[$key]}--></span>
                        <span style="<!--{$arrErr[$key]|getErrorColor}-->">
                            <!--{assign var=dead_sex_value value="`$arrForm[$key]`"}-->
                            <!--{* html_radios name=$key options=$arrSex selected=$arrForm[$key]|default:0 *}-->
                            <!--{html_radios name=$key options=$arrSex selected=$dead_sex_value|default:''}-->
                        </span>
                    </td>
                </tr>
                <tr>
                    <th class="alignL sp_title_01">生年月日</th>
                    <td class="alignL">
                        <!--{assign var=prefix value="dead_birth_"}-->
                        <!--{assign var=key1 value="`$prefix`koyomi_type"}-->
                        <!--{assign var=key2 value="`$prefix`year"}-->
                        <!--{assign var=key3 value="`$prefix`month"}-->
                        <!--{assign var=key4 value="`$prefix`day"}-->
                        <!--{assign var=errBirth value="`$arrErr.$key1``$arrErr.$key2``$arrErr.$key3``$arrErr.$key4`"}-->
                        <!--{if $errBirth}-->
                            <span class="attention"><!--{$errBirth}--></span>
                        <!--{/if}-->
                        <select name="<!--{$key1}-->" style="<!--{$errBirth|getErrorColor}-->">
                            <option value="" selected="">未選択</option>
                            <!--{* html_options options=$arrKoyomiType selected=$arrForm[$key1]|default:-1 *}-->
                            <!--{html_options options=$arrKoyomiType selected=$arrForm[$key1]}-->
                        </select>
                        <input type="text" class="w_20" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]|default:''}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;"  size="6" class="box6" />
                        年&nbsp;
                        <select name="<!--{$key3}-->" style="<!--{$errBirth|getErrorColor}-->">
                            <option value="" selected="">未選択</option>
                            <!--{* html_options options=$arrBirthMonth selected=$arrForm[$key3]|default:'' *}-->
                            <!--{html_options options=$arrBirthMonth selected=$arrForm[$key3]}-->
                        </select>月&nbsp;
                        <select name="<!--{$key4}-->" style="<!--{$errBirth|getErrorColor}-->">
                            <option value="" selected="">未選択</option>
                            <!--{* html_options options=$arrBirthDay selected=$arrForm[$key4]|default:'' *}-->
                            <!--{html_options options=$arrBirthDay selected=$arrForm[$key4]}-->
                        </select>日
                    </td>
                </tr>

                <tr>
                    <th class="alignL sp_title_01">死亡年月日</th>
                    <td class="alignL">
                        <!--{assign var=prefix value="dead_"}-->
                        <!--{assign var=key1 value="`$prefix`koyomi_type"}-->
                        <!--{assign var=key2 value="`$prefix`year"}-->
                        <!--{assign var=key3 value="`$prefix`month"}-->
                        <!--{assign var=key4 value="`$prefix`day"}-->
                        <!--{assign var=err value="`$arrErr.$key1``$arrErr.$key2``$arrErr.$key3``$arrErr.$key4`"}-->
                        <!--{if $err}-->
                            <span class="attention"><!--{$err}--></span>
                        <!--{/if}-->
                        <select name="<!--{$key1}-->" style="<!--{$err|getErrorColor}-->">
                            <option value="" selected="">未選択</option>
                            <!--{* html_options options=$arrKoyomiType selected=$arrForm[$key1]|default:-1 *}-->
                            <!--{html_options options=$arrKoyomiType selected=$arrForm[$key1]}-->
                        </select>
                        <input type="text" class="w_20" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]|default:''}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;"  size="6" class="box6" />
                        年&nbsp;
                        <select name="<!--{$key3}-->" style="<!--{$err|getErrorColor}-->">
                            <option value="" selected="">未選択</option>
                            <!--{* html_options options=$arrDeathMonth selected=$arrForm[$key3]|default:$current_month *}-->
                            <!--{html_options options=$arrDeathMonth selected=$arrForm[$key3]}-->
                        </select>月&nbsp;
                        <select name="<!--{$key4}-->" style="<!--{$err|getErrorColor}-->">
                            <option value="" selected="">未選択</option>
                            <!--{* html_options options=$arrDeathDay selected=$arrForm[$key4]|default:$current_day *}-->
                            <!--{html_options options=$arrDeathDay selected=$arrForm[$key4]}-->
                        </select>日

                        <!-- ============  死亡時刻 追加（死産児） ============== -->

                     <!--{if $sibou_time_Flg_v == ""}-->

                        <!--{assign var=death_time_H value="time_of_death_hour"}-->
                        <!--{assign var=death_time_M value="time_of_death_minutes"}-->

                        <!--{assign var=time_of_death_time_V value="time_of_death_time"}-->

                        <p style="margin: 10px 0;">
                        <span>
                        死亡時刻
                        </span>
                         <!--{*  死亡時刻  時間　*}-->
                        <span id="death_time_val_01">
                        <select name="<!--{$death_time_H}-->" id="time_of_death_hour" style="<!--{$arrErr[$death_time_H]|getErrorColor}-->">
                           
                            <!--{assign var=death_time_H_V value=$Arr_Yoyaku_Data[$death_time_H]}-->
                            <!--{html_options options=$arr_death_hour_TT selected=$death_time_H_V}-->
                        </select>
                             時
                        </span>

                          <!--{*  死亡時刻  分　*}-->
                        <span id="death_time_val_02">
                        <select name="<!--{$death_time_M}-->" id="time_of_death_minutes" style="<!--{$arrErr[$death_time_M]|getErrorColor}-->">
                            
                            <!--{assign var=death_time_M_V value=$Arr_Yoyaku_Data[$death_time_M]}-->
                            <!--{html_options options=$arr_death_minute_TT selected=$death_time_M_V}-->
                        </select>
                             分
                        </span>

                        <input type="hidden" name="time_of_death_time" id="time_of_death_time" class="w_80" name="<!--{$time_of_death_time_V}-->" id="time_of_death_free" value="<!--{$arrForm[$time_of_death_free_v]}-->" maxlength="12" size="12" class="box6" />
                        </p>

                         <p class="form_info_M">※ 死亡時刻が不明の場合は、死亡時刻から「時刻不明」を選択し、下記の入力ボックスへ大枠の時刻を入力してください。</p>

                        <p>
                        <span id="death_time_free_ed">
                        死亡時刻未定の入力
                        </span>
                        <span class="death_time_free">
                             <!--{assign var=time_of_death_free_v value="time_of_death_free"}-->
                             <input type="text" class="w_80" name="<!--{$time_of_death_free_v}-->" id="time_of_death_free" value="<!--{$arrForm[$time_of_death_free_v]}-->" maxlength="60" size="40" class="box6" />

                        </span>
                        </p>

                        <!--{else}-->

                        <!--{assign var=death_time_H value="time_of_death_hour"}-->
                        <!--{assign var=death_time_M value="time_of_death_minutes"}-->

                        <!--{assign var=time_of_death_time_V value="time_of_death_time"}-->

                        <p style="margin: 10px 0;">
                        <span>
                        死亡時刻
                        </span>
                         <!--{*  死亡時刻  時間　*}-->
                        <span id="death_time_val_01">
                        <select name="<!--{$death_time_H}-->" id="time_of_death_hour" style="<!--{$arrErr[$death_time_H]|getErrorColor}-->">
                           
                            <!--{assign var=death_time_H_V value=$death_first_time}-->
                            <!--{html_options options=$arr_death_hour_TT selected=$death_time_H_V}-->
                        </select>
                             時
                        </span>

                          <!--{*  死亡時刻  分　*}-->
                        <span id="death_time_val_02">
                        <select name="<!--{$death_time_M}-->" id="time_of_death_minutes" style="<!--{$arrErr[$death_time_M]|getErrorColor}-->">
                            
                            <!--{assign var=death_time_M_V value=$death_second_time}-->
                            <!--{html_options options=$arr_death_minute_TT selected=$death_time_M_V}-->
                        </select>
                             分
                        </span>

                        <input type="hidden" name="time_of_death_time" id="time_of_death_time" class="w_80" name="<!--{$time_of_death_time_V}-->" id="time_of_death_free" value="<!--{$GET_sibou_time_V}-->" maxlength="12" size="12" class="box6" />
                        </p>

                         <p class="form_info_M">※ 死亡時刻が不明の場合は、死亡時刻から「時刻不明」を選択し、下記の入力ボックスへ大枠の時刻を入力してください。</p>

                        <p>
                        <span id="death_time_free_ed">
                        死亡時刻未定の入力
                        </span>
                        <span class="death_time_free">
                             <!--{assign var=time_of_death_free_v value="time_of_death_free"}-->
                             <input type="text" class="w_80" name="<!--{$time_of_death_free_v}-->" id="time_of_death_free" value="<!--{$arrForm[$time_of_death_free_v]}-->" maxlength="60" size="40" class="box6" />

                        </span>
                        </p>

                        <!--{/if}-->


                        <!-- ============  死亡時刻 追加  END ============== -->

                    </td>
                </tr>

                <tr>
                    <th class="alignL sp_title_01">郵便番号</th>
                    <td class="alignL">
                        <!--{assign var=prefix value="dead_"}-->
                        <!--{assign var=key1 value="`$prefix`zip01"}-->
                        <!--{assign var=key2 value="`$prefix`zip02"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>
                        〒 <input id="yubin_number_15" type="number" class="w_15" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]|h}-->" maxlength="<!--{$smarty.const.ZIP01_LEN}-->" size="6" class="box6" style="ime-mode:disabled;<!--{$arrErr[$key1]|getErrorColor}-->;" />
                         - <input id="yubin_number_16" type="number" class="w_20" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]|h}-->" maxlength="<!--{$smarty.const.ZIP02_LEN}-->" size="6" class="box6" style="ime-mode:disabled;<!--{$arrErr[$key2]|getErrorColor}-->;" />

                        <span style="margin: 0px 10px;display: inline-block;">
                            <input type="button" id="sinsei_dead_btn" value="申請者と住所が同じ" />
                        </span>

                        <span>
                            <input type="button" value="郵便→住所" onClick="main.chkCode('dead_zip01');main.chkCode('dead_zip02');AjaxZip3.zip2addr('dead_zip01','dead_zip02','dead_address1','dead_address1');" />
                        </span>
                    </td>
                </tr>
                <tr>
                    <th class="alignL sp_title_01">住所</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="dead_address1"}-->
                        <!--{assign var=key2 value="dead_address2"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>
                        町名まで：<input type="text" class="w_60" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]}-->" maxlength="<!--{$smarty.const.MTEXT_LEN}-->" style="<!--{$arrErr[$key1]|getErrorColor}-->;" class="box240" />
                        <span style="margin-left:20px;"></span>
                        番地以降：<input type="text" class="w_60" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]}-->" maxlength="<!--{$smarty.const.MTEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;" class="box240" />
                    </td>
                </tr>

                <!-- 死亡場所（分娩場所）　追加 -->
                <tr>
                    <th class="alignL sp_title_01">分娩場所</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="death_place"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--></span>
                        <input type="text" class="w_80" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]}-->" maxlength="<!--{$smarty.const.MTEXT_LEN}-->" style="<!--{$arrErr[$key1]|getErrorColor}-->;width:70%;"  />
                    </td>
                </tr>
                <!-- 死亡場所（分娩場所）　追加 END -->

                <tr>
                    <th class="alignL sp_title_01">郵便番号（本籍）</th>
                    <td class="alignL">
                        <!--{assign var=prefix value="dead_honseki_"}-->
                        <!--{assign var=key1 value="`$prefix`zip01"}-->
                        <!--{assign var=key2 value="`$prefix`zip02"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>
                        〒 <input id="yubin_number_17" type="number" class="w_15" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]|h}-->" maxlength="<!--{$smarty.const.ZIP01_LEN}-->" size="6" class="box6" style="ime-mode:disabled;<!--{$arrErr[$key1]|getErrorColor}-->;" />
                         - <input id="yubin_number_18" type="number" class="w_20" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]|h}-->" maxlength="<!--{$smarty.const.ZIP02_LEN}-->" size="6" class="box6" style="ime-mode:disabled;<!--{$arrErr[$key2]|getErrorColor}-->;" />
                        
                        
                        <span style="margin: 0px 10px;display: inline-block;">
                            <input type="button" id="dead_honseki_btn" value="死亡者住所と本籍が同じ" />
                        </span>

                        <span>
                            <input type="button" value="郵便→住所" onClick="main.chkCode('dead_honseki_zip01');main.chkCode('dead_honseki_zip02');AjaxZip3.zip2addr('dead_honseki_zip01','dead_honseki_zip02','dead_honseki_address1','dead_honseki_address1');" />
                        </span>
                    </td>
                </tr>
                <tr>
                    <th class="alignL sp_title_01">本籍</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="dead_honseki_address1"}-->
                        <!--{assign var=key2 value="dead_honseki_address2"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--></span>
                        町名まで：<input type="text" class="w_60" name="<!--{$key1}-->" value="<!--{$arrForm[$key1]}-->" maxlength="<!--{$smarty.const.MTEXT_LEN}-->" style="<!--{$arrErr[$key1]|getErrorColor}-->;" class="box240" />
                        <span style="margin-left:20px;"></span>
                        番地以降：<input type="text" class="w_60" name="<!--{$key2}-->" value="<!--{$arrForm[$key2]}-->" maxlength="<!--{$smarty.const.MTEXT_LEN}-->" style="<!--{$arrErr[$key2]|getErrorColor}-->;" class="box240" />
                    </td>
                </tr>

                
                <!--{assign var=kaisou_num value="funeral_num"}-->
                <tr>       
                    <th class="alignL sp_title_01">会葬者数</th>    
                    <td class="alignL">
                            <input type="number" class="w_15" name="<!--{$kaisou_num}-->" value="<!--{$arrForm[$kaisou_num]}-->" maxlength="5" size="5" class="box6" />
                            人位
                    </td>
                </tr>
               
                <!--{assign var=nin_weeks_f_v value="nin_weeks_f"}-->
                <tr>
                    <th class="alignL sp_title_01">妊娠週数</th>
                    <td class="alignL">

                         週：
                        <select id="nin_weeks_f" name="<!--{$nin_weeks_f_v}-->" style="<!--{$err|getErrorColor}-->">
                            <option value="" selected="">未選択</option>
                        <!--{html_options options=$arr_Nin_Week_V value=$arr_Nin_Week_V}-->
                         </select>
                
                    </td>
                </tr>

                <!--{assign var=weight_f_v value="weight_f"}-->
                <tr>       
                    <th class="alignL sp_title_01">体重</th>    
                    <td class="alignL">
                            <input type="number" id="weight_f" class="w_15" name="<!--{$weight_f_v}-->" value="<!--{$arrForm[$weight_f_v]}-->" maxlength="5" size="5" class="box6" />
                            g
                    </td>
                </tr>

                <!--{assign var=coffin_wifth_v value="coffin_wifth"}-->
                <!--{assign var=coffin_height_v value="coffin_height"}-->
                <!--{assign var=coffin_hei_v value="coffin_hei"}-->
                <tr>       
                    <th class="alignL sp_title_01">棺の大きさ ※標準以外はcmで記入</th>    
                    <td class="alignL">

                            <span>縦：
                                <input type="number" id="hitugi_07" class="w_20" name="<!--{$coffin_height_v}-->" value="<!--{$arrForm[$coffin_height_v]}-->" maxlength="8" size="8" class="box6" />
                            </span>

                            <span>横：
                                <input type="number" id="hitugi_08" class="w_20" name="<!--{$coffin_wifth_v}-->" value="<!--{$arrForm[$coffin_wifth_v]}-->" maxlength="8" size="8" class="box6" />
                            </span>

                            <span>高：
                                <input type="number" id="hitugi_09" class="w_20" name="<!--{$coffin_hei_v}-->" value="<!--{$arrForm[$coffin_hei_v]}-->" maxlength="8" size="8" class="box6" />
                            </span>

                    </td>
                </tr>
            </table>

<!--{/if}-->




            <!-- 追加　前橋用 23_1130 夏目 -->
            <table class="list_edit_04">
                <caption class="strong">■詳細情報</caption>
                <col width="25%" />
                <col width="75%" />

                <!--{assign var=key value="room_type"}-->
                <tr>
                    <th class="alignL sp_title_01">待合室利用</th>
                    <td class="alignL">

                    <p class="form_info_M">※ 利用者をご入力の場合は、「利用する」にチェックを入れてからご入力ください。</p>
                      
                        <span class="attention"><!--{$arrErr[$key]}--></span>
                        <span style="<!--{$arrErr[$key]|getErrorColor}-->">
                            <!--{html_radios name="$key" class="$key" options=$arrRoomType selected=$arrForm[$key]|default:0}-->
                        </span>

                        <!--{assign var=room_type_num_v value="room_type_num"}-->
                        <!--{if $Ren_Machiai_riyou_F_v == 0}-->
                        <span id="room_type_num_span">
                            （利用者<input type="number" class="w_20" id="room_type_num" name="<!--{$room_type_num_v}-->" value="<!--{$arrForm[$room_type_num_v]}-->" maxlength="10" size="10" class="box6" />人位）
                        </span>
                        <!--{else}-->
                          <span id="room_type_num_span">
                            （利用者<input type="number" class="w_20" id="room_type_num" name="<!--{$room_type_num_v}-->" value="<!--{$Ren_Machiai_riyou_val}-->" maxlength="10" size="10" class="box6" />人位）
                        </span>
                        <!--{/if}-->



                        <!--{assign var=roby_type_num_v value="roby_type_num"}-->
                        <!--{if $Ren_Machiai_roby_F_v == 0}-->
                        <span id="roby_type_num_span">
                            （ロビー待ち<input type="number" class="w_20" id="roby_type_num" name="<!--{$roby_type_num_v}-->" value="<!--{$arrForm[$roby_type_num_v]}-->" maxlength="10" size="10" class="box6" />人位）
                        </span>
                        <!--{else}-->
                         <span id="roby_type_num_span">
                            （ロビー待ち<input type="number" class="w_20" id="roby_type_num" name="<!--{$roby_type_num_v}-->" value="<!--{$matche_roby_num_val}-->" maxlength="10" size="10" class="box6" />人位）
                        </span>
                        <!--{/if}-->

                        <!--{assign var=Machi_show_v value="Machi_show"}-->
                        <p style="margin: 15px 0 5px 0;">
                        <span id="room_big_size">
                        部屋の大きさ：
                        </span>

                        <!--{if $Ren_room_F_v == 1}-->
                            <span style="display:inline-block;">
                            <!--{html_radios name="$Machi_show_v" class="$Machi_show_v" options=$arrMatchi_room_s selected=$arrForm[$Machi_show_v]|default:1}-->
                            </span>
                        <!--{elseif $Ren_room_F_v == 2}-->
                            <span style="display:inline-block;">
                             <!--{html_radios name="$Machi_show_v" class="$Machi_show_v" options=$arrMatchi_room_s selected=$arrForm[$Machi_show_v]|default:2}-->
                            </span>
                        <!--{elseif $Ren_room_F_v == 3}-->
                             <span style="display:inline-block;">
                            <!--{html_radios name="$Machi_show_v" class="$Machi_show_v" options=$arrMatchi_room_s selected=$arrForm[$Machi_show_v]|default:3}-->
                            </span>
                        <!--{else}-->
                             <span style="display:inline-block;">
                            <!--{html_radios name="$Machi_show_v" class="$Machi_show_v" options=$arrMatchi_room_s selected=$arrForm[$Machi_show_v]|default:0}-->
                            </span>
                        <!--{/if}-->
                        </p>
                    </td>
                </tr>


                <!--{assign var=funeral_style_n value="funeral_style"}-->
                <!--{assign var=GET_yousiki_val value=$GET_yousiki_v}-->
               
                <tr>
                    <th class="alignL sp_title_01">様式</th>
                    <td class="alignL">

                        <p class="form_info_M">※ 選択項目に「様式」がない場合は「その他」をご選択して、右側のボックスへご入力ください。</p>
                      
                        <!--{if $Yousiki_Flg_v == ""}-->
                        <select id="funeral_style" name="<!--{$funeral_style_n}-->" style="<!--{$err|getErrorColor}-->">
                            <option value="" selected="">未選択</option>
                         <!--{html_options options=$arrSyuu_k_Val_v value=$arrSyuu_k_Val_v}-->
                         </select>

                        <!--{assign var=funeral_style_others_v value="funeral_style_others"}-->
                         <span style="margin-left:20px;">
                              <input type="text" class="w_60" id="funeral_style_others" name="<!--{$funeral_style_others_v}-->" value="<!--{$arrForm[$funeral_style_others_v]}-->" maxlength="50" size="20" class="box6" />
                         </span>

                         <!--{else}-->

                          <select id="funeral_style" name="<!--{$funeral_style_n}-->" style="<!--{$err|getErrorColor}-->">
                            <option value="">未選択</option>
                         <!--{html_options options=$arrSyuu_k_Val_v value=$arrSyuu_k_Val_v selected=$GET_yousiki_v}-->
                         </select>

                        <!--{assign var=funeral_style_others_v value="funeral_style_others"}-->
                         <span style="margin-left:20px;">
                              <input type="text" class="w_60" id="funeral_style_others" name="<!--{$funeral_style_others_v}-->" value="<!--{$Ren_Youshiki_val}-->" maxlength="50" size="20" class="box6" />
                         </span>

                         <!--{/if}-->

                    </td>
                </tr>

            

                <!--{assign var=temple_name_v value="temple_name"}-->
                <tr>
                    <th class="alignL sp_title_01">寺院名 等</th>
                    <td class="alignL">

                         <p class="form_info_M">※ 選択項目に「寺院名」がない場合は「その他」をご選択して、右側のボックスへご入力ください。</p>
                    

                        <!--{if $Ziin_Flg_v == ""}-->
                        <select id="temple_name" name="<!--{$temple_name_v}-->" style="<!--{$err|getErrorColor}-->">
                            <option value="" selected="">未選択</option>
                         <!--{html_options options=$arrZiin_val_v value=$arrZiin_val_v}-->
                         </select>

                         <!--{else}-->
                        <select id="temple_name" name="<!--{$temple_name_v}-->" style="<!--{$err|getErrorColor}-->">
                            <option value="">未選択</option>
                         <!--{html_options options=$arrZiin_val_v value=$arrZiin_val_v selected=$GET_ziin_v}-->
                         </select>

                         <!--{/if}-->
                         
                        <!--{if $Ziin_Flg_Text_v == ""}-->
                        <!--{assign var=temple_name_others_v value="temple_name_others"}-->
                         <span id="zinn_name_edit">
                              <input type="text" class="w_60" id="temple_name_others" name="<!--{$temple_name_others_v}-->" value="<!--{$arrForm[$temple_name_others_v]}-->" maxlength="50" size="20" class="box6" />
                         </span>
                        
                        <!--{else}-->
                          <span id="zinn_name_edit">
                              <input type="text" class="w_60" id="temple_name_others" name="<!--{$temple_name_others_v}-->" value="<!--{$GET_yousiki_v}-->" maxlength="50" size="20" class="box6" />
                         </span>

                        <!--{/if}-->
                        
                        <!--{assign var=kouro_kubun_v value="kouro_kubun"}-->
                         <span id="kouro_edit">
                         香炉：
                         </span>
                       
                         <!--{if $Ren_Kouro_F_v == 1}-->
                        <span style="display:inline-block;">
                         <!--{html_radios name="$kouro_kubun_v" options=$arrKouro selected=$arrForm[$Ren_Kouro_val]|default:1}-->
                         </span>

                         <!--{else}-->
                         <span style="display:inline-block;">
                         <!--{html_radios name="$kouro_kubun_v" options=$arrKouro selected=$arrForm[$Ren_Kouro_val]|default:0}-->
                         </span>
                         <!--{/if}-->

                    </td>
                </tr>

                <!--{assign var=key1 value="car_type"}-->
                <!--{assign var=key2 value="car_dtkb"}-->
                <!--{assign var=key3 value="car_time"}-->
                <tr>
                    <th class="alignL sp_title_01">霊柩車利用</th>
                    <td class="alignL">
                    
                       
                        <span class="attention"><!--{$arrErr[$key1]}--><!--{$arrErr[$key2]}--><!--{$arrErr[$key3]}--></span>
                        <span style="<!--{$arrErr[$key1]|getErrorColor}-->">
                            <!--{html_radios name="$key1" class="$key1" options=$arrCarType_Mae selected=$arrForm[$key1]|default:0}-->
                        </span>

                

                         <p class="form_info_M">※ 選択項目に「出棺場所」がない場合は「その他」をご選択して、右側のボックスへご入力ください。</p>

                       <!--{assign var=syukkan_place_v value="syukkan_place"}-->
                       <!--{assign var=syukkan_place_others_v value="syukkan_place_others"}-->

                       <!--{if $Syukann_Flg_v == ""}-->
                      <p>出棺場所：
                        <select id="syukkan_place" name="<!--{$syukkan_place_v}-->" style="<!--{$arrErr[$syukkan_place_v]|getErrorColor}-->">
                            <option value="" selected="">未選択</option>
                         <!--{html_options options=$arrSyukan_Place_v value=$arrSyukan_Place_v }-->
                         </select> 
                        <!--{else}-->
                        <p>出棺場所：
                        <select id="syukkan_place" name="<!--{$syukkan_place_v}-->" style="<!--{$arrErr[$syukkan_place_v]|getErrorColor}-->">
                            <option value="">未選択</option>
                         <!--{html_options options=$arrSyukan_Place_v value=$arrSyukan_Place_v selected=$GET_syukann_v}-->
                         </select> 
                        <!--{/if}-->

                      
                        <!--{if $Syukann_Flg_Text_v == ""}-->
                         <span style="margin-left:20px;">
                              <input type="text" class="w_60" id="syukkan_place_others" name="<!--{$syukkan_place_others_v}-->" value="<!--{$arrForm[$syukkan_place_others_v]}-->" maxlength="50" size="20" class="box6" />
                         </span>
                        <!--{else}-->
                        <span style="margin-left:20px;">
                              <input type="text" class="w_60" id="syukkan_place_others" name="<!--{$syukkan_place_others_v}-->" value="<!--{$GET_syukann_v}-->" maxlength="50" size="20" class="box6" />
                         </span>
                        <!--{/if}-->

                     </p>

                    </td>
                </tr>

                <tr>
                    <th class="alignL sp_title_01">備考</th>
                    <td class="alignL">
                               <!--{assign var=key1 value="yoyaku_biko_f"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--></span>
                        <textarea id="edit_bikou" name="<!--{$key1}-->" cols="50" rows="4" style="<!--{$arrErr[$key1]|getErrorColor}-->;"><!--{$arrForm[$key1]|h}--></textarea>
                    </td>
                </tr>


            </table>

            <table class="list_edit_05">
                <caption class="strong">■業者情報</caption>
                <col width="25%" />
                <col width="75%" />
                <tr>
                    <th class="alignL sp_title_01">担当者</th>
                    <td class="alignL"><!--{$stuff_name}--></td>
                </tr>
                <tr>
                    <th class="alignL sp_title_01">メールアドレス</th>
                    <td class="alignL"><!--{$stuff_mail}--></td>
                </tr>


                <tr>
                    <th class="alignL sp_title_01">連絡事項</th>
                    <td class="alignL">
                        <!--{assign var=key1 value="stuff_info"}-->
                        <span class="attention"><!--{$arrErr[$key1]}--></span>
                        <textarea id="edit_ranraku" name="<!--{$key1}-->" cols="50" rows="5" style="<!--{$arrErr[$key1]|getErrorColor}-->;"><!--{$arrForm[$key1]|h}--></textarea>
                    </td>
                </tr>
            </table>
            <div class="btn">
                <!--{if $mode == "reserve_entry" || $mode == "reserve_entry_r" || $mode == "entry_confirm"}-->
                    <a class="btn_default" href="javascript:;" onclick="main.setModeAndSubmit('form1', 'entry_confirm'); return false;">予約を登録する</a>
                <!--{elseif $mode == "reserve_edit" || $mode == "reserve_edit_r" || $mode == "edit_confirm" || $mode == "cancel_confirm"}-->
                    <a class="btn_default" href="javascript:;" onclick="main.setModeAndSubmit('form1', 'edit_confirm'); return false;">予約を変更する</a>
                    <a class="btn_default" href="javascript:;" onclick="main.setModeAndSubmit('form1', 'cancel_confirm'); return false;">予約を取消する</a>    
                <!--{/if}-->
            </div>
        <!--{/if}-->
        </form>
    </div>
    <!--{* ▲MAIN部 *}-->
    <!--{* ▲HEADER *}-->
    <!--{* ▼FOOTER *}-->

    <div id="footer">
        <!--{include file=$footer_tpl}-->
    </div>
    <!--{* ▲FOOTER *}-->


 <script>

(function($){
    $(document).ready(function(){

    var edit_ranraku = $('#edit_ranraku').val();

    if(edit_ranraku.indexOf('様式:') !== -1) {
        console.log('含まれている');
    } else {
        console.log('含まれていない');
    }

});

})(jQuery);

</script>

 <script>

(function($){
    $(document).ready(function(){
    
    var stuff_infoValue = $('textarea[name="stuff_info"]');

    function removeStringFromStuffInfo(targetString) {
            var currentValue = stuff_infoValue.val();
            var newValue = currentValue.replace(targetString, '');
            stuff_infoValue.val(newValue);
        }

    function addStringToStuffInfo(newString) {

            var currentValue = stuff_infoValue.val();
            var newValue = currentValue + newString;
            stuff_infoValue.val(newValue);
        }

    $("#funeral_style").change(function(){
        var value = $("#funeral_style_others").val(); 
        if (value !== 10) {
            removeStringFromStuffInfo("様式：" + value + "\n");
             $("#funeral_style_others").val(""); 
        }
    });

    $("#funeral_style_others").blur(function(){
        var value = $(this).val(); 
        if (value !== "") {
           
           addStringToStuffInfo("様式：" + value + "\n");
        } else {
            
           removeStringFromStuffInfo("様式：" + value + "\n");
        }
    });
});

})(jQuery);

</script>


<!-- ============  追加　夏目（前橋） 喪主  =============== -->
<script>

(function($){
    $(document).ready(function(){
    
        $('#mosyu_text').prop('disabled', true);

        var stuff_infoValue = $('textarea[name="stuff_info"]');

        function removeStringFromStuffInfo(targetString) {
            var currentValue = stuff_infoValue.val();
            var newValue = currentValue.replace(targetString, '');
            stuff_infoValue.val(newValue);
        }

        function addStringToStuffInfo(newString) {

            var currentValue = stuff_infoValue.val();
            var newValue = currentValue + newString;
            stuff_infoValue.val(newValue);
        }

      

         $('input[name="mosyu_select"]').change(function(){

            var selectedValue = $(this).val();

            if(selectedValue == 0) {
                $('#mosyu_text').prop('disabled', true);

                removeStringFromStuffInfo("喪主：" + $('#mosyu_text').val() + "\n");
                $('#mosyu_text').val("");

            } else {
                $('#mosyu_text').prop('disabled', false);
            }

         });


         $('#mosyu_text').blur(function(){

            console.log("mosyu_select 1:::" + $('#mosyu_text').val());
            addStringToStuffInfo("喪主：" + $('#mosyu_text').val() + "\n");

         });

});

})(jQuery);

</script>

<!-- ============  追加　夏目（前橋） 死亡時刻の 時間, 分, を db保存用パラメーターの input に入れる  =============== -->
<script>

(function($){
    $(document).ready(function(){

        var time_of_death_free = $('#time_of_death_free');

        time_of_death_free.prop('disabled', true);
        $('#time_of_death_hour').prop('disabled', false);
        $('#time_of_death_minutes').prop('disabled', false);

        if ($('#time_of_death_time').val() === "") {
            var hour_r = $('#time_of_death_hour').val();
            var minute_r = $('#time_of_death_minutes').val();
            var time_of_death_r = hour_r + minute_r;
            $('#time_of_death_time').val(time_of_death_r);
        }
      

        $('#time_of_death_hour, #time_of_death_minutes').blur(function() {
       
            var hour = $('#time_of_death_hour').val();
            var minute = $('#time_of_death_minutes').val();
      
            var time_of_death = hour + minute;

            console.log("hour:::" + hour);
            console.log("minute:::" + minute);

            if (hour === "時刻不明" || minute === "時刻不明") {
                time_of_death_free.prop('disabled', false);
                $('#time_of_death_hour').prop('disabled', true);
                $('#time_of_death_minutes').prop('disabled', true);

                hour = "";
                minute = "";
                time_of_death = "";

                console.log("if 内 hour:::" + hour);
                console.log("if 内 minute:::" + minute);

                $('#time_of_death_time').val(time_of_death);

            } else {
                time_of_death_free.prop('disabled', true);
                $('#time_of_death_hour').prop('disabled', false);
                $('#time_of_death_minutes').prop('disabled', false);

                $('#time_of_death_free').val("");

                time_of_death = hour + minute;
                $('#time_of_death_time').val(time_of_death);
               

            }

            time_of_death = hour + minute;
            $('#time_of_death_time').val(time_of_death);

    });

     $('#time_of_death_free').blur(function() {

        var time_of_death_free_val = $('#time_of_death_free').val();
        
        if(time_of_death_free_val === "") {
             time_of_death_free.prop('disabled', true);
             $('#time_of_death_hour').prop('disabled', false);
             $('#time_of_death_minutes').prop('disabled', false);
        } 

    });
 

});

})(jQuery);

</script>

<!-- ============  追加　夏目（前橋）　入力制限 棺の大きさ  =============== -->



<script>
document.getElementById("weight_f").addEventListener("input", function() {
  if (this.value.length > 7) {
    this.value = this.value.slice(0, 7);
  }
});
</script>


<script>
document.getElementById("hitugi_01").addEventListener("input", function() {
  if (this.value.length > 3) {
    this.value = this.value.slice(0, 3);
  }
});
</script>

<script>
document.getElementById("hitugi_02").addEventListener("input", function() {
  if (this.value.length > 3) {
    this.value = this.value.slice(0, 3);
  }
});
</script>

<script>
document.getElementById("hitugi_03").addEventListener("input", function() {
  if (this.value.length > 3) {
    this.value = this.value.slice(0, 3);
  }
});
</script>

<script>
document.getElementById("hitugi_04").addEventListener("input", function() {
  if (this.value.length > 3) {
    this.value = this.value.slice(0, 3);
  }
});
</script>

<script>
document.getElementById("hitugi_05").addEventListener("input", function() {
  if (this.value.length > 3) {
    this.value = this.value.slice(0, 3);
  }
});
</script>

<script>
document.getElementById("hitugi_06").addEventListener("input", function() {
  if (this.value.length > 3) {
    this.value = this.value.slice(0, 3);
  }
});
</script>

<script>
document.getElementById("hitugi_07").addEventListener("input", function() {
  if (this.value.length > 3) {
    this.value = this.value.slice(0, 3);
  }
});
</script>

<script>
document.getElementById("hitugi_08").addEventListener("input", function() {
  if (this.value.length > 3) {
    this.value = this.value.slice(0, 3);
  }
});
</script>

<script>
document.getElementById("hitugi_09").addEventListener("input", function() {
  if (this.value.length > 3) {
    this.value = this.value.slice(0, 3);
  }
});
</script>

<!-- ============  追加　夏目（前橋）　入力制限 死亡時年齢  =============== -->
<script>
document.getElementById("Age_at_Death").addEventListener("input", function() {
  if (this.value.length > 3) {
    this.value = this.value.slice(0, 3);
  }
});
</script>

<!-- ============  追加　夏目（前橋）　入力制限 電話番号  =============== -->
<script>
document.getElementById("ren_tel_01").addEventListener("input", function() {
  if (this.value.length > 4) {
    this.value = this.value.slice(0, 4);
  }
});
</script>

<script>
document.getElementById("ren_tel_02").addEventListener("input", function() {
  if (this.value.length > 4) {
    this.value = this.value.slice(0, 4);
  }
});
</script>

<script>
document.getElementById("ren_tel_03").addEventListener("input", function() {
  if (this.value.length > 4) {
    this.value = this.value.slice(0, 4);
  }
});
</script>

<script>
document.getElementById("ren_tel_04").addEventListener("input", function() {
  if (this.value.length > 4) {
    this.value = this.value.slice(0, 4);
  }
});
</script>

<script>
document.getElementById("ren_tel_05").addEventListener("input", function() {
  if (this.value.length > 4) {
    this.value = this.value.slice(0, 4);
  }
});
</script>

<script>
document.getElementById("ren_tel_06").addEventListener("input", function() {
  if (this.value.length > 4) {
    this.value = this.value.slice(0, 4);
  }
});
</script>

<script>
document.getElementById("ren_tel_07").addEventListener("input", function() {
  if (this.value.length > 4) {
    this.value = this.value.slice(0, 4);
  }
});
</script>

<script>
document.getElementById("ren_tel_08").addEventListener("input", function() {
  if (this.value.length > 4) {
    this.value = this.value.slice(0, 4);
  }
});
</script>

<script>
document.getElementById("ren_tel_09").addEventListener("input", function() {
  if (this.value.length > 4) {
    this.value = this.value.slice(0, 4);
  }
});
</script>

<!-- ============  追加　夏目（前橋）　入力制限 郵便番号  =============== -->
<script>
document.getElementById("yubin_number_01").addEventListener("input", function() {
  if (this.value.length > 3) {
    this.value = this.value.slice(0, 3);
  }
});
</script>

<script>
document.getElementById("yubin_number_03").addEventListener("input", function() {
  if (this.value.length > 3) {
    this.value = this.value.slice(0, 3);
  }
});
</script>

<script>
document.getElementById("yubin_number_05").addEventListener("input", function() {
  if (this.value.length > 3) {
    this.value = this.value.slice(0, 3);
  }
});
</script>

<script>
document.getElementById("yubin_number_02").addEventListener("input", function() {
  if (this.value.length > 4) {
    this.value = this.value.slice(0, 4);
  }
});
</script>

<script>
document.getElementById("yubin_number_04").addEventListener("input", function() {
  if (this.value.length > 4) {
    this.value = this.value.slice(0, 4);
  }
});
</script>

<script>
document.getElementById("yubin_number_06").addEventListener("input", function() {
  if (this.value.length > 4) {
    this.value = this.value.slice(0, 4);
  }
});

</script>

<script>
document.getElementById("yubin_number_07").addEventListener("input", function() {
  if (this.value.length > 3) {
    this.value = this.value.slice(0, 3);
  }
});
</script>

<script>
document.getElementById("yubin_number_08").addEventListener("input", function() {
  if (this.value.length > 4) {
    this.value = this.value.slice(0, 4);
  }
});

</script>

<script>
document.getElementById("yubin_number_09").addEventListener("input", function() {
  if (this.value.length > 3) {
    this.value = this.value.slice(0, 3);
  }
});
</script>

<script>
document.getElementById("yubin_number_10").addEventListener("input", function() {
  if (this.value.length > 4) {
    this.value = this.value.slice(0, 4);
  }
});

</script>

<script>
document.getElementById("yubin_number_11").addEventListener("input", function() {
  if (this.value.length > 3) {
    this.value = this.value.slice(0, 3);
  }
});
</script>

<script>
document.getElementById("yubin_number_12").addEventListener("input", function() {
  if (this.value.length > 4) {
    this.value = this.value.slice(0, 4);
  }
});

</script>

<script>
document.getElementById("yubin_number_13").addEventListener("input", function() {
  if (this.value.length > 3) {
    this.value = this.value.slice(0, 3);
  }
});
</script>

<script>
document.getElementById("yubin_number_14").addEventListener("input", function() {
  if (this.value.length > 4) {
    this.value = this.value.slice(0, 4);
  }
});

</script>

<script>
document.getElementById("yubin_number_15").addEventListener("input", function() {
  if (this.value.length > 3) {
    this.value = this.value.slice(0, 3);
  }
});
</script>

<script>
document.getElementById("yubin_number_16").addEventListener("input", function() {
  if (this.value.length > 4) {
    this.value = this.value.slice(0, 4);
  }
});

</script>

<script>
document.getElementById("yubin_number_17").addEventListener("input", function() {
  if (this.value.length > 3) {
    this.value = this.value.slice(0, 3);
  }
});
</script>

<script>
document.getElementById("yubin_number_18").addEventListener("input", function() {
  if (this.value.length > 4) {
    this.value = this.value.slice(0, 4);
  }
});

</script>


<!-- ============  追加　夏目（前橋）　霊安室 時間 , 日時 =============== -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>

<script type="text/javascript">

(function($) {
    $(document).ready(function() {

        $("#reian_day_01").datepicker({
            buttonText: "日付を選択", 
            showOn: "both" 
        });

         $("#reian_day_02").datepicker({
            buttonText: "日付を選択", 
            showOn: "both" 
        });
 
  $.datepicker.regional['ja'] = {
    closeText: '閉じる',
    prevText: '<前',
    nextText: '次>',
    currentText: '今日',
    monthNames: ['1月','2月','3月','4月','5月','6月',
    '7月','8月','9月','10月','11月','12月'],
    monthNamesShort: ['1月','2月','3月','4月','5月','6月',
    '7月','8月','9月','10月','11月','12月'],
    dayNames: ['日曜日','月曜日','火曜日','水曜日','木曜日','金曜日','土曜日'],
    dayNamesShort: ['日','月','火','水','木','金','土'],
    dayNamesMin: ['日','月','火','水','木','金','土'],
    weekHeader: '週',
    dateFormat: 'yy年mm月dd日',
    firstDay: 0,
    isRTL: false,
    showMonthAfterYear: true,
    yearSuffix: '年'};
  $.datepicker.setDefaults($.datepicker.regional['ja']);

});

})(jQuery);


</script>

<!-- ============ 24_0221 追加　夏目（前橋）　喪主追加 ============== -->
<script type="text/javascript">

(function($){
    $(document).ready(function(){

        
        var reian_text = $('#reian_text');
        var reian_text_02 = $('#reian_text_02');

        var reian_day_01 = $('#reian_day_01');
        var reian_day_02 = $('#reian_day_02');

        var reian_time_01 = $('#reian_time_01');
        var reian_time_02 = $('#reian_time_02');

        reian_text.hide();
        reian_text_02.hide();

        var stuff_infoValue = $('textarea[name="stuff_info"]');


        function removeStringFromStuffInfo(targetString) {
            var currentValue = stuff_infoValue.val();
            var newValue = currentValue.replace(targetString, '');
            stuff_infoValue.val(newValue);
        }

        function addStringToStuffInfo(newString) {

            var currentValue = stuff_infoValue.val();
            var newValue = currentValue + newString;
            stuff_infoValue.val(newValue);
        }

        $('input[name="reian_kubun_f"]').change(function(){

            var reian_kubun_f_val = $(this).val();

            if(reian_kubun_f_val == 0) {
                reian_text.hide();
                reian_text_02.hide();

                removeStringFromStuffInfo("霊安室利用：" + reian_day_01.val() + reian_time_01.val() + "時 - " + reian_day_02.val() + reian_time_02.val() + "時" + "\n");
            } else {
                reian_text.show();
                reian_text_02.show();
            }

        });

        reian_day_01.on('change', function(){
            var select_value = $('input[name="reian_kubun_f"]:checked').val();

             removeStringFromStuffInfo("霊安室利用：" + reian_day_01.val() + reian_time_01.val() + "時 - " + reian_day_02.val() + reian_time_02.val() + "時" + "\n");

            console.log("霊安室利用:a_01");
            console.log("霊安室利用：" + reian_day_01.val() + "から" + reian_day_02.val() + "\n");

            if(select_value == 1) {

                    if(reian_day_01.val() != "" && reian_day_02.val() != "" && reian_time_01.val() != "" && reian_time_02.val() != "") {
                        removeStringFromStuffInfo("霊安室利用：" + reian_day_01.val() + reian_time_01.val() + "時 - " + reian_day_02.val() + reian_time_02.val() + "時" + "\n");
                        addStringToStuffInfo("霊安室利用：" + reian_day_01.val() + reian_time_01.val() + "時 - " + reian_day_02.val() + reian_time_02.val()  + "時" + "\n");
                    
                        console.log("霊安室利用:01");
                    }
                  
            } else {
                     removeStringFromStuffInfo("霊安室利用：" + reian_day_01.val() + reian_time_01.val() + "時 - " + reian_day_02.val() + reian_time_02.val() + "時" + "\n");
                    console.log("霊安室利用:02");
            }

        });

        reian_day_02.on('change', function(){
            var select_value = $('input[name="reian_kubun_f"]:checked').val();

             removeStringFromStuffInfo("霊安室利用：" + reian_day_01.val() + reian_time_01.val() + "時 - " + reian_day_02.val() + reian_time_02.val() + "時" + "\n");

            console.log("霊安室利用:b_01");
            console.log("霊安室利用：" + reian_day_01.val() + reian_time_01.val() + "から" + reian_day_02.val()  + "\n");

            if(select_value == 1) {

                    if(reian_day_01.val() != "" && reian_day_02.val() != "" && reian_time_01.val() != "" && reian_time_02.val() != "") {
                         removeStringFromStuffInfo("霊安室利用：" + reian_day_01.val() + reian_time_01.val() + "時 - " + reian_day_02.val() + reian_time_02.val() + "時" + "\n");
                        addStringToStuffInfo("霊安室利用：" + reian_day_01.val() + reian_time_01.val() + "時 - " + reian_day_02.val() + reian_time_02.val()  + "時" + "\n");
                    
                        console.log("霊安室利用:03");
                    }
               
            } else {
                      removeStringFromStuffInfo("霊安室利用：" + reian_day_01.val() + reian_time_01.val() + "時 - " + reian_day_02.val() + reian_time_02.val() + "時" + "\n");
                    console.log("霊安室利用:04");
            }

        });

         reian_time_01.on('change', function(){
            var select_value = $('input[name="reian_kubun_f"]:checked').val();

             removeStringFromStuffInfo("霊安室利用：" + reian_day_01.val() + reian_time_01.val() + "時 - " + reian_day_02.val() + reian_time_02.val() + "時" + "\n");

            console.log("霊安室利用:b_01");
            console.log("霊安室利用：" + reian_day_01.val() + reian_time_01.val() + "から" + reian_day_02.val()  + "\n");

            if(select_value == 1) {

                    if(reian_day_01.val() != "" && reian_day_02.val() != "" && reian_time_01.val() != "" && reian_time_02.val() != "") {
                         removeStringFromStuffInfo("霊安室利用：" + reian_day_01.val() + reian_time_01.val() + "時 - " + reian_day_02.val() + reian_time_02.val() + "時" + "\n");
                       addStringToStuffInfo("霊安室利用：" + reian_day_01.val() + reian_time_01.val() + "時 - " + reian_day_02.val() + reian_time_02.val()  + "時" + "\n");
                    
                        console.log("霊安室利用:03");
                    }
               
            } else {
                     removeStringFromStuffInfo("霊安室利用：" + reian_day_01.val() + reian_time_01.val() + "時 - " + reian_day_02.val() + reian_time_02.val() + "時" + "\n");
                    console.log("霊安室利用:04");
            }

        });

          reian_time_02.on('change', function(){
            var select_value = $('input[name="reian_kubun_f"]:checked').val();

             removeStringFromStuffInfo("霊安室利用：" + reian_day_01.val() + reian_time_01.val() + "時 - " + reian_day_02.val() + reian_time_02.val() + "時" + "\n");

            console.log("霊安室利用:b_01");
            console.log("霊安室利用：" + reian_day_01.val() + reian_time_01.val() + "から" + reian_day_02.val()  + "\n");

            if(select_value == 1) {

                    if(reian_day_01.val() != "" && reian_day_02.val() != "" && reian_time_01.val() != "" && reian_time_02.val() != "") {
                         removeStringFromStuffInfo("霊安室利用：" + reian_day_01.val() + reian_time_01.val() + "時 - " + reian_day_02.val() + reian_time_02.val() + "時" + "\n");
                       addStringToStuffInfo("霊安室利用：" + reian_day_01.val() + reian_time_01.val() + "時 - " + reian_day_02.val() + reian_time_02.val()  + "時" + "\n");
                    
                        console.log("霊安室利用:03");
                    }
               
            } else {
                    removeStringFromStuffInfo("霊安室利用：" + reian_day_01.val() + reian_time_01.val() + "時 - " + reian_day_02.val() + reian_time_02.val() + "時" + "\n");
                    console.log("霊安室利用:04");
            }

        });


    });

})(jQuery);

</script>


<!-- ============ 24_0209 追加　夏目（前橋）　スマホ用対応 ============== -->
<script type="text/javascript">

(function($){
    $(document).ready(function(){

    if ($(window).width() <= 768) {
        $('table.list_edit col').remove();
        $('table.list_edit_02 col').remove();
        $('table.list_edit_03 col').remove();
        $('table.list_edit_04 col').remove();
        $('table.list_edit_05 col').remove();
        
    } else {
        $('table.list_edit').find('col').remove();

        $('table.list_edit').prepend('<col width="25%"><col width="75%">');
        $('table.list_edit_02').prepend('<col width="25%"><col width="75%">');
        $('table.list_edit_03').prepend('<col width="25%"><col width="75%">');
        $('table.list_edit_04').prepend('<col width="25%"><col width="75%">');
        $('table.list_edit_05').prepend('<col width="25%"><col width="75%">');

    }

});

})(jQuery);

</script>

<!-- ============  追加　夏目（前橋）　申請者の住所を、死亡者に入れる =============== -->
<script type="text/javascript">

(function($){
    $(document).ready(function(){

        $('#dead_honseki_btn').on('click', function(){

            var dead_zip01_val = $('input[name="dead_zip01"]').val();
            var dead_zip02_val = $('input[name="dead_zip02"]').val();
            var dead_address1_val = $('input[name="dead_address1"]').val();
            var dead_address2_val = $('input[name="dead_address2"]').val();
          
            $('input[name="dead_honseki_zip01"]').val(dead_zip01_val);
            $('input[name="dead_honseki_zip02"]').val(dead_zip02_val);
            $('input[name="dead_honseki_address1"]').val(dead_address1_val);
            $('input[name="dead_honseki_address2"]').val(dead_address2_val);
        });
     });

})(jQuery);
</script>

<!-- ============  追加　夏目（前橋）　申請者の住所を、死亡者に入れる =============== -->
<script type="text/javascript">

(function($){
    $(document).ready(function(){

        var applicant_zip01 = $('input[name="applicant_zip01"]');
        var applicant_zip02 = $('input[name="applicant_zip02"]');
        var applicant_address1 = $('input[name="applicant_address1"]');
        var applicant_address2 = $('input[name="applicant_address2"]');

        $('input[name="applicant_zip01"], input[name="applicant_zip02"], input[name="applicant_address1"], input[name="applicant_address2"]').on('change', function(){
            
            applicant_zip01_val = $('input[name="applicant_zip01"]').val();
            applicant_zip02_val = $('input[name="applicant_zip02"]').val();
            applicant_address1_val = $('input[name="applicant_address1"]').val();
            applicant_address2_val = $('input[name="applicant_address2"]').val();
        });

        $('#sinsei_dead_btn').on('click', function(){

            applicant_zip01_val = $('input[name="applicant_zip01"]').val();
            applicant_zip02_val = $('input[name="applicant_zip02"]').val();
            applicant_address1_val = $('input[name="applicant_address1"]').val();
            applicant_address2_val = $('input[name="applicant_address2"]').val();
          
            $('input[name="dead_zip01"]').val(applicant_zip01_val);
            $('input[name="dead_zip02"]').val(applicant_zip02_val);
            $('input[name="dead_address1"]').val(applicant_address1_val);
            $('input[name="dead_address2"]').val(applicant_address2_val);
        });
     });
})(jQuery);

</script>

<!-- ============  追加　夏目（前橋）　待合室・ロビー　=============== -->
<script type="text/javascript">

(function($) {
    $(document).ready(function() {

        var Fnc_idx = 0;

        var romm_type_val = $('input[name="room_type"]:checked').val();
        if(romm_type_val == 0) {
            $('#roby_type_num_span').show();
            $('#room_type_num_span').hide();
        } else {
            $('#roby_type_num_span').hide();
            $('#room_type_num_span').show();
        }

        var Machi_show_val = $('input[name="Machi_show"]:checked').val();
        console.log("部屋:::" + Machi_show_val);
         $('input[name="Machi_show"]').each(function() {
            if ($(this).val() === Machi_show_val) {
                $(this).prop('checked', true);
            } else {
                $(this).prop('checked', false);
            }
        });

        var room_type_num = $('#room_type_num');
        var roby_type_num = $('#roby_type_num');

        var stuff_infoValue = $('textarea[name="stuff_info"]');

        function removeStringFromStuffInfo(targetString) {
            var currentValue = stuff_infoValue.val();
            var newValue = currentValue.replace(targetString, '');
            stuff_infoValue.val(newValue);
        }

        function addStringToStuffInfo(newString) {
            var currentValue = stuff_infoValue.val();
            var newValue = currentValue + newString;
            stuff_infoValue.val(newValue);
        }

       function updateStuffInfo() {
            var currentValue = stuff_infoValue.val();

            if ($('#room_type_num_span').is(':visible')) {
                removeStringFromStuffInfo("ロビー待合せ：（" + roby_type_num.val() + "）人位" + "\n");
                removeStringFromStuffInfo("利用者：（" + room_type_num.val() + "）人位" + "\n");

                addStringToStuffInfo("利用者：（" + room_type_num.val() + "）人位" + "\n");
            } else {
                removeStringFromStuffInfo("利用者：（" + room_type_num.val() + "）人位" + "\n");
                removeStringFromStuffInfo("ロビー待合せ：（" + roby_type_num.val() + "）人位" + "\n");

                addStringToStuffInfo("ロビー待合せ：（" + roby_type_num.val() + "）人位" + "\n");
            }
        }
    

        if(Fnc_idx === 0) {
                roby_type_num.on('change', function(){
                updateStuffInfo();

                console.log("１：" + Fnc_idx);
             });
        } else {

        }

        $('.room_type').on('change', function() {
            if ($(this).val() === '0') {

                Fnc_idx = 1;
            
                $('#room_type_num_span').hide();
                $('#roby_type_num_span').show();

                $('input[name="Machi_show"]').prop('disabled', false);
                $('input[name="Machi_show"][value="0"]').prop('checked', true);
                $('input[name="Machi_show"]').not('[value="0"]').prop('disabled', true);

                removeStringFromStuffInfo("利用者：（" + room_type_num.val() + "）人位" + "\n");

                removeStringFromStuffInfo("部屋の大きさ：" + "小部屋（48人）" + "\n");
                removeStringFromStuffInfo("部屋の大きさ：" + "大部屋（64人）" + "\n");
                removeStringFromStuffInfo("部屋の大きさ：" + "2室連結" + "\n");

                roby_type_num.on('change', function(){
                    updateStuffInfo();
                    Fnc_idx = 1;
                    console.log("５：" + Fnc_idx);
                });

            } else if ($(this).val() === '1') {

                Fnc_idx = 1;
                console.log("３：" + Fnc_idx);
                $('#room_type_num_span').show();
                $('#roby_type_num_span').hide();

                $('input[name="Machi_show"]').prop('disabled', false);
                $('input[name="Machi_show"][value="0"]').prop('disabled', false);
                $('input[name="Machi_show"][value="0"]').prop('checked', true);

                removeStringFromStuffInfo("ロビー待合せ：（" + roby_type_num.val() + "）人位" + "\n");

                room_type_num.on('change', function(){
                    updateStuffInfo();
                    Fnc_idx = 1;
                    console.log("４：" + Fnc_idx);
                });
                
                 $("input[name='Machi_show']").off('change');

                $("input[name='Machi_show']").change(function(){
                    
                    var selectedValue = $("input[name='Machi_show']:checked").val();

                    if(selectedValue == 1) {
                            removeStringFromStuffInfo("部屋の大きさ：" + "大部屋（64人）" + "\n");
                            removeStringFromStuffInfo("部屋の大きさ：" + "2室連結" + "\n");

                            addStringToStuffInfo("部屋の大きさ：" + "小部屋（48人）" + "\n");
                            console.log("選択された値: " + selectedValue);
                    } else if(selectedValue == 2) {
                            removeStringFromStuffInfo("部屋の大きさ：" + "小部屋（48人）" + "\n");
                            removeStringFromStuffInfo("部屋の大きさ：" + "2室連結" + "\n");

                            addStringToStuffInfo("部屋の大きさ：" + "大部屋（64人）" + "\n");
                            console.log("選択された値: " + selectedValue);
                    } else if(selectedValue == 3) {
                            removeStringFromStuffInfo("部屋の大きさ：" + "小部屋（48人）" + "\n");
                            removeStringFromStuffInfo("部屋の大きさ：" + "大部屋（64人）" + "\n");

                            addStringToStuffInfo("部屋の大きさ：" + "2室連結" + "\n");
                            console.log("選択された値: " + selectedValue);
                    } else {
                            removeStringFromStuffInfo("部屋の大きさ：" + "小部屋（48人）" + "\n");
                            removeStringFromStuffInfo("部屋の大きさ：" + "大部屋（64人）" + "\n");
                            removeStringFromStuffInfo("部屋の大きさ：" + "2室連結" + "\n");
                            console.log("選択された値: " + selectedValue);
                    }
                 
                });

            }

        });

    });
})(jQuery);

</script>
<!-- ============  追加　夏目（前橋）　待合室・ロビー END　=============== -->


<!-- 追加　前橋用  24_0122 夏目 -->
<!-- 香炉　、体重　、　待合室利用　詳細　、を連絡事項に入れる -->
<script type="text/javascript">
    
document.addEventListener("DOMContentLoaded", function() {

    var Machi_show = document.querySelector('input[name="Machi_show"]:checked').value;
    var textarea = document.querySelector('textarea[name="stuff_info"]');
    var currentTextareaValue = textarea.value;

    document.querySelectorAll('input[name="kouro_kubun"]').forEach(function(radio) {
        radio.addEventListener('change', updateTextarea);
    });

    document.querySelectorAll('input[name="death_weight_tmp"]').forEach(function(radio) {
        radio.addEventListener('change', update_Death_Wight);
    });

});

function updateTextarea() {
    var kouroKubunValue = document.querySelector('input[name="kouro_kubun"]:checked').value;
    var textarea = document.querySelector('textarea[name="stuff_info"]');
    var currentTextareaValue = textarea.value;

    currentTextareaValue = currentTextareaValue.replace(/香炉：香炉有り\n/g, '');

    if (kouroKubunValue === '1') {
        textarea.value = currentTextareaValue + '香炉：香炉有り\n';
        console.log("連絡事項：：：" + textarea.value + "\n");
    } else {
        textarea.value = currentTextareaValue;
    }
}

function update_Death_Wight() {
    var death_weight_tmp_Value = document.querySelector('input[name="death_weight_tmp"]:checked').value;
    var textarea = document.querySelector('textarea[name="stuff_info"]');
    var currentTextareaValue = textarea.value;

    currentTextareaValue = currentTextareaValue.replace(/体重：100kg 以下\n|体重：100kg 以上\n/g, '');

    if (death_weight_tmp_Value === '1') {
        textarea.value = currentTextareaValue + '体重：100kg 以下\n';
        console.log("連絡事項：：：" + textarea.value + "\n");
    } else if (death_weight_tmp_Value === '2') {
        textarea.value = currentTextareaValue + '体重：100kg 以上\n';
        console.log("連絡事項：：：" + textarea.value + "\n");

    } else {
        currentTextareaValue = currentTextareaValue.replace(/体重：100kg 以下\n|体重：100kg 以上\n/g, '');
        textarea.value = currentTextareaValue;
        console.log("連絡事項：：：" + textarea.value + "\n");
    }
}

function update_Machi_show() {
    var Machi_show = document.querySelector('input[name="Machi_show"]:checked').value;
    var textarea = document.querySelector('textarea[name="stuff_info"]');
    var currentTextareaValue = textarea.value;
    
    currentTextareaValue = currentTextareaValue.replace(/待合室利用：小部屋（48人）\n|待合室利用：大部屋（64人）\n|待合室利用：2室連結\n/g, '');

    if (Machi_show === '1') {
        textarea.value = currentTextareaValue + '待合室利用：小部屋（48人）\n';
        console.log("連絡事項：：：" + textarea.value + "\n");
    } else if (Machi_show === '2') {
        textarea.value = currentTextareaValue + '待合室利用：大部屋（64人）\n';
        console.log("連絡事項：：：" + textarea.value + "\n");

    } else if(Machi_show === '3') {
        textarea.value = currentTextareaValue + '待合室利用：2室連結\n';
        console.log("連絡事項：：：" + textarea.value + "\n");

    } else {
        currentTextareaValue = currentTextareaValue.replace(/待合室利用：小部屋（48人）\n|待合室利用：大部屋（64人）\n|待合室利用：2室連結\n/g, '');
        textarea.value = currentTextareaValue;
        console.log("連絡事項：：：" + textarea.value + "\n");
    }
}

</script>

<!-- 追加 前橋用 24_0118 夏目 -->
<script type="text/javascript">

document.addEventListener("DOMContentLoaded", function() {

    const radioButtons = document.querySelectorAll('.car_type');

    var car_dtkb = document.getElementById('car_dtkb');
    var car_time = document.getElementById('car_time');
    var syukkan_place = document.getElementById('syukkan_place');

    car_dtkb.disabled = true; 
    car_time.disabled = true;
    syukkan_place.disabled = true;

    radioButtons.forEach(radioButton => {
        radioButton.addEventListener('change', function() {

            const carTypeValue = this.value;

            if (carTypeValue === '0') {
                car_dtkb.disabled = true; 
                car_time.disabled = true;
                syukkan_place.disabled = true;

                car_dtkb.value = "";
                car_time.value = "";
                syukkan_place.value = "";


                console.log('利用しないが選択されました');
            } else if (carTypeValue === '1') {
                car_dtkb.disabled = false; 
                car_time.disabled = false;
                syukkan_place.disabled = false; 
              
                console.log('利用するが選択されました');
            }
        });
    });

});


</script>

<!-- 追加 前橋用 23_1212 夏目 -->
<script type="text/javascript">

 function calculateAge() {
            
            
            var birthYearType = parseInt(document.getElementById('dead_birth_koyomi_type').value);
            var birthYear = parseInt(document.getElementById('dead_birth_year').value);
            var birthMonth = parseInt(document.getElementById('dead_birth_month').value);
            var birthDay = parseInt(document.getElementById('dead_birth_day').value);

        
            if (birthYearType === -1) {
                birthYear = birthYear;
            } else if (birthYearType === 4) {
                birthYear = birthYear + 2018;
            } else if (birthYearType === 3) { 
                birthYear = birthYear + 1988;
            } else if (birthYearType === 2) {
                birthYear = birthYear + 1925;
            } else if (birthYearType === 1) { 
                birthYear = birthYear + 1911;
            } else if (birthYearType === 0) { 
                birthYear = birthYear + 1868;
            }

            console.log("birthYear:::" + birthYear);

            var dead_koyomi_type = parseInt(document.getElementById('dead_koyomi_type').value);
            var dead_year = parseInt(document.getElementById('dead_year').value);
            var dead_month = parseInt(document.getElementById('dead_month').value);
            var dead_day = parseInt(document.getElementById('dead_day').value);

            if (dead_koyomi_type === -1) { 
                dead_year = dead_year;
            } else if (dead_koyomi_type === 4) { 
                dead_year = dead_year + 2018;
            } else if (dead_koyomi_type === 3) { 
                dead_year = dead_year + 1988;
            } else if (dead_koyomi_type === 2) { 
                dead_year = dead_year + 1925;
            } else if (dead_koyomi_type === 1) {
                dead_year = dead_year + 1911;
            } else if (dead_koyomi_type === 0) {
                dead_year = dead_year + 1868;
            }

            console.log("dead_year:::" + dead_year);
            
            var Dead_Now_Nenrei_Val = dead_year - birthYear;
            if(dead_month > birthMonth) {
                Dead_Now_Nenrei_Val += 1;
            } else if(dead_month === birthMonth) {
                if(dead_day >= birthDay) {
                     Dead_Now_Nenrei_Val += 1;
                }
            } 

            var resultTextBox = document.getElementById('Age_at_Death');

            if (!isNaN(Dead_Now_Nenrei_Val)) {
                var numericValue = Number(Dead_Now_Nenrei_Val);

                if (numericValue >= 0) {
                    resultTextBox.value = numericValue;   
                }   
        
            } else {
            
             }
       
        }

        
        document.getElementById('dead_birth_koyomi_type').addEventListener('change', calculateAge);
        document.getElementById('dead_birth_year').addEventListener('change', calculateAge);
        document.getElementById('dead_birth_month').addEventListener('change', calculateAge);
        document.getElementById('dead_birth_day').addEventListener('change', calculateAge);

        document.getElementById('dead_koyomi_type').addEventListener('change', calculateAge);
        document.getElementById('dead_year').addEventListener('change', calculateAge);
        document.getElementById('dead_month').addEventListener('change', calculateAge);
        document.getElementById('dead_day').addEventListener('change', calculateAge);

     
       function Validation_Zero() {
       
            document.getElementById('dead_birth_koyomi_type').value = "";
            document.getElementById('dead_birth_year').value = "";
            document.getElementById('dead_birth_month').value = "";
            document.getElementById('dead_birth_day').value = "";

            document.getElementById('dead_koyomi_type').value = "";
            document.getElementById('dead_year').value = "";
            document.getElementById('dead_month').value = "";
            document.getElementById('dead_day').value = "";

            document.getElementById('Age_at_Death').value = "";

        }

</script>

<!-- 追加　前橋用  23_1206 夏目 -->
<script type="text/javascript">

document.addEventListener("DOMContentLoaded", function() {
    var selectBox = document.getElementById("funeral_style");
    var funeral_style_others = document.getElementById("funeral_style_others");

    toggleTextBox_SelectBox_funeral(selectBox, funeral_style_others);

    selectBox.addEventListener("change", function() {
        toggleTextBox_SelectBox_funeral(selectBox, funeral_style_others);
    });
});

function toggleTextBox_SelectBox_funeral(selectBox, textBoxElement) {
    var selectedValue = selectBox.value;

    textBoxElement.disabled = selectedValue !== "10";
    textBoxElement.readOnly = selectedValue !== "10";
}


document.addEventListener("DOMContentLoaded", function() {
    var selectBox_02 = document.getElementById("temple_name");
    var temple_name_others = document.getElementById("temple_name_others");

    if (temple_name_others.value.trim() !== "") {
        var options = selectBox_02.options;
        for (var i = 0; i < options.length; i++) {
            if (options[i].value === "その他") {
                selectBox_02.selectedIndex = i;
                break;
            }
        }
    }

    toggleTextBox_SelectBox_temple(selectBox_02, temple_name_others);

    selectBox_02.addEventListener("change", function() {
        toggleTextBox_SelectBox_temple(selectBox_02, temple_name_others);
    });
});

function toggleTextBox_SelectBox_temple(selectBox, textBoxElement) {
    var selectedValue = selectBox.value;

    textBoxElement.disabled = selectedValue !== "その他";
    textBoxElement.readOnly = selectedValue !== "その他";
}

document.addEventListener("DOMContentLoaded", function() {
    var selectBox_03 = document.getElementById("syukkan_place");
    var syukkan_place_others = document.getElementById("syukkan_place_others");

     if (syukkan_place_others.value.trim() !== "") {
        var options = selectBox_03.options;
        for (var i = 0; i < options.length; i++) {
            if (options[i].value === "その他") {
                selectBox_03.selectedIndex = i;
                break;
            }
        }
    }

    toggleTextBox_SelectBox_syukkan(selectBox_03, syukkan_place_others);

    selectBox_03.addEventListener("change", function() {
        toggleTextBox_SelectBox_syukkan(selectBox_03, syukkan_place_others);
    });
});

function toggleTextBox_SelectBox_syukkan(selectBox, textBoxElement) {
    var selectedValue = selectBox.value;

    textBoxElement.disabled = selectedValue !== "その他";
    textBoxElement.readOnly = selectedValue !== "その他";
}


document.addEventListener("DOMContentLoaded", function() {
   var roomTypeRadios = document.getElementsByName("applicant_rel");
   var roomTypeNumTextbox = document.getElementById("applicant_rel_text_v");

    if (roomTypeNumTextbox.value.trim() !== "") {
        for (var i = 0; i < roomTypeRadios.length; i++) {
            if (roomTypeRadios[i].value === "その他") {
                roomTypeRadios[i].checked = true;
                break;
            } 
        }
    }

     for (var i = 0; i < roomTypeRadios.length; i++) {
        roomTypeRadios[i].addEventListener("change", function() {
            if (this.value === "親族") {
                roomTypeNumTextbox.value = ""; 
            }
        });
    }

    toggleTextBox_Applicant_rel(roomTypeRadios, roomTypeNumTextbox, "その他");
  
    for (var i = 0; i < roomTypeRadios.length; i++) {
        roomTypeRadios[i].addEventListener("change", function() {
            toggleTextBox_Applicant_rel(roomTypeRadios, roomTypeNumTextbox, "その他");
        });
    }

});

function toggleTextBox_Applicant_rel(rasio_el, text_box_el, Hantei_Val) {

    var isRoomType1Checked = false;
    for (var i = 0; i < rasio_el.length; i++) {
        if (rasio_el[i].value === Hantei_Val && rasio_el[i].checked) {
             isRoomType1Checked = true;
            break;
        }
    }
    text_box_el.disabled = !isRoomType1Checked;
    text_box_el.readOnly = !isRoomType1Checked;
}

</script>

<!-- 追加　前橋用  23_1225 夏目 -->
<script type="text/javascript">

function Dead_time_Validate() {
    var yoyakubi_date_id = document.getElementById('yoyakubi_date_id').value;
    var formattedDate = yoyakubi_date_id.replace(/^(\d{2}-\d{2}-\d{2} \d{2}:\d{2})$/, '20$1');
    var parsedDate = new Date(formattedDate);
    
    var yoyaku_Year = parsedDate.getFullYear();
    var yoyaku_Month = parsedDate.getMonth();
    var yoyaku_Date = parsedDate.getDate();


    var dead_koyomi_type = parseInt(document.getElementById('dead_koyomi_type').value);
    var dead_year = parseInt(document.getElementById('dead_year').value);
    var dead_month = parseInt(document.getElementById('dead_month').value);
    var dead_day = parseInt(document.getElementById('dead_day').value);
   

    if (dead_koyomi_type === -1) { 
        dead_year = dead_year;
    } else if (dead_koyomi_type === 4) { 
        dead_year = dead_year + 2018;
    } else if (dead_koyomi_type === 3) { 
        dead_year = dead_year + 1988;
    } else if (dead_koyomi_type === 2) { 
        dead_year = dead_year + 1925;
    } else if (dead_koyomi_type === 1) {
        dead_year = dead_year + 1911;
    } else if (dead_koyomi_type === 0) {
        dead_year = dead_year + 1868;
    }

}

document.addEventListener("DOMContentLoaded", function() {
    Dead_time_Validate();
});

document.getElementById('dead_year').addEventListener('change', Dead_time_Validate);
document.getElementById('dead_month').addEventListener('change', Dead_time_Validate);
document.getElementById('dead_day').addEventListener('change', Dead_time_Validate);


</script>





</body>
<!--{/strip}-->
<!-- ▲BODY部 エンド -->
<!--{include file=$html_end_tpl}-->
