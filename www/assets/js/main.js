var initTagsSelect2 = function ($el) {
    $el.select2({
        tags: true,
        tokenSeparators: [',', ' '],
        minimumInputLength: 0,
        ajax: {
            dataType: 'json',
            data: function (term, page) {
                return {
                    term: term['term']
                };
            }
        }
    });
    return $el;
};

var redrawSnippets = function (snippets) {
    for (var key in snippets) {
        if (snippets.hasOwnProperty(key)) {
            $('#' + key).html(snippets[key]);
        }
    }
};

var attachCover = function ($el) {
    if ($el.find('.Cover').length == 0) {
        if (!$el.is('body')) {
            $el.css('position', 'relative');
        }
        $('<div class="Cover"><div class="Cover__loader"></div></div>').hide().appendTo($el).fadeIn(200);
    }
};

var detachCover = function ($el) {
    $el.find('.Cover').fadeOut(250, function () {
        $(this).remove();
    });
};

var initMobileNav = function ($nav) {
    $nav.find('select').on('change', function (e) {
        window.location = $(e.target).val();
    })
};

var initEasterEgg = function ($el, pattern) {
    var doBarrelRoll = function () {
        $el.find('body').toggleClass('barrel-roll');
    };
    var typed = "";
    $el.keyup(function (e) {
        if (e.key.length !== 1) return;
        typed += e.key;
        if (typed.length > pattern.length) {
            typed = typed.slice(1);
        }
        if (typed.toLocaleLowerCase() === pattern) {
            doBarrelRoll();
        }
    });
};

jQuery(function ($) {
    $.nette.init();
    $.nette.ext({
        success: function () {
            $.nette.load();
        }
    });

    initMobileNav($('#nav-mobile'));
    initEasterEgg($(document), 'do a barrel roll');
});