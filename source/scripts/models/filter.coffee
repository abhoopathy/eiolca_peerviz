define ['underscore','backbone'], (_,Backbone) ->

    FilterModel = Backbone.Model.extend

        defaults:
            id: 0
            title: 'Title'
            active: false
            type: ''
            urlParam: ''

        initialize: ->
            @on('change:data', @dataChanged)

        # select, options, urlParamName, data{selection}
        # range, options, loRange, hiRange, loUrlParamName, hiUrlParamName, data{loVal,hiVal}
        #
        #TODO add validation
        #validate:

        dataChanged: -> @set({urlParam: @getURLString()})

        getURLString: ->

            if @get('type') == 'select'
                val = @get('data').selection
                if val == 'default'
                    return ''
                else
                    urlParamName = @get "urlParamName"
                    return  urlParamName + "=" + val

            else if @get('type') == 'range'
                loVal = @get('data').loVal
                hiVal = @get('data').hiVal

                if loVal == @get('loRange')
                    loStr = ''
                else
                    loStr = @get('loUrlParamName') +
                        '=' + loVal

                if hiVal == @get('hiRange')
                    hiStr = ''
                else
                    hiStr = (if loStr == '' then '' else '&') +
                        @get('hiUrlParamName') +
                        '=' + hiVal

                return loStr + hiStr

    return FilterModel
