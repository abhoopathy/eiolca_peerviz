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
                    $tip = this.view.$loTip.text(ui.values[0])
                    $tip = this.view.$hiTip.text(ui.values[1])
                    this.view.loVal = ui.values[0]
                    this.view.hiVal = ui.values[1]

            _.bindAll(opts)

            this.$slider = this.$el.find('.range-slider').slider opts

            this.$loTip = this.$el.find('.loVal')
            this.$hiTip = this.$el.find('.hiVal')
            this.$el.find('.ui-slider-handle:eq(0)').append this.$loTip
            this.$el.find('.ui-slider-handle:eq(1)').append this.$hiTip




        #### Handling UI Events
        events:
            'click .remove': 'removeFilter'
            'mouseup .ui-slider-handle': 'sliderChanged'

        sliderChanged: ->

            if this.loVal == this.filter.get('loRange')
                loStr = ''
            else
                loStr = this.filter.get('loUrlParamName') +
                    '=' + this.loVal

            if this.hiVal == this.filter.get('hiRange')
                hiStr = ''
            else
                hiStr = (if loStr == '' then '' else '&') +
                    this.filter.get('hiUrlParamName') +
                    '=' + this.hiVal

            this.filter.set { urlParam: loStr + hiStr }


        ## On filter remove, set the url parameter string to '' and trigger
        ## filter:removed
        removeFilter: ->
            this.$el.remove()
            this.filter.set({urlParam: ''})
            app.events.trigger('filter:removed', this.filter.id)

    return RangeFilterView
