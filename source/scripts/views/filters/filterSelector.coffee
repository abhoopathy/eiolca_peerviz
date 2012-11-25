define [
    'jquery', 'backbone',
    'jade!templates/filters/filterSelector'

], ($, Backbone, FilterSelectorTemplate) ->

    FilterSelectorView = Backbone.View.extend

        #### Initialization

        el: $('#filter-selector')

        initialize: (filterCollection) ->
            this.filters = filterCollection
            this.render()
            this.bindEvents()
            this.$list = this.$el.find('ul')

        render: ->
            compiledTemplate = FilterSelectorTemplate({filters: this.filters.toJSON()})
            this.$el.find('ul').html(compiledTemplate)


        #### Handle External events

        ## Bind external events
        bindEvents: ->
            _.bindAll(this)
            app.events.on('filter:removed', this.filterRemovedHandler)

        ## When filter is removed, show that filter option in selector
        filterRemovedHandler: (filterID) ->
            $li = this.$el.find("li[data-filterID='#{filterID}']")
            $li.show()


        #### Handling UI Events

        events:
            'click a': 'addFilter'

        ## When user add's a filter form selector, hide the option from
        ## the menu and trigger the addClicked event
        addFilter: (e) ->
            $li = $(e.target).closest('li')
            filterID = $li.attr('data-filterID')
            app.events.trigger('filter:added', filterID)
            $li.hide()

    return FilterSelectorView
