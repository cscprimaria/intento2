module Jekyll
  class ImachPageGenerator < Generator
    safe true

    def generate(site)
      imaches = site.static_files
      count = 1
      imaches.each do |imach|
        if imach.path.include? "photos"
          site.pages << TagPage.new(site, site.source, imach, count)
          count = count+1
        end
      end
    end
  end

  class TagPage < Page
    def initialize(site, base, imach, count)
      @site = site
      @base = base
      @dir  = File.join('imach', imach.basename)
      @name = 'index.html'
      @count = count

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'imaches.html')
      self.data['imach'] = imach
      self.data['number'] = count
      self.data['title'] = "Tip #"+ count.to_s
    end
  end
end
