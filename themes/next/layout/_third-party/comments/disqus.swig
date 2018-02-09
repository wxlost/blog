{% if not (theme.duoshuo and theme.duoshuo.shortname) and not theme.duoshuo_shortname %}
  {% if theme.disqus.enable %}

    {% if theme.disqus.count  %}
      <script id="dsq-count-scr" src="https://{{theme.disqus.shortname}}.disqus.com/count.js" async></script>
    {% endif %}

    {% if page.comments %}
      <script type="text/javascript">
        disqusLoaded=false;
        var disqus_config = function () {
          this.page.url = '{{ page.permalink }}';
          this.page.identifier = '{{ page.path }}';
          this.page.title = '{{ page.title| addslashes }}';
        };
        function loadDisqus(){
          var d = document, s = d.createElement('script');
          s.src = 'https://{{theme.disqus.shortname}}.disqus.com/embed.js';
          s.setAttribute('data-timestamp', '' + +new Date());
          (d.head || d.body).appendChild(s);
          disqusLoaded=true;
        }
        //Get the offset of an object
        function findTop(obj) {
          var curtop = 0;
          if (obj.offsetParent) {
            do {
              curtop += obj.offsetTop;
            } while (obj = obj.offsetParent);
          return curtop;
          }
        }
        if(window.location.hash.indexOf('#comments') > 0)
          loadDisqus();
        window.onscroll = function() {
          var commentsOffset = findTop(comments);
          if(!disqusLoaded && window.pageYOffset > commentsOffset - 1500)
            loadDisqus();
        }
      </script>
    {% endif %}

  {% endif %}
{% endif %}
