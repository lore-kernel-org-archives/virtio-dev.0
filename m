Return-Path: <virtio-dev-return-11360-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790D7C678D4
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 11:44:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AE80D2A8ED
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 11:44:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A4AD698667E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 11:44:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9A2FB986672; Thu,  2 Mar 2023 11:44:03 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 877EC986674;
	Thu,  2 Mar 2023 11:43:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ievsX5bSPZElGWKw5Dr4W0TW27a7zH3PQ4SiP+8sU5VpMZtFI+0FMHUQnyHZ1eB5INibUhlIlTBLzJRMj115I2SLiBxWCeandfMh7/oct4LGMnld+MNJ+whTdwHGQosdriWivGxmsc7AzpjQ4iSOZC1YqroJy1wLLLo34KBGVR5OQiqLblJKIwLz3R17GH3id/CNH5+23ocNdVBXcPMIuz0D2khjRuG75IvbfFtUTJQ7U1uw+odrp+DE1PilYrZDOBW8CJu06VskQhvOKefls7yWqqxnCjYJCeyHkgnHrUkUB+rYpfLVIcfqAGxyM6W44IXQSF/TxPEEAPDZn4m3GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v222BrKaMSwUuS9cm3C1sxdvhyimnFxsVKEai8HT1hQ=;
 b=HL6XmOVAjDVZE0zowKpRtrwRTb1ABfcBdY9BgVVuxKRdFrQaF4Qi9eHUiiPkvX7laxndXpieD/0NMSps6omkbU/M1eMuWf7FaF0+p9YGMc26lVd+Kfvk6Fg9tBJwfL0nTZDfUrKpY/5wtrVXBQIjdvvLLIwpiFFadkqrbR54WdPpNm8Pm5oxwn0TZJRrHyCen/5B9Txfef/gzl7xYvhgJVij4HW7g662f0ZN3Fc7dkZIHoPE7vvvo5DHNMJ11l1Ausz82DAX5Pt5BwVFqfuhAlcgczD2P4JPGff27RkuxZzL11udf2qoi6zPYKXwjsSo2dLXu2n51tOCGTtWIO4ZIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
References: <20230301141027.59500-1-hengqi@linux.alibaba.com>
User-agent: mu4e 1.8.14; emacs 30.0.50
From: David Edmondson <david.edmondson@oracle.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S . Tsirkin" <mst@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        Alvaro Karsz
 <alvaro.karsz@solid-run.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>, virtio-comment@lists.oasis-open.org
