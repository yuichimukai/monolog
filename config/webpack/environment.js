const { environment } = require("@rails/webpacker");

// jQueryとBootstapのJSを使えるように
const webpack = require("webpack");

environment.plugins.prepend(
	"Provide",
	new webpack.ProvidePlugin({
		$: "jquery/src/jquery",
		jQuery: "jquery/src/jquery",
		jquery: "jquery/src/jquery",
	})
);

module.exports = environment;
