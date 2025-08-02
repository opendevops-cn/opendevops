module.exports = {
    title: 'OpenDevOps',
    description: 'CoDo 快速入门文档',
    head: [['link', {rel: 'icon', href: '/favicon.ico'}]],
    themeConfig: {
        logo: 'https://img.opendevops.cn/logo.png',
        nav: [
            {text: 'Home', link: '/'},
            {text: '招聘', link: '/zh/ad/'},
            {
                text: '部署文档',
                items: [
                    {text: 'Docker Compose 部署', link: '/zh/guide-v2/2-install/docker.md'},
                    {text: 'Kubernetes Helm 部署', link: '/zh/guide-v2/2-install/k8s.md'}
                ]
            },
            {text: '使用文档', link: '/zh/guide-v2/'},
            // { text: '论坛', link: 'https://bbs.opendevops.cn/', target: '_blank' },
            {text: '官网', link: 'https://www.opendevops.cn/', target: '_blank'},
            {text: 'Demo', link: 'https://demo.opendevops.cn/user/login', target: '_blank'},
            {text: 'Gitee', link: 'https://gitee.com/opendevops/opendevops', target: '_blank'},
            {text: 'Github', link: 'https://github.com/opendevops-cn', target: '_blank'},
            {
                text: '了解更多',
                items: [
                    {text: 'FAQ', link: '/zh/guide/more/faq/'},
                    {text: 'QQ群', link: '/zh/guide/more/qgroup/'},
                    {text: '贡献者', link: '/zh/guide/more/contributor/'},
                    {text: '权限文档', link: '/zh/guide/more/permission/'},
                    {text: '最佳示例', link: '/zh/guide/more/example/'},
                    // { text: '如何更新', link: '/zh/guide/more/update/' }
                ]
            }
        ],
        sidebar: {
            '/zh/guide-v2/': [
                {
                    title: '它是什么',
                    collapsable: false,
                    children: ['']
                },
                {
                    title: '架构',
                    collapsable: false,
                    children: [
                        '/zh/guide-v2/1-architectures/',
                    ]
                },
                {
                    title: '如何安装',
                    collapsable: false,
                    children: [
                        '/zh/guide-v2/2-install/',
                        '/zh/guide-v2/2-install/docker.md',
                        '/zh/guide-v2/2-install/k8s.md'
                    ]
                },
                {
                    title: '使用admin管理用户权限',
                    collapsable: true,
                    children: [
                        '/zh/guide-v2/3-admin/',
                        '/zh/guide-v2/3-admin/biz-auth.md',
                        '/zh/guide-v2/3-admin/role-auth.md'
                    ]
                },
                {
                    title: '使用CMDB管理数据资源',
                    collapsable: true,
                    children: [
                        '/zh/guide-v2/4-cmdb/',
                        '/zh/guide-v2/4-cmdb/biz-tree.md',
                        '/zh/guide-v2/4-cmdb/cloud-asset.md'
                    ]
                },
                {
                    title: '使用flow编排自动化工作流',
                    collapsable: true,
                    children: [
                        '/zh/guide-v2/5-codo-flow/',
                        '/zh/guide-v2/5-codo-flow/codo-agent.md',
                        '/zh/guide-v2/5-codo-flow/example-cicd.md',
                        '/zh/guide-v2/5-codo-flow/example-distribute-deploy.md',
                        '/zh/guide-v2/5-codo-flow/example-flow-audit.md'
                    ]
                },
                {
                    title: '使用配置中心管理配置',
                    collapsable: true,
                    children: [
                        '/zh/guide-v2/6-config-center/'
                    ]
                },
                {
                    title: '使用通知中心完成高效率告警',
                    collapsable: true,
                    children: [
                        '/zh/guide-v2/7-notice/'
                    ]
                },
                {
                    title: '使用云原生管理平台管理多地集群',
                    collapsable: true,
                    children: [
                        '/zh/guide-v2/8-cloud-native-management/'
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