Date: Thu, 02 Mar 2023 11:36:18 +0000
In-reply-to: <20230301141027.59500-1-hengqi@linux.alibaba.com>
Message-ID: <m2lekf1iq8.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::34) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|SJ0PR10MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: f41c6668-0e99-434c-ec0d-08db1b1363ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8SfaCrSvNPj1h/HpS79NXPpJy6QQSOOK2jVIjYb8za/6L1+ArHyIUsV29yWrsiNhRab3VKw7F5ws00DYAxDcIuBTZ6jAMbLaar2bGBuN3QVGIjMaFBDZHx9uhY7umhVfDtMvt4i5qV2P7zb2dLF1UcWcoeznD3zvPjJ1E/G51Z8bJxfOpiw+YEKXe9gj3zJb8b+ZUk+a58F7vc2MSI8wrgAWe3XkTXbMCmGcbhpl+M7Gw4lirTJ98t8tycQQVdv1vwNzNSWMkWzqr4fmODwFgM+0z5b2sJGP+j0mHLCpFmHwjYoy8TYy/d56nn5uJH1kx5ZDaRd8J7gcF3k8Ok8DzYbpBqPWRjiMXg/5qXNolqDlvsWXfHN3TUgYY4ROJWHxH3eu+dOP/tkOMYga9kC2fCVYyXPjI1gzji5IokL2KHnhZl4ruISxCEICIM1re4RxHKe+POVdUzVimt6h/gCPcHMDlu449q2IxmQxDa1c9HxDHisGPtY7/EHoF1rXAAvvC0hLh9sWPLW4W6ur25DdFJ1l0oLAOI1VYRIqpXqsDJ4DJc87qmmxR1//VHrMCrnAQzYFww+vmolfqM0UcfIvndND8fpY7h/nNEakDIJTQ5mBJ+slBWsaKD/VereTAdQIVhhGFllDBC0EVbPcwv/SKADnnrdB9iUFdFFe6ZNTT+w=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199018)(5660300002)(30864003)(8936002)(44832011)(6666004)(83380400001)(66946007)(66556008)(6916009)(8676002)(66476007)(4326008)(86362001)(41300700001)(66899018)(6506007)(478600001)(38100700002)(6486002)(966005)(186003)(316002)(2906002)(26005)(54906003)(2616005)(36756003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?r0GLfoOEJq7GwxvBU6k0qK5Wl3TSl9mmrUfKr5+wbXYNCO1ttsoLScbRU6C8?=
 =?us-ascii?Q?BUgTNvGM85lf89eHUyXBD98CNynfZW9WFuT7ttjBKU6AoLaXDlmWY3JYaz70?=
 =?us-ascii?Q?6Lp5FJZki2Elsj1az9HPEqrQYoIPItyKw3/xyM1bvGGFxuNpAB25nak7qzuK?=
 =?us-ascii?Q?Rj5DFWXwtmPlpBl44sCakf+bOEQFeieqwdibBTa5amWa+5v76T2SpSLsbuuk?=
 =?us-ascii?Q?1UXVNxkAkmnjfTKRjxHimhUmy2Q6mPt+R7K9C7N52VMZeu5CRTHKYdDGTcs6?=
 =?us-ascii?Q?UahrHq4/0RFn/bWRpIniRfnKAGxmeIcVaumXW4CQCPQrGrtkpWzGsmINBz5I?=
 =?us-ascii?Q?/LnXg9coVdtPwuai/rLOr3otj+uwTMwmX9G89DsIL9JUDDtwR1CyHDCg4xOS?=
 =?us-ascii?Q?KV1D8E8hAGdOv2gRj+/+r7qF5cMG4pdrmSLHRtltYodR7ZwMLMdkbpCwR1Ys?=
 =?us-ascii?Q?w7k1Q5VtG0blAqKjR+onwufxmcP5L8FIwnhhcTf88xG4MxtKSLyqCCTl8bxx?=
 =?us-ascii?Q?QZAOscRJSoVZE6w+nfQ0kmt3XRBDkJnRbsAr5m8RCGzydIEsf4pn0XTJiQFL?=
 =?us-ascii?Q?Dz9N0XUKlSomYmIFSBwL4vjQMoTNcyqVgrkzYol/UjbV4z1oWykLCGLmurwy?=
 =?us-ascii?Q?mLV73Go35TwWTl0SV4k8l5n44LG+iIY5Z2mg8UnMW95sbzGFBsQMPpxiPNmQ?=
 =?us-ascii?Q?wABTX1eI2kYi0t4UZtW/W6uvTKH2jlVvzc+xlpzdiAQwM4B731FL7hB/K/Hk?=
 =?us-ascii?Q?JBjb2K6eOJ3jqSyywRGGntMvvLZS1exp6Fi0C2VoG/lnXGItwT9zhqpiWKF8?=
 =?us-ascii?Q?z0pZtOxL9Nl+I32t1iDu3AsIuhe/kfvmK+jEKPgilCdIwrmRCsltcQ40u8Ue?=
 =?us-ascii?Q?6ZIhRi7/Pc/DUYeXY7+fKLk3o7gjH4/JNUDg2sQI4Wj2qk9sb/ACK7ZEeIX4?=
 =?us-ascii?Q?OsTcjQc6YVUsIehr4J7wraWaybc4sKOp0hLWeMQv8P+Ap/rNr3JCvla/3B71?=
 =?us-ascii?Q?BA106tTRJonbB7o87Uw1EucJixmE3+78wA2cs3PEqWXijAuYpYL+qDnpbReO?=
 =?us-ascii?Q?RkB/nWbsX3B+4J9k4884ppZootIGr5neXKYlyVCZ+MJCuzt0A5w+hM5jh+UY?=
 =?us-ascii?Q?x63t7FYJbsPLc++RXQK3SWVbxuzZP5OwbiwKcwn+1AVdvCvMCc0fFfWUSO2Y?=
 =?us-ascii?Q?r+KRcO6DIbbQfLYyCcvbyhwTaN5ePBOAKXue3+LQTW697+G7Op5L3E7GktsE?=
 =?us-ascii?Q?aPapEOgOaLmgpq9Su+M+vYHzVxzmMYCUjbqLy0IAjJ8pj5KyhJoh2pZd0PN8?=
 =?us-ascii?Q?s7pWuFv7D9VLlf6y+On3xQW+Tv989+hzxNJF/3VouTRkFXcIaxYmlQQ7HSqz?=
 =?us-ascii?Q?JxI0A7Rfu2x23vnNrWk+3ASahFQMAnXg2Mzr78f6bDAzX2YZ39HtfWDkdYX7?=
 =?us-ascii?Q?YbIIU1X01tzW7ENAPRV/tJO+lnqPcGASDUCg6Tlm97tYg8mnyU+5aEJkj7IV?=
 =?us-ascii?Q?AvflumQFDZvBJh27t5uuU7HoxeFHGTuxSQGSacp8G0P6dzKmmY6M5b+CgOM0?=
 =?us-ascii?Q?BxZ1J8k8kX49gHK2YAr1KsnCBNFyQz0Fc5mkmR2jtkZnX0aUql5A8h9XOQMi?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Noe4dTtlwl0nae88JAnqR7g17/KJczfh6Ty/ToR3F9Bl/6cybHFF9VWXg0PdV92Fq8QcTd73r4aU0KyaXuukE0F9AD8Y+tKOmHRAktxuxh8Kcmk0tf+RNLj/f1DdhTEdt5pwroeJqeCO49giotr46RVase4z8z9SCy0VtWFtD7lLD9KflFMRsg2PUok6S/5t8+uilpTAS4RKXdMxCN7tjcg4mmw7SZdYm1LTNK5Oj7oJ+755zwO9WVmaM4DkG6bjcmuJN+rHmAFvlGB96OL+yrSmWujDSlJfJbcZaKzDy1MP20koB+dtJSgSwfcnyWqedaXFwTymecNgnRZS7CzZSYIn+aHic82qmtwFWJ4BpeKVzr4t/iGoccLqlv0xfI9REc0RCbuGLWCP8YMwKDmUojJbEDUsDeFy49V0Pp3TIdsUStLLUFOMfaWf6HTsRSNjWZxvPGLNHd0H5o/D4PNgBCn+0+c+pPry1BfEX99D0RA8eTv5iigHcNF2eII9zXYulHahFAJxpMLT3PMi4PcBsSIMKdO4Ju69fCOyA5O23QKhviO8zkn9VC/Nff/jawAikPeucVxydvYTRS9NJ5idsKKJdjtrjP6RLB6DfxoODFmzKgvolF4AuaDORnqHemWlE218SpUg3Qe0/MN57slbepB3+4ZaV5HLHBvdTfeNLyJAuWcIlZo76HO8/d1GAYEvr/62yQS6K6qw93WAjLOMDi8cYu2SlCsFzPApF1RZEjoiepNtu5gDnbCEuCQS0s01MY41AxmCjTSR8c+hN/YCKTwCf4FTNPkhO2tEYkNX0E33WIlkeHF3Db4qoitf0yCbz006HISVW+5Cm5g3nUHnT1dq8EDSOcrSX5V8FuNjM++AQVyoJFOQezEhD6sEAkxC8fhbefaLbGBgY8P4YIZ+5tvtZH/KXmxpzN/s4MI6BJo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f41c6668-0e99-434c-ec0d-08db1b1363ba
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 11:43:49.5361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNmb6QrMkqV2nqU/OG2WJBrgW1LLKV2l7RGHahY9Rw75PEYfHNFmAKZoRq5xfEFGXJtTkKqWqm9Ys3QsjuolLgiDWj4j4m3iFtqM5b3TUTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6430
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_06,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020102
X-Proofpoint-GUID: D61yW0vMRqXfZFsPOiMEY_cMDhQpq-0r
X-Proofpoint-ORIG-GUID: D61yW0vMRqXfZFsPOiMEY_cMDhQpq-0r
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v10] virtio-net: support the virtqueue
 coalescing moderation


