$(function(){
var state = 0;

	$("#grow1").click(function(){
	if(state === 0){
		$("#darkbg").css({"display":"block"}); 
		$("#chart1").addClass("chartbig");
 		$(".grow").css({"display":"block"});
		$("#grow1").find("img").attr({"src":"img/close.png"}); 
		state = 1
	}
	if(state === 1){
		$(".grow").click(function(){
			location.href="index.html";
			$("#chart1").removeClass("chartbig");
		});
		$("#darkbg").click(function(){location.href="index.html"});
	}
	});
	$("#grow2").click(function(){
	if(state === 0){
		$("#darkbg").css({"display":"block"}); 
		$("#chart2").addClass("chartbig");
 		$(".grow").css({"display":"block"});
		$("#grow2").find("img").attr({"src":"img/close.png"}); 
		state = 1
	}
	if(state === 1){
		$(".grow").click(function(){
			location.href="index.html";
			$("#chart2").removeClass("chartbig");
		});
		$("#darkbg").click(function(){location.href="index.html"});
	}
	});
	$("#grow3").click(function(){
	if(state === 0){
		$("#darkbg").css({"display":"block"}); 
		$("#chart3").addClass("chartbig");
 		$(".grow").css({"display":"block"});
		$("#grow3").find("img").attr({"src":"img/close.png"}); 
		state = 1
	}
	if(state === 1){
		$(".grow").click(function(){
			location.href="index.html";
			$("#chart3").removeClass("chartbig");
		});
		$("#darkbg").click(function(){location.href="index.html"});
	}
	});
	$("#grow4").click(function(){
	if(state === 0){
		$("#darkbg").css({"display":"block"}); 
		$("#chart4").addClass("chartbig");
 		$(".grow").css({"display":"block"});
		$("#grow4").find("img").attr({"src":"img/close.png"}); 
		state = 1
	}
	if(state === 1){
		$(".grow").click(function(){
			location.href="index.html";
			$("#chart4").removeClass("chartbig");
		});
		$("#darkbg").click(function(){location.href="index.html"});
	}
	});
	$("#grow5").click(function(){
	if(state === 0){
		$("#darkbg").css({"display":"block"}); 
		$("#chart5").addClass("chartbig");
 		$(".grow").css({"display":"block"});
		$("#grow5").find("img").attr({"src":"img/close.png"}); 
		state = 1
	}
	if(state === 1){
		$(".grow").click(function(){
			location.href="index.html";
			$("#chart5").removeClass("chartbig");
		});
		$("#darkbg").click(function(){location.href="index.html"});
	}
	});
	$("#grow6").click(function(){
	if(state === 0){
		$("#darkbg").css({"display":"block"}); 
		$("#chart6").addClass("chartbig");
 		$(".grow").css({"display":"block"});
		$("#grow6").find("img").attr({"src":"img/close.png"}); 
		state = 1
	}
	if(state === 1){
		$(".grow").click(function(){
			location.href="index.html";
			$("#chart6").removeClass("chartbig");
		});
		$("#darkbg").click(function(){location.href="index.html"});
	}
	});

});