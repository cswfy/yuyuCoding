<?php
    session_start ();
    header ( 'Content-type: image/png' );
    //建立圖片
    $im = imagecreate($x=130,$y=45 );
    $bg = imagecolorallocate($im,rand(50,200),rand(0,155),rand(0,155)); //第一次對 imagecolorallocate() 的呼叫會給基於調色盤的影象填充背景色
    $fontColor = imageColorAllocate ( $im, 255, 255, 255 );  //字型顏色
    $fontstyle = 'rock.ttf';          //字型樣式，這個可以從c:windowsFonts資料夾下找到，我把它放到和authcode.php檔案同一個目錄，這裡可以替換其他的字型樣式
    //產生隨機字元
    for($i = 0; $i < 4; $i ++) {
        $randAsciiNumArray     = array (rand(48,57),rand(65,90));
        $randAsciiNum         = $randAsciiNumArray [rand ( 0, 1 )];
        $randStr             = chr ( $randAsciiNum );
        imagettftext($im,30,rand(0,20)-rand(0,25),5+$i*30,rand(30,35),$fontColor,$fontstyle,$randStr);
        $authcode            .= $randStr;
    }
    $_SESSION['authcode']    = $randFourStr;//使用者和使用者輸入的驗證碼做比較
    //干擾線
    for ($i=0;$i<8;$i++){
        $lineColor    = imagecolorallocate($im,rand(0,255),rand(0,255),rand(0,255));
        imageline ($im,rand(0,$x),0,rand(0,$x),$y,$lineColor);
    }
    //干擾點
    for ($i=0;$i<250;$i++){
        imagesetpixel($im,rand(0,$x),rand(0,$y),$fontColor);
    }
    imagepng($im);
    imagedestroy($im);
?>