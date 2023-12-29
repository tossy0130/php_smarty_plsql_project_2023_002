
// ============= フォームバリデーション TEL <input type="text">

             function validateForm_TEL() {
            var tel01 = document.getElementById('applicant_tel01').value.trim();
            var tel02 = document.getElementById('applicant_tel02').value.trim();
            var tel03 = document.getElementById('applicant_tel03').value.trim();
            var errorSpan_TEL = document.getElementById('errorSpan_TEL');

            if (tel01 === '' || tel02 === '' || tel03 === '') {
           
                errorSpan_TEL.textContent = '※連絡先TELを入力してください。';

                if (tel01 === '') {
                    document.getElementById('applicant_tel01').classList.add('error-background');
                }
                if (tel02 === '') {
                    document.getElementById('applicant_tel02').classList.add('error-background');
                }
                if (tel03 === '') {
                    document.getElementById('applicant_tel03').classList.add('error-background');
                }
            } else {
                errorSpan.textContent = '';
            }
        
        }

        document.getElementById('applicant_tel01').addEventListener('input', validateForm_TEL);
        document.getElementById('applicant_tel02').addEventListener('input', validateForm_TEL);
        document.getElementById('applicant_tel03').addEventListener('input', validateForm_TEL);

        document.getElementById('form1').addEventListener('submit', validateForm_TEL);