Return-Path: <virtio-dev-return-11579-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823E1C61DA4
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 16:32:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4A5B73E318
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 16:32:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3E11F98670A
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 16:32:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 27D1C984772; Thu,  9 Mar 2023 16:32:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1478B9866FB;
	Thu,  9 Mar 2023 16:32:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJJA8VZNNHFkabGsGcRnp3H5gOSoWibUyJSDrUg0tldgbp7BNjuTjmwSPpBKn+WwxICFjYVptz4o9MtJ43/wBS8om9P1nR2MTWo9ydqbaPJ4CjMD7snBv72eXK6OGxHKmHRIyutCkTOK+kCVgyMwUEgcCLCDhupCoZL+cbkzqorn25rvu4VMj4heNDbJn08sYUC4JrnKhnz8LN2pXHsV0QX0P8/jHfeBywjIbe6fySOw+Mq26dhOWEPbHvuHpqV3a6m9CFAqywwVH5uGAij0TAWvkChczk1hYlhW5/HWFqhDK0DaWwLeBQjTIpbZNSMfT8Ptcg4iBq+ITVUoVv3IOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfaQ/A5T3JS10OAUblqYfYMbJWGxPxF28SIpGWsP96A=;
 b=ZOM12w/JIYKCBvJONpOeHDAYEOyLmS0GK7vgKSYVDC8XovggO7d6xSZsfk8hiGEaRNOcJbZ/LtelUnnm4FXJjJqfjNalJJf9WQMloNv5ZeQJnmQBqVeRvi4AL3kw9kdZpneB4w7CqsPP3o9b8QkrpoaTtu9jK42UPj1REYw7UvmBEuuyeIjXjBeMdzgWroBhxGs5B60/3BpTd0qYL58nJuhSDJQuGYuDqv0wVx5YEU2v1Q9GkSoiQabULq3ISOKqpD7kCwNfrdsp9iHJ9o8qr2UsiUXOaHsnJcRhrkQ0ty7Px7jZibd/tWZVCY+O3BeoqoTOylRowpXZ1QglKhxTFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Thu, 9 Mar 2023 17:32:14 +0100
From: Jiri Pirko <jiri@nvidia.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>,
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <ZAoKDgkOpG8FKCmc@nanopsycho>
References: <cover.1677761896.git.mst@redhat.com>
 <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
 <ZAXfegxCfvfLwiJT@nanopsycho>
 <20230306133816-mutt-send-email-mst@kernel.org>
 <ZAbpiRVdo8BciELX@nanopsycho>
 <20230307111458-mutt-send-email-mst@kernel.org>
 <ZAhdzCd6qwWydesz@nanopsycho>
 <PH0PR12MB5481E320D33B4594F050B3C8DCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZAmMp3W4CwL9xpD2@nanopsycho>
 <PH0PR12MB5481450730C442429F3D98C7DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR12MB5481450730C442429F3D98C7DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
