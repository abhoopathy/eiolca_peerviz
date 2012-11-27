define [
    'jquery'
    'backbone'
    'jade!templates/filters/selectFilter'

], (
    $
    Backbone
    SelectFilterTemplate
) ->

    SelectFilterView = Backbone.View.extend

        #### Initialization
        initialize: (filterModel) ->
            this.filter = filterModel
            this.render()

        render: ->
            compiledTemplate =
                SelectFilterTemplate(this.filter.toJSON())
            this.$el.html(compiledTemplate)


        #### Handling UI Events
        events:
            'click .remove': 'removeFilter'
            'change select': 'selectChanged'

        ## On selectbox change, get current value of select element, get url
        ## param name, and concatenate into URL parameter string
        selectChanged: ->
            # Get value of select box
            $select = this.$el.find('select')
            urlParamValue = $select.val()

            if urlParamValue != 'default'

                $select.find("option[value='default']").remove()

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

    return SelectFilterView
