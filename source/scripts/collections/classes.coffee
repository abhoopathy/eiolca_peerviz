define [
    'underscore',
    'backbone',
    'cs!models/class'

], (_, Backbone, ClassModel) ->

    ClassCollection = Backbone.Collection.extend
        model: ClassModel

        someCollectionMethod: (class_id) -> this.get(class_id)

    return ClassCollection
