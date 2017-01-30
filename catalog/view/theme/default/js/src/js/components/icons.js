function icon(name) {
	var template = '<svg viewBox="0 0 150 150" class="icon icon-'+ name +'">';
		template +=	'<use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_'+ name +'"></use>';
		template +=	'</svg>';

	return template;
}

module.exports = icon;