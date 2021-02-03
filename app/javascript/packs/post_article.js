window.addEventListener('load', () => {
  const uploader = document.querySelector('.d-none');
  uploader.addEventListener('change', (e) => {//.noneの値の変更が確定された時
    const file = uploader.files[0];// files[0] 選択したファイルオブジェクトを取得する
    const reader = new FileReader();// FileReaderオブジェクトをインスタンス化.a1FileReaderはオブジェクトからデータを読み込むことのみを目的としたオブジェクト
    reader.readAsDataURL(file);// readAsDataURL(file) file画像の読み込み。データを base64 データurl にエンコードします
    reader.onload = () => {// onload 読み込みが成功したか調べる
      const image = reader.result;// result readerの読み込み成功後に、中身のデータを取得する。（読み取り専用）
      document.querySelector('#change-avatar').setAttribute('src', image);
    }
  })
})