module.exports = {
	title: 'OpenDevOps',
	description: ' Vue驱动的CoDo快速入门文档',
	head: [ [ 'link', { rel: 'icon', href: '/favicon.ico' } ] ],
	themeConfig: {
		logo: 'https://img.opendevops.cn/logo.png',
		nav: [
			{ text: 'Home', link: '/' },
			{ text: '招聘', link: '/zh/ad/' },
			{
				text: '部署文档',
				items: [
					{ text: '单机部署', link: '/zh/guide/install/local/' },
					{ text: '分布式部署', link: '/zh/guide/install/distribute/' }
				]
			},
			{ text: '使用文档', link: '/zh/guide/used/' },
			// { text: '论坛', link: 'https://bbs.opendevops.cn/', target: '_blank' },
			{ text: '官网', link: 'https://www.opendevops.cn/', target: '_blank' },
			{ text: 'Demo', link: 'https://demo.opendevops.cn/login', target: '_blank' },
			{ text: 'Gitee', link: 'https://gitee.com/opendevops/opendevops', target: '_blank' },
			{ text: 'Github', link: 'https://github.com/opendevops-cn', target: '_blank' },
			{
				text: '了解更多',
				items: [
					{ text: 'FAQ', link: '/zh/guide/more/faq/' },
					{ text: 'QQ群', link: '/zh/guide/more/qgroup/' },
					{ text: '贡献者', link: '/zh/guide/more/contributor/' },
					{ text: '权限文档', link: '/zh/guide/more/permission/' },
					{ text: '最佳示例', link: '/zh/guide/more/example/' },
					{ text: '如何更新', link: '/zh/guide/more/update/' }
				]
			}
		],
		sidebar: {
			'/zh/guide/': [
				{
					title: '它是什么',
					collapsable: false,
					children: [ '' ]
				},
				{
					title: '如何安装',
					collapsable: false,
					children: [ '/zh/guide/install/local/', '/zh/guide/install/distribute/' ]
				},
				{
					title: '如何使用',
					collapsable: false,
					children: [ '/zh/guide/used/' ]
				},
				{
					title: '中间件部署',
					collapsable: true,
					children: [
						{
							title: 'ETCD',
							collapsable: true,
							children: [
								'/zh/guide/plugin/middleware/etcd/simple.md',
								'/zh/guide/plugin/middleware/etcd/cluster.md'
							]
						}
					]
				},
				{
					title: '插件部署',
					collapsable: false,
					children: [
						'/zh/guide/plugin/Bind.md',
						'/zh/guide/plugin/Inception.md',
						'/zh/guide/plugin/sonarQube.md',
						'/zh/guide/plugin/SQLAdvisor.md'
					]
				},
				{
					title: '其他相关',
					collapsable: false,
					children: [
						'/zh/guide/more/faq/',
						'/zh/guide/more/qgroup/',
						'/zh/guide/more/contributor/',
						'/zh/guide/more/permission/',
						'/zh/guide/more/example/',
						'/zh/guide/more/update/'
					]
				}
				// {
				//   title: '使用',
				//   collapsable: false,
				//   children: [
				//     '/zh/guide/install/local/',
				//     '/zh/guide/install/distribute/'
				//   ]
				// }
			]
		}
		// sidebar: {
		//   '/zh/guide/': [''],
		//   '/zh/install/local/': [''],
		//   '/zh/install/distribute/': [''],
		// },
	}
};