On Wednesday, 2023-03-01 at 22:10:27 +08, Heng Qi wrote:
> Currently, coalescing parameters are grouped for all transmit and receive
> virtqueues. This patch supports setting or getting the parameters for a
> specified virtqueue, and a typical application of this function is netdim[1].
>
> When the traffic between virtqueues is unbalanced, for example, one virtqueue
> is busy and another virtqueue is idle, then it will be very useful to
> control coalescing parameters at the virtqueue granularity.
>
> [1] https://docs.kernel.org/networking/net_dim.html
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> This patch is on top of Alvaro's latest v7 patch: https://lists.oasis-open.org/archives/virtio-dev/202302/msg00431.html .
>
> v9->v10:
>        1. Remove the "global values". @Parav Pandit
>        2. Avoid multiple interpretations of command behavior. @Alvaro Karsz
>
> v8->v9:
>        1. Declare the commands that can be sent for each feature. @Alvaro Karsz
>        2. Add information about "global values" in the command's explanation. @Alvaro Karsz
>
> v7->v8:
>        1. Use "best-effort" in Alvaro's patch instead of "the device may set the parameter to a value close to 2". @Michael S . Tsirkin, @David Edmondson
>
> v6->v7:
>        1. Clarify the relationship of VIRTIO_NET_CTRL_NOTF_COAL_TX/RX_SET and VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET. @Alvaro Karsz, @Michael S. Tsirkin
>        2. Remove the formula for vqn range. @Parav Pandit
>        3. Some expressions are clearer. @Parav Pandit, @Michael S. Tsirkin
>
> v5->v6:
>        1. Explain that the device may set a different value than the one passed in by the driver. @David Edmondson
>
> v4->v5:
>        1. Add the correspondence between virtio_net_ctrl_coal and virtio_net_ctrl_coal_vq and control commands. @Michael S. Tsirkin
>        2. Add read and write attributes for each field. @Michael S. Tsirkin
>        3. A clearer description of how to set coalescing parameters for vq reset. @Michael S. Tsirkin
>        4. Fix some syntax errors. @Michael S. Tsirkin, @David Edmondson
>
> v3->v4:
>        1. Include virtio_net_ctrl_coal in the virtio_net_ctrl_coal_vq structure. @Alvaro Karsz
>        2. Add consideration of vq reset. @Michael S. Tsirkin, @Parav Pandit, @Alvaro Karsz
>        3. Avoid too many examples by giving a comprehensive example. @Michael S. Tsirkin
>        4. Fix typos and streamline clarifications. @Michael S. Tsirkin, @Parav Pandit, @Alvaro Karsz
>
> v2->v3:
>        1. Add the netdim link. @Parav Pandit
>        2. VIRTIO_NET_F_VQ_NOTF_COAL no longer depends on VIRTIO_NET_F_NOTF_COAL. @Michael S. Tsirkin, @Alvaro Karsz
>        3. _VQ_GET is explained more. @Michael S. Tsirkin
>        4. Add more examples to avoid misunderstandings. @Michael S. Tsirkin
>        5. Clarify some statements. @Michael S. Tsirkin, @Parav Pandit, @Alvaro Karsz
>        6. Adjust the virtio_net_ctrl_coal_vq structure. @Michael S. Tsirkin
>        7. Fix some typos. @Michael S. Tsirkin
>
> v1->v2:
>        1. Rename VIRTIO_NET_F_PERQUEUE_NOTF_COAL to VIRTIO_NET_F_VQ_NOTF_COAL. @Michael S. Tsirkin
>        2. Use the \field{vqn} instead of the qid. @Michael S. Tsirkin
>        3. Unify tx and rx control structures into one structure virtio_net_ctrl_coal_vq. @Michael S. Tsirkin
>        4. Add a new control command VIRTIO_NET_CTRL_NOTF_COAL_VQ. @Michael S. Tsirkin, @Parav Pandit, @Alvaro Karsz
>        5. The special value 0xFFF is removed because VIRTIO_NET_CTRL_NOTF_COAL can be used. @Alvaro Karsz
>        6. Clarify some special scenarios. @Michael S. Tsirkin, @Parav Pandit, @Alvaro Karsz
>
>  device-types/net/description.tex | 88 ++++++++++++++++++++++++++++----
>  1 file changed, 77 insertions(+), 11 deletions(-)
>
> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index e71e33b..b5d45e8 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -83,6 +83,8 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
>  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>      channel.
>  
> +\item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports virtqueue notification coalescing.
> +
>  \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing.
>  
>  \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
> @@ -139,6 +141,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
>  \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
>  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> +\item[VIRTIO_NET_F_VQ_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>  \end{description}
>  
>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
> @@ -1505,13 +1508,13 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  
>  \paragraph{Notifications Coalescing}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>  
> -If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can
> -send control commands for dynamically changing the coalescing parameters.
> +If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, a driver can send
> +commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET
> +for notification coalescing.

"to change the notification coalescing parameters."

>  
> -\begin{note}
> -The behavior of the device in response to these commands is best-effort:
> -the device may generate notifications more or less frequently than specified.
> -\end{note}
> +If the VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated, a driver can send
> +commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET
> +for notification coalescing.

"to change the per-virtqueue notification coalescing parameters."

>  
>  \begin{lstlisting}
>  struct virtio_net_ctrl_coal {
> @@ -1519,25 +1522,74 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>      le32 max_usecs;
>  };
>  
> +struct virtio_net_ctrl_coal_vq {
> +    le16 vqn;
> +    le16 reserved;
> +    struct virtio_net_ctrl_coal coal;
> +};
> +
>  #define VIRTIO_NET_CTRL_NOTF_COAL 6
>   #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
>   #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 2
> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 3
>  \end{lstlisting}
>  
>  Coalescing parameters:
>  \begin{itemize}
> +\item \field{vqn}: The virtqueue number of an enabled transmit or receive virtqueue.
>  \item \field{max_usecs} for RX: Maximum number of microseconds to delay a RX notification.
>  \item \field{max_usecs} for TX: Maximum number of microseconds to delay a TX notification.
>  \item \field{max_packets} for RX: Maximum number of packets to receive before a RX notification.
>  \item \field{max_packets} for TX: Maximum number of packets to send before a TX notification.
>  \end{itemize}
>  
> -The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
> +\field{reserved} is reserved and it is ignored by a device.
> +
> +Read/Write attributes for coalescing parameters:
> +\begin{itemize}
> +\item For commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET, \field{max_usecs}
> +      and \field{max_packets} are write-only for a driver.
> +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, \field{vqn}, \field{reserved}, \field{max_usecs}
> +      and \field{max_packets} are write-only for a driver.
> +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET, \field{vqn} and \field{reserved} are write-only
> +      for a driver, and, \field{max_usecs} and \field{max_packets} are read-only for the driver.
> +\end{itemize}
> +
> +The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
>  \begin{enumerate}
> -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} and \field{max_packets} parameters for all transmit virtqueues.
> -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} and \field{max_packets} parameters for all receive virtqueues.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: use the structure virtio_net_ctrl_coal to set the \field{max_usecs} and \field{max_packets} parameters for all transmit virtqueues.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: use the structure virtio_net_ctrl_coal to set the \field{max_usecs} and \field{max_packets} parameters for all receive virtqueues.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: use the structure virtio_net_ctrl_coal_vq to set the \field{max_usecs} and \field{max_packets} parameters
> +                                        for an enabled transmit/receive virtqueue whose number is \field{vqn}.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: use the structure virtio_net_ctrl_coal_vq to get the \field{max_usecs} and \field{max_packets} parameters
> +                                        for an enabled transmit/receive virtqueue whose number is \field{vqn}.

