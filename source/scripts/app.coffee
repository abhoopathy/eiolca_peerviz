window.app = {}

define [
    'underscore',
    'backbone',

    'cs!router',
    'cs!views/main',


], ( _, Backbone, Router, MainView) ->

        initialize: ->
            app.events = _.extend({}, Backbone.Events)

            mainView = new MainView()
            router = Router.initialize()

            #collection = new NodeCollection()
            #collection.fetch();
