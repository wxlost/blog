{% if theme.disqusapi.enable %}
    {% set iDisqus_css_uri = url_for(theme.vendors._internal + '/disqusapi/dist/iDisqus.min.css?v=1.0.0') %}
    {% if theme.vendors.iDisqus_css %}
      {% set iDisqus_css_uri = theme.vendors.iDisqus_css %}
    {% endif %}
    <link rel="stylesheet" href="{{ iDisqus_css_uri }}" type="text/css" />

    {% set iDisqus_js_uri = url_for(theme.vendors._internal + '/disqusapi/dist/iDisqus.min.js?v=1.0.0') %}
    {% if theme.vendors.iDisqus_js %}
      {% set iDisqus_js_uri = theme.vendors.iDisqus_js %}
    {% endif %}
    <script type="text/javascript" src="{{ iDisqus_js_uri }}"></script>
    <script>
        var emojiList = [];
        var disq = new iDisqus('comment', {
            forum: '{{ theme.disqusapi.forum }}',
            site: '{{ theme.disqusapi.site }}',
            api: '{{ theme.disqusapi.api }}',
            mode: {{ theme.disqusapi.mode }},
            badge: '{{ theme.disqusapi.badge }}',
            timeout: {{ theme.disqusapi.timeout }},
            init: true,
            url: location.pathname.replace('index.html',''),
            emoji_list: emojiList
        });
        disq.count();
    </script>
{% endif %}