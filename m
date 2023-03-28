Return-Path: <virtio-dev-return-11811-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6334EC77B61
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 13:59:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CE8AAF3F4F
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 13:59:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C20AA9863E5
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 13:59:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B898598637D; Tue, 28 Mar 2023 13:59:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A77F19863BF;
	Tue, 28 Mar 2023 13:59:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gO0DSTpZqksRgwtXRfN3vI8TSMHSyfdFrjBJlPls5sy0tmgeuGZxV/q1O99tC6vnlFMdtbF2RYFpbd37m/GmiWrgh3GZH+OOUlCXcbbFziJ2I9qw5TWBRg6aR+wG7pUzpvKlyu6J6K4bj3of2zhhG4eb0Km6bJ5R81DLkYQOsm6RVGif8WDsTUs1U8cG0TU/2pRFnBmwTjK/68jH8sxJsXN+6HYUTK9eUk82LJp17cJ0U94Md77AL+cjhWwyVEAQZz7tiCKOuZE53oraFBkcNRjADqzYjER5RJf1wRFTfXBj9gFMD7GhIpeBGWeLS6xTHM+xt2dcn/eqytVUbuLFng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0nZaE3EeqARa1dVwrzoo3UD7fM54gb8U2tIIsHXwLo=;
 b=Njq/gZgQOdqfKSr2acNWvxpn50Xes/XldBfLk+fFbBpczdBhD9PIfvcLCnw6ZNHOOAXYeHRIMrtfIJ1dBeyzXEC1NB5f1UYbuB48dzDTapY7R+fcAONaR4X/x/COCGXYlrzrvc7eBhhkk7FWX977i32BllD2H5IDYhq9xcB8SKdBTKlZIWV+n2WY0xeZXs5Re4Q70LZJUirjVTgWTRQf0OTg6JOFJMpp9UV3o67Mk0PDDQTCsvl3+rXAdHMY/B51N+IhEtFYgE/HGS8LeNgEpyIn3vlsvdA1Sgj6Ukt/EHsZCJ0wEp8GuPp9LsO2/RiTY6lZUorBCgJAVBJqlcqw3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
From: David Edmondson <david.edmondson@oracle.com>
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com,
        virtio-dev@lists.oasis-open.org, pasic@linux.ibm.com,
        cohuck@redhat.com
Cc: sgarzare@redhat.com, virtio-comment@lists.oasis-open.org,
        shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>,
        Max Gurtovoy
 <mgurtovoy@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
In-Reply-To: <20230327235936.414196-3-parav@nvidia.com>
References: <20230327235936.414196-1-parav@nvidia.com>
 <20230327235936.414196-3-parav@nvidia.com>