Should this now be "whose index is \field{vqn}"?

>  \end{enumerate}
>  
> +\begin{note}
> +The behavior of the device in response to these commands is best-effort:
> +the device may generate notifications more or less frequently than specified.
> +\end{note}
> +
> +If coalescing parameters are being set, the device applies the last coalescing parameters received for a
> +virtqueue, regardless of the command used to set the parameters. Use the following command sequence
> +with 2 pairs of virtqueues as an example:
> +Each of the following commands sets \field{max_usecs} and \field{max_packets} parameters for virtqueues.
> +\begin{itemize}
> +\item Command1: VIRTIO_NET_CTRL_NOTF_COAL_RX_SET sets coalescing parameters for virtqueue0 and virtqueue2, and, virtqueue1 and virtqueue3 retain their previous parameter values.
> +\item Command2: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} = 0 sets coalescing parameters for virtqueue0, and virtqueue2 retains the values from command1.
> +\item Command3: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} = 0, the device responds with coalescing parameters of virtqueue0 set by command2.
> +\item Command4: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} = 1 sets coalescing parameters for virtqueue1, and virtqueue3 retains its previous values.
> +\item Command5: VIRTIO_NET_CTRL_NOTF_COAL_TX_SET sets coalescing parameters for virtqueue1 and virtqueue3, and overrides the values set by command4.
> +\item Command6: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} = 1, the device responds with coalescing parameters of virtqueue1 set by command5.
> +\end{itemize}
> +
> +Upon disabling and re-enabling the transmit virtqueue, the device will set the coalescing parameters of the virtqueue
> +to those configured through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or to 0 if the command did not set any TX coalescing parameters.
> +
> +Upon disabling and re-enabling the receive virtqueue, the device will set the coalescing parameters of the virtqueue
> +to those configured through the VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command, or to 0 if the command did not set any RX coalescing parameters.
> +
>  \subparagraph{Operation}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / Operation}
>  
>  The device sends a used buffer notification once the notification conditions are met and if the notifications are not suppressed as explained in \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}.
> @@ -1585,11 +1637,25 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  
>  \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>  
> -If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
> +A driver MUST negotiate the VIRTIO_NET_F_NOTF_COAL feature before issuing commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRIO_NET_CTRL_NOTF_COAL_RX_SET.
> +
> +A driver MUST negotiate the VIRTIO_NET_F_VQ_NOTF_COAL feature before issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRIO_NET_CTRL_NOTF_COAL_VQ_GET.
> +
> +A driver MUST ignore the values of coalescing parameters received from the VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command if a device responds with VIRTIO_NET_ERR.
>  
>  \devicenormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>  
> -A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with VIRTIO_NET_ERR if it was not able to change the parameters.
> +A device MUST ignore \field{reserved}.
> +
> +A device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands with VIRTIO_NET_ERR if it was not able to change the parameters.
> +
> +A device MUST respond to the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command with VIRTIO_NET_ERR if it was not able to change the parameters.
> +
> +A device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET commands with VIRTIO_NET_ERR if the given virtqueue is disabled.
> +
> +After disabling and re-enabling a transmit/receive virtqueue, the device MUST set coalescing parameters of the virtqueue
> +to those configured using the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET/VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command, or, if the command
> +did not configure TX/RX coalescing parameters, to 0.
>  
>  A device SHOULD NOT send used buffer notifications to the driver if the notifications are suppressed, even if the notification conditions are met.
-- 
Welcome to Conditioning.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

