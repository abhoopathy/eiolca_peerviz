define [
    'jquery',
    'backbone',

    'cs!views//filters/dropdownFilter'

], ($, Backbone
    DropdownFilterView) ->

    FiltersPaneView = Backbone.View.extend

        el: $('#filters-wrapper')

        filters: []

        events: {
            'click #add-filter': 'addFilter'
        }

        initialize: (vent) ->
            _.bindAll(this)

            this.vent = vent
            this.vent.on("filter:UIChange", this.filterUIChange)

        filterUIChange: ->
            urlString = ""
            _.each this.filters, (filterView) ->
                urlString = filterView.url
            console.log urlString

        addFilter: () ->
            filter = this.filterData[0]

            #filterView
            #if filter.type == 'dropdown'
            #    filterView = new DropdownFilterView()
            #if filter.type == 'range'
            #    filterView = new RangeFilterView()

            filterView = new DropdownFilterView(filter, this.vent)
            this.$el.append filterView.el
            this.filters.push filterView

        filterData: [
            {
                id: 1
                title: 'Climate Zone'
                type: 'dropdown'
                options: [
                    {display:'1', value:'1'},
                    {display:'2', value:'2'},
                    {display:'3', value:'3'},
                    {display:'4', value:'4'},
                    {display:'5', value:'5'},
                ]
                urlParam: 'climate' }

            {
                id: 2
                title: 'Enrollment'
                type: 'range'
                range: 1000
                loUrlParam: 'lo_pop'
                hiUrlParam: 'hi_pop' }

        ]

    return FiltersPaneView
