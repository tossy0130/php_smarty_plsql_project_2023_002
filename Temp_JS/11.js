// <!-- ============  追加　夏目（前橋） 喪主  =============== -->
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

// <!-- ============  追加　夏目智徹（前橋） 死亡時刻の 時間, 分, を db保存用パラメーターの input に入れる  =============== -->

(function($){
    $(document).ready(function(){

        var time_of_death_free = $('#time_of_death_free');

        time_of_death_free.prop('disabled', true);
        $('#time_of_death_hour').prop('disabled', false);
        $('#time_of_death_minutes').prop('disabled', false);


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

                time_of_death = hour + minute;
                $('#time_of_death_time').val(time_of_death);
                console.log("死亡時刻:::" + time_of_death);
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

// <!-- ============  追加　夏目（前橋）　入力制限 棺の大きさ  =============== -->

document.getElementById("hitugi_01").addEventListener("input", function() {
  if (this.value.length > 3) {
    this.value = this.value.slice(0, 3);
  }
});

document.getElementById("ren_tel_02").addEventListener("input", function() {
  if (this.value.length > 4) {
    this.value = this.value.slice(0, 4);
  }
});


// ========================死亡時刻　
(function($){
    $(document).ready(function(){

        var time_of_death_free = $('#time_of_death_free');

        time_of_death_free.prop('disabled', true);
        $('#time_of_death_hour').prop('disabled', false);
        $('#time_of_death_minutes').prop('disabled', false);

        // === hidenn の要素の値が、空だったら、0000 をセットする
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

            // === 時刻不明　だった場合 => テキストボックスを使えるようにする。
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
                console.log("死亡時刻:::" + time_of_death);
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