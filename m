Return-Path: <virtio-dev-return-12630-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B267EC7EE22
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 16:12:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F2A507A1CB
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 16:11:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EB5AF9866D9
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 16:11:59 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E151A986590; Wed, 10 May 2023 16:11:59 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CE7FD986591;
	Wed, 10 May 2023 16:11:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxgJtHcE/ELac7jmqle8QPJhz3fCUs97gZL/O+wACyqC8ExZvfS8DQfyKWQof/QeEO54+OdCpzrBSKNJNMl6LFW3SIs6rgqK1p8NtE+iLozsPlM3s8L2SZ0emlG0I7/Inw05NgCCspKTuVemhYdaRu05SrMbqdvg8mNe8K4KtZ02Uv+VgEwu+LG+b/fs49sxivyv7nGKWXmG0rrX1EZ12OMKX1ckyc5pD95JNgBavUOWFvsjmPrN1zOZNrcbzNsCLw8hZyolTrc1U+QSiZpk92qLMXG9p+w/q5vE8ffatUrmTcvNhDv5Sxhq+ygIc8IqKe+BCwD0uMvxyO86tqogCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMIJKimm2M4yqXECNA2rfMrZQrkGHVfm0Rvk/1MDlG0=;
 b=klw8b/qAWvnT5FqYXK/z9AozYQJLxSiazWYhzbzJq/9R/Ut5XnkVGQWoSpLWuU4UAjBsjuzPMVD4vYYmc7A37nbr8b0qWUPoGn7vy3hQH4coa3wR2N2SJG4rTt0tHQ1hk0lqoq6MXQwxmlRY6WzSOZaGQidZqYDtAXYLlnIzoGB7/eeKaNA5p8eU+hFEiFQ+sDMaX5t/+zzIeSkofADyV99cH/lBHyVcn4KdlrqGlZPIdY93WMgz2VSa7b2Me3e4cs2LDP6alnv4xEMxdxGY6+mCxCnCWKq7cm7LVkDxSSYe81LynwfewO+h2QBOprXWwddf7evGa2fAG2xeI4MO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <43ec1c8d-7d11-2400-3649-1fe366b1e21b@nvidia.com>
Date: Wed, 10 May 2023 12:11:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
 david.edmondson@oracle.com, sburla@marvell.com, yishaih@nvidia.com,
 maorg@nvidia.com, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
