SitemapGenerator::Sitemap.default_host = "https://ruby.ci"
SitemapGenerator::Sitemap.create(filename: :sitemap_ruby_ci) do
  add '/', changefreq: 'monthly', priority: 0.9
  add '/pricing', changefreq: 'monthly', priority: 0.8
  add '/docs', changefreq: 'weekly', priority: 0.8
  add '/blog', changefreq: 'weekly', priority: 0.5
end