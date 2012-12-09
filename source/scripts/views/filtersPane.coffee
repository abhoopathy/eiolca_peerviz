define [
    'jquery'
    'backbone'

    'cs!collections/filter'

    'cs!views/filters/selectFilter'
    'cs!views/filters/rangeFilter'

], (
    $
    Backbone

    FilterCollection

    SelectFilterView
    RangeFilterView
) ->

    FiltersPaneView = Backbone.View.extend

        #### Initialization

        el: $('#filters-wrapper')

        initialize: ->
            # Initialize and populate filter collection
            @filters = new FilterCollection()
            @filters.add @filterData

            @$filterList = $(".filter-list")

            # TODO: fix this
            @addFilter('climateZone')
            @addFilter('type')
            @addFilter('enrollment')

            @bindEvents()


        #### Handle External events

        bindEvents: ->
            _.bindAll(this)
            @filters.on 'change:urlParam', @filterChanged
            app.events.on 'search:resultSubmitted', @setFiltersFromNodeData

        setFiltersFromNodeData: (nodeData) ->

            @filters.get('climateZone').setData { selection: nodeData.climate }
            @filters.get('enrollment').setData
                    loVal: parseInt(nodeData.enrollment) - 6000
                    hiVal: parseInt(nodeData.enrollment) + 6000
            @filters.get('type').setData {  selection: nodeData.is_private }

        filterChanged: () ->
            params = @filters.getUrlParams()
            clearTimeout(@timeout)
            @timeout = setTimeout(
                (->
                    app.events.trigger('filters:urlParamsChanged', params)
                ), 80)


        ####
        ## Adds a filter view given it's id.
        ## TODO: validation
        addFilter: (filterID) ->
            filter = @filters.get(filterID)

            if filter.get('type') == 'select'
                filterView = new SelectFilterView(filter)
            if filter.get('type') == 'range'
                filterView = new RangeFilterView(filter)

            @$filterList.append filterView.el


        #### Filter data for app-wide filter collection

        # TODO: put modality specific options in seperate attr
        #   and add getter/setter methods for it in filter model
        filterData: [{
                id: 'climateZone'
                title: 'Climate Zone'
                type: 'select'
                config:
                    options: [
                        {display:'1', value:'1'},
                        {display:'2', value:'2'},
                        {display:'3', value:'3'},
                        {display:'4', value:'4'},
                        {display:'5', value:'5'},
                    ]
                    urlParamName: 'climate'
                data:
                    selection: 'default'
            },
            {
                id: 'type'
                title: 'Type'
                type: 'select'
                config:
                    options: [
                        {display:'Public', value:'1'},
                        {display:'Private', value:'0'},
                    ]
                    urlParamName: 'public'
                data:
                    selection: 'default'
            }
            {
                id: 'enrollment'
                title: 'Enrollment'
                type: 'range'
                config:
                    loRange: 0
                    hiRange: 40000
                    loUrlParamName: 'lo_pop'
                    hiUrlParamName: 'hi_pop'
                data:
                    loVal: @loRange
                    hiVal: @hiRange
            }]

    return FiltersPaneView
