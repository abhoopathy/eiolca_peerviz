define [
    'jquery',
    'underscore',
    'backbone',
    'jade!templates/searchResults'
], ($, _, Backbone, SearchResultsTemplate) ->

    SearchOverlayView = Backbone.View.extend

        el: $('#search-overlay-box')

        autoCompleteData: []

        events:
            'keyup #search-input': 'inputChanged'

        inputChanged: (e) ->
            searchTerms = this.$search.val()
            if searchTerms.length > 2
                $.getJSON "php/search.php?term=#{searchTerms}", this.updateResults
            else
                this.emptyResults()


        emptyResults: ->
            this.$searchResults.html ''

        updateResults: (results) ->
            compiledTemplate = SearchResultsTemplate({results: results})
            console.log this.$searchResults.html compiledTemplate

        initialize: () ->
            _.bindAll(this)
            this.$search = this.$el.find("#search-input")
            this.$searchResults = this.$el.find(".search-results")


    return SearchOverlayView
