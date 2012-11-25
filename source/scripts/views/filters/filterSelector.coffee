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
            this.filters.on 'change:active', (filter) ->
                if filter.get('active')
                    this.activateFilter
                else
                    this.deactivateFilter

        ## When filter is removed, show that filter option in selector
        filterRemovedHandler: (filterID) ->
            $li = this.$el.find("li[data-filterID='#{filterID}']")
            $li.show()


        #### Handling UI Events

        events:
            'click a': 'activateFilter'

        ## When user add's a filter form selector, hide the option from
        ## the menu and trigger the addClicked event
        activateFilter: (e) ->
            $li = $(e.target).closest('li')
            filterID = $li.attr('data-filterID')
            this.filters.get(filterID).set({active: true})

    return FilterSelectorView