References: <20230506000135.628899-1-parav@nvidia.com>
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230510014534-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:408:94::17) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|SJ0PR12MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 1efe688a-7e47-4776-a6f9-08db517144d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gmJxvdf0Spkpy09mIeUp5xK5SO4CaSqja1LGVuhoCGpReRNfEkDdz5IQ4u3uOJxRBd1QQW3TSltbd3OTSThqcWrx0KiePps+Rb4QAuRUA6r1+wt/i4quQFUMD6+olvVWas19rc6nY/u/WyrLm4tlUM9E7YfNClrZKOiyNifkJRGsUD6ny38m6oFSnzf8EorhtkKpIzqnBRMVxnfxIrU8k+HkQzyUYcdyC9Z51Mu6MCCc5Ba+omQ7aHiKtxpLokSaR4izJ1c7vFQd7wv+K2Dd0hDXzRNSE83pCFD6wVKaiu7juUaF0v/rTzncqTQqcOBAELcfT5jjXXMY20VHdBgMD8k7JYB/OwlIfEaVtwJdkIpIost6c+MS7dAt+glyK3Y0MVVa3nxlU2vezk4QwNCIIbj0LJqfS/qY4wOLQ1HGgZbI/WR/ntVLOfhDQV/XAGyL/+nfV5RieHA8RrBgJGn977mkVzZw4+feXeaeSbai9jl1LB40nS8e/1YhfxeIQBICC1yNXm+RjnBTzW9zWMQ0ziTgG6roxmISoa0P4N37aroZd4mcKco9lLBySImgT9blzpLTnKXu9UZphRri3k6mjkWiMzXYcbz+8eQEjU2jpGgRZ8/1HlApPN1pOMFW0v5GjREjst48CxUboC1FICfGmw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(451199021)(53546011)(36756003)(66476007)(31696002)(4326008)(110136005)(66556008)(316002)(66946007)(86362001)(478600001)(6486002)(5660300002)(8936002)(41300700001)(8676002)(186003)(2906002)(38100700002)(107886003)(6506007)(6512007)(83380400001)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEtsNnFCVkM3T0piM2J5N3RDV2dCbDFaR1FJdUNIYTZCbUZYb3ZzZlZwOTB6?=
 =?utf-8?B?OXZZRWpqUWllQXBTaHN1RkFMekFhSXlMV3YwM1JmV0JUc3J4T3ZTdlNCS1Fr?=
 =?utf-8?B?Ulk5bFhlTnpIaWpPZmFmM3pyMUJVOFQ4clQ0M1NWWHVybUVtMHNiYU5QNkNH?=
 =?utf-8?B?ZS8zekhmRkk1dU1KUGdYbGQ5Y0ZHemNlZmN3Nk1VT3N5SFY2MlRBK3ErM1Br?=
 =?utf-8?B?VlVmNVFxYTlhVHkzbnRGVlBBV1hxdDlKSmcyUzZhc0gvbWdGTXZUOVZOTC9q?=
 =?utf-8?B?K1lsbThpbVo2ck5RdUs1TThRcnpuMGV2bHI0YUEzTlZKMUhwM2VZTktaSEJM?=
 =?utf-8?B?NW8rSDlaU3VCSmw5MmxZclZNclBITHVyOUE4a253ZkluZHYvZUErdzR5enhJ?=
 =?utf-8?B?amhQNUo2YVM0UEhoZlhMeXBkS0lLQkhXanFYamxOVmxEY3FsMWovUXhLQjg1?=
 =?utf-8?B?N2VUWFBPMWZOb0ttdEp0RnNnb2M0dzBvSWhFY2NaSlRTOHNiUVlwQXhyYmEv?=
 =?utf-8?B?b2UxdXk2bUQ3bU5oSGFNUmI2anhhOC9hVjJuQnpnSG42Szk1M1RaTVhwcXNu?=
 =?utf-8?B?akMvUHp3QTAvV21jV2h4d1loODcvMi93RkZUak8xa2ZTOExzZlg2aWcvdXli?=
 =?utf-8?B?dFZTWmxQRGVOTi8rT1V6d3YxaElqUmRGbXV4eUViQ2w2aXlqS3lCNTh6WHh3?=
 =?utf-8?B?K0hlazJwajZ4cVNHZlZ1b1Yzb2cxS0FVbXRJOFhYR3prTlFWdjZ4c3V0blEw?=
 =?utf-8?B?NW05OHJ2ZThjaFJFUHFZeElkeWJEU2oyYWZCbHpkRzVvM3RRMTdvSmtyL0lL?=
 =?utf-8?B?VXpqcUdhMzJuc1NrbWxmd1RPS2hJeVpnN2NNQitOVzFMLzFtaWowMFR4VUlE?=
 =?utf-8?B?OTZzK1R2SFdFL3dBRnhlc2RKMVR6MDZjN3U5dlNmYjdmTHVja0xJTXBWb28x?=
 =?utf-8?B?dUZCcU8vS2dxRDg3OWh6RS9lQk54eG01bWFIMHFvVDFFVkJGd0JBZHI4VUhm?=
 =?utf-8?B?MTMvd3dKMWpmYkc2aG1rYmhhL0orV09rZTVGcUlITkMrdUpsWHpBQnRBc0hl?=
 =?utf-8?B?cXlUcUI2UVFJVDNrd0g4RnpQRmttaC9sR255c2hYM2dBWXRkMWpNZTlRcFNw?=
 =?utf-8?B?T210SG93M1ZaaU4rN2hYVmlhWUt0S1ZYYUx6MUkyUVQ2QkgwQVNMU3d4VnJJ?=
 =?utf-8?B?c2MxM1E5Y3h4L1pHd09pU0lvaDVZZC9ZM2Q0Q3ozTGc3R2wvSG5pS2x1U3Q1?=
 =?utf-8?B?ZVVpOC9rODZPaTdXaHNtNWIzRExoL1hmTTFLUmJpZ3d1R01jczhQM0hiUElJ?=
 =?utf-8?B?MzA3U1dhcE5FeHNYRTM1MDdnZHFEcXdVZDMyUzNQZVdIZHpYZEFZbGVWQ0hC?=
 =?utf-8?B?bFNTb1R3ZGx6OGtHOHh5em5TVkh3YktTQTZ6SFpaUll0cUpGMUtkREFWT21S?=
 =?utf-8?B?a2lXS3BDYXdNZ2RSWnIxcE51SkpGcmxyUWxENTRiRmJWU0pQbDg5Z1hGUkRa?=
 =?utf-8?B?VXRKeUVPOG5EL05LcXVpUitFTis4cmdvL25zc3Flb1daWWpLMVpzL1RZVWhz?=
 =?utf-8?B?QkdMZDhlUGxvSUtiMkhodzRoMk90bE9uTm43emxTOXhuLy9YZDVMSll4UGdm?=
 =?utf-8?B?c1oxWDRuM3RHS1NlbnR2S0FTSlRIQ21NMThSQXdtdVJ2dTNJa2d2NTc1TFRu?=
 =?utf-8?B?cFM1UXhwaWtqaW5ZVDU4SXdnRXJnUzhDN0VFUU9Jb2t1anNkejZEcC9vWnhW?=
 =?utf-8?B?djliSytHb1pTOWZoVStrQXlGUVJNY0ZOcG1ZeTR4N3BicWV2YVNxQjhuUkFr?=
 =?utf-8?B?a2o5b2E5bVR2TVdDVEZWc0t2UTlwUEVldVRVOXg3dFdrdHVHbmpwU2hyL3dJ?=
 =?utf-8?B?NU0xcHNweldhSWM2VVpQN2c2MzlnWC9OZGtEWUV5b3RMdlcvbi9wMklJUXgy?=
 =?utf-8?B?MWJ1NFlLOEUyUGUvQWNISTMzd3FjSkJRL3VhcEJpajlJUGErWnkzOXFpNThr?=
 =?utf-8?B?UURsb1VMbmVBSUZHUWNRRWJyVlNidkxNdWtUemUyVjE5RFlHaWh1Uko1aGcv?=
 =?utf-8?B?aVlTeHRYLzlwcWxSc2pyVGZRWUh2TCtYUTRUS1hHanNvcDBCRHJSMDlGQThQ?=
 =?utf-8?B?YnVMaElRTVpyOEZlVGFlQlNTTFY1SEpDNmFPQmlLRmVBWkYxdlQ0SXNyVzNZ?=
 =?utf-8?Q?Q6std2RLKm4nhpYusJ/dV8Uqk3EL4Xp5yA90ydGJS48+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efe688a-7e47-4776-a6f9-08db517144d7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 16:11:53.3367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PpGvHiNl7KkQM+mDoQL79qgIsBAAylIpTIi/RJnKHdvpCkXJvNiknuC/QZB2cCB/hg2h7JXk0VrPECoboVLfFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6783
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ



On 5/10/2023 2:04 AM, Michael S. Tsirkin wrote:
> On Mon, May 08, 2023 at 10:23:39AM +0800, Jason Wang wrote:
>>> I thought so too originally. Unfortunately I now think that no, legacy is not
>>> going to be a byproduct of transport virtqueue for modern -
>>> it is different enough that it needs dedicated commands.
>>
>> If you mean the transport virtqueue, I think some dedicated commands
>> for legacy are needed. Then it would be a transport that supports
>> transitional devices. It would be much better than having commands for
>> a partial transport like this patch did.
> 
> OK I am beginning to get what you are saying.  So your criticism is
> this: what if device supports vq transport for modern, and we want to
> build a transitional device on top.  how will that look. yes?
> A reasonable thing to include at least in the commit log. Parav?
> 
I am still trying to understand what is "vq transport for modern"?
Do you mean transporting currently defined config space access over vq?
If so, is this VQ belong to the guest or hypervisor?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

