<!--{include file=$html_start_tpl}-->
<!-- ▼BODY部 スタート -->
<!--{strip}-->
<body class="frame_outer">
    <!--{$GLOBAL_ERR}-->
    <noscript>
        <p>JavaScript を有効にしてご利用下さい.</p>
    </noscript>
    <!--{* ▼HEADER *}-->
    <div id="header">
        <!--{include file=$header_tpl}-->
    </div>
    <!--{* ▲HEADER *}-->
    <!--{* ▼MAIN部 *}-->
    <div id="main">
        <span class="strong top_span"><!--{$current_datetime}-->現在の予約状況</span><br>
        <!--{if $tpl_error != ""}-->
            <span class="attention"><!--{$tpl_error}--></span><br>
        <!--{/if}-->
        <!--★★検索結果一覧★★-->
        <form name="form1" id="form1" method="post" action="?">
            <input type="hidden" name="<!--{$smarty.const.TRANSACTION_ID_NAME}-->" value="<!--{$transactionid}-->" />
            <input type="hidden" name="mode" value="" />
            <input type="hidden" name="UKE_NEND" value="" />
            <input type="hidden" name="UKE_NO" value="" />
            <input type="hidden" name="YOYAKUBI_STRING" value="" />
            <div class="btn">
                <!--{* ログイン済み *}-->
                <!--{if $tpl_login == 1 }-->
                    <a class="btn_default" href="javascript:;" onclick="main.setModeAndSubmit('form1', 'reserve_list'); return false;">予約状況確認</a>
                    <a class="btn_default" href="javascript:;" onclick="main.setModeAndSubmit('form1', 'view_list'); return false;">空き状況確認</a>
                    <a class="btn_default" href="javascript:;" onclick="main.setModeAndSubmit('form1', 'pdf_view'); return false;">埋火葬許可書 アップロード一覧</a>
                    <a class="btn_default" href="javascript:;" onclick="main.setModeAndSubmit('form1', 'reload'); return false;">最新状況に更新</a>
                    <a class="btn_default" href="javascript:;" onclick="main.setModeAndSubmit('form1', 'logout'); return false;">ログアウト</a>
                <!--{else}-->
                    <a class="btn_default" href="javascript:;" onclick="main.setModeAndSubmit('form1', 'login'); return false;">ログイン</a>
                <!--{/if}-->
            </div>
        </form>

<h2>日付を選択してください</h2>

<form name="day_search" id="day_search" method="post" action="./day_search.php">
    <input name="day_val" type="text" id="datepicker">

    <input id="day_search_submit" type="submit" value="検索">
</form>

            
 <!--{if $disp_flag == 1}-->

   <span class="alignL strong underline clearfix">日別予約情報</span>
            <!--{* 検索結果表示テーブル *}-->
            
 <!--{assign var=val_idx value="0"}-->
   <p class="strong underline" id="kasou_text">火葬予約日時：<!--{$arr_val_05[$val_idx]}--> データ一覧表示</p>
   <p id="kasou_search_max">
   【日別 火葬件数】：
<!--{if $Count_Uketuke_val != ""}-->
    <!--{$Count_Uketuke_val}--> 件
<!--{/if}-->
   </p>
            <table class="list" id="search_table_view">
                <col width="4%" />
                <col width="7%" />
                <col width="11%" />
                <col width="11%" />
                <col width="12%" />
                <col width="8%" />
                <col width="5%" />
                <col width="5%" />
                <col width="9%" />
                <col width="15%" />
                <col width="12%" />

                <tr>
                    <th class="alignC">No.</th>
                    <th class="alignL">受付番号</th>
                    <th class="alignL">申請者</th>
                    <th class="alignL">死亡者</th>
                    <th class="alignC">火葬区分</th>
                    <th class="alignC">式場利用</th>
                    <th class="alignC">通夜式</th>
                    <th class="alignC">霊柩車</th>
                    <th class="alignC">担当者</th>
                    <th class="alignC">業者名</th>
                    <th class="alignC">埋火葬許可証</th>
               </tr>
                
            <!--{section name=idx loop=$arr_idx}-->
               <tr>
                    <td><!--{$arr_idx_NUM[idx]}--></td>
                    <td><!--{$arr_val_01[idx]}--></td>
                    <td><!--{$arr_val_02[idx]}--></td>
                    <td><!--{$arr_val_03[idx]}--></td>
                    <td>
                    <!--{if $arr_val_04[idx] == 0}-->
                        大人(12歳以上)
                    <!--{elseif $arr_val_04[idx] == 1}-->
                        小人(12歳未満)
                    <!--{elseif $arr_val_04[idx] == 2}-->
                        死産児
                    <!--{/if}-->
                    </td>
                    <td>
                    <!--{if $arr_val_06[idx] == 0}-->
                        利用なし
                     <!--{elseif $arr_val_06[idx] == 1}-->
                        大式場
                     <!--{elseif $arr_val_06[idx] == 2}-->
                        小式場
                    <!--{/if}-->
                    </td>

                     <td>  
                     <!--{if $arr_val_07[idx] == 0}-->
                        なし
                     <!--{elseif $arr_val_07[idx] == 1}-->
                        利用
                     <!--{/if}-->
                     </td>

                     <td>  
                     <!--{if $arr_val_08[idx] == 0}-->
                        なし
                     <!--{elseif $arr_val_08[idx] == 1}-->
                        利用
                     <!--{/if}-->
                     </td>

                     <td><!--{$arr_val_09[idx]}--></td>
                     <td><!--{$arr_val_10[idx]}--></td>
                     <td>
                     <a href="<!--{$arr_val_11[idx]}-->" id="kyoka_syo_search" target="_blank" >表示</a>
                     </td>
              </tr>
            <!--{/section}-->

            </table>



    <!--{* 検索結果表示テーブル *}-->
<!--{/if}-->

        </div>
    <!--{* ▲MAIN部 *}-->
    <!--{* ▲HEADER *}-->
    <!--{* ▼FOOTER *}-->
    <div id="footer">
        <!--{include file=$footer_tpl}-->
    </div>
    <!--{* ▲FOOTER *}-->

<!-- ========　追加 24_03_07 夏目 前橋用 ======== -->

<!-- jQuery UI -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>

<script type="text/javascript">

(function($) {
    $(document).ready(function() {

        $("#datepicker").datepicker({
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
    dateFormat: 'yy-mm-dd',
    firstDay: 0,
    isRTL: false,
    showMonthAfterYear: true,
    yearSuffix: '年'};
  $.datepicker.setDefaults($.datepicker.regional['ja']);

});

})(jQuery);


</script>

<script>
    
    function submitForm() {
        document.getElementById("day_search").submit(); 
    }

    $(function() {
        $("#datepicker").datepicker({
            dateFormat: 'yy-mm-dd',
            onSelect: function(date) {
                console.log("サブミット OK");
                submitForm(); 
            }
        });
    });
</script>

</body>
<!--{/strip}-->
<!-- ▲BODY部 エンド -->
<!--{include file=$html_end_tpl}-->