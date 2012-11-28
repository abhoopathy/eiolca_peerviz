define [
    'jquery',
    'underscore',
    'backbone',
], ($, _, Backbone) ->

    SearchOverlayView = Backbone.View.extend

        el: $('#search-overlay-box')

        events: { }

        initialize: () ->
            this.$input = this.$el.find('#search-input')
                .autocomplete
                    source: 'php/json_all.php'
                    minLength: 3
                    select: (event, ui) ->
                        console.log event
                        console.log ui

    return SearchOverlayView
