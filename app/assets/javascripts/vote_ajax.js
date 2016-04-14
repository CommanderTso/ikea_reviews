$(document).ready(function() {
  $("a.vote_change").click(function(event) {
    event.preventDefault();

    var request = $.ajax({
			method: "GET",
			url: $(this).attr('ajax_path')
		});

    request.done(function(data) {
      if ('new_score' in data) {
        $('li#review-rating-' + data.review_id).text("Review rating: " + data.new_score);
      } else {
        if ($('div.flash_message').text != data.login_error) {
           $('div.flash_message').text(data.login_error)
        }
      }

    });
  });
});
