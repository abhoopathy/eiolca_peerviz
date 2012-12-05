define [
    'jquery',
    'underscore',
    'backbone',
    'cs!views/filtersPane',
    'cs!views/searchOverlay',

    'jqueryui',

], ($, _, Backbone, FiltersPaneView, SearchOverlayView) ->

    PickNodesView = Backbone.View.extend

        el: $('#pick-nodes')

        events: {
        }

        render: ->
            #this.$el

        initialize: () ->
            this.render()
            filtersPaneView = new FiltersPaneView()
            searchOverlayView = new SearchOverlayView()

    return PickNodesView
