define [
    'jquery'
    'backbone'
    'jade!templates/filters/dropdownFilter'

], (
    $
    Backbone
    DropdownFilterTemplate
) ->

    DropdownFilterView = Backbone.View.extend

        #### Initialization
        initialize: (filterModel) ->
            this.filter = filterModel
            this.render()

        render: ->
            compiledTemplate =
                DropdownFilterTemplate(this.filter.toJSON())
            this.$el.html(compiledTemplate)


        #### Handling UI Events
        events:
            'click .remove': 'removeFilter'
            'change select': 'dropdownChanged'

        ## On selectbox change, get current value of select element, get url
        ## param name, and concatenate into URL parameter string
        dropdownChanged: ->
            # Get value of select box
            $dropdown = this.$el.find('select')
            urlParamValue = $dropdown.val()

            if urlParamValue != 'default'

                $dropdown.find("option[value='default']").remove()

                # Get parameter name for url
                urlParamName = this.filter.get "urlParamName"

                # Set parameter status in model
                this.filter.set
                    urlParam: urlParamName + "=" + urlParamValue

        ## On filter remove, set the url parameter string to '' and trigger
        ## filter:removed
        removeFilter: ->
            this.$el.remove()
            this.filter.set({urlParam: '', active: false})

    return DropdownFilterView
