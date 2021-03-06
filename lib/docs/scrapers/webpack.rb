module Docs
  class Webpack < UrlScraper
    self.name = 'webpack'
    self.type = 'webpack'

    version '2' do
      self.release = '2.2.0'
      self.base_url = 'https://webpack.js.org/'
      self.root_path = 'get-started/'
      self.initial_paths = %w(
        concepts/
        guides/
        api/
        configuration/
        loaders/
        plugins/
      )
      self.links = {
        home: 'https://webpack.js.org/',
        code: 'https://github.com/webpack/webpack'
      }

      html_filters.push 'webpack/clean_html', 'webpack/entries'

      options[:container] = '.page'
      options[:trailing_slash] = true
      options[:only_patterns] = [
        /\Aget-started\//,
        /\Aconcepts\//,
        /\Aguides\//,
        /\Aapi\//,
        /\Aconfiguration\//,
        /\Aloaders\//,
        /\Aplugins\//
      ]

      options[:attribution] = <<-HTML
        &copy; 2012&ndash;2016 Tobias Koppers<br>
        Licensed under the Creative Commons Attribution License 4.0.
      HTML

      ([self.root_path] + self.initial_paths).each do |path|
        stub(path) do
          capybara = load_capybara_selenium
          capybara.app_host = self.base_url.origin
          capybara.visit("#{self.base_url}#{path}")
          capybara.execute_script('return document.body.innerHTML')
        end
      end
    end

    version '1' do
      self.release = '1.13.2'
      self.base_url = 'https://webpack.github.io/docs/'
      self.links = {
        home: 'https://webpack.github.io/',
        code: 'https://github.com/webpack/webpack'
      }

      html_filters.push 'webpack/entries_old', 'webpack/clean_html_old', 'title'

      options[:title] = false
      options[:root_title] = 'webpack'

      options[:skip] = %w(list-of-tutorials.html examples.html changelog.html ideas.html roadmap.html)

      options[:attribution] = <<-HTML
        &copy; 2012&ndash;2016 Tobias Koppers<br>
        Licensed under the MIT License.
      HTML
    end
  end
end
