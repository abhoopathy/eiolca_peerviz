define [
    'jquery'
    'backbone'
    'jade!templates/filters/selectFilter'

], (
    $
    Backbone
    SelectFilterTemplate
) ->

    SelectFilterView = Backbone.View.extend

        #### Initialization
        initialize: (filterModel) ->
            _.bindAll(this)
            @filter = filterModel
            @filter.on 'change:data', @filterDataChanged
            @render()

        render: ->
            compiledTemplate =
                SelectFilterTemplate(@filter.toJSON())
            @$el.html(compiledTemplate)


        #### Handling External events
        filterDataChanged: ->
            selection = @filter.get('data').selection
            $option = @$el.find(".select-option[data-val='#{selection}']")
            @select($option)


        #### Handling UI Events
        events:
            'click .remove': 'removeFilter'
            'click .select-option:not(.selected)': 'selectChanged'

        ## On selectbox change, get current value of option.
        ## Set model's urlParam attribute either  to '' or correct
        ## name=val pair.
        selectChanged: (e) ->
            $option = $(e.target)
            @select($option)

            # Get parameter value
            urlParamValue = $option.attr('data-val')
            @filter.set
                data: {selection: urlParamValue}

        select: ($option) ->
            @$el.find('li.select-option.selected')
                .removeClass('selected')
            $option.addClass('selected')

        ## On filter remove, set the url parameter string to '' and trigger
        ## filter:removed
        removeFilter: ->
            @$el.remove()
            @filter.set({urlParam: '', active: false})

    return SelectFilterView
