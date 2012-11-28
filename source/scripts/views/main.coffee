define [
    'jquery',
    'underscore',
    'backbone',
    'cs!views/pickNodes',

    'jqueryui',

], ($, _, Backbone, PickNodesView) ->

    MainView = Backbone.View.extend

        el: $('#app-wrapper')

        events: { }

        render: ->

        initialize: () ->
            pickNodesView = new PickNodesView()

    return MainView