Date: Tue, 28 Mar 2023 14:58:52 +0100
Message-ID: <m27cv1c6zn.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::16) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|DS0PR10MB7052:EE_
X-MS-Office365-Filtering-Correlation-Id: 8baaeb85-e754-4e6b-c8c2-08db2f949376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	S79K7YKvSsXejUFT9TmmgGhj+73t/8M4+KqinyvrvAL7MUmxwuHEdqDh3Jiftvt7AcK9C/hzts6YeMwZtiRDLg3fWtTHTgE67z1BqBL8rK7Stgf6DGpFarHehYFvdrauH5OE+4DxkxfutzymYECx+9j4D0RcfBYlS1SAeoJ5jlKiLqtRyO3ybMflPJMe1ItMs4YM1Auj/QjTqR6FCz4FdPnlGzm0t+jZSWjtAfP5Yqs4sUWEy2xskJKIZqohlMe19siV3Cj6kYk+k/NsEoRfp8cOb8BOatspOdZawJNuX83SGUcMaQUS39SBxPEiAQFiUx+QD9DBRfQDBD4R+hRaLoGPj07h12XesbIl2zgy7pKWrDgCS6q9zVPsO9U1R//tschTAeQFanMODCcgE6vPRyj9QK2HZ+ZLMklCbUm+dQYpdWSjKN/p8rRea+nPCLxS/daUoP5zx7I0cm16WE+dgr7PqZS06UUPEG41gok+1AKFNLFhNooLK1ASo0/ZkkqegjYxPzaGNB525QTxUD5jvfJCpMFD0BA6S1Q3FGg206RJVWJp4TcQB2CKtVE0NnvLiz6FPpQSkCwvJwKQglFsDA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(366004)(136003)(396003)(451199021)(38100700002)(66899021)(4326008)(966005)(44832011)(6512007)(478600001)(2616005)(7416002)(6666004)(41300700001)(2906002)(8676002)(316002)(66556008)(8936002)(66946007)(66476007)(6506007)(54906003)(86362001)(36756003)(6486002)(5660300002)(83380400001)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wX25w/mwNvSCmlE/iMI96D6/Efe4GDrn0codtXF8kp+2R5U/EVsdIiTlEbS4?=
 =?us-ascii?Q?WNTvTVL2mTBemrsTwZoa5BcvwE53L5iDEA8g67BEDYof42ZlE/K62FMK9ElU?=
 =?us-ascii?Q?lsBYiV1YVKOVNHXO+7nJsdhWA3P5p0Lf1PQcTQnZMvTN18neMRlfYDtHL+Ec?=
 =?us-ascii?Q?cEwayU+I8CJ3MlA5PGn8aWIZbP92CcyhMRcoKb3gtUkHHyDhJufICS8coD8N?=
 =?us-ascii?Q?liTP0X3QwFZ9X3PwrvRdoT2bZnZyufhDJcipPcqHirCJzhGPI3gc8i8x8RjA?=
 =?us-ascii?Q?uCN2J/F9OHKDk/jCqcQZbySxkfzwok7piAGs5WUXJWM8GQKNsFMbckZZSQub?=
 =?us-ascii?Q?Z0GVrpAYx9k8yXnJHTcAzIe9kvjqwjCXDRDmIJPJhBcvGnTUyfO0YPxGG7vt?=
 =?us-ascii?Q?gcIENOTrRJ+TUiLc2PU1LU+BBCESIsvSIF9krNN7dYC0phj+4mtMVzEfB/ms?=
 =?us-ascii?Q?WfktdtlzeDwdrT9+AY6vhXTPIegFfhtoumkTYp17p4SbYenvu0cz3+tja5Hz?=
 =?us-ascii?Q?ETl9p2BmKZCwBHnqmi3ObXnDIrtzZNqXw1jAx9sRPTFEtlyCPpu7pJ9fZaDT?=
 =?us-ascii?Q?MwtK9Yqbg3EKY1W2Hx06ygzIlSCk0srtKltPS5V/1Pm1yK+Mn/7Dt6J3DpY8?=
 =?us-ascii?Q?NxlIXnvz6pDb7OkacTkVoZE4TdD/WzJKTzw0USxHObg7iPjEPfw3LzCf8ebj?=
 =?us-ascii?Q?sZSmm6JnqUiD/dLRHyUynTeHh/i0D2hqUZh9XtU6/SpYsoech2WEk3FNj9B7?=
 =?us-ascii?Q?kGE/0JZGpa9cNBCEXllTMxc9pD3mkE1j8YHDkl/f6g1VAE6+d/uQjEZAgEoU?=
 =?us-ascii?Q?PooMKpbJiJ11aLd40B/w9kMqcJ2M4+UaqUmqQXE/PivaoW0odEB917JWtCL4?=
 =?us-ascii?Q?baeKDEGVNZ9fVyfU2SiCkd31IZNxNPtfrV5MVGIOnCyxxMiFJ4E10yuzRT4A?=
 =?us-ascii?Q?Ly4DPuxn9df2I9vrb1CwS+/Md97zTnj4hHb3AH2wbYnX5hnzYqtTyutuw0Im?=
 =?us-ascii?Q?hMSo8G+u7RYKVHN0iyn3pXdJxX0/zNZAonE+ExNnSxJHXnCv01RF/WXePhum?=
 =?us-ascii?Q?6vZ+Kyg2/D3/7oQNAW5d1IRGpJbAUpMSxAY2iIn/RCFY3zVpuG/mhW89peZf?=
 =?us-ascii?Q?oA6w7AGtqPxmFRpNT014qbkL8dumrtfpoDkhuoPUrq07Hu7chrO77U99DyXK?=
 =?us-ascii?Q?yH5qCq2UT7Wu7FeVlArVZJYfPteqd5l4Eov/9JGVZOci5zsTw3o8KBO2zlDh?=
 =?us-ascii?Q?weP6VAxy+XP9am73z4h2+lKmj4n8RdsKs3PbK81JTtHQPCVVn2ysboPesUqT?=
 =?us-ascii?Q?JWJ4VoyyE+D9cGvmiR0nhhtqJaN1A28Wtp03sj24Q4alGIXXJDgwM0OrzRJn?=
 =?us-ascii?Q?9ucXXoS2RhUwF9sRqKvm4JhtOhD7RPEUlPnflUE0bqPFAEUwdAygnVrDJGci?=
 =?us-ascii?Q?Qowadyg0R/A48n9iWzz/ialQh+/K/hJbF0l/vBqVQOzku61t3V87y9YdSsSq?=
 =?us-ascii?Q?n4lHW8Dg9LZr27FtehvsMwP8crytb/K6gVEqN9cq6aFBXkLCchWqDTko9WWE?=
 =?us-ascii?Q?CarIo/AjVdYNWd62Zq8LXjbkSZFEoB38gS/gp+Ml7WPa9+bHNg8uxPhxekVJ?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jV4dg0zhKAQWFkhhVFks1TKsP7YRW3sIg4XLG4zWKZZ37Kk2R3udH8q0feQrRwXrXUe4T4By7JBsyByToYwiZFT84Jaj5Fs9XCnA5jE1LDAGq04Kwd3kIfwCsJyUn2ckYT7qZn/+hL3VqCLoyV0Yk4jvz0vJI6XvfQASu5MGbg7FiV11z3iJqpXzDMt3ujNH/LkPrpU7oPPnVoc/XTgP86Vy/apci810wbecSoWWBJpu5HGOObd/s1VNIbAgBlm535I9QNG+BVP/TUAY24OlO91RzH0jyb6GcICJ0RC+WV5USqMen4qgYbilMCMPIK5typAUywdOCLJHjiyBOggiCzoGGN73ixIEZdYxuhLalc5ZPrNhjaFDi5HhFG71E2ip13NK/lo0GCaIYsxKEDheVnpZNRCnBNDuBEkML2oDirdCl4qJ/tCv679UoWT5kYzv2lJML06I5IL6sfaQEqXccHmjL7VM6njxuU9chUgDGWk0SrGYMa9qXGG41RzjMWSjrGXO+D5qSP/nF96FvKGMHiMOV42zEGfNIkOWABg/m2G7LaLBFzVctRZe0h06qsNqh2LhH0OgbzsfrQ++jj5IV0p5BQ/7sZeaFXa2udbRz19IBSZTSuVyxXkLZVMAEriXshl2QIg/aD93pe5spQgfInFrz/8Br2BLn1AIATi9NpTlrScl7m9kNupMwc5TzgSt1LeT7EAhOMpEVjlaEEsiCOj2Zk0t+WfNrELBifn1GuHLwfLBsH2rZp83lsNut3/TKRxKgh/57zUEaltuq/1C0JMH0flIadz3IPNgRVmuWnEut4Dua7YPhRvEKsIdY9lIUWI5HyfhB2wFi2AHGW1EopDwFTWqdljhentqWzkycKUcjNTs+PbJ0zDXoaRvjKrm
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8baaeb85-e754-4e6b-c8c2-08db2f949376
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 13:58:58.0869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+2w85BP+eeLbP87HMVC+UwxX9BsIlEOOP4fkuUsDK0EWh0YJJQ8E5xGYfk1JvFYdpQUAvDo4uBqrynhsJfbZrjyUIbK8Uq0rwUuivv/c0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7052
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303280110
X-Proofpoint-ORIG-GUID: K9PzSCfhWgH9qugiVoKruWA6YalNmeG8
X-Proofpoint-GUID: K9PzSCfhWgH9qugiVoKruWA6YalNmeG8
Subject: Re: [virtio-dev] [PATCH v8 2/8] transport-pci: Refer to the vq by
 its number

