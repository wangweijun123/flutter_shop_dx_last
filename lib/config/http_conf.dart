// const base_url = 'http://127.0.0.1/:3000/';
// const base_url = 'http://192.168.0.32:3000/';
// ip 变化了, 客户端与服务端都要变化一下哦node_shop_server/router/config.js
const base_url = 'http://172.16.64.127:3000/';
const servicePath = {
  'homePageContext': base_url + 'getHomePageContent', //首页数据
  'getHotGoods': base_url + 'getHotGoods', //火爆专区
  'getCategory': base_url + 'getCategory', //商品类别信息
  'getCategoryGoods': base_url + 'getCategoryGoods', //商品分类别的商品列表
  'getGoodDetail': base_url + 'getGoodDetail', //商品详细信息
};
