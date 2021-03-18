$(document).on("turbolinks:load", function () {
	if ($("nav.pagination a[rel=next]").length) {
		$(".user-list").infiniteScroll({
			path: "nav.pagination a[rel=next]",
			append: ".user_list ul",
			elementScroll: true,
			history: true,
			prefill: false,
			status: ".page-load-status",
			hideNav: ".pagination",
		});
	}
});
