
// クッキーの取得
function getCookie(name) {
    const value = `; ${document.cookie}`;
    const parts = value.split(`; ${name}=`);
    if (parts.length === 2) return parts.pop().split(';').shift();
}

// クッキーの設定
function setCookie(name, value, days) {
    const date = new Date();
    date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
    const expires = `expires=${date.toUTCString()}`;
    document.cookie = `${name}=${value}; ${expires}; path=/`;
}

// クリックイベントハンドラ
function handleLinkClick() {
    // クッキーが存在しない場合
    if (!getCookie('linkClicked')) {
        alert('初めてクリックされました！');
        // クッキーを設定
        setCookie('linkClicked', 'true', 365);
    } else {
        alert('既にクリックされています！');
    }
}
