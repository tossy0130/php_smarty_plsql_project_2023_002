
/*

セレクトボックス , テキストボックス　 ON , OFF


*/

document.addEventListener("DOMContentLoaded", function() {
    var time_of_death_time = document.getElementById("time_of_death_time"); //セレクトボックス
    var time_of_death_free = document.getElementById("time_of_death_free");//テキストボックス

    var time_of_death_free_value = document.getElementById("time_of_death_free").value;//テキストボックスの値

    time_of_death_free.disabled = true; 

    if(time_of_death_free_value === '') {

            time_of_death_time.addEventListener("change", function() {
                toggleTextBox_SelectBox_Death_Time(time_of_death_time, time_of_death_free);
            });

            console.log("if time");
     } else {

            time_of_death_time.disabled = true;
            console.log("else time");
     }
  
});

time_of_death_free.addEventListener("input", function () {

        var time_of_death_time = document.getElementById("time_of_death_time");
        var time_of_death_free = document.getElementById("time_of_death_free");
        var time_of_death_free_value = document.getElementById("time_of_death_free").value;

        if(time_of_death_free_value === '') {

             time_of_death_time.disabled = false;

            time_of_death_time.addEventListener("change", function() {
                toggleTextBox_SelectBox_Death_Time(time_of_death_time, time_of_death_free);
            });

            console.log("if time");

     } else {

            time_of_death_time.disabled = true;

            console.log("else time");

     }
});

function toggleTextBox_SelectBox_Death_Time(selectBox, textBoxElement) {
    var selectedValue = selectBox.value;

    textBoxElement.disabled = selectedValue !== "";
    textBoxElement.readOnly = selectedValue !== "";
}

