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

        render: ->
            compiledTemplate =
                RangeFilterTemplate(this.filter.toJSON())
            this.$el.html(compiledTemplate)


        #### Handling UI Events
        events: {
            'click .remove': 'removeFilter'
        }


        ## On filter remove, set the url parameter string to '' and trigger
        ## filter:removed
        removeFilter: ->
            this.$el.remove()
            this.filter.set({urlParam: ''})
            app.events.trigger('filter:removed', this.filter.id)

    return RangeFilterView
