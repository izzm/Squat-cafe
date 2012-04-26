xml.instruct! :xml

xml.dc_catalog :last_update => DateTime.now.strftime("%Y-%m-%d %H:%M") do
  xml.delivery_service do
    xml.categories do
      @category.children.visible.sorted.each do |cat|
        xml.category cat.name, :id => cat.id
      end
    end
    
    xml.products do
      @category.self_and_descendants_goods.visible.sorted.each do |good|
        xml.product :id => good.id do
          xml.category_id good.category_id
          xml.name good.name
          unless good.description.blank?
            xml.description good.description
          end
          xml.price good.price
          unless good.attachments.blank?
            xml.picture image_path(good.attachments.first.image.url)
          end
        end
      end
    end
  end
end