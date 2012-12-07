define [
    'jquery'
    'backbone'
    'jade!templates/filters/rangeFilter'

], (
    $
    Backbone
    RangeFilterTemplate
) ->

    #### View for rendering range filters with a slider
    ## TODO: make mouseup trigger even if not on handle
    RangeFilterView = Backbone.View.extend

        #### Initialization
        initialize: (filterModel) ->
            _.bindAll(this)
            @filter = filterModel
            @filter.on 'change:data', @filterDataChanged
            @render()
            @addSlider()

        render: ->
            compiledTemplate =
                RangeFilterTemplate(@filter.toJSON())
            @$el.html(compiledTemplate)

        addSlider: ->
            loRange = @filter.getConfig('loRange')
            hiRange = @filter.getConfig('hiRange')

            opts =
                view: this
                range: true
                min: loRange
                max: hiRange
                values: [loRange, hiRange]
                slide: (e, ui) ->
                    $tip = @view.$loTip.text(ui.values[0])
                    $tip = @view.$hiTip.text(ui.values[1])
                    @view.loVal = ui.values[0]
                    @view.hiVal = ui.values[1]

            _.bindAll(opts)

            @$slider = @$el.find('.range-slider').slider opts

            @$loTip = @$el.find('.loVal')
            @$hiTip = @$el.find('.hiVal')
            @$el.find('.ui-slider-handle:eq(0)').append @$loTip
            @$el.find('.ui-slider-handle:eq(1)').append @$hiTip


        #### Handling External events
        filterDataChanged: ->
            loVal = @filter.getData('loVal')
            hiVal = @filter.getData('hiVal')
            @$slider.slider( "values", [ loVal, hiVal ] );
            @$loTip.text(loVal)
            @$hiTip.text(hiVal)


        #### Handling UI Events
        events:
            'click .remove'             : 'removeFilter'
            'mouseup .ui-slider-handle' : 'sliderChanged'

        sliderChanged: ->
            @filter.setData
                loVal: @loVal
                hiVal: @hiVal


        ## On filter remove, set the url parameter string to '' and trigger
        ## filter:removed
        removeFilter: ->
            @$el.remove()
            @filter.set({urlParam: ''})
            #app.events.trigger('filter:removed', @filter.id)

    return RangeFilterView
