define [
    'underscore',
    'backbone',
    'cs!models/filter'

], (_, Backbone, FilterModel) ->

    FilterCollection = Backbone.Collection.extend

        model: FilterModel

        getUrlParams: ->
            urlChunks = _.filter(
                    # Get urlParam of each model
                    (_.map this.models, (filter) -> filter.get 'urlParam'), #
                    # Include only non-empty urlParams
                    (urlChunk) -> urlChunk != '')

            # If no params, return empty str
            if urlChunks.length == 0
                return ''

            else

                # Reduce array of urlParams into string
                urlString = '?' +

                    # Follow all but last chunk ends with &
                    _.reduce(
                        _.initial urlChunks
                        (str, urlChunk) -> str + urlChunk + "&",
                        "") +

                    # last chunk has no &
                    _.last urlChunks


    return FilterCollection
