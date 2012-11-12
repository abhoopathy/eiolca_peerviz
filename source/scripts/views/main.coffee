define [
    'jquery',
    'underscore',
    'backbone',

], ($, _, Backbone) ->

    MainView = Backbone.View.extend

        el: $('#app-wrapper')

        events: {
            'click .submit': 'submitHandler'
        }

        initialize: () ->

    return MainView
