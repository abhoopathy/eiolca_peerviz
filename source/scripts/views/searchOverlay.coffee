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
            if e.keyCode not in [40, 38, 13]

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
                $("#search-input").blur()

            # upkey
            if e.keyCode == 38
                this.upPressed()
                $("#search-input").blur()

            # enter key
            if e.keyCode == 13
                this.enterPressed()

        downPressed: ->
            if this.$selectedResult
                this.$selectedResult.removeClass('selected')
                this.$selectedResult = this.$selectedResult.next().addClass('selected')
            else
                this.$selectedResult = this.$searchResults.find('.search-result').first().addClass('selected')
            $("#search-input").attr 'value',  this.$selectedResult.text()

        upPressed: ->
            if this.$selectedResult
                this.$selectedResult.removeClass('selected')
                this.$selectedResult = this.$selectedResult.prev().addClass('selected')
                $("#search-input").attr 'value',  this.$selectedResult.text()

        enterPressed: ->
            console.log this

        emptyResults: ->
            this.$searchResults.html ''

        updateResults: (results) ->
            compiledTemplate = SearchResultsTemplate({results: results})
            this.$searchResults.html compiledTemplate

        initialize: () ->
            this.$el.show()
            _.bindAll(this)
            this.$search = this.$el.find("#search-input")
            this.$searchResults = this.$el.find(".search-results")
            this.$search.focus()
            $().bind('keyup', this.handleKeys)

    return SearchOverlayView
