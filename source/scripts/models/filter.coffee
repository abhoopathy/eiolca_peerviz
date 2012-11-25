define ['underscore','backbone'], (_,Backbone) ->

    FilterModel = Backbone.Model.extend

        defaults: {
            id: 0
            title: 'Title'
            type: ''
            urlParam: ''
        }

        #TODO add validation

    return FilterModel
