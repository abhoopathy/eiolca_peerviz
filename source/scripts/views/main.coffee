define [
    'jquery',
    'underscore',
    'backbone',
    'cs!views/filtersPane',

], ($, _, Backbone, FiltersPaneView) ->

    MainView = Backbone.View.extend

        el: $('#app-wrapper')

        events: { }

        render: ->
            #this.$el

        initialize: (vent) ->
            this.render()
            this.vent = vent
            filtersPaneView = new FiltersPaneView(vent)

    return MainView
