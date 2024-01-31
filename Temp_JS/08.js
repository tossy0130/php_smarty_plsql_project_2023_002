

// ================== Jquery 即時関数
(function($){
    $(document).ready(function(){

        var applicant_zip01 = $('input[name="applicant_zip01"]');
        var applicant_zip02 = $('input[name="applicant_zip02"]');
        var applicant_address1 = $('input[name="applicant_address1"]');
        var applicant_address2 = $('input[name="applicant_address2"]');

        // ========= テキストボックスの、値の変化をイベントで取得
        $('input[name="applicant_zip01"], input[name="applicant_zip02"], input[name="applicant_address1"], input[name="applicant_address2"]').on('change', function(){
            
            applicant_zip01_val = $('input[name="applicant_zip01"]').val();
            applicant_zip02_val = $('input[name="applicant_zip02"]').val();
            applicant_address1_val = $('input[name="applicant_address1"]').val();
            applicant_address2_val = $('input[name="applicant_address2"]').val();
        });

        // ========= ボタンをクリックしたら、値を別のテキストボックスへ挿入
        $('#sinsei_dead_btn').on('click', function(){
          
            $('input[name="dead_zip01"]').val(applicant_zip01_val);
            $('input[name="dead_zip02"]').val(applicant_zip02_val);
            $('input[name="dead_address1"]').val(applicant_address1_val);
            $('input[name="dead_address2"]').val(applicant_address2_val);
        });
     });
})(jQuery);