Parav Pandit <parav@nvidia.com> writes:

> Currently specification uses virtqueue index and
> number interchangeably to refer to the virtqueue.
>
> Instead refer to it by its number.
>
> This patch is on top of [1].
>
> [1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00527.html
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
> changelog:
> v7->v8:
> - remove note about first virtqueue number
> - skipped Max's comment to put word 'structure' in same line as its
>   crosses 65 chars limit per line
> - reworded queue_notification data set line, as '=' and vq number
>   wording was odd
> v2->v3:
> - addressed comments from Michael
> - changed vqn to virtqueue number in the Note
> - refer to vqn field instead of virtqueue number
> ---
>  transport-pci.tex | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/transport-pci.tex b/transport-pci.tex
> index b07a822..a554081 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -390,13 +390,15 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>  
>  \item[\field{queue_notify_data}]
>          This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated.
> -        The driver will use this value to put it in the 'virtqueue number' field
> -        in the available buffer notification structure.
> +        The driver will use this value to put it in the field
> +        \field{vqn} in the available buffer notification
> +        structure.

The language here is a bit odd. Suggest:

        The driver will use this value in the \field{vqn} field of the
        available buffer notification structure.

>          See section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Available Buffer Notifications}.
>          \begin{note}
>          This field provides the device with flexibility to determine how virtqueues
>          will be referred to in available buffer notifications.
> -        In a trivial case the device can set \field{queue_notify_data}=vqn. Some devices
> +        In a trivial case the device can set
> +        \field{queue_notify_data} to the vq number. Some devices
>          may benefit from providing another value, for example an internal virtqueue
>          identifier, or an internal offset related to the virtqueue number.
>          \end{note}
> @@ -1005,7 +1007,7 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
>  The driver typically does this as follows, for each virtqueue a device has:
>  
>  \begin{enumerate}
> -\item Write the virtqueue index (first queue is 0) to \field{queue_select}.
> +\item Write the virtqueue number to \field{queue_select}.
>  
>  \item Read the virtqueue size from \field{queue_size}. This controls how big the virtqueue is
>    (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues}). If this field is 0, the virtqueue does not exist.
> @@ -1035,7 +1037,7 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
>  
>  When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
>  the driver sends an available buffer notification to the device by writing
> -the 16-bit virtqueue index
> +the 16-bit virtqueue number
>  of this virtqueue to the Queue Notify address.
>  
>  When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
> @@ -1053,7 +1055,7 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
>  If VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated:
>  \begin{itemize}
>  \item If VIRTIO_F_NOTIFICATION_DATA has not been negotiated, the driver MUST use the
> -\field{queue_notify_data} value instead of the virtqueue index.
> +\field{queue_notify_data} value instead of the virtqueue number.
>  \item If VIRTIO_F_NOTIFICATION_DATA has been negotiated, the driver MUST set the
>  \field{vqn} field to the \field{queue_notify_data} value.
>  \end{itemize}
> -- 
> 2.26.2
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
-- 
At least they're not lonely.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

