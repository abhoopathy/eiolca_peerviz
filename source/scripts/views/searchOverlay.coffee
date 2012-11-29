define [
    'jquery',
    'underscore',
    'backbone',
    'jade!templates/searchResults'
], ($, _, Backbone, SearchResultsTemplate) ->

    SearchOverlayView = Backbone.View.extend

        el: $('.search-overlay')

        autoCompleteData: []

        events:
            'keyup #search-input': 'inputChanged'

        inputChanged: (e) ->
            searchTerms = this.$search.val()
            if e.keyCode != 40 && e.keyCode != 40

                if searchTerms.length == 1
                    # select it
                else if searchTerms.length > 2
                    $.getJSON "php/search.php?term=#{searchTerms}", this.updateResults
                    this.$selectedResult = null
                else
                    this.$selectedResult = null
                    this.emptyResults()

                e.stopPropagation()

        handleKeys: (e) ->
            # downkey
            if  e.keyCode == 40
                this.downPressed()

            # enter key
            if e.keyCode == 13
                this.enterPressed()

        downPressed: ->
            if this.$selectedResult
                this.$selectedResult.removeClass('selected')
                this.$selectedResult = this.$selectedResult.next().addClass('selected')
            else
                this.$selectedResult = this.$searchResults.find('.search-result').first().addClass('selected')

        enterPressed: ->
            console.log this

        emptyResults: ->
            this.$searchResults.html ''

        updateResults: (results) ->
            compiledTemplate = SearchResultsTemplate({results: results})
            this.$searchResults.html compiledTemplate

        initialize: () ->
            _.bindAll(this)
            this.$search = this.$el.find("#search-input")
            this.$searchResults = this.$el.find(".search-results")
            this.$search.focus()
            $(document).bind('keyup', this.handleKeys);

    return SearchOverlayView
