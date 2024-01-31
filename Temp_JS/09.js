
// ================================ ラジオボタンの値を、でテキストボックスの表示・非表示切替、
// === テキストボックスの値をテキストエリアへ 挿入する。
(function ($) {
    $(document).ready(function() {

        $('#room_type_num_span').hide();
        $('#roby_type_num_span').show();

        var room_type_num = $('#room_type_num');
        var roby_type_num = $('#roby_type_num');

        var stuff_infoValue = $('textarea[name="stuff_info"]');

        // === テキストエリアの、文字の重複を防ぐために、削除する関数
        function removeStringFromStuffInfo(targetString) {
            var currentValue = stuff_infoValue.val();
            var newValue = currentValue.replace(targetString, '');
            stuff_infoValue.val(newValue);
        }

        // === ラジオボックスが最初の値が 0 なので、それに合わせた初期用イベント
        roby_type_num.on('change', function(){
                  removeStringFromStuffInfo("ロビー待合せ（" + roby_type_num.val() + "）人位" + "\n");
                 stuff_infoValue.val("ロビー待合せ（" + roby_type_num.val() + "）人位" + "\n");
        });
    
    // ====== ラジオボタン　、テキストボックスの表示・非表示を切り替える。
    $('.room_type').on('change', function() {
       
        if ($(this).val() === '0') {
            $('#room_type_num_span').hide();
            $('#roby_type_num_span').show();

            roby_type_num.on('change', function(){
                  removeStringFromStuffInfo("ロビー待合せ（" + roby_type_num.val() + "）人位" + "\n");
                 stuff_infoValue.val("ロビー待合せ（" + roby_type_num.val() + "）人位" + "\n");
            });
           

        } else if ($(this).val() === '1') {
            $('#room_type_num_span').show();
            $('#roby_type_num_span').hide();

            room_type_num.on('change', function(){
                 removeStringFromStuffInfo("利用者（" + room_type_num.val() + "）人位" + "\n");
                 stuff_infoValue.val("利用者（" + room_type_num.val() + "）人位" + "\n");
            });
        }
    });

});
})(jQuery);