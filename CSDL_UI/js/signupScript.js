$(window).resize(function(){
    var windowWidth = $(window).width();
    var imgSrc = $('#image');
    if($('#action').is(':checked')){
      if(windowWidth > 600){
        document.getElementById("mySidebar").style.width = "252px";
        $('#main, footer').css({ "marginLeft": "240px" });
       
      }else{
        $('.sticky-top').css({"display": "none"});
        document.getElementById("mySidebar").style.width = "100%";          
      }
    }
    else{
      if(windowWidth <= 600){
        document.getElementById("mySidebar").style.width = "0";
        $('#main, footer').css({ "marginLeft": "0" });
      }
      else{
        document.getElementById("mySidebar").style.width = "92px";
        $('#main, footer').css({ "marginLeft": "80px" });
      }
    }
    });