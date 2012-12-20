define [
    'jquery',
    'lodash',
    'backbone',
    'cs!views/filtersPane',
    'cs!views/searchOverlay',
    'cs!views/peerResultsPane',
    'cs!collections/node'

    'jqueryui',

], ($, _, Backbone, FiltersPaneView, SearchOverlayView, PeerResultsPaneView, NodeCollection) ->

    PickNodesView = Backbone.View.extend

        el: $('#pick-nodes')

        initialize: () ->
            this.render()

            app.nodes = new NodeCollection()

            filtersPaneView = new FiltersPaneView()
            searchOverlayView = new SearchOverlayView()
            peerResultsPaneView = new PeerResultsPaneView()

    return PickNodesView
