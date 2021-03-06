class PagePresenter < Presenter
  def bson_id
    @source.id.to_s
  end

  def available_slices
    slices = {}
    ObjectSpace.each_object do |object|
      ActiveSupport::Deprecation.silence do
        if object.class == Class && object.name =~ /\w+Slice$/
          key = object.name.underscore.sub('_slice', '')
          slices[key] = key.humanize
        end
      end
    end
    slices
  end

  def name
    @source.name
  end

  def editing_entry_content_slices?(entries)
    set_page? && (! entries.nil?)
  end

  def set_page?
    @source.set_page?
  end

  def main_template
    'page_main'
  end

  def meta_template
    'page_meta'
  end

  def main_extra_template
    'page_main_extra'
  end

  def meta_extra_template
    'page_meta_extra'
  end

  def breadcrumbs
    [@source] + @source.ancestors
  end

  def children
    @source.children
  end

  def as_json(options={})
    json = {
      '_id' => @source.id,
      'url' => "/admin/pages/#{@source.id}"
    }
    self.class.columns.each do |key, val|
      json[key.to_s] = send(key)
    end
    json
  end

end

