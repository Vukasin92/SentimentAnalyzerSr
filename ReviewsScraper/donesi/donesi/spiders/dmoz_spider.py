from scrapy.spider import BaseSpider
from scrapy.selector import HtmlXPathSelector
from donesi.items import DonesiItem
import scrapy

class DonesiSpider(BaseSpider):
    name = "donesi"
    allowed_domains = ["donesi.com"]
    start_urls = [
        #"http://www.donesi.com/beograd/reviews.php?sortby=srank&offset=0"
    ]

    def parse(self, response):
        hxs = HtmlXPathSelector(response)
        reviews = hxs.select('//span[@itemprop="reviewBody"]')
        items = []
        for review in reviews:
            item = DonesiItem()
            item["reviewBody"] = review.select('text()').extract()
            item["reviewRating"] = review.select('following-sibling::meta[@itemprop="reviewRating"]/@content').extract()
            items.append(item)
        return items

    def start_requests(self):
        for i in range(0, 802):
            yield scrapy.Request("http://www.donesi.com/beograd/reviews.php?sortby=srank&offset="+str(i*20), self.parse)