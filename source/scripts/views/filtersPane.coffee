define [
    'jquery'
    'backbone'

    'cs!collections/filter'
    'cs!views/filters/filterSelector'

    'cs!views/filters/dropdownFilter'
    'cs!views/filters/rangeFilter'

], (
    $
    Backbone

    FilterCollection
    FilterSelectorView

    DropdownFilterView
    RangeFilterView
) ->

    FiltersPaneView = Backbone.View.extend

        #### Initialization

        el: $('#filters-wrapper')

        initialize: ->
            # Initialize and populate filter collection
            this.filters = new FilterCollection()
            this.filters.add this.filterData

            filterSelectorView = new FilterSelectorView(this.filters)

            this.bindEvents()

            #TODO remove these
            #this.addFilter(1)
            #this.addFilter(2)
            #this.addFilter(3)



        #### Handle External events

        bindEvents: ->
            _.bindAll(this)
            app.events.on('filter:added', this.addFilter)
            this.filters.on('change', this.filterChanged)


        filterChanged: (filterID) ->
            console.log this.filters.getUrlParams()

        addFilter: (filterID) ->

            filter = this.filters.get(filterID)

            if filter.get('type') == 'dropdown'
                filterView = new DropdownFilterView(filter)
            if filter.get('type') == 'range'
                filterView = new RangeFilterView(filter)

            this.$el.find('.filter-list').append filterView.el



        #### Filter data for app-wide filter collection
        filterData: [{
                id: '1'
                title: 'Climate Zone'
                type: 'dropdown'
                options: [
                    {display:'1', value:'1'},
                    {display:'2', value:'2'},
                    {display:'3', value:'3'},
                    {display:'4', value:'4'},
                    {display:'5', value:'5'},
                ]
                urlParamName: 'climate'
            },
            {
                id: '2'
                title: 'Type'
                type: 'dropdown'
                options: [
                    {display:'Public', value:'1'},
                    {display:'Private', value:'0'},
                ]
                urlParamName: 'public'
            }
            {
                id: '3'
                title: 'Enrollment'
                type: 'range'
                loRange: 0
                hiRange: 12000000
                loUrlParamName: 'lo_pop'
                hiUrlParamName: 'hi_pop'
            }]

    return FiltersPaneView
