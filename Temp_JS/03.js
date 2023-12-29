   function Dead_time_Validate() {

            var yoyakubi_date_id = document.getElementById('yoyakubi_date_id').value;
            var formattedDate = yoyakubi_date_id.replace(/^(\d{2}-\d{2}-\d{2} \d{2}:\d{2})$/, '20$1');
            var parsedDate = new Date(formattedDate);

            console.log("parsedDate:::parsedDate.getFullYear():::" + parsedDate.getFullYear());
            console.log("parsedDate:::parsedDate.getMonth():::" + parsedDate.getMonth());
            console.log("parsedDate::: parsedDate.getDate():::" + parsedDate.getHours());
            console.log("parsedDate::: parsedDate.getDate():::" + parsedDate.getMinutes());

            var dead_koyomi_type = parseInt(document.getElementById('dead_koyomi_type').value);
            var dead_year = parseInt(document.getElementById('dead_year').value);
            var dead_month = parseInt(document.getElementById('dead_month').value);
            var dead_day = parseInt(document.getElementById('dead_day').value);
            var time_of_death_hour = parseInt(document.getElementById('time_of_death_hour').value);
            var time_of_death_minutes = parseInt(document.getElementById('time_of_death_minutes').value);

            if (dead_koyomi_type === -1) { 
                dead_year = dead_year;
            } else if (dead_koyomi_type === 4) { 
                dead_year = dead_year + 2018;
            } else if (dead_koyomi_type === 3) { 
                dead_year = dead_year + 1988;
            } else if (dead_koyomi_type === 2) { 
                dead_year = dead_year + 1925;
            } else if (dead_koyomi_type === 1) {
                dead_year = dead_year + 1911;
            } else if (dead_koyomi_type === 0) {
                dead_year = dead_year + 1868;
            }

            parsedDate.setFullYear(dead_year);
            parsedDate.setMonth(dead_month - 1);
            parsedDate.setDate(dead_day);
            parsedDate.setHours(time_of_death_hour);
            parsedDate.setMinutes(time_of_death_minutes);

            var timeDifference = new Date() - parsedDate;

            console.log("parsedDate::: parsedDate:::" + parsedDate);
            console.log("timeDifference::: timeDifference:::" + timeDifference);

            if (timeDifference < 24 * 60 * 60 * 1000) {
                alert('死亡日から24時間経過していません。');

                console.log("if timeDifference < 24 * 60 * 60 * 1000 :::" + timeDifference);
                document.getElementById('dead_year').value = "";
                document.getElementById('dead_month').value = "";
                document.getElementById('dead_day').value = "";
                document.getElementById('time_of_death_hour').value = "";
                document.getElementById('time_of_death_minutes').value = "";
            } else {
                 console.log(" timeDifference < 24 * 60 * 60 * 1000 :::" + timeDifference);
            }

        }
          

            document.getElementById('dead_koyomi_type').addEventListener('change', Dead_time_Validate);
            document.getElementById('dead_year').addEventListener('change', Dead_time_Validate);
            document.getElementById('dead_month').addEventListener('change', Dead_time_Validate);
            document.getElementById('time_of_death_minutes').addEventListener('change', Dead_time_Validate);