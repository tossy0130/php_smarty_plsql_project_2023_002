
// ================================ ラジオボタンで　テキストボックスの表示・非表示　切り替え
//================================= テキストボックスの値を抽出

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
