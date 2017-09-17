describe 'Tab Ahead. Options', ->
    # --> Constants shared with `popup.coffee`
    QUERY =
        ALL: 'all'
        CURRENT: 'current'

    FAV =
        FAV: 'fav'
        NOFAV: 'nofav'

    PREF_QUERY = 'pref/query'
    PREF_FAV = 'pref/fav'

    # Constants shared with `popup.coffee` <--

    CLASSES =
        ACTIVE: 'active'

    beforeEach ->
        setFixtures window.__html__['test/fixtures/options.html']
        window.localStorage[PREF_QUERY] = undefined
        window.localStorage[PREF_FAV] = undefined

    describe 'loaded without exploding', ->
        it 'is available', ->
            (expect window.tabaheadOptions).toBeDefined()
            (expect window.tabaheadOptions).toEqual jasmine.any Function

    describe 'expects the chrome options html', ->
        it 'expects to find the two options', ->
            (expect $ 'body').toContainElement '#current'
            (expect $ 'body').toContainElement '#all'
            (expect $ 'body').toContainElement '#nofav'
            (expect $ 'body').toContainElement '#fav'

    describe 'Initially the option', ->
        beforeEach ->
            window.localStorage[PREF_QUERY] = undefined
            window.localStorage[PREF_FAV] = undefined
            window.tabaheadOptions window.localStorage

        it 'will be set to `current`', ->
            (expect $ '#current').toHaveClass CLASSES.ACTIVE
            (expect $ '#all').not.toHaveClass CLASSES.ACTIVE
            (expect $ '#fav').toHaveClass CLASSES.ACTIVE
            (expect $ '#nofav').not.toHaveClass CLASSES.ACTIVE
            (expect window.localStorage[PREF_QUERY]).toBe QUERY.CURRENT
            (expect window.localStorage[PREF_FAV]).toBe FAV.FAV

    describe 'Clicking `#all`', ->
        beforeEach ->
            window.tabaheadOptions window.localStorage

            # Simply using `$.trigger` won't work in `PhantomJS`.
            event = document.createEvent 'MouseEvents'
            event.initMouseEvent 'click'

            (($ '#all').get 0).dispatchEvent event

        it 'should set the option to `all`', ->
            (expect $ '#all').toHaveClass CLASSES.ACTIVE
            (expect $ '#current').not.toHaveClass CLASSES.ACTIVE
            (expect window.localStorage[PREF_QUERY]).toBe QUERY.ALL

    describe 'Clicking `#current`', ->
        beforeEach ->
            window.tabaheadOptions window.localStorage

            # Simply using `$.trigger` won't work in `PhantomJS`.
            event = document.createEvent 'MouseEvents'
            event.initMouseEvent 'click'

            (($ '#current').get 0).dispatchEvent event

        it 'should set the option to `current`', ->
            (expect $ '#current').toHaveClass CLASSES.ACTIVE
            (expect $ '#all').not.toHaveClass CLASSES.ACTIVE
            (expect window.localStorage[PREF_QUERY]).toBe QUERY.CURRENT



    describe 'Clicking `#fav`', ->
        beforeEach ->
            window.tabaheadOptions window.localStorage

            # Simply using `$.trigger` won't work in `PhantomJS`.
            event = document.createEvent 'MouseEvents'
            event.initMouseEvent 'click'

            (($ '#fav').get 0).dispatchEvent event

        it 'should set the option to `all`', ->
            (expect $ '#fav').toHaveClass CLASSES.ACTIVE
            (expect $ '#nofav').not.toHaveClass CLASSES.ACTIVE
            (expect window.localStorage[PREF_FAV]).toBe FAV.FAV

    describe 'Clicking `#nofav`', ->
        beforeEach ->
            window.tabaheadOptions window.localStorage

            # Simply using `$.trigger` won't work in `PhantomJS`.
            event = document.createEvent 'MouseEvents'
            event.initMouseEvent 'click'

            (($ '#nofav').get 0).dispatchEvent event

        it 'should set the option to `current`', ->
            (expect $ '#nofav').toHaveClass CLASSES.ACTIVE
            (expect $ '#fav').not.toHaveClass CLASSES.ACTIVE
            (expect window.localStorage[PREF_FAV]).toBe FAV.NOFAV
