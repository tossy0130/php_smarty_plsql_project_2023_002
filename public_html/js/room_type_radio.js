

// ========= radioボックスの 1にチェックがある場合は、
//=== room_type_num　の入力が可能
//=== room_type が 0の場合は、room_type_num　の入力不可
document.addEventListener("DOMContentLoaded", function() {
    var roomTypeRadios = document.getElementsByName("room_type");
    var roomTypeNumTextbox = document.getElementById("room_type_num");

    toggleTextBox_RoomType();

    // === ラジオボタンのチェンジイベント
    for (var i = 0; i < roomTypeRadios.length; i++) {
        roomTypeRadios[i].addEventListener("change", function() {
            toggleTextBox_RoomType();
        });
    }
});

function toggleTextBox_RoomType() {
    var roomTypeRadios = document.getElementsByName("room_type");
    var roomTypeNumTextbox = document.getElementById("room_type_num");

    var isRoomType1Checked = false;

    // === value 1の場合
    for (var i = 0; i < roomTypeRadios.length; i++) {
        if (roomTypeRadios[i].value === "1" && roomTypeRadios[i].checked) {
             isRoomType1Checked = true;
            break;
        }
    }

    // === value　が １以外のradioの値への処理
    roomTypeNumTextbox.disabled = !isRoomType1Checked;
    roomTypeNumTextbox.readOnly = !isRoomType1Checked;

}

// =========================== select ボックス用
document.addEventListener("DOMContentLoaded", function() {
    var selectBox = document.getElementById("funeral_style");
    var funeral_style_others = document.getElementById("funeral_style_others");

    toggleTextBox_SelectBox(selectBox, funeral_style_others);

    selectBox.addEventListener("change", function() {
        toggleTextBox_SelectBox(selectBox, funeral_style_others);
    });
});

function toggleTextBox_SelectBox(selectBox, textBoxElement) {
    var selectedValue = selectBox.value;

    textBoxElement.disabled = selectedValue !== "10";
    textBoxElement.readOnly = selectedValue !== "10";
}
