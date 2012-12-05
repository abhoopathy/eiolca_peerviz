define [
    'jquery',
    'underscore',
    'backbone',
    'jade!templates/searchResults'
], ($, _, Backbone, SearchResultsTemplate) ->

    SearchOverlayView = Backbone.View.extend


        #### Initialization ####

        el: $('.search-overlay')

        initialize: () ->
            _.bindAll(@)
            @$el.show()
            @$search = @$el.find("#search-input").focus()
            @$searchResults = @$el.find(".search-results")
            @handleKeyPresses()

        events:
            'keyup #search-input': 'inputChanged'
            'mouseenter .search-result': 'mouseOverResult'
            'mouseleave .search-result': 'mouseOutResult'
            'click .search-result': 'clickedResult'



        #### Handle Autocomplete Fetching ####

        ## On input change, fetch results and update
        inputChanged: (e) ->
            searchTerms = @$search.val()
            if e.keyCode not in [40, 38, 13]

                if searchTerms.length == 1
                    # select it
                else if searchTerms.length > 2
                    $.getJSON "php/search.php?term=#{searchTerms}", @updateResults
                    @$selectedResult = null
                else
                    @$selectedResult = null
                    @emptyResults()

                    e.stopPropagation()

        ## Empty results container
        emptyResults: -> @$searchResults.html ''

        ## Update results container given results json
        updateResults: (results) ->
            compiledTemplate = SearchResultsTemplate({results: results})
            @$searchResults.html compiledTemplate



        #### Handle Mouse Events ####
        mouseOverResult: (e) -> @selectResult $(e.target)
        mouseOutResult: (e) -> @selectReset
        clickedResult: (e) -> @submitResult $(e.target)



        #### Handle Key Events ####

        ## Bind them to document
        handleKeyPresses: -> $(window).bind('keyup', @handleKeys)

        ## Handle down, up, and enter
        handleKeys: (e) ->
            e.stopPropagation()
            # downkey
            if  e.keyCode == 40
                @selectChange('down')

            # upkey
            if e.keyCode == 38
                @selectChange('up')

            # enter key
            if e.keyCode == 13
                @submitResult @$selectedResult



        #### Methods for selecting results, and choosing them. ####

        ## Called to select next and previous result
        ## with arrow keys
        selectChange: (direction) ->
            if direction in ['up', 'down']
                if @$selectedResult
                    # next/prev element
                    $newResult =
                        if direction == 'up' then @$selectedResult.prev() else @$selectedResult.next()
                    # If there is no next/previous element, reset
                    if $newResult.length < 1
                      @$el.find("#search-input").focus()
                      return @selectReset()
                    @selectResult $newResult
                    @scrollTo $newResult
                else
                    # If nothing already selected, select first or last
                    # element (depending on direction)
                    if direction == 'up'
                      @selectResult @$searchResults.find('.search-result').last()
                    else
                      @selectResult @$searchResults.find('.search-result').first()

        scrollTo: ($result) ->
            top = $result.position().top - @$searchResults.position().top
            @$searchResults.scrollTop(top)

        ## Given jq result object, deselect anything previously selected.
        ## Select result, update input text with new selection.
        ## Used for both keyboard and mouse events.
        selectResult: ($result) ->
            if @$selectedResult
                @$selectedResult.removeClass('selected')
            @$selectedResult = $result.addClass('selected')
            $("#search-input").attr 'value',  @$selectedResult.text()

        ## Selects nothing, updates input box 
        selectReset: ->
            if @$selectedResult
                @$selectedResult.removeClass('selected')
            @$selectedResult = null
            $("#search-input").attr 'value',  ''

        ## Submit a result. Happens both on click and on 'enter'
        submitResult: ($result) ->
            @$el.hide()
            ipedsID = $result.attr 'data-ipedsID'
            app.events.trigger 'search:resultSubmitted', ipedsID


    return SearchOverlayView
