
define [
    'underscore',
    'backbone',

    'cs!router',
    'cs!views/pickNodes',

], ( _, Backbone, Router, PickNodesView) ->

        initialize: ->
            window.app =
                events:  _.extend({}, Backbone.Events)

            pickNodesView = new PickNodesView()
            router = Router.initialize()

            #collection = new NodeCollection()
            #collection.fetch();
