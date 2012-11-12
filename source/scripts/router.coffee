define [
    'jquery',
    'underscore',
    'backbone',


], ($, _, Backbone ) ->

    Router = Backbone.Router.extend
        routes:
            'search/:term': 'search'
            '*actions': 'defaultAction'

        search: (searchTerm) ->
            console.log searchTerm

       #analytics: () ->
       #    url = Backbone.history.getFragment()
       #    _gaq.push(['_trackPageview', "/#{url}"])

    initialize = ->
        router = new Router
        Backbone.history.start()
        return router


    return {
        initialize: initialize
    }
