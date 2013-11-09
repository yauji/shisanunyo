// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function(){
	// fix issue form----------------------------
	$("#fi_formbody > *").css("display", "none");
	  //  	$("#fi_trName").css("display", "none");
	  
	  	$("#fi_trName").css("display", "table-row");
	$("#fi_trPrincipalCurrency").css("display", "table-row");
	$("#fi_trBaseCurrency").css("display", "table-row");
	$("#fi_trDate").css("display", "table-row");
	$("#fi_trPrincipalJPY").css("display", "table-row");
	$("#fi_trValueForeign").css("display", "table-row");
	$("#fi_trExchangeRate").css("display", "table-row");
	$("#fi_trMemo").css("display", "table-row");

//
	
    $("#fi_requestType").change(function(){
	$("#fi_formbody > *").css("display", "none");

	$("#fi_trName").css("display", "table-row");
	$("#fi_trPrincipalCurrency").css("display", "table-row");
	$("#fi_trBaseCurrency").css("display", "table-row");
	$("#fi_trDate").css("display", "table-row");
	$("#fi_trMemo").css("display", "table-row");
	
			$("#fix_issue_principalCurrency").removeAttr("disabled");
			$("#fix_issue_baseCurrency").removeAttr("disabled");


    	if($("#fi_requestType").val() == "jpy2fc"){
	$("#fi_trPrincipalJPY").css("display", "table-row");
	$("#fi_trValueForeign").css("display", "table-row");
	$("#fi_trExchangeRate").css("display", "table-row");
	
			$("#fi_trPrincipalCurrency").val("JPY");
			$("#fix_issue_principalCurrency").attr("disabled", true);
			$("#fix_issue_baseCurrency").val("AUD");

	
    	}else if($("#fi_requestType").val() == "fc2jpy"){
	$("#fi_trPrincipalForeign").css("display", "table-row");
	$("#fi_trValueJPY").css("display", "table-row");
	$("#fi_trExchangeRate").css("display", "table-row");
	
			$("#fix_issue_baseCurrency").val("JPY");
			$("#fix_issue_baseCurrency").attr("disabled", true);

    		
    	}else if($("#fi_requestType").val() == "teiki_jpy"){
			$("#fi_trPrincipalJPY").css("display", "table-row");
			$("#fi_trInterestRate").css("display", "table-row");
			$("#fi_trDuration").css("display", "table-row");
	
			$("#fi_trPrincipalCurrency").val("JPY");
			$("#fix_issue_principalCurrency").attr("disabled", true);
			$("#fix_issue_baseCurrency").val("JPY");
			$("#fix_issue_baseCurrency").attr("disabled", true);

    		
    	}else if($("#fi_requestType").val() == "teiki_fc"){
	$("#fi_trPrincipalForeign").css("display", "table-row");
	$("#fi_trInterestRate").css("display", "table-row");
	$("#fi_trDuration").css("display", "table-row");
    		
    	}else if($("#fi_requestType").val() == "shikumi_jpy2fc"){
	$("#fi_trPrincipalJPY").css("display", "table-row");
	$("#fi_trExchangeRate").css("display", "table-row");
    		
    	}else if($("#fi_requestType").val() == "shikumi_fc2jpy"){
	$("#fi_trPrincipalForeign").css("display", "table-row");
	$("#fi_trExchangeRate").css("display", "table-row");
    		
    	}else if($("#fi_requestType").val() == "shikumi_fc2fc"){
	$("#fi_trPrincipalForeign").css("display", "table-row");
	$("#fi_trExchangeRate").css("display", "table-row");
    		
    	}else{
    		
    	}
    	
    });


	// unfix issue form----------------------------
	$("#ui_formbody > *").css("display", "none");
	  
	  	$("#ui_trName").css("display", "table-row");
		$("#ui_trPrincipalCurrency").css("display", "table-row");
		$("#ui_trBaseCurrency").css("display", "table-row");
		$("#ui_trMemo").css("display", "table-row");
		$("#ui_trDate").css("display", "table-row");
		$("#ui_trNoItem").css("display", "table-row");
		$("#ui_trPrincipalJPY").css("display", "table-row");
		$("#ui_trBasePrice").css("display", "table-row");
		
		$("#unfix_issue_principalCurrency").attr("disabled", true);
		$("#unfix_issue_baseCurrency").attr("disabled", true);

	
    	$("#ui_requestType").change(function(){
		$("#ui_formbody > *").css("display", "none");

	  	$("#ui_trName").css("display", "table-row");
		$("#ui_trPrincipalCurrency").css("display", "table-row");
		$("#ui_trBaseCurrency").css("display", "table-row");
		$("#ui_trMemo").css("display", "table-row");
		$("#ui_trDate").css("display", "table-row");
		$("#ui_trNoItem").css("display", "table-row");
	
		$("#unfix_issue_principalCurrency").removeAttr("disabled");
		$("#unfix_issue_baseCurrency").removeAttr("disabled");


    	if($("#ui_requestType").val() == "jpy"){
			$("#ui_trPrincipalJPY").css("display", "table-row");
			$("#ui_trBasePrice").css("display", "table-row");
	
			$("#unfix_issue_principalCurrency").val("JPY");
			$("#unfix_issue_principalCurrency").attr("disabled", true);
			$("#unfix_issue_baseCurrency").val("JPY");
			$("#unfix_issue_baseCurrency").attr("disabled", true);

	
    	}else if($("#ui_requestType").val() == "fc"){
			$("#ui_trPrincipalForeign").css("display", "table-row");
			$("#ui_trBasePriceForeign").css("display", "table-row");
	
			$("#unfix_issue_principalCurrency").val("AUD");
			$("#unfix_issue_baseCurrency").val("AUD");
    		
    	}else{
    		
    	}
    	
    });
});

