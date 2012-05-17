xml.instruct! :xml
xml.declare! :DOCTYPE, :dc_catalog, :SYSTEM, "http://www.delivery-club.ru/xml/dc.dtd"

xml.dc_catalog :last_update => DateTime.now.strftime("%Y-%m-%d %H:%M") do
  xml.delivery_service do
    xml.categories do
      @categories.each do |cat|
        xml.category cat.name, :id => cat.id
      end
    end
    
    xml.products do
      @goods.each do |good|
        xml.product :id => good.id do
          xml.category_id good.category_id
          xml.name good.name
          unless good.description.blank?
            xml.description strip_tags(good.description)
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