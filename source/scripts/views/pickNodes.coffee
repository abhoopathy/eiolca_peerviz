define [
    'jquery',
    'lodash',
    'backbone',
    'cs!views/filtersPane',
    'cs!views/searchOverlay',

    'jqueryui',

], ($, _, Backbone, FiltersPaneView, SearchOverlayView) ->

    PickNodesView = Backbone.View.extend

        el: $('#pick-nodes')

        initialize: () ->
            this.render()
            filtersPaneView = new FiltersPaneView()
            searchOverlayView = new SearchOverlayView()
            #peerResultsView = new peerResultsView()

    return PickNodesView
