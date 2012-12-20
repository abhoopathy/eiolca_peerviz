define [
    'jquery',
    'lodash',
    'backbone',
    'cs!views/pickNodes',

    'jqueryui',

], ($, _, Backbone, PickNodesView) ->

    MainView = Backbone.View.extend

        el: $('#app-wrapper')

        initialize: () ->
            pickNodesView = new PickNodesView()

    return MainView
