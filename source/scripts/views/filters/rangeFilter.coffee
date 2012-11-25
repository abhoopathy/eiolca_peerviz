define [
    'jquery'
    'backbone'
    'jade!templates/filters/rangeFilter'

], (
    $
    Backbone
    RangeFilterTemplate
) ->

    RangeFilterView = Backbone.View.extend

        #### Initialization
        initialize: (filterModel) ->
            this.filter = filterModel
            this.render()
            this.addSlider()

        render: ->
            compiledTemplate =
                RangeFilterTemplate(this.filter.toJSON())
            this.$el.html(compiledTemplate)


        addSlider: ->
            loRange = this.filter.get('loRange')
            hiRange = this.filter.get('hiRange')

            opts =
                view: this
                range: true
                min: loRange
                max: hiRange
                values: [loRange, hiRange]
                slide: (e, ui) ->
                    this.view.loVal = ui.values[0]
                    this.view.hiVal = ui.values[1]

            _.bindAll(opts)

            this.$slider = this.$el.find('#range-slider').slider opts


        #### Handling UI Events
        events:
            'click .remove': 'removeFilter'
            'mouseup a.ui-slider-handle': 'sliderChanged'

        sliderChanged: ->
            console.log this.loVal
            console.log this.hiVal

        ## On filter remove, set the url parameter string to '' and trigger
        ## filter:removed
        removeFilter: ->
            this.$el.remove()
            this.filter.set({urlParam: ''})
            app.events.trigger('filter:removed', this.filter.id)

    return RangeFilterView
