define ['lodash','backbone'], (_,Backbone) ->

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

        dataChanged: ->
            @set({urlParam: @getURLString()})
            @trigger('change:urlParam')

        getConfig: (key) ->
            # TODO: if key exists
            configData = @get('config')
            return configData[key]

        getData: (key) ->
            # TODO: if key exists
            data = @get('data')
            return data[key]

        setData: (obj) ->
            data = @get('data')
            _.each(obj, (k,v) ->
                data[v] = k)
            @trigger('change:data')

        getURLString: ->
            if @get('type') == 'select'
                val = @getData('selection')
                if val == 'default'
                    return ''
                else
                    urlParamName = @getConfig "urlParamName"
                    return  urlParamName + "=" + val

            else if @get('type') == 'range'
                loVal = @get('data').loVal
                hiVal = @get('data').hiVal

                if loVal == @getConfig('loRange')
                    loStr = ''
                else
                    loStr = @getConfig('loUrlParamName') +
                        '=' + loVal

                if hiVal == @getConfig('hiRange')
                    hiStr = ''
                else
                    hiStr = (if loStr == '' then '' else '&') +
                        @getConfig('hiUrlParamName') +
                        '=' + hiVal

                return loStr + hiStr

    return FilterModel