X-ClientProxiedBy: FR2P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::12) To MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|MN2PR12MB4502:EE_
X-MS-Office365-Filtering-Correlation-Id: 9937f309-caea-488a-52a6-08db20bbd94c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cTrbJwx1k8xgnWa+3e+ebcsSodVAvXMIvBhePE2VeIfJHztdC93jfZugzsXWUox9tIa8J/cNBJOHdzxg62FH1jkkYH+B1OulDN2yJx0sNQ59o9gKyIcjMkORKf01mPP0zFmh2ATBUm9oWUDsYnPp1q8e2kwOwIz10L8LVpL2lJ47DPvRpUsdMqSGVLi/h8sqGqshlQaZS+BSsAIgRfBtlI/yrgb1VVP7/vDSyPyUSa5J7b16/y3PPI8+R7n10dTEc2usKXCacPz/Nbt6wuNGrN/E3akPkwaKkgM8wuMHqq0jK5A7g/W7L5ywjOunSZE3tCjzXIaIrjyfptyp9OwVplZCF9gkQo2XhZ+m9O9MAM4fpPvyQuVjXUuWMWl0bja/oKD76JyUhY/r0fH3zHrk4ARbjQ6laHtzoA2KcGyMoFgeZCDv2P5xRnJm9S5dXPV6439q8EwgqQtjGc6muhHffmu+8SpOamN0CKdAVE/jWHYQojP9eCN/VBIWf6bgSQHobSkuNGKCLJbPlrZlNo136sRTFH2kY+uDoaL+fZTJCxcDkI5D2/qiWRX5Aog4vYkqgREcWT64wrM3lTXDGUnF7jgcZDB8NK7C6w4krfktzHBY2pouXxlc2SyGJLlwtuaG+9ARsHfdrd9EbvT1SEuTFg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(396003)(376002)(366004)(136003)(39860400002)(346002)(451199018)(54906003)(6636002)(478600001)(6486002)(316002)(7416002)(5660300002)(2906002)(6862004)(8936002)(66556008)(66476007)(8676002)(66946007)(41300700001)(4326008)(107886003)(86362001)(38100700002)(6666004)(9686003)(186003)(33716001)(6512007)(6506007)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QwqHQWKKJT7VTr/Vg6MK1/01IcmE8upnQX6yMzf4C9X4dxHGcTQCwib6Dktf?=
 =?us-ascii?Q?4hfPhMfaVfdusJL6/QukOamQUleP7VUmeMI9IED8fW6dveFYeMHMLZ9jZCow?=
 =?us-ascii?Q?6XoWEM0uOkypTrQo0fN94OToz4WNVWGOKl2nUndMDtRmsbyAF/uJZiIfO8Zf?=
 =?us-ascii?Q?r6ruAxRsa2EImjNoLBJv2x3EVXKc9rmSaoltZhzZbQJN2GBnzu+2YNGNTQdD?=
 =?us-ascii?Q?jMwIfuy+Lqg6auitj6AdEkgIhOf0OrDOsjrzK7s5k2QfcIxZSCNcdXVovDId?=
 =?us-ascii?Q?Ad2l5rkuepmh8f4bNIsnBEWkpFQuG/XFRL4ISkPKnVrsjBd/aBzP3LQbzA+e?=
 =?us-ascii?Q?bSM5VgO02iT9T5F2e4Jf4lkCUuEfqULa254vh34yiju1cMctv/t8D7T21/ru?=
 =?us-ascii?Q?nvNySpw1MsoXjl0yFuMHKq0ULxAZDGWOXkGItnf/aNenGQ7bFbH531+vgGM8?=
 =?us-ascii?Q?XLuU/d7vDwvW+Ycfk2teJBInFOLdNqnb67lz3L4+pf75cmMGaKY2CDDST5QI?=
 =?us-ascii?Q?ZHHl8eh3+tLUpR7tjKxKPLgVX8YJweH/Yk6AvawRuzA8P8apruUj8Yzte6OX?=
 =?us-ascii?Q?m4rNS9ZbGQq5tgdhZT+MInmrdx1w+FhOU1LkCi8+qsC+9dsHeWsnLHUQaCyf?=
 =?us-ascii?Q?RKuPrdNU4DPtl+CwRExS6Lzb9vDBKa7Ht8D91IuI650id8Oc0cAFrgPabEHx?=
 =?us-ascii?Q?HskdMK5H/WYLP2jPP3BPg3nJMEsr3saGZyhN0g06BUxOFmY2S6nS8lQBMQ/N?=
 =?us-ascii?Q?RtEcyuDbFa3CDtxFeyjj5lajaQdsilLPmMBXdOwq7YFn3dyQXicZvSDoI19I?=
 =?us-ascii?Q?anYWw+3a+yLjXMrzTHs/37QEoFp+EMiMwRE8TnwCBTNvB53Dc/EcnaEg3bxx?=
 =?us-ascii?Q?4yAgvdc7uRI2A0t/DbAH220QXx+P4ull0mbJ1228YonqgQ3JgECx8BJ0iN/4?=
 =?us-ascii?Q?Z2MsKmTxkjkzhJBYhuGEF/35rGr/coHW4P9FXaSK+22h1QpiiAH7PwiiXCE4?=
 =?us-ascii?Q?ULDjf3wwRYM5WdsI0vYjaj9AVZ9NDtUdht8cUyrzH0M9tSCfvrKT8mycDT9y?=
 =?us-ascii?Q?ismHebQceTRJEuOtQw9Zt7i+1Ww2qRsz+UluLtuukDxzEu3PdD60ru0RjoCk?=
 =?us-ascii?Q?Z8w1U4DS7euN5Ln4r8+nzxXKJqtrBLM6dQEgKcRSOQfN7fB1DT7lUVQ/NUAj?=
 =?us-ascii?Q?Wbq1V2/ePvOGBEf+0n81awqLy4AZJaU+1axnkSL01Li6HE93073tLqFEywnX?=
 =?us-ascii?Q?zXOuSJIbTSyXX66Wjz82DRz3Fj9xao6KCM3BaEXAyZ1mBGbG1AFnVyPJtWiM?=
 =?us-ascii?Q?dZZyomXFu8GIwihItn/uINUxKmeLZucruOIqlqjSIbpYTYYMmCQEcrpr4Yss?=
 =?us-ascii?Q?b10XcnZ/sQy5h1294zSfZAaJCt3r8PaLmUTVrmABIvldTJ2VLQXAIfqrBOSZ?=
 =?us-ascii?Q?6/BGC1f5PUbhS+20Ebm+5quCBTMmc3CX9W0nCDWIY3cpNDwGPJqIw6Wlvw1z?=
 =?us-ascii?Q?BMzAMUdFUxEbAwgudygJQi8ZYvcVU3rS1BPNVDpbjaYrgsaQ1palzBHBIhba?=
 =?us-ascii?Q?u4LLKZw25hLyOLjCyqilUjLmxoPO47L3fm3TcjIR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9937f309-caea-488a-52a6-08db20bbd94c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 16:32:18.1719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cOnKWT1dEoAWN44K1IoyvvzxGSlHOfyL6SWQjMtqalZsf2LxNARuBD5lBMzbl6If
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4502
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio] [PATCH v10 04/10] admin: introduce
 virtio admin virtqueues

Thu, Mar 09, 2023 at 01:36:00PM CET, parav@nvidia.com wrote:
>
>
>> From: Jiri Pirko <jiri@nvidia.com>
>> Sent: Thursday, March 9, 2023 2:37 AM
>
>
>> >We want the ability to program/provision the virtio feature bits and virtio
>> config space parameters of the VF through PF.
>> >These are host-facing parameters that usually migrate from one to another
>> host when a VF migrates.
>> 
>> Here is where we lack to have separate "devlink function" entity, independend
>> of "devlink port" :/ I mean, for MAC config and irq vectors.
>> What other host facing parmeters you have in mind. VLAN of "ip vf" is
>> definitelly one of them, I have to emphasize.
>> 
>It is not.
>
>Virtio feature bits defined by the virtio spec.
>Virtio config space fields present in the each virtio device specific spec.

If those are only virtio-specifig things, I'm good.

Mac is part of Virtio_net config space. Good.



>
>> 
>> >
>
>> >virtio net doesn't implement it either and I don't see any user asking for it
>> either.
>> >All users have migrated to using tc mechanism for long time now.
>> 
>> Okay, so the bottom line is, we should take care of host facing config of VF, but
>> we should not care about network plug of VF - that stays out of the scope.
>Right.

Good.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

