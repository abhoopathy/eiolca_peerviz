define [
    'jquery',
    'lodash',
    'backbone',
    'jade!templates/searchResults'
], ($, _, Backbone, SearchResultsTemplate) ->

    ## View for search overlay which opens on load, through
    ## the pickNodes view.
    # TODO: when only one result, select it
    # TODO: browser test
    SearchOverlayView = Backbone.View.extend


        #### Initialization ####
        el: $('.search-overlay')

        ## Bind key and mouse events to document
        initialize: () ->
            _.bindAll(this)
            @$el.show()
            @$search = @$el.find("#search-input").focus()
            @$searchResults = @$el.find(".search-results")
            @bindDocumentEvents()

        events:
            'keyup #search-input'       : 'inputChanged'
            'click .search-result'      : 'clickedResult'
            'mouseenter .search-result' : 'mouseOverResult'
            'mouseleave .search-result' : 'mouseOutResult'

        ## Bind key and mouse events to document
        bindDocumentEvents: ->
            $(window).bind('keyup', @handleKeys)
            $(window).bind('mousemove', @rebindHover)

        ## Unbind these afterward to prevent memory leaks
        unbindDocumentEvents: ->
            $(window).unbind('keyup', @handleKeys)
            $(window).unbind('mousemove', @rebindHover)



        #### Handle Mouse & Key Events ####
        mouseOverResult: (e) -> @selectResult $(e.target) if @hoverEnabled
        mouseOutResult: (e) -> @selectReset if @hoverEnabled
        clickedResult: (e) -> @submitResult $(e.target)
        rebindHover: (e) -> @hoverEnabled = true

        # Handle key down/up to select results
        # Enter key submits seleted result.
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
        updateResults: (resultsData) ->
            @resultsData = resultsData
            compiledTemplate =
                SearchResultsTemplate({results: resultsData})
            @$searchResults.html compiledTemplate



        #### Methods for selecting, choosing, scrolling results ####
        ## Called to select next and previous result
        ## with arrow keys
        selectChange: (direction) ->
            if direction not in ['up', 'down']
                return

            @hoverEnabled = false

            # If something is already selected
            if @$selectedResult
                # Get next/prev element
                $newResult =
                    if direction == 'up' then @$selectedResult.prev() else @$selectedResult.next()

                # If there is no next/previous element, reset
                if $newResult.length < 1
                    @$el.find("#search-input").focus()
                    return @selectReset()

                # Else select next/prev element
                else
                    $oldResult = @selectResult($newResult)
                    if direction == 'up' then @scrollUp() else @scrollDown($oldResult)

            # If nothing is selected
            else
                # If nothing already selected, select first or last
                # element (depending on direction)
                if direction == 'up'
                    @selectResult @$searchResults.find('.search-result').last()
                else
                    @selectResult @$searchResults.find('.search-result').first()


        ## Scroll results box up and down with selected result
        scrollUp: -> @$searchResults.scrollTop(
                    @$searchResults.scrollTop() - @$selectedResult.outerHeight())
        scrollDown: ($result) -> @$searchResults.scrollTop(
                    @$searchResults.scrollTop() + $result.outerHeight())

        ## Given jq result object, deselect anything previously selected.
        ## Select result, update input text with new selection.
        selectResult: ($result) ->
            if @$selectedResult
                $oldResult = @$selectedResult.removeClass('selected')
            @$selectedResult = $result.addClass('selected')
            $("#search-input").attr 'value',  @$selectedResult.text()
            return $oldResult

        selectReset: ->
            # Select nothing
            if @$selectedResult
                @$selectedResult.removeClass('selected')
            @$selectedResult = null
            # Empty the input box
            $("#search-input").attr 'value',  ''
            # Scroll to the top of the results
            @$searchResults.scrollTop(0)

        ## Submit a result. Happens both on click and on 'enter'
        submitResult: ($result) ->
            @$el.hide()
            ipedsID = $result.attr 'data-ipedsID'
            nodeData = @resultsData[ipedsID]
            app.events.trigger 'search:resultSubmitted', nodeData
            @unbindDocumentEvents()


    return SearchOverlayView
