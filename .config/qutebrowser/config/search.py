def setup(c):
    c.url.searchengines = {
        'DEFAULT': 'https://duckduckgo.com/?q={}',
        'g': 'https://www.google.com/search?q={}',
        'w': 'https://en.wikipedia.org/wiki/{}',
        'yt': 'https://www.youtube.com/results?search_query={}',
    }
    c.url.start_pages = ['https://duckduckgo.com']
