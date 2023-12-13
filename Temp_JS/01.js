function calculateAge() {

  var birthYearType = parseInt(document.getElementById('dead_birth_koyomi_type').value);
  var birthYear = parseInt(document.getElementById('dead_birth_year').value);
  var birthMonth = parseInt(document.getElementById('dead_birth_month').value);
  var birthDay = parseInt(document.getElementById('dead_birth_day').value);


  if (birthYearType === -1) {
    birthYear = birthYear;
  } else if (birthYearType === 4) {
    birthYear = birthYear + 2018;
  } else if (birthYearType === 3) {
    birthYear = birthYear + 1988;
  } else if (birthYearType === 2) {
    birthYear = birthYear + 1925;
  } else if (birthYearType === 1) {
    birthYear = birthYear + 1911;
  } else if (birthYearType === 0) {
    birthYear = birthYear + 1868;
  }

  console.log("birthYear:::" + birthYear);

  var dead_koyomi_type = parseInt(document.getElementById('dead_koyomi_type').value);
  var dead_year = parseInt(document.getElementById('dead_year').value);
  var dead_month = parseInt(document.getElementById('dead_month').value);
  var dead_day = parseInt(document.getElementById('dead_day').value);

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

  console.log("dead_year:::" + dead_year);

  var Dead_Now_Nenrei_Val = dead_year - birthYear;
  if (dead_month < birthMonth) {
    Dead_Now_Nenrei_Val += 1;
  } else if (dead_month === birthMonth) {
    if (dead_day <= birthDay) {
      Dead_Now_Nenrei_Val += 1;
    }
  }

  var resultTextBox = document.getElementById('Age_at_Death');
  resultTextBox.value = Dead_Now_Nenrei_Val;
}

document.getElementById('dead_birth_koyomi_type').addEventListener('change', calculateAge);
document.getElementById('dead_birth_year').addEventListener('change', calculateAge);
document.getElementById('dead_birth_month').addEventListener('change', calculateAge);
document.getElementById('dead_birth_day').addEventListener('change', calculateAge);

document.getElementById('dead_koyomi_type').addEventListener('change', calculateAge);
document.getElementById('dead_year').addEventListener('change', calculateAge);
document.getElementById('dead_month').addEventListener('change', calculateAge);
document.getElementById('dead_day').addEventListener('change', calculateAge);