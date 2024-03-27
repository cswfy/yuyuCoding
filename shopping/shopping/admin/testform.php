<?php
  header("Content-Type:text/html;charset=utf-8");      //設定頭部資訊
  //isset()檢測變數是否設定
  if(isset($_REQUEST['authcode'])){
    session_start();
    //strtolower()小寫函數
    if(strtolower($_REQUEST['authcode'])== $_SESSION['authcode']){
      //跳轉頁面
      echo "<script language=\"javascript\">";
      echo "document.location=\"./testform.php\"";
      echo "</script>";
    }else{
      //提示以及跳轉頁面
      echo "<script language=\"javascript\">";
      echo "alert('輸入錯誤!');";
      echo "document.location=\"./testform.php\"";
      echo "</script>";
    }
    exit();
  }