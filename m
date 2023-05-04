Return-Path: <virtio-dev-return-12547-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D83C77B7C
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 14:26:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B77D919090A
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 14:26:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AEEA19866BA
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 14:26:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A34589866B1; Thu,  4 May 2023 14:26:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8FB2F9866B2;
	Thu,  4 May 2023 14:26:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sp6QOsqnJ00e403qDQFx2UlNZGrHM5D9sFVZuvrvVjsFwybIs99DjIOYrBYk0ETolhkNWQgpgAHVYLVTuAJ8iW06YXiksP+JP6UI4ZY8wXH6NILDAKMiO9jV3NnE2QfGJow8QMla5xak5FfMbcn4F2n9RhQ+XuLzTL7FqLC06EacF44cr9C2LYAQtcDbwU8GcujAhRuuNwFrs0dUGE2KJIRvxhGFnwxV19Fvtfh+k8FSgOIEIvdsFSOoIXsk7VAWk5PfnhR+LpW/jsqdQDXYKYKifjCiuKTH76rta8LNPQScTdRjgP9Jjyb4wm2qNC92/tNz+TZ0byojyGCLJ9Qqzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSwhTWZ+g7rMuRqD6G6/XsC0T3sJe02p3hdFFN5Z+ww=;
 b=OW8OqZTJpkrVQnp5faOzapTnecOVnBjS6SndrFR18Xt0gayjYwaBFe2fKpiEeIXpXxnK9IeDopVvcgPXrypKZF9Kof5Hmsh7y1/jKgpzwEDQ6OVvG6T9JK4I2ocxdLsb0BZ9EAUu7EesL4OnEYPb7OT9WMWEMxcheMnS892XZ8NN3+p+FvASoLQJb0iWIWdav1Y2l23z/+BBbk8keYxEr5gChTsQBhYUbWyjNy/SbjKNElyy26eveGzUszUFBJOxq/PW8oDtu88K4MZjaAjqPlVC90/6pugnCvw7+ASC03NvdXOrbrFjHXNkWw55QN7dnp06JGVNW79TbDmbF63Wsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
From: David Edmondson <david.edmondson@oracle.com>
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com,
        virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: sgarzare@redhat.com, pasic@linux.ibm.com,
        virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
        Parav Pandit
 <parav@nvidia.com>
In-Reply-To: <20230504022959.547025-3-parav@nvidia.com>
References: <20230504022959.547025-1-parav@nvidia.com>
 <20230504022959.547025-3-parav@nvidia.com>
Date: Thu, 04 May 2023 15:20:56 +0100
Message-ID: <m24jos5gaf.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0275.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::10) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|PH7PR10MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: 357c8cae-2973-4754-6586-08db4caac95e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	um2No6D/gFiUUulFciUtx++c5NvIw06fsrLliOogi6/nlPo28u4rLDEorBZ0yZ36iK2ORGHrDiI1ZCtfwuLhVoKRuLC/92NQYlT723NNauACC6zJaumICwUwWSS4fATkR42eGa6rh6hAHpBL7MHCqhtOjvGeUPwl9OZqVIYzLNljrTLUCCKF3c+DjFaaa26g4c4zhPt9QE3RKBQsSsZHmFGrz6QxUpdLvlCDozdgfIfTSaOIB4i47JvDzEzRckAV4dn6vPvQlccEyKM4OyBa7LCLvrPHKceaTtwvqSwpMfB+cyl/o38QXD7mjvVqLqSGj69yO7spXyPw6qyvQqWpzK2h6wFBmy2PGu17KqAOfLmMMW/Ks8CAgHH61csazi0ICkIC+TlIROqly57waPAnQiNKDP1/pm0cP9Q/GluHt34au5y90KRhlZUd1WmFaAV4cHFSe/PlbOi0DBc9BknuX+DuVpglsoYlcwj00bibKn6VtUTWRbmF+BQMndrSRY8XjGm2ApnYWQsWiKQP54gFwC78bWNQu2ItdMQOC3cGMDA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199021)(36756003)(38100700002)(5660300002)(2906002)(44832011)(8936002)(316002)(86362001)(8676002)(4326008)(66556008)(66476007)(41300700001)(66946007)(966005)(83380400001)(186003)(6512007)(6506007)(26005)(6486002)(478600001)(2616005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?urEJnomc6elkkts3pUiu5eACzY15iNvu0hqe4/U6V8Dz25VX75S7YLPGjXmP?=
 =?us-ascii?Q?es1WgeBZ8WOqnmtujGo+1yvWI5+BqK51qN/Qh9V7NDJMWvc3SgKxUh//b4KE?=
 =?us-ascii?Q?19C8Bu4T4V/F0Yd7LRX0LLabZOHYyfOR5Er+A2DsnRAU7+bH2mulmeFIivnx?=
 =?us-ascii?Q?cxdh/bR3TmQFsvGwH4OoOe6ElkWAHSrmi+oEH0j0JkAgcxM4Gwy6ZoHPvOzn?=
 =?us-ascii?Q?K9HKV0tAKSHNmVsuNgWZbmJlTaxYJHjnwTggWFrgDrMwR9aLtllGXX29DUQT?=
 =?us-ascii?Q?jowDz67EaL2qERl4pBHVzCe/C8ahGiOv7bkbSE80CYj56HWrrTWzTy6XQy1b?=
 =?us-ascii?Q?Xj8i59Pma5vZdb+hFjZgCsFpnWxHrG49qFDKnlbkjrFu8DkFb5WzNnlSmcmp?=
 =?us-ascii?Q?tn97nPgY4HWHe5OHqt4NjsMTBVqZD/2EOkfSauarphmixIaaquTS8AiqFx8U?=
 =?us-ascii?Q?Bk2O2o94L3vuoWSyo1qAkU2kjFIIp4N9F+LiC7o2uKIeDCC+zFoDai90PoQd?=
 =?us-ascii?Q?B72hWjqP1OblL9Musb72QpJiI2iIAJbaR9mKwev1qDN04YHpek0MGCcIXylS?=
 =?us-ascii?Q?xhbD33vBmqrfp9s4p0VIbJWt1LmzgJaPEiV3+PSK+ndhzNCUW2tPiuRhgeR8?=
 =?us-ascii?Q?5izAUA37Q/ly0zUi6CkhlQoYlkz92abT/CU9S1Mg6RAZJgIgETseZWZEy4/v?=
 =?us-ascii?Q?DXpxbq9XEMIBXz6BfWZdplpeq/elSc5Ey9QqvJIKA5Iw+WRl0+i/ipYCf4Y1?=
 =?us-ascii?Q?7vxYxpvMdkb3yLdOCCl3lPS2D6k5gX29dBsG9sUIsTx42A1sG8L+d/A+5+GD?=
 =?us-ascii?Q?NNhtrMaVOCKtrf9VtZgQGxhkhj4nVAncwvdS7BC4yrbtUi0nIVCh32yHIeQB?=
 =?us-ascii?Q?obzMisUIADNNZsgcJ3HuF2M6w1KFw+4uNwCjcFyL83SmVAytZbjlLD2+2kGi?=
 =?us-ascii?Q?LBR5C7cS90inPQyQGDTuzP9wpKIatp5TfCOqn2FTNQwyVV3++TWlMZZjOA/1?=
 =?us-ascii?Q?usXoke7n5gKjk+06s2d2MZgrAOu9J9Esm+HJGYxvcDNEVs/qne+1Fm+hFjPY?=
 =?us-ascii?Q?0gUYUsKamiwm6anngXPNHE5srvCm4RnRi7YdcLUxtHl/GKcX3lUq0pg7UtL3?=
 =?us-ascii?Q?80XZ6iZSdEGFZvbVr0wYyHrR5qV/wAM36GrwTESW4Qpdxs7ag2COZ8phrZ3r?=
 =?us-ascii?Q?BwKqTFJeluZBnueDE+yoA0DYUj1H15lTtAzVnZWhNScyFs92UaxGkh67uwIt?=
 =?us-ascii?Q?d8w923r6FeMT6Vg6jLPKTG0oi7IQtPHA3GSmw/NbXkhqrjfB85BwUU00tJlR?=
 =?us-ascii?Q?q/6QdoiIypKngQasOq+1TDMRlpaMkVuZkpeFVuQiCPCoaV6jkvmk0ZdctsS7?=
 =?us-ascii?Q?qeqLvsS5q4eoR99ex+K0KYuav3EDjk9+IXWoW7PLzhRwLSa0i14gg1Rphudn?=
 =?us-ascii?Q?felxIkU8m2G9LkoUFyYdYEYNX/Lvi9PHN1RNLiFED2ua30oQfEPpA4d0ajgY?=
 =?us-ascii?Q?QR1afzAfd975TdXxigtgEX3ytbQOiBgxg+wtFAotfapJCOOkT8AK7WFBry9F?=
 =?us-ascii?Q?MsVS9ENCjaJkPM+dLNuLm1NYKxzXbXnoB/oInu2hg0x4YPadUrwO2zvVwi9f?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SZ9OsLaezBsaBcAmHPTZqZJQ16qcvfJfhBUYPwPVggOvLj3S9q/GafPXacoR5C6GUkvvwjXwRzgvFUIeiqOZSPC7CgAvmzuczDxjhHXkKAYOxZtODiHhcJfEOJjS+nkdBU6rFdJLN/+ZY7nNH2S5FrTUedaLXJ4YZMKPEw6uzjnM4Tf3mqu+5zRjdkMdqRgbcZ4A5m3otr5uv5owj7rdVJtCXyw29glvIdvgw7zIuFAGXWi9la1JB4YuVKIaeBi8EDV30MWc8bnbkI8DZTBr7PD8tLQDVkdHToklbLROkDnm6zte7jU63nHDkWbqieZC6uWMJIgj7GrtslM+CaVX7IctS/Sal5oi13EqofmScq1geZ0nlIZ7XN4GFNJLhA6S5lBjJTsXHFpbOMBNg9wyv1GVc7JrWWgVH4LyR34ISqQODrw7OoEh7jLBsZh3kMbpq+c+NOrhEACqWHAZ5lCzp1130XCfQVgmlmAGiPom1CygAAOUyRhB5UeGwrH4Z9qBVp8TBaSxhxewse5jFXaag1yTJwy4KOxLmm1QVdcrblUsfsLJpWEA5XNZAI1nnhqpGW+NgCVffSIMPQtSofjOWgk3DkuoBwEtPpTN9nw2Qjv01ve139zS0BKqM3I52Gfch0UmmpsVfJ5t2dHT65gHV2DnhyaLbfMhOZOgBVc7iN7EB8avjUAMN50nS6L6i67FFHEjAU3CnDqLNTX+AOoHj8awwXKabQfrwyd67uviPmsJ9ovxGrfFUNoFLq6k6pb3mXXFwj82rcklQPykCt3RyD0kRWdTITV3++1IS7Tv0+qPTgUfozHhNQ/ZxKAZQbCp2bIJ9QMc0FgEGTPdHBeTQ5gIXR3DatHJaWgu20BIOmOpJOhsNEgfoWy9N628fy3Z
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 357c8cae-2973-4754-6586-08db4caac95e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 14:21:01.1935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13GN5sR5xcpkbfJ7zBR6Jr2ETzDTgNy34osiW3Qe0/MDsf4kKM6WWQfX4qjuWckIk+jKLJ7IuTOCXWheyNITKHoY+ADfFqeiahdm5Ga79nI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6284
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040117
X-Proofpoint-GUID: xaBchOoFhzWjYTHmvBMdDk-H_Gbv2tDo
X-Proofpoint-ORIG-GUID: xaBchOoFhzWjYTHmvBMdDk-H_Gbv2tDo
Subject: [virtio-dev] Re: [PATCH v16 02/11] content.tex Replace virtqueue number with index

Parav Pandit <parav@nvidia.com> writes:

> Replace virtqueue number with index to align to rest of the
> specification.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
>

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
> changelog:
> v11->v12:
> - new patch
> ---
>  content.tex | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/content.tex b/content.tex
> index 9b694f2..9cf938c 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -406,7 +406,7 @@ \section{Driver Notifications} \label{sec:Basic Facilities of a Virtio Device /
>  
>  When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
>  this notification involves sending the
> -virtqueue number to the device (method depending on the transport).
> +virtqueue index to the device (method depending on the transport).
>  
>  However, some devices benefit from the ability to find out the
>  amount of available data in the queue without accessing the virtqueue in memory:
> @@ -790,13 +790,13 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>    buffer notifications.
>    As mentioned in section \ref{sec:Basic Facilities of a Virtio Device / Driver notifications}, when the
>    driver is required to send an available buffer notification to the device, it
> -  sends the virtqueue number to be notified. The method of delivering
> +  sends the virtqueue index to be notified. The method of delivering
>    notifications is transport specific.
>    With the PCI transport, the device can optionally provide a per-virtqueue value
> -  for the driver to use in driver notifications, instead of the virtqueue number.
> +  for the driver to use in driver notifications, instead of the virtqueue index.
>    Some devices may benefit from this flexibility by providing, for example,
>    an internal virtqueue identifier, or an internal offset related to the
> -  virtqueue number.
> +  virtqueue index.
>  
>    This feature indicates the availability of such value. The definition of the
>    data to be provided in driver notification and the delivery method is
> -- 
> 2.26.2
-- 
There's someone in my head but it's not me.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

