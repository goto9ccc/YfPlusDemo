# YfPlusDemo
缘起：
最近给用友U8某客户做了个手机客户端，删除掉大部分业务逻辑后，基于易飞ERP，如何针对易飞数据库的移动、WEB、桌面端演示DEMO
提示：
本人一直反对针对ERP软件原有逻辑的再开发，因为软件供应商的商品历经演化与迭代之后，包含了成熟的管理思想与方法论在里面，所谓个性化需求，大部分只是不愿意按流程实施的借口。
应用：
本代码只包含查询业务，除了应用移动端扫描会要求建表与提交新数据以外，不会修改任何数据。也不建议您添加修改原来数据。
由于不建表，暴露的接口应用在公网是不安全的，所以，请在内网使用。如在公网使用，建议增加
1、登录鉴权表，登录后返回token，限定生命周期
2、所有接口增加token校验。
3、使用https
正在完成的其它工作
iOS Swift端
html+js 纯前端
基于开源硬件的工业端
由于手头有一定的工作，预计年后会陆续提交
