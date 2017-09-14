window.tabaheadOptions = (storage) ->
    # --> Constants shared with `popup.coffee`
    QUERY =
        ALL: 'all'
        CURRENT: 'current'

    PREF_QUERY = 'pref/query'
    PREF_FAV = 'pref/fav'

    FAV =
        FAV: 'fav'
        NOFAV: 'nofav'
    # Constants shared with `popup.coffee` <--

    CLASSES =
        ACTIVE: 'active'

    # UI
    ui =
        all: document.getElementById 'all'
        current: document.getElementById 'current'
        fav: document.getElementById 'fav'
        nofav: document.getElementById 'nofav'
        activateAll: ->
            ui.current.classList.remove CLASSES.ACTIVE
            ui.all.classList.add CLASSES.ACTIVE
        activateCurrent: ->
            ui.all.classList.remove CLASSES.ACTIVE
            ui.current.classList.add CLASSES.ACTIVE
        update: ->
            query = storage[PREF_QUERY]
            switch query
                when QUERY.ALL then ui.activateAll()
                when QUERY.CURRENT then ui.activateCurrent()
                else
                # Something went wrong. Let's reset.
                    storage[PREF_QUERY] = QUERY.CURRENT
                    ui.update()
        activateFav: ->
            ui.nofav.classList.remove CLASSES.ACTIVE
            ui.fav.classList.add CLASSES.ACTIVE
        activateNofav: ->
            ui.fav.classList.remove CLASSES.ACTIVE
            ui.nofav.classList.add CLASSES.ACTIVE
        updateFav: ->
            fav = storage[PREF_FAV]
            switch fav
                when FAV.FAV then ui.activateFav()
                when FAV.NOFAV then ui.activateNofav()
                else
                # Something went wrong. Let's reset.
                    storage[PREF_FAV] = FAV.FAV
                    ui.updateFav()

    # Events
    ui.all.addEventListener 'click', ->
        storage[PREF_QUERY] = QUERY.ALL
        ui.update()
        false
    ui.current.addEventListener 'click', ->
        storage[PREF_QUERY] = QUERY.CURRENT
        ui.update()
        false
    ui.fav.addEventListener 'click', ->
        storage[PREF_FAV] = FAV.FAV
        ui.updateFav()
        false
    ui.nofav.addEventListener 'click', ->
        storage[PREF_FAV] = FAV.NOFAV
        ui.updateFav()
        false

    # Init default pref
    storage[PREF_QUERY] = QUERY.CURRENT unless storage[PREF_QUERY]
    storage[PREF_FAV] = FAV.FAV unless storage[PREF_FAV]

    # Init UI state
    ui.update()
    ui.updateFav()

# Go go go, unless we're unit testing this thing.
window.tabaheadOptions window.localStorage unless window.__karma__?
