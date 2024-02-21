
// ================================ ラジオボタンで　テキストボックスの表示・非表示　切り替え
//================================= テキストボックスの値を抽出

(function($) {
    $(document).ready(function() {

        var reian_text = $('#reian_text');
        var reian_text_v_01 = $('#reian_text_v_01');
        var reian_text_v_02 = $('#reian_text_v_02');

        reian_text.hide();

        var stuff_infoValue = $('textarea[name="stuff_info"]');

        function removeStringFromStuffInfo(targetString) {
      
            var currentValue = stuff_infoValue.val();
            var newValue = currentValue.replace(targetString, '');
            stuff_infoValue.val(newValue);
        }

        function addStringToStuffInfo(newString) {
            
            removeStringFromStuffInfo("霊安室利用（" + reian_text_v_01.val() + "時から" + reian_text_v_02.val() + "時まで" + "）" + "\n");

            var currentValue = stuff_infoValue.val();
            var newValue = currentValue + newString;
            stuff_infoValue.val(newValue);
        }

        $('input[name="reian_kubun_f"]').change(function(){

            var select_value = $('input[name="reian_kubun_f"]:checked').val();

            if(select_value == 0) {
                reian_text.hide();
                console.log(select_value);

                removeStringFromStuffInfo("霊安室利用（" + reian_text_v_01.val() + "時から" + reian_text_v_02.val() + "時まで" + "）" + "\n");
             
            } else {
                reian_text.show();

                console.log("00");
                console.log(select_value);
              
            }
            
        });

        reian_text_v_01.off('blur').on('blur', function(){
            var select_value = $('input[name="reian_kubun_f"]:checked').val();
            if(select_value == 1) {

                if(reian_text_v_02.val() == "") {
                    removeStringFromStuffInfo("霊安室利用（" + reian_text_v_01.val() + "時から" + reian_text_v_02.val() + "時まで" + "）" + "\n");
                    console.log("01");
                } else {
                    console.log("02");
                    removeStringFromStuffInfo("霊安室利用（" + reian_text_v_01.val() + "時から" + reian_text_v_02.val() + "時まで" + "）" + "\n");
                    addStringToStuffInfo("霊安室利用（" + reian_text_v_01.val() + "時から" + reian_text_v_02.val() + "時まで" + "）" + "\n");
                }
             
            }
        });
        
        var reian_text_v_02_event_count = 0;

        reian_text_v_02.off('blur').on('blur', function(){

            reian_text_v_02_event_count++;

            var select_value = $('input[name="reian_kubun_f"]:checked').val();
            if(select_value == 1) {

                if(reian_text_v_02.val() == "") {
                    removeStringFromStuffInfo("霊安室利用（" + reian_text_v_01.val() + "時から" + reian_text_v_02.val() + "時まで" + "）" + "\n");
                    console.log("03");
                } else {
                    console.log("04");
                    removeStringFromStuffInfo("霊安室利用（" + reian_text_v_01.val() + "時から" + reian_text_v_02.val() + "時まで" + "）" + "\n");
                    addStringToStuffInfo("霊安室利用（" + reian_text_v_01.val() + "時から" + reian_text_v_02.val() + "時まで" + "）" + "\n");
                }

            }
        });

  

    });

})(jQuery);
