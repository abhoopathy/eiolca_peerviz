//Define shortcut aliases

require.config({
    paths: {
        jquery: 'libs/jquery/jquery-1.8.3.min',
        jqueryui: 'libs/jquery/jquery-ui-1.9.2.custom.min',
        lodash: 'libs/lodash/lodash-min',
        backbone: 'libs/backbone/backbone-min'
    },

    shim: {
        backbone: {
            deps: ['lodash', 'jquery'],
            exports: 'Backbone'
        },
        lodash: {
            exports: '_'
        },
        jquery: {
            exports: '$'
        }
    }
});

require(['cs!app'], function(App) {
    App.initialize();
});

