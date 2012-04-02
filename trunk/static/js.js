$(document).ready(function () {
	var validateTitle = $(#validateTitle);
	$('tytul').keyup(function () {
	var t = this;
	if (this.value != this.lastValue) {
		if (this.timer) clearTimeout(this.timer);
		validateTitle.removeClass('error').html('<img src="static/images/ajax-loader.gif" height="16" width="16" /> skanuje duplikaty...');
		
		this.timer = setTimeout(function () {
			$.ajax({
				url: 'inc/functions.php',
				data: 'action=check_title&title=' + t.value,
				dataType: 'json',
				type: 'post',
				success: function(j) {
					validateTitle.html(j.msg);
				}
			});
		}, 200);

		this.lastValue = this.value;
	}
});
});