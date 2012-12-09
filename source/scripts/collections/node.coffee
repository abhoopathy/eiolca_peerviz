define [
    'underscore',
    'jquery',
    'backbone',
    'cs!models/node'

], (_, $, Backbone, NodeModel) ->

    NodeCollection = Backbone.Collection.extend

        model: NodeModel

        url: 'php/json_all.php'

        initialize: ->
            _.bindAll(this)
            app.events.on 'filters:urlParamsChanged', @paramsChanged

        paramsChanged: (params) -> $.getJSON "php/json_all.php#{params}", @dataFetched

        dataFetched: (data) ->
            @add data

    return NodeCollection
