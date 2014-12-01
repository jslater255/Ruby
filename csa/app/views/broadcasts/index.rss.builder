xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "CSA jas38 Application"
    xml.description "CSA Description"

     @broadcasts.each do |broadcast|
       if display_feeds(broadcast).include? "Rss"
        xml.item do
          xml.title broadcast.content
          xml.description 'CSA description either a job news or general news'
          xml.pubDate  broadcast.created_at
          #xml.link post_url(@broadcasts)
       end
      end
     end
    end
  end
