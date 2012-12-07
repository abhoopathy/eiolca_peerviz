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
            this.filter = filterModel
            this.render()

        render: ->
            compiledTemplate =
                SelectFilterTemplate(this.filter.toJSON())
            this.$el.html(compiledTemplate)


        #### Handling UI Events
        events:
            'click .remove': 'removeFilter'
            'click .select-option:not(.selected)': 'selectChanged'

        ## On selectbox change, get current value of option.
        ## Set model's urlParam attribute either  to '' or correct
        ## name=val pair.
        selectChanged: (e) ->
            $option = $(e.target)
            this.$el.find('li.select-option.selected')
                .removeClass('selected')
            $option.addClass('selected')

            # Get parameter value
            urlParamValue = $option.attr('data-val')
            this.filter.set
                data: {selection: urlParamValue}

        ## On filter remove, set the url parameter string to '' and trigger
        ## filter:removed
        removeFilter: ->
            this.$el.remove()
            this.filter.set({urlParam: '', active: false})

    return SelectFilterView
