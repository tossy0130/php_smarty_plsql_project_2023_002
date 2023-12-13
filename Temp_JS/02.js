document.addEventListener("DOMContentLoaded", function() {
    var roomTypeRadios = document.getElementsByName("room_type");
    var roomTypeNumTextbox = document.getElementById("room_type_num");

    toggleTextBox_RoomType(roomTypeRadios, roomTypeNumTextbox, "1");
  
    for (var i = 0; i < roomTypeRadios.length; i++) {
        roomTypeRadios[i].addEventListener("change", function() {
            toggleTextBox_RoomType(roomTypeRadios, roomTypeNumTextbox, "1");
        });
    }

});

function toggleTextBox_RoomType(rasio_el, text_box_el, Hantei_Val) {

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

    textBoxElement.disabled = selectedValue !== "その他";
    textBoxElement.readOnly = selectedValue !== "その他";
}


document.addEventListener("DOMContentLoaded", function() {
    var selectBox_02 = document.getElementById("temple_name");
    var temple_name_others = document.getElementById("temple_name_others");

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

    toggleTextBox_Applicant_rel(roomTypeRadios, roomTypeNumTextbox, "1");
  
    for (var i = 0; i < roomTypeRadios.length; i++) {
        roomTypeRadios[i].addEventListener("change", function() {
            toggleTextBox_Applicant_rel(roomTypeRadios, roomTypeNumTextbox, "1");
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