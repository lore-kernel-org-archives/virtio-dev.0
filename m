Return-Path: <virtio-dev-return-11473-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61275C678D4
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 10:41:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8DF5941EF9
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 10:41:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 806EB9866CB
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 10:41:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 718FB983E53; Tue,  7 Mar 2023 10:41:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5CAA99866C2;
	Tue,  7 Mar 2023 10:41:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqDpXOiMsRg7ObL+hBVA2fHRQzY1WNtUQ1jAemEruczwgBxXHGHaIG4A6OGa34EV5X7mY2DsrdRg+r4e9hJ3SuAxIc5s6dtijv9+VVXPh6At6sgz47UHQiaYPEqr6NQr0ULNm/4La82LNos0hBrwqqUyMnqiBKB3VUMWEFhah2ACFqa+OsrhSrWlExE8XL/dolxiHdZSZ63Z9N7fmaQHMii5KfvWJFBjawZcnxXweLFXjj504eJamcTW0i5zAWdIABCKbJGiBsmLuKAhmt2kEbc92GM3GUqBO+dKSQ5V87c2AjSJjFpivon4YcUA7egQ6dL5Swx8teE9va/OI92yeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0UqNAOJtYG+HRyqNMQdKGW2Xi5nM8xkh5iloszREeQ=;
 b=KJ0tu58zk4vUjbl7nygEhOkBlcjMoJODEmfSeMcrDWkeuKGKaqw+1gQbiG8eIXi6GTLYqawpgv+LCV1oT13iPfSELFW+1lLieunTNcfUbaj0ZoXlume0lrN8dK/Nirz5duV0GXaHHvl7jZp8iV1h0mPtbWi1fZspcMf31cQuweeGuIe4brBneK1w+tr+RewC3MC5j+MnhviO7+dtgaLPd8P4nVubGHIZ6i9uExxPX7Q5XGYEjWWM4zm0v23yC00lZhrhSKFW/u7mOcyHciVGVZ+xLwzuNLanCavxBSB/7o970Qgo5H2D0ndHjGhA1lgeJ1ZbFi3eHQFFbHaZxritYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
From: David Edmondson <david.edmondson@oracle.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org,
        virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com,
        cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com,
        nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
        pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
        Parav Pandit
 <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
References: <cover.1677761896.git.mst@redhat.com>
 <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
Date: Tue, 07 Mar 2023 10:41:31 +0000
Message-ID: <m2fsagzvvo.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0031.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::10) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|DS0PR10MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ae94a8-648d-4e52-4fd1-08db1ef887c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ibSeDmM+0xTApwYp7pTz8fNKazs8Z27UJyP7ZZhTFRbEP1DmrFCKh9ESYsGPDIIHysvtrt6N+PhrlgsfDh26KqMSL2SeB4ULjrGXgckm7osenhnyFQ9XhSO7smRNfZfPdtNnoKViSXjkuzz7zBb7LtmQb21uySZxFg5Zp9b0CmMwpbmW9tD90SK9bjVwcFe+/LDupXhGbCoOd81nvNL5u5tBsj8pF1LwsDGm4IZOvQnUNnDutvZk9uPuYf6IIdvN1YTACC5+sQOYuE0hNn3LUaZSK8kFmNvdRdnjeSn90rCIFG94mVw5+sEZA4eLzCh46fsJWw2z84xr8HboOyddqkICiHtbiAOvYsQs3TU4du33csmds0ZhMS8jhMmfgHFJHLWXav9mBYkc5aHsjtqVR9hVKBvATjW/wwJsbnLhh1nyhHxe8UtJy4PfCJcU6/4UdVitQgyc3F/Go6xXeaLOT3d0mogkYMUOPMslyZMgIzG6gawrwhhlktVdarmWcCN5g190imdBFCwpkXUr/iE5iblQ7TyEfrdZT6E8fZDR1F92RJ0Uvfr3z5hTmDmaH5ucq3V+Z6Gdwz2SbcQ4EcjNwusid97V5nYDo01KCrF4tGq06XpzImF1TmmNkvNstXAqy3LuBA4QYAVyom/7E/UPwrGDsgkfqnUWxquw8feLTXg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199018)(6506007)(6666004)(2906002)(8676002)(4326008)(66556008)(66946007)(66476007)(86362001)(316002)(921005)(8936002)(5660300002)(38100700002)(7416002)(41300700001)(478600001)(83380400001)(36756003)(16799955002)(966005)(6486002)(44832011)(54906003)(66899018)(2616005)(26005)(6512007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?EEHcyA7cl9khiHkmXWNKd5skIOFNuCKZUz3Jvj8PcN/sLa99c/RaksQdutml?=
 =?us-ascii?Q?7OQ2KYYmA+tOfvY2+CAn6sCpxBT6fst4sb1bQm9G1nNEYoXHN9kLSeYhFP4l?=
 =?us-ascii?Q?97QSQsdOsFKsHiMrEx1pLY8GOBDK3GOLCPmYH1BH9CQ3qi3hdCaWtoZ8JDS1?=
 =?us-ascii?Q?apoEG7wt1KvYiXBRnhpxsS45TVhVpctNgA4H87HPRYtiSDURSKqlUKipP+2t?=
 =?us-ascii?Q?eqlJhW7ymdxmuMHwbGx3ncYSCZV2DZqA4p4AmAmznDGDxDN1HRRY0vZOLmfy?=
 =?us-ascii?Q?NorksmZCtccThArxxwm+kqXgG3HDmKiuSQ1N67HbomEWz0E4H336l2BS2CAj?=
 =?us-ascii?Q?y3f6GJQ85lSCHkpzpDYu4dACncD3MRPCJFaXFXBMi9E9A2z7nLLM6Nm2cuSl?=
 =?us-ascii?Q?HVI1NNFLp0FSQeKiC+DwvI4lLCpEO3OzUkSov0kioRbLAtAWbM1tO6RZfH0n?=
 =?us-ascii?Q?yBISFXRJOea0cgO7k+7GyNbrl3YFF90GdDciXgdEx6FZFUN1dp+3nz7BUCM9?=
 =?us-ascii?Q?a31WxUAk1ZUvsfODCEaZP6hFQQLI11d1QpTv3tFApIUBHPYHOC7fwPnY2GTM?=
 =?us-ascii?Q?js5oS2VURkBTLhdkn3crm+1Cfpi53mXDcjzw1EkuJB34kM5dQXgveVYP1b5m?=
 =?us-ascii?Q?NV6yFQjPXtvA7LqGKgYIBV74pqSsAw5w3tV7ZDT/R4Nyp8Ui61rG3E3Mvunz?=
 =?us-ascii?Q?zEiY3DUhsKFQG8zxt/4oK4t7WsSol5EgZbpegvRc0S6WTvxug/pciM/SrLtQ?=
 =?us-ascii?Q?6UGpVgIDjm47+bXiybEgVXkgy02vOXhZvxIYkxAtA4etGTmXpNSuPK8JL57y?=
 =?us-ascii?Q?EMJH+laj+r3StrBe+/l0x8QRNmdakwlE6dz4nwzxNo/t9o/Jc5H+6xchHsjZ?=
 =?us-ascii?Q?NkqkA6bZYLSAt4uiMp0bK33uafABDK5L6tVkPNdEUKa1vP+XqFp8CEcr2mSG?=
 =?us-ascii?Q?KVr7qXL3vuUGHQiZUD2RtUrTQ41bX1w6x00uQ5WrRovEt9k/gX7zYiADv8y6?=
 =?us-ascii?Q?qTyhTJ9GR45iR3lyfanqj1VWp6RXoupmfuK4XxOnW2YG0+LIyLucjQ5V2eYP?=
 =?us-ascii?Q?PHp6FFXKHKVvRCxuIVLKM4lX+N6BHNzGjEiMRTHnW8jXBRSj7myF1OTLRjwU?=
 =?us-ascii?Q?2njb6OZ0LJz/No8b8jO3oCVT7i3l6KiKQLf2961oDL7SV8UQMl3fWuqET9XB?=
 =?us-ascii?Q?bTWBje8DWL7oK0H/XJ41tJqjP99Y2IkyJJTKuOqleuzavCKoTceFTzwFxJt+?=
 =?us-ascii?Q?66mLNFbSM80LAFNrPjDz52wO5nix2qwVNvpcIumk4IVJF6viBHVEhZ/9wRdI?=
 =?us-ascii?Q?kOrd/xWZiZzkQfShvtcevhYnf8lxfhx1ju976LEZT0Tw6ku8fOaxdtKxSoVb?=
 =?us-ascii?Q?NEjIVorz0Q4Co5csW9BYbFrNNFPIZXA33qee+J2YvRmFBxlI4JY25BHWzPcB?=
 =?us-ascii?Q?0YyCtmnT5ZXp8XOazE+GtXvwZackkf5l0qMoBHBVzj31SZ/UV/69RibtPCnm?=
 =?us-ascii?Q?gb8gZN13kLZMv//+UCVpsBK4lT2FDnKq790fBcPZuSzfzBmZuRn9t+g5Qh4e?=
 =?us-ascii?Q?og+FFuwBe7l34j1/456N3cjrTKoz0u+uTRRFPFBesSmbJURWZ6wrip2t4FKL?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	C38/ExgKBk7LX8R1vWNdUOOx6jYvWFwSYB7TUH4hy3iJO3+omSJMKsfzyBvdXkQ8h9l8OR/hMzd7iFi8VmVqIq4RySsyNoc++h9/zQdiishVu9Ymb841SOpAhSqson3C7e/CU/b5gPRu16MrB8mdFwOdZCU3JpVffUESnu9q/Niydgc4ma6V7T/o0rFSi9+LmvGLI3M7DNA0Eyg/bmm7IJTaWlEqy0YvAu6We+vWhIB4mRAmEuNnhOnkm8sFVB1I7PPKodkzhHsSTGkwuaSSeFfYTquj4f0XiSYXNSWa8NEx6Jm3HOyo1gHMNZT4IObt0l+434kzfkD8fdVQZZv4BVYtvksJnZSAvx9hvCHGQaI3MxeQNnz9GnMCvcq4MHAyHKZoPEPe8Wo6TWAIhl4DQZZ5WnJyqk9ZHQNFtSf9lMJB9+MPDY8W91Tv3RF4SeDSfsArNc9BX4TV0I8EUZISmUTl6ftucoU18b3qt6XqGueN5qUxxaCzc3rrxtY99Fvh/FUocFxiIpeBEYrpwQOmXI00YmG00AmA4DFy/Dyvvk6fFnbtJ8CQCL+1MkMlxch+aqgE9XCm6tUcBYDSbP/8nrTgRnxxMAxDmcjFNV7gBrpdJQ/f0P9ZUG0ukF+gL7PQVlxMKdNfXeF2U0AqQs41tb97/OBtw2bwf0CZHY2QUKVMSUQ4PoDEz88VLp1ORtrX4l5zoCA1fPVNxFS0Q7XmfHkVaV6gQnOlXY4xL526Y/AdWMlfb92Qqkr7jF51OT4d5H14WB4mB6MLl99K38SKxBMetw7E+98psCgM0JADoQiRZCDu7uW8/Ww+GmvxXWi42TFqyiQ5lhZPDhdvbAZKDJM1PYADeAFXZUADoYG4sOHwzZby6gIk8TnsDUdpceR2hfkeUUNt1i/ryawb8SNFtQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ae94a8-648d-4e52-4fd1-08db1ef887c5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 10:41:38.4135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YKapK3GckIO0maZ7imfvozxefKoQ/iDOpwBHabPe+cXIiTozlLAA2ZOgJnEjPoxBRYOUjmoMTbk6Iv5fjICegN6utx1XDUdIJM4xbI5EjVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7272
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_04,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070096
X-Proofpoint-GUID: bJ0JZ1F4u7lkSKIcWci6ugTVYzW9JnwD
X-Proofpoint-ORIG-GUID: bJ0JZ1F4u7lkSKIcWci6ugTVYzW9JnwD
Subject: [virtio-dev] Re: [virtio] [PATCH v10 04/10] admin: introduce virtio admin
 virtqueues

"Michael S. Tsirkin" <mst@redhat.com> writes:

> The admin virtqueues will be the first interface to issue admin commands.

"first interface used" ?

> Currently virtio specification defines control virtqueue to manipulate

"Currently the virtio specification defines the control virtqueue"

> features and configuration of the device it operates on. However,
> control virtqueue commands are device type specific, which makes it very
> difficult to extend for device agnostic commands.
>
> To support this requirement in a more generic way, this patch introduces
> a new admin virtqueue interface.
>
> We also support more than one admin virtqueue, for QoS and
> scalability requirements.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  admin.tex   | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  content.tex |  7 +++--
>  2 files changed, 79 insertions(+), 2 deletions(-)
>
> diff --git a/admin.tex b/admin.tex
> index 7e28b77..3ffac2e 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -155,3 +155,77 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>  \field{command_specific_data} and \field{command_specific_result}
>  depends on these structures and is described separately or is
>  implicit in the structure description.
> +
> +\section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
> +
> +An administration virtqueue of an owner device is used to submit
> +group administration commands. An owner device can have more
> +than one administration virtqueue.
> +
> +If VIRTIO_F_ADMIN_VQ has been negotiated, an owner device exposes one
> +or more adminstration virtqueues. The number and locations of the
> +administration virtqueues are exposed by the owner device in a transport
> +specific manner.
> +
> +The driver submits commands by queueing them to an arbitrary
> +administration virtqueue, and they are processed by the
> +device in the order in which they are queued. It is the
> +responsibility of the driver to ensure ordering for commands
> +placed on different administration virtqueues, because they will
> +be executed with no order constraints.
> +
> +Administration virtqueues are used as follows:
> +\begin{itemize}
> +\item The driver submits the command using the \field{struct virtio_admin_cmd}
> +structure using a buffer consisting of two parts: a device-readable one followed by a
> +device-writable one.
> +\item the device-readable part includes fields from \field{opcode}
> +through \field{command_specific_data}.
> +\item the device-writeable buffer includes fields from \field{status}
> +through \field{command_specific_result} inclusive.
> +\end{itemize}
> +
> +For each command, this specification describes a distinct
> +format structure used for \field{command_specific_data} and
> +\field{command_specific_result}, the length of these fields
> +depends on the command.
> +
> +However, to ensure forward compatibility
> +\begin{itemize}
> +\item drivers are allowed to submit buffers that are longer
> +than what the device expects

s/what//

> +(that is, longer than the length of
> +\field{opcode} through \field{command_specific_data}).
> +This allows the driver to maintain
> +a single format structure even if some structure fields are
> +unused by the device.
> +\item drivers are allowed to submit buffers that are shorter
> +than what the device expects
> +(that is, shorter than the length of \field{status} through
> +\field{command_specific_result}). This allows the device to maintain
> +a single format structure even if some structure fields are
> +unused by the driver.
> +\end{itemize}

Given that the previous patch declared this as a single data structure
(containing both command and result), with no length indicators for the
command specific data or result, how will a device know how much space
the driver has allocated for the command_specific_data or
command_specific result?

> +The device compares the length of each part (device-readable and
> +device-writeable) of the buffer as submitted by driver to what it
> +expects and then silently truncates the structures to either the
> +length submitted by the driver, or the length described in this
> +specification, whichever is shorter.  The device silently ignores
> +any data falling outside the shorter of the two lengths. Any
> +missing fields are interpreted as set to zero.
> +
> +Similarly, the driver compares the used buffer length
> +of the buffer to what it expects and then silently
> +truncates the structure to the used buffer length.
> +The driver silently ignores any data falling outside
> +the used buffer length reported by the device.  Any missing
> +fields are interpreted as set to zero.
> +
> +This simplifies driver and device implementations since the
> +driver/device can simply maintain a single large structure (such
> +as a C structure) for a command and its result. As new versions
> +of the specification are designed, new fields can be added to the
> +tail of a structure, with the driver/device using the full
> +structure without concern for versioning.
> +>>>>>>> 0edc690... admin: introduce virtio admin virtqueues

Merge detritus.

> diff --git a/content.tex b/content.tex
> index ffe45c4..c8647c9 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -99,10 +99,10 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
>  \begin{description}
>  \item[0 to 23, and 50 to 127] Feature bits for the specific device type
>  
> -\item[24 to 40] Feature bits reserved for extensions to the queue and
> +\item[24 to 41] Feature bits reserved for extensions to the queue and
>    feature negotiation mechanisms
>  
> -\item[41 to 49, and 128 and above] Feature bits reserved for future extensions.
> +\item[42 to 49, and 128 and above] Feature bits reserved for future extensions.
>  \end{description}
>  
>  \begin{note}
> @@ -7682,6 +7682,9 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>    that the driver can reset a queue individually.
>    See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}.
>  
> +  \item[VIRTIO_F_ADMIN_VQ(41)] This feature indicates that the device exposes one or more
> +  administration virtqueues.
> +
>  \end{description}
>  
>  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> -- 
> MST
>
>
> ---------------------------------------------------------------------
> To unsubscribe from this mail list, you must leave the OASIS TC that 
> generates this mail.  Follow this link to all your TCs in OASIS at:
> https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 
-- 
And removed his hat, in respect of her presence.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

