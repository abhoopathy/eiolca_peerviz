define [
    'jquery',
    'underscore',
    'backbone',
], ($, _, Backbone ) ->

    Router = Backbone.Router.extend
        routes:
            '*actions': 'defaultAction'

    initialize = ->
        router = new Router
        Backbone.history.start()
        return router

    return {
        initialize: initialize
    }
