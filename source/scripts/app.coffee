define [
    'underscore',
    'backbone',

    'cs!router',
    'cs!views/main',

    'cs!collections/node'

], ( _, Backbone, Router, MainView,
    NodeModel, NodeCollection) ->

        initialize: ->
            vent = _.extend({}, Backbone.Events)

            mainView = new MainView(vent)
            router = Router.initialize()

            #collection = new NodeCollection()
            #collection.fetch();
