// JavaScript Document
$(document).ready(function(){
	var feedbackBlock = $('.feedback_block')
	$('.feedback_link').click(function(){
		feedbackBlock.fadeIn(200);
		});
	$('.close_fb').click(function(){
		feedbackBlock.fadeOut(150);
		});
	return false;
});