# Pages flagged with `hide: true` (or `published: false`) in their front
# matter are dropped before rendering: they are not written to _site and do
# not appear in the navigation. Jekyll does not honor `published: false` for
# plain pages by itself, so this hook fills that gap.
Jekyll::Hooks.register :site, :pre_render do |site|
  site.pages.reject! do |page|
    page.data["hide"] == true || page.data["published"] == false
  end
end
