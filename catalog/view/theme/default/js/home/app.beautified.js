!function e(t, n, r) {
    function s(o, u) {
        if (!n[o]) {
            if (!t[o]) {
                var a = "function" == typeof require && require;
                if (!u && a) return a(o, !0);
                if (i) return i(o, !0);
                var f = new Error("Cannot find module '" + o + "'");
                throw f.code = "MODULE_NOT_FOUND", f;
            }
            var l = n[o] = {
                exports: {}
            };
            t[o][0].call(l.exports, function(e) {
                var n = t[o][1][e];
                return s(n ? n : e);
            }, l, l.exports, e, t, n, r);
        }
        return n[o].exports;
    }
    for (var i = "function" == typeof require && require, o = 0; o < r.length; o++) s(r[o]);
    return s;
}({
    1: [ function(require, module, exports) {
        require("./components/popups.js");
        jQuery(document).ready(function() {
            width = window.innerWidth, height = window.innerHeight, $("body").hasClass("home") && (width <= 600 && require("./mobile.js"), 
            width >= 600 && width <= 800 && require("./tablet.js"), width >= 800 && require("./desktop.js"), 
            $(".feature-point").on("click", function(e) {
                e.preventDefault(), $(".features-list").toggleClass("active"), $(".feature").removeClass("active"), 
                $(this).parent().toggleClass("active");
            }), $(".close-x").on("click", function(e) {
                e.preventDefault(), $(".features-list").removeClass("active"), $(this).parent().parent().removeClass("active");
            })), $("body").hasClass("store") && require("./store.js"), $("body").hasClass("checkout") && (require("./checkout.js"), 
            require("./components/tabs.js")), $(".scroll-to-start a").on("click", function(e) {
                e.preventDefault(), $(window).scrollTo("#why", 1e3, {
                    offset: {
                        top: 800
                    }
                });
            }), $(".back-top").on("click", function(e) {
                e.preventDefault(), $(window).scrollTo(0, 5e3);
            });
        });
    }, {
        "./checkout.js": 2,
        "./components/popups.js": 4,
        "./components/tabs.js": 5,
        "./desktop.js": 6,
        "./mobile.js": 7,
        "./store.js": 8,
        "./tablet.js": 9
    } ],
    2: [ function(require, module, exports) {
        !function() {
            $("#same-address").on("click", function() {
                $(".shipping-address .fields-wrap").toggleClass("expanded"), $(".shipping-address .form-note").toggleClass("show");
            }), $("#continue-to-payment").on("click", function() {
                $("#payment-selection").addClass("expanded"), $("#address-info").addClass("done").removeClass("expanded"), 
                $(".col-right-footer").show();
            }), $("#back-to-address").on("click", function() {
                $("#payment-selection").removeClass("expanded"), $("#address-info").removeClass("done").addClass("expanded"), 
                $(".col-right-footer").hide();
            });
        }();
    }, {} ],
    3: [ function(require, module, exports) {
        function icon(name) {
            var template = '<svg viewBox="0 0 150 150" class="icon icon-' + name + '">';
            return template += '<use xlink:href="catalog/view/theme/default/icons/sprite.svg#icon_' + name + '"></use>', 
            template += "</svg>";
        }
        module.exports = icon;
    }, {} ],
    4: [ function(require, module, exports) {
        icon = require("./icons.js"), window.createPopup = function(view) {
            $.ajax({
                url: view,
                cache: !1
            }).done(function(html) {
                var template = '<div class="popup-wrap">';
                template += '<div class="overlay"></div>', template += '<div class="popup-container">', 
                template += '<div class="popup-content">', template += html, template += "</div><!-- .popup-content -->", 
                template += '<a href="javascript:void(0)" class="x" onclick="$(this).parent().parent().remove()">', 
                template += icon("x"), template += "</a>", template += "</div><!-- .popup-container -->", 
                template += "</div><!-- .popup-wrap -->", $(document.body).append(template);
            });
        }, window.popupFromPopup = function(view) {
            $(".popup-container").addClass("fadeOut"), setTimeout(function() {
                $.ajax({
                    url: view,
                    cache: !0
                }).done(function(html) {
                    $(".popup-container").removeClass("fadeOut"), $(".popup-content").html(html);
                });
            }, 500);
        }, window.toast = function(message, type, callback) {
            var template = '<div class="toast">';
            template += '<div class="message">', "success" === type && (template += icon("check")), 
            template += message, template += "</div>", template += "</div>", $("body").append(template), 
            setTimeout(function() {
                $(".toast").addClass("fadeOut");
            }, 1500), setTimeout(function() {
                $(".toast").remove, callback();
            }, 2e3);
        };
    }, {
        "./icons.js": 3
    } ],
    5: [ function(require, module, exports) {
        window.createTabs = function(evt, tab) {
            var i, tabcontent, tablinks;
            for (tabcontent = document.getElementsByClassName("tab-content"), i = 0; i < tabcontent.length; i++) tabcontent[i].style.display = "none";
            for (tablinks = document.getElementsByClassName("tab-link"), i = 0; i < tablinks.length; i++) tablinks[i].className = tablinks[i].className.replace(" active", "");
            document.getElementById(tab).style.display = "block", evt.currentTarget.className += " active";
        };
    }, {} ],
    6: [ function(require, module, exports) {
        !function() {
            var ww = window.innerWidth, wh = window.innerHeight, saber = $("#intro .saber-photo"), sh = (saber.width(), 
            saber.height()), controller = new ScrollMagic.Controller(), starScroll = new TimelineMax({
                repeat: 0,
                yoyo: !0
            }).add([ TweenMax.fromTo("#intro .saber-photo", 1, {
                rotation: 90,
                y: sh / 2,
                scale: .5
            }, {
                rotation: 0
            }), TweenMax.to("#intro .scroll-to-start", .5, {
                opacity: 0
            }) ]), split = (new TimelineMax({
                repeat: -1,
                yoyo: !0
            }).add(TweenMax.to("#intro .scroll-to-start span", .7, {
                opacity: 0
            })), new ScrollMagic.Scene({
                triggerElement: "#intro",
                duration: 700,
                triggerHook: "onLeave"
            }).setTween(starScroll).setPin("#intro").addTo(controller), new TimelineMax({
                repeat: 0,
                yoyo: !0
            }).add([ TweenMax.to(".sabermach-title .to-left", 1, {
                x: -1500,
                opacity: 0
            }), TweenMax.to(".sabermach-title .to-right", 1, {
                x: 1500,
                opacity: 0
            }) ]));
            new ScrollMagic.Scene({
                triggerElement: "#intro",
                triggerHook: "onEnter",
                duration: 2e3,
                offset: 1800
            }).setTween(split).addTo(controller);
            var showDescription = (new ScrollMagic.Scene({
                triggerElement: "#why",
                duration: 4e3,
                triggerHook: "onLeave"
            }).setPin("#why").addTo(controller), new TimelineMax({
                repeat: 0,
                yoyo: !0
            }).add([ TweenMax.fromTo("#why .why-intro", .1, {
                x: -1e3
            }, {
                x: 0
            }), TweenMax.to("#intro .saber-photo", .1, {
                y: .2 * wh,
                scale: 1.2
            }), TweenMax.to("#why .do-action-text", .1, {
                opacity: 1
            }) ]));
            new ScrollMagic.Scene({
                triggerElement: "#why",
                duration: 700,
                triggerHook: "onLeave"
            }).setTween(showDescription).addTo(controller);
            new ScrollMagic.Scene({
                triggerElement: "#why",
                triggerHook: "onLeave",
                duration: 2e3,
                offset: 1500
            }).setTween(TweenMax.to("#intro .saber-photo", .5, {
                backgroundPosition: "-4305px 0",
                ease: SteppedEase.config(35),
                yoyo: !0,
                repeat: 0
            })).addTo(controller);
            var showList = new TimelineMax({
                repeat: 0,
                yoyo: !0
            }).add([ TweenMax.to("#why .why-intro", .1, {
                x: "-100%"
            }), TweenMax.to("#why .why-list", .1, {
                x: 0
            }), TweenMax.to("#intro .saber-photo", .1, {
                x: -(.2 * ww)
            }), TweenMax.to("#why .do-action-text", .1, {
                x: -(.2 * ww)
            }) ]);
            new ScrollMagic.Scene({
                triggerElement: "#why",
                duration: 700,
                offset: 1200,
                triggerHook: "onLeave"
            }).setTween(showList).addTo(controller);
            new ScrollMagic.Scene({
                triggerElement: "#why",
                triggerHook: "onLeave",
                offset: 1700
            }).setClassToggle("#item-1", "active").addTo(controller), new ScrollMagic.Scene({
                triggerElement: "#why",
                triggerHook: "onLeave",
                offset: 2200
            }).setClassToggle("#item-2", "active").addTo(controller).on("enter", function(event) {
                $("#item-1").removeClass("active");
            }).on("leave", function(event) {
                $("#item-1").addClass("active");
            }), new ScrollMagic.Scene({
                triggerElement: "#why",
                triggerHook: "onLeave",
                offset: 2700
            }).setClassToggle("#item-3", "active").addTo(controller).on("enter", function(event) {
                $("#item-2").removeClass("active");
            }).on("leave", function(event) {
                $("#item-2").addClass("active");
            }), new ScrollMagic.Scene({
                triggerElement: "#why",
                triggerHook: "onLeave",
                offset: 3200
            }).setClassToggle("#item-4", "active").addTo(controller).on("enter", function(event) {
                $("#item-3").removeClass("active");
            }).on("leave", function(event) {
                $("#item-3").addClass("active");
            });
            var hideList = new TimelineMax({
                repeat: 0,
                yoyo: !0
            }).add([ TweenMax.to("#why .why-list", .1, {
                x: 2e3
            }), TweenMax.to("#intro .saber-photo", .1, {
                x: "0%",
                y: sh / 2,
                scale: .5
            }), TweenMax.to("#why .do-action-text", .1, {
                x: "0%",
                opacity: 0
            }) ]);
            new ScrollMagic.Scene({
                triggerElement: "#why",
                duration: 700,
                offset: 3700,
                triggerHook: "onLeave"
            }).setTween(hideList).addTo(controller);
            new ScrollMagic.Scene({
                triggerElement: "#features",
                duration: 3200,
                triggerHook: "onLeave"
            }).setPin("#features").addTo(controller);
            var rotateSaber = TweenMax.to("#intro .saber-photo", 1, {
                rotation: 270
            });
            new ScrollMagic.Scene({
                triggerElement: "#features",
                duration: 1500,
                triggerHook: "onLeave"
            }).setTween(rotateSaber).addTo(controller);
            var showFeatures = new TimelineMax({
                repeat: 0,
                yoyo: !0
            }).add([ TweenMax.to("#intro .saber-photo", .1, {
                opacity: 0,
                position: "relative"
            }), TweenMax.fromTo("#features .saber-photo", .2, {
                opacity: 0,
                rotation: 270,
                scale: .5,
                y: sh / 2
            }, {
                opacity: 1,
                position: "absolute"
            }), TweenMax.fromTo(".features-list", .9, {
                opacity: 0
            }, {
                opacity: 1
            }), TweenMax.to(".do-action-text", 1, {
                opacity: 1
            }) ]);
            new ScrollMagic.Scene({
                triggerElement: "#features",
                duration: 800,
                offset: 1500,
                triggerHook: "onLeave"
            }).setTween(showFeatures).addTo(controller);
            new ScrollMagic.Scene({
                triggerElement: "#carousel",
                triggerHook: "onLeave"
            }).setClassToggle("#cta", "active").addTo(controller), new ScrollMagic.Scene({
                triggerElement: "#carousel",
                triggerHook: "onLeave",
                offset: -800
            }).on("start", function(event) {
                "FORWARD" == event.scrollDirection && $(window).scrollTo("#carousel", 1e3);
            }).addTo(controller);
            new Swiper("#sabers-carousel", {
                effect: "coverflow",
                grabCursor: !0,
                centeredSlides: !0,
                nextButton: ".swiper-button-next",
                prevButton: ".swiper-button-prev",
                slidesPerView: 3,
                coverflow: {
                    rotate: 0,
                    stretch: 20,
                    depth: 50,
                    modifier: 9,
                    slideShadows: !1
                }
            });
        }();
    }, {} ],
    7: [ function(require, module, exports) {
        !function() {
            var wh = (window.innerWidth, window.innerHeight), saber = $("#intro .saber-photo"), sh = (saber.width(), 
            saber.height()), controller = new ScrollMagic.Controller(), starScroll = new TimelineMax({
                repeat: 0,
                yoyo: !0
            }).add([ TweenMax.fromTo("#intro .saber-photo", 1, {
                y: sh / 2.5,
                scale: .4
            }, {
                y: sh / 2.5,
                scale: .5
            }), TweenMax.to("#intro .scroll-to-start", .5, {
                opacity: 0
            }) ]), split = (new TimelineMax({
                repeat: -1,
                yoyo: !0
            }).add(TweenMax.to("#intro .scroll-to-start span", .7, {
                opacity: 0
            })), new ScrollMagic.Scene({
                triggerElement: "#intro",
                duration: 400,
                triggerHook: "onLeave"
            }).setTween(starScroll).setPin("#intro").addTo(controller), new TimelineMax({
                repeat: 0,
                yoyo: !0
            }).add([ TweenMax.to(".sabermach-title .to-left", 1, {
                x: -1500,
                opacity: 0
            }), TweenMax.to(".sabermach-title .to-right", 1, {
                x: 1500,
                opacity: 0
            }) ]));
            new ScrollMagic.Scene({
                triggerElement: "#intro",
                triggerHook: "onEnter",
                duration: 1e3,
                offset: 1e3
            }).setTween(split).addTo(controller), new ScrollMagic.Scene({
                triggerElement: "#why",
                triggerHook: "onEnter"
            }).setClassToggle("#intro .saber-photo", "fixed").addTo(controller);
            var showListOffset = 2600, whyListDuration = 500, showDescription = (new ScrollMagic.Scene({
                triggerElement: "#why",
                duration: showListOffset + 6 * whyListDuration,
                triggerHook: "onLeave"
            }).setPin("#why").addTo(controller), new TimelineMax({
                repeat: 0,
                yoyo: !0
            }).add([ TweenMax.to("#intro .saber-photo", .1, {
                y: .1 * wh,
                scale: 1.2
            }), TweenMax.to("#why .do-action-text", .1, {
                opacity: 1
            }) ]));
            new ScrollMagic.Scene({
                triggerElement: "#why",
                duration: 700,
                triggerHook: "onLeave"
            }).setTween(showDescription).addTo(controller);
            new ScrollMagic.Scene({
                triggerElement: "#why",
                triggerHook: "onLeave",
                duration: 2e3,
                offset: 500
            }).setTween(TweenMax.to("#intro .saber-photo", .5, {
                backgroundPosition: "-4305px 0",
                ease: SteppedEase.config(35),
                yoyo: !0,
                repeat: 0
            })).addTo(controller);
            var showList = new TimelineMax({
                repeat: 0,
                yoyo: !0
            }).add([ TweenMax.to("#why .why-intro", .1, {
                x: -1e3
            }), TweenMax.to("#why .why-list", .1, {
                x: 0
            }), TweenMax.to("#intro .saber-photo", .1, {
                x: -400
            }), TweenMax.to("#why .do-action-text", .1, {
                x: -400
            }) ]);
            new ScrollMagic.Scene({
                triggerElement: "#why",
                duration: 700,
                offset: showListOffset,
                triggerHook: "onLeave"
            }).setTween(showList).addTo(controller);
            new ScrollMagic.Scene({
                triggerElement: "#why",
                triggerHook: "onLeave",
                offset: showListOffset + 1 * whyListDuration
            }).setClassToggle("#item-1", "active").addTo(controller), new ScrollMagic.Scene({
                triggerElement: "#why",
                triggerHook: "onLeave",
                offset: showListOffset + 2 * whyListDuration
            }).setClassToggle("#item-2", "active").addTo(controller).on("enter", function(event) {
                $("#item-1").removeClass("active");
            }).on("leave", function(event) {
                $("#item-1").addClass("active");
            }), new ScrollMagic.Scene({
                triggerElement: "#why",
                triggerHook: "onLeave",
                offset: showListOffset + 3 * whyListDuration
            }).setClassToggle("#item-3", "active").addTo(controller).on("enter", function(event) {
                $("#item-2").removeClass("active");
            }).on("leave", function(event) {
                $("#item-2").addClass("active");
            }), new ScrollMagic.Scene({
                triggerElement: "#why",
                triggerHook: "onLeave",
                offset: showListOffset + 4 * whyListDuration
            }).setClassToggle("#item-4", "active").addTo(controller).on("enter", function(event) {
                $("#item-3").removeClass("active");
            }).on("leave", function(event) {
                $("#item-3").addClass("active");
            });
            var hideList = new TimelineMax({
                repeat: 0,
                yoyo: !0
            }).add([ TweenMax.to("#why .why-list", .1, {
                x: 600
            }), TweenMax.to("#intro .saber-photo", .1, {
                x: 0,
                y: .4 * wh,
                scale: 1
            }), TweenMax.to("#why .do-action-text", .1, {
                x: 0,
                opacity: 0
            }) ]);
            new ScrollMagic.Scene({
                triggerElement: "#why",
                duration: 1e3,
                offset: showListOffset + 5 * whyListDuration,
                triggerHook: "onLeave"
            }).setTween(hideList).addTo(controller);
            new ScrollMagic.Scene({
                triggerElement: "#features",
                duration: 3200,
                triggerHook: "onLeave"
            }).setPin("#features").addTo(controller), new ScrollMagic.Scene({
                triggerElement: "#features",
                duration: 1500,
                triggerHook: "onLeave"
            }).setTween(TweenMax.to("#intro .saber-photo", 1, {
                scale: .8,
                y: .5 * wh
            })).addTo(controller);
            var showFeatures = new TimelineMax({
                repeat: 0,
                yoyo: !0
            }).add([ TweenMax.to("#intro .saber-photo", .1, {
                opacity: 0,
                position: "relative"
            }), TweenMax.fromTo("#features .saber-photo", .2, {
                opacity: 0,
                rotation: 0,
                scale: .8,
                y: .5 * wh,
                position: "absolute"
            }, {
                opacity: 1
            }), TweenMax.fromTo(".features-list", .9, {
                opacity: 0
            }, {
                opacity: 1
            }), TweenMax.to(".do-action-text", 1, {
                opacity: 1
            }) ]);
            new ScrollMagic.Scene({
                triggerElement: "#features",
                duration: 800,
                offset: 1500,
                triggerHook: "onLeave"
            }).setTween(showFeatures).addTo(controller);
            new ScrollMagic.Scene({
                triggerElement: "#carousel",
                triggerHook: "onLeave"
            }).setClassToggle("#cta", "active").addTo(controller), new ScrollMagic.Scene({
                triggerElement: "#carousel",
                triggerHook: "onLeave",
                offset: -800
            }).on("start", function(event) {
                "FORWARD" == event.scrollDirection && $(window).scrollTo("#carousel", 1e3);
            }).addTo(controller);
            new Swiper("#sabers-carousel", {
                centeredSlides: !0,
                loop: !0,
                freeMode: !0,
                nextButton: ".swiper-button-next",
                prevButton: ".swiper-button-prev",
                slidesPerView: 1.5,
                coverflow: {
                    rotate: 0,
                    stretch: 20,
                    depth: 50,
                    modifier: 9,
                    slideShadows: !1
                }
            });
        }();
    }, {} ],
    8: [ function(require, module, exports) {
        var icon = require("./components/icons.js");
        !function() {
            $(".choose-series-radio").on("click", function() {
                var data = $(this).data();
                $("#sounds strong").html(data.sounds), $("#colors strong").html(data.colors), "expert-t" === data.name ? $("#series-selection").html("Expert " + icon("thunder")) : $("#series-selection").html(data.name), 
                $("#saber-series").addClass("done").removeClass("expanded"), $("#saber-hilt").hasClass("done") || $("#saber-hilt").addClass("expanded"), 
                "checkbox" === $(".choose-color-radio").attr("type") && $(".choose-color-radio").attr("type", "radio").prop({
                    checked: !1,
                    disabled: !1
                });
            }), $(".choose-hilt-radio").on("click", function() {
                var data = $(this).data();
                $("#hilt-selection").html(data.name), $("#saber-hilt").addClass("done").removeClass("expanded"), 
                $("#saber-color").addClass("expanded");
            }), $(".choose-color-radio").on("click", function() {
                var data = $(this).data();
                $("#colors-selection").html(data.name), $("#saber-color").addClass("done").removeClass("expanded"), 
                console.log("hello");
            }), $(".selection").on("click", function() {
                $(this).parent().addClass("expanded");
            });
        }();
    }, {
        "./components/icons.js": 3
    } ],
    9: [ function(require, module, exports) {
        !function() {
            var saber = (window.innerWidth, window.innerHeight, $("#intro .saber-photo")), sh = (saber.width(), 
            saber.height()), controller = new ScrollMagic.Controller(), starScroll = new TimelineMax({
                repeat: 0,
                yoyo: !0
            }).add([ TweenMax.fromTo("#intro .saber-photo", 1, {
                rotation: 90,
                y: sh / 2,
                scale: .5
            }, {
                rotation: 0
            }), TweenMax.to("#intro .scroll-to-start", .5, {
                opacity: 0
            }) ]), split = (new TimelineMax({
                repeat: -1,
                yoyo: !0
            }).add(TweenMax.to("#intro .scroll-to-start span", .7, {
                opacity: 0
            })), new ScrollMagic.Scene({
                triggerElement: "#intro",
                duration: 700,
                triggerHook: "onLeave"
            }).setTween(starScroll).setPin("#intro").addTo(controller), new TimelineMax({
                repeat: 0,
                yoyo: !0
            }).add([ TweenMax.to(".sabermach-title .to-left", 1, {
                x: -1500,
                opacity: 0
            }), TweenMax.to(".sabermach-title .to-right", 1, {
                x: 1500,
                opacity: 0
            }) ]));
            new ScrollMagic.Scene({
                triggerElement: "#intro",
                triggerHook: "onEnter",
                duration: 2e3,
                offset: 1800
            }).setTween(split).addTo(controller), new ScrollMagic.Scene({
                triggerElement: "#why",
                triggerHook: "onEnter"
            }).setClassToggle("#intro .saber-image", "fixed").addTo(controller);
            var showDescription = (new ScrollMagic.Scene({
                triggerElement: "#why",
                duration: 4e3,
                triggerHook: "onLeave"
            }).setPin("#why").addTo(controller), new TimelineMax({
                repeat: 0,
                yoyo: !0
            }).add([ TweenMax.fromTo("#why .why-intro", .1, {
                x: -1e3
            }, {
                x: 0
            }), TweenMax.to("#intro .saber-image", .1, {
                x: 150,
                y: -(.1 * sh),
                scale: 1.2
            }), TweenMax.to("#why .do-action-text", .1, {
                opacity: 1
            }) ]));
            new ScrollMagic.Scene({
                triggerElement: "#why",
                duration: 700,
                triggerHook: "onLeave"
            }).setTween(showDescription).addTo(controller);
            new ScrollMagic.Scene({
                triggerElement: "#why",
                triggerHook: "onLeave",
                duration: 2e3,
                offset: 1500
            }).setTween(TweenMax.to("#intro .saber-photo", .5, {
                backgroundPosition: "-4305px 0",
                ease: SteppedEase.config(35),
                yoyo: !0,
                repeat: 0
            })).addTo(controller);
            var showList = new TimelineMax({
                repeat: 0,
                yoyo: !0
            }).add([ TweenMax.to("#why .why-intro", .1, {
                x: -1e3
            }), TweenMax.to("#why .why-list", .1, {
                x: 0
            }), TweenMax.to("#intro .saber-image", .1, {
                x: -200
            }), TweenMax.to("#why .do-action-text", .1, {
                x: -200
            }) ]);
            new ScrollMagic.Scene({
                triggerElement: "#why",
                duration: 700,
                offset: 1200,
                triggerHook: "onLeave"
            }).setTween(showList).addTo(controller);
            new ScrollMagic.Scene({
                triggerElement: "#why",
                triggerHook: "onLeave",
                offset: 1700
            }).setClassToggle("#item-1", "active").addTo(controller), new ScrollMagic.Scene({
                triggerElement: "#why",
                triggerHook: "onLeave",
                offset: 2200
            }).setClassToggle("#item-2", "active").addTo(controller).on("enter", function(event) {
                $("#item-1").removeClass("active");
            }).on("leave", function(event) {
                $("#item-1").addClass("active");
            }), new ScrollMagic.Scene({
                triggerElement: "#why",
                triggerHook: "onLeave",
                offset: 2700
            }).setClassToggle("#item-3", "active").addTo(controller).on("enter", function(event) {
                $("#item-2").removeClass("active");
            }).on("leave", function(event) {
                $("#item-2").addClass("active");
            }), new ScrollMagic.Scene({
                triggerElement: "#why",
                triggerHook: "onLeave",
                offset: 3200
            }).setClassToggle("#item-4", "active").addTo(controller).on("enter", function(event) {
                $("#item-3").removeClass("active");
            }).on("leave", function(event) {
                $("#item-3").addClass("active");
            });
            var hideList = new TimelineMax({
                repeat: 0,
                yoyo: !0
            }).add([ TweenMax.to("#why .why-list", .1, {
                x: 2e3
            }), TweenMax.to("#intro .saber-image", .1, {
                x: 0,
                y: 0,
                scale: 1
            }), TweenMax.to("#why .do-action-text", .1, {
                x: 0,
                opacity: 0
            }) ]);
            new ScrollMagic.Scene({
                triggerElement: "#why",
                duration: 700,
                offset: 3700,
                triggerHook: "onLeave"
            }).setTween(hideList).addTo(controller);
            new ScrollMagic.Scene({
                triggerElement: "#features",
                duration: 3200,
                triggerHook: "onLeave"
            }).setPin("#features").addTo(controller);
            var rotateSaber = TweenMax.to("#intro .saber-image", 1, {
                rotation: 270
            });
            new ScrollMagic.Scene({
                triggerElement: "#features",
                duration: 1500,
                triggerHook: "onLeave"
            }).setTween(rotateSaber).addTo(controller);
            var showFeatures = new TimelineMax({
                repeat: 0,
                yoyo: !0
            }).add([ TweenMax.to("#intro .saber-photo", .1, {
                opacity: 0,
                position: "relative"
            }), TweenMax.fromTo("#features .saber-photo", .2, {
                opacity: 0,
                rotation: 270,
                scale: .5,
                y: .5 * sh,
                position: "absolute"
            }, {
                opacity: 1
            }), TweenMax.fromTo(".features-list", .9, {
                opacity: 0
            }, {
                opacity: 1
            }), TweenMax.to(".do-action-text", 1, {
                opacity: 1
            }) ]);
            new ScrollMagic.Scene({
                triggerElement: "#features",
                duration: 800,
                offset: 1500,
                triggerHook: "onLeave"
            }).setTween(showFeatures).addTo(controller);
            new ScrollMagic.Scene({
                triggerElement: "#carousel",
                triggerHook: "onLeave"
            }).setClassToggle("#cta", "active").addTo(controller), new ScrollMagic.Scene({
                triggerElement: "#carousel",
                triggerHook: "onLeave",
                offset: -800
            }).on("start", function(event) {
                "FORWARD" == event.scrollDirection && $(window).scrollTo("#carousel", 1e3);
            }).addTo(controller);
            new Swiper("#sabers-carousel", {
                effect: "coverflow",
                grabCursor: !0,
                centeredSlides: !0,
                nextButton: ".swiper-button-next",
                prevButton: ".swiper-button-prev",
                slidesPerView: 2,
                coverflow: {
                    rotate: 0,
                    stretch: 20,
                    depth: 40,
                    modifier: 6,
                    slideShadows: !1
                }
            });
        }();
    }, {} ]
}, {}, [ 1 ]);