define [
    'jquery',
    'backbone',
    'jade!templates/filters/dropdownFilter'

], ($, Backbone, DropdownFilterTemplate) ->

    DropdownFilterView = Backbone.View.extend

        url: ''

        events: {
            'change select': 'dropdownChanged'
            'click .remove': 'removeFilter'
        }


        # On UI filter change, get current value of select element, get url
        # param name, and concatenate into URL parameter string
        dropdownChanged: ->
            $dropdown = this.$el.find('select')
            urlParamValue = $dropdown.val()
            urlParamName = this.filterData.urlParam
            this.url = urlParamName + "=" + urlParamValue
            this.vent.trigger('filter:UIChange')

        removeFilter: ->
            this.$el.remove()
            this.url = ""

        render: ->
            template = DropdownFilterTemplate(this.filterData)
            this.$el.html(template)

        initialize: (filterData, vent) ->
            this.vent = vent
            this.filterData = filterData
            this.render()

        #getParams: () ->

    return DropdownFilterView
