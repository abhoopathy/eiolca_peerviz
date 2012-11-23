define [
    'jquery',
    'underscore',
    'backbone',


], ($, _, Backbone ) ->

    # The Backbone Router. It is cool
    Router = Backbone.Router.extend

        # Set up routes for searching for things,
        # and a defaultAction route if nothing else
        # is matched (must be last)
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
