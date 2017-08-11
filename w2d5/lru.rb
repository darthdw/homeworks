class LRUCache

  def initialize(size)
    @cache = []
    @size = size
  end

  def count
    @cache.dup.count
  end

  def add(el)
    organize_cache(el) if @cache.include?(el)
    @cache.unshift(el)
    @cache = @cache.take(@size)
  end

  def show
    @cache.dup
  end

  private
  def organize_cache(el)
    @cache.delete(el)
  end

end
