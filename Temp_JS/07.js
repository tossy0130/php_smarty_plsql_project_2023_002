/*

チェックボタンの値が 0 なら、　

セレクトボックス car_dtkb , car_time , syukkan_place を入力不可 & 値を空

チェックボタンの値が 1 なら、

セレクトボックス car_dtkb , car_time , syukkan_place 入力 OK

*/
document.addEventListener("DOMContentLoaded", function () {

    // === ラジオボタンの要素取得
    const radioButtons = document.querySelectorAll('.car_type');

    // === セレクトボックス id 取得
    var car_dtkb = document.getElementById('car_dtkb');
    var car_time = document.getElementById('car_time');
    var syukkan_place = document.getElementById('syukkan_place');

    car_dtkb.disabled = true; 
    car_time.disabled = true;
    syukkan_place.disabled = true;

    // === ラジオボタン のチェックをイベントで取得
    radioButtons.forEach(radioButton => {
        radioButton.addEventListener('change', function() {

            const carTypeValue = this.value;

            // === ラジオボタン の値が 0 の時の処理
            if (carTypeValue === '0') {
                car_dtkb.disabled = true; 
                car_time.disabled = true;
                syukkan_place.disabled = true;

                car_dtkb.value = "";
                car_time.value = "";
                syukkan_place.value = "";


                console.log('利用しないが選択されました');

             // === ラジオボタン の値が 1 の時の処理
            } else if (carTypeValue === '1') {
                car_dtkb.disabled = false; 
                car_time.disabled = false;
                syukkan_place.disabled = false; 
              
                console.log('利用するが選択されました');
            }
        });
    });

});