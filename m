Return-Path: <virtio-dev-return-12031-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3257AC7618D
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 03:42:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8281326A3A
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 03:42:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 743239865E1
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 03:42:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 683CF9865BD; Thu,  6 Apr 2023 03:42:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4E35E9865B3;
	Thu,  6 Apr 2023 03:42:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGkEBLPW1VXrb/jPrgcJXQNL0RUuN7awLCTbEsPoqAjbHMVrXSE7FJenxeqIHkoCbcu43lCQrxpzaBULmW4gJ+b672OH4JgkmJF4DlpCFDcBxicK9Q8d3cvHlZBrvF9zeUV4/kKN355rmK9LNvbdkgyaySbKUULPGLwGFHY1bc04hEc1+2C5c8doAzVVlYbuSbGwpVFCqJPv7ihj/XfDSfkGK7byMlqxDOTzrP4P8dHnfBW1GpRag2/oZGYKzSAXs2+SNrBcr1DwU62LHCU/QaS0RYSCHKtKfn0loXOMxuLUWA/pxXLSxd4AMrTHOsO1Y/vynZBsZ5TXG1dJAY1NGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHqkB6aVXcpScjfAJnXTqgTvU5S57bupThS4u/oeS0Y=;
 b=gJfN/n6i3exJ4Vy0R+fO6TgzaindEu6F7nZXIFj1H8XdKeBoJH5ZkX9UZUHdEhyFaodgfTbrheHTn6XBio5HcomzYg0TFX2X09U6NPPLSTjGzisLYjBNOObQYevwI0eRh16EX/etBiCJRi3PAPUV8nRwkJg6azT1fwS/lr/YHvYse8ZVzdbOt6eftXzMQ9tnXFppSA2mz0Jn5ab2YyaO2JJvGwtwFMTq6CzgT1T1XxEck9rTInnVBrQvorsO/VA8pFqyFQrZsL8NpYgxyK40u6R1Z6aCisFlOP2KFX1IR4uf0iSfEbnkwy3SrKrM78Lki0UZjnE7aAFFxxT7o1GCug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <ce6437c5-0cb6-f1a9-d978-b8084c95c552@nvidia.com>
Date: Wed, 5 Apr 2023 23:42:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To: "Michael S. Tsirkin" <mst@redhat.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
 stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
 hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
 Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
References: <cover.1680533760.git.mst@redhat.com>
 <f83a6a225a28909eea927575b6783c0fe238fdbd.1680533760.git.mst@redhat.com>
Content-Language: en-US
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <f83a6a225a28909eea927575b6783c0fe238fdbd.1680533760.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0021.namprd18.prod.outlook.com
 (2603:10b6:806:f3::12) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|DS0PR12MB8477:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc89478-068e-4040-24ca-08db3650f1d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5qJnA9SFFuDtZ/sDsQzhdfzxeDBATHZlugmoY9KnIP6uurtJ2OejzVHyaH5JEzHI9YTL2G6+68D/uE6EJL7c0ETtU80im51N/gOUl0atvq4UZTJvUS0rB6fdB8IaFzyQNuqlnSHrmsYQEUfGNdZO5u/NVKftTV+owEejLWR4V4zo1MdSfp7/gh1C5dvmeRyllPZhdkHAWnjHv31Yyysq76jm8DiWDBQTehn+LKy0emOmU7jOiL2WWo7JeaZKiZqXNiQyYtqw+FmLLuXPIeTQtDq8eBA+ZgyDboGoxndjseLSPXdl4w5cMZfPqXG3QOuhLe0nYuoEfxk4kEqgGZZMa0tGkQLw9CtyMs3cTYLoWom1ZC6YuKzcL+4ur3wiJjjis6dx4Mx4Nu0FwKr0JD5zQt1Ze9alZXqNJ62MaS37S95Q8e7WY/AKF/XGHItODTGXM4dhdvyUXzHa4kaUvZgvekLoN9j6iLlH2VISdjD0uUvWYl4gLdj2moKzP/9nFBtXx/W52VWXMZ/y2iBE8ACrG8Lyg9nh0Osk22gnjS5tCPePpEgcw8IOfjIVJzKPzIYD1l/SDvanbpzaqbmKI899JAWseOwnhq8wv7fY655RiPlllnQeVfYnCXeM9WcDlRdK61JQQO2eDYrHWDw+3HsTZ0qZ6w/MXrJwh6zdnbrgSeI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199021)(2616005)(83380400001)(6486002)(478600001)(316002)(26005)(53546011)(6506007)(54906003)(186003)(6512007)(6666004)(107886003)(2906002)(7416002)(5660300002)(38100700002)(36756003)(8676002)(921005)(66476007)(4326008)(41300700001)(66946007)(8936002)(31696002)(66556008)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SW5NTkVBV3pTS3JIbVpNMTNkZzFyb2t1cG5BOEd5d3JuZ2FOdGJmcUFtOGcy?=
 =?utf-8?B?Z2p6MnFobGNWZUVCUEVtTWxhbWNjb05BakdWeXVKMDlnWUVKMGhLaE5yZjgz?=
 =?utf-8?B?MjlOL21CQzdkaDIxWEI2Y2JSRE1hTStaaml0ZUp5QXRMcFBvbmZyMUQwOHZp?=
 =?utf-8?B?K3JnaElSVTUxQTBTa2tvSGhhRVZEVW9TdVdaUm9xREU1dWFsVUM0NkIyb3pW?=
 =?utf-8?B?SzFzT3liWnhQTGF5TDUxajEwM3JjZHFhL2ZBM29ZMFk0cmUwRTQzRnN0VFhT?=
 =?utf-8?B?b3NqeDVDOUluMlptS0NBTTlvMlVodk5SRU5QNUQ3VHNqcFNDL3BZN3lBRmNa?=
 =?utf-8?B?T1NxNkszYUNmYVdHN3ZIcjVYL1hQTGlBeWNUUlF2MnhrUXJIemJXSGc2K1hH?=
 =?utf-8?B?QUgwdFhGbFVEMk1OTFV6QURnL0NQSmlKelhWajROeGtIVmgzeW8rUmNVY085?=
 =?utf-8?B?ZlNvSUFIUnN4VENrSFNKSnJEczk3VXhuZW4xcDd6aEw0Ti9TeDRJNEJHWjVn?=
 =?utf-8?B?QWw3aVlRcmJ4QzdaVU96d1AxWEFKSnVhWW1DVEQwU0s1MUpIL05UcURTNjlT?=
 =?utf-8?B?TFZHUkxoMklCZURCOWRVU1FEcHNwRlNWY2RMci8rRzB4MUttcUVQMW40dnNs?=
 =?utf-8?B?OGZSeGN4c2RpUU1xT2luc24yZkRRK1pKU0d2dy9ELy9SK3ZLam1FY3pKS0FF?=
 =?utf-8?B?bFhLemRCQlhMYUFHSDdKeTgxNXJkZjNwaDdhdWdnTXFSQjZTNGFZZm01UEVO?=
 =?utf-8?B?a201OEtwcU9NampDdUQwaWVLOU1uR3FibERiQ3hWbWVMOVRCL2Rod3NMRzJ5?=
 =?utf-8?B?WnUwWjBMRVhXc3V5Q3RDNTVKVmliU3Y0c0E0d1BwR1BGRmdhS21sM3NyYmQw?=
 =?utf-8?B?bysvWmNZc1I3YkRsdWZ5WDVJYVdUc3NvRjJpTmFuTzJnZjlGd1llQmVQV1Ja?=
 =?utf-8?B?N3ZIbUkwdEk5SFF0Y0c5dmdZc0FBMUNIeURrZC9NMWNQV0VaU3NpUVFRbW9o?=
 =?utf-8?B?dHEzWTlSU2JZNWNRY1kzOWx1cFYwNHpyK0theEVIL3Y2dktqQ2hDQkd5STQz?=
 =?utf-8?B?dENGYTNzdURZNDlibzFKamdmK0xMNGRaZzRYY2lJVm5RWTlTYnZaV2ZYWTE4?=
 =?utf-8?B?Vjg1OFg5MXRCYWJ1L1h4K2JjbjZUYXR5OGZRSUpEajc3TFU0WkE5MnBxaDBM?=
 =?utf-8?B?eDFaOFdBTUlBNHdsMHd1MFhiQ1d1NHdwL3U5eHpvMkJwd2w4UXVsS1JOd2Fy?=
 =?utf-8?B?OVM1aWlrUXp3aGNFcjU0eTZJeXc3NU1RK29qem16cXJuVU02Mm51c0RBY2FQ?=
 =?utf-8?B?ZlNtTlhvM3ZINHhXdzF2Y000NlJ1SFJuLy8rZ2FaTklDWHVGUmc5UkUrR2c0?=
 =?utf-8?B?ZEpnaklwRGNmM0QvV0Yrajg1Z3lIRVZ3SzdOWDZiL2ZaOHd3VXhjY0tFTWhq?=
 =?utf-8?B?WEtYK28yYTRqMStRdEpXVmdNTFZpVk0yL3NTT2lLVDZtOGlPWmpKekJaOFI2?=
 =?utf-8?B?YzNJbEx4WE94dmpBcVZBa2orVTNqTit5dTF4YmJDc24rNFBFY3JTQnhIenJF?=
 =?utf-8?B?YjJtYXcvMUNEeWFRSFJhZnpOVlVBMG9PdWgwb1hOK3pPblMrd2l3bVdReFp3?=
 =?utf-8?B?TW9NQ2RWazdzRjdVT1JTaVRlQ2lHUGg5RGpNcVhTbE9wMFpHOWNZSGdicnNP?=
 =?utf-8?B?WUN0M05kRVJvOGZ0QlVQQi9pVlYxTUtsbGZsVFUyNlYwNkVFajRNcXRFRU9k?=
 =?utf-8?B?LytGL3Z2Uk9HT3VzdXp6WEhIa0RScG8zQjU3T1VabDhOWlRROEg1Vk9oWGQ5?=
 =?utf-8?B?RzhnSUg1eFBzSGlpYTh1VkVTaHhEVDNuUU9wZlVZSCtVNkZPUnRKc2l0T0oz?=
 =?utf-8?B?bEIySDNJYmtObm5pSTdlNW5VSlltb3AraUFEOFJUYkVqcEVISmppOGw1dHpH?=
 =?utf-8?B?SWZ6ZEJUOHJxVkdTekdFMHdSUncwZFg4R2lWLzNXZHBGVDlUdndXRk9oWDVF?=
 =?utf-8?B?MWpscXYvaU9HUkpGWXZnUU1jSWdjYWRIRjlIczNVNXk1M3M5UlkySEh5OU5T?=
 =?utf-8?B?NTVWR0N3Uk5GOTFmMzJMbkMxNCsyTDdNL3c5ei9CSkFGOFNSZlN1bXlTQ1Bw?=
 =?utf-8?Q?gXQs8ILAe+pqU0wdOUocjpvIb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc89478-068e-4040-24ca-08db3650f1d3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 03:42:28.7385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cE/Ovv9QWTekFD0N4cekosepN1Wk+pc2vg3wDJn7Egevb+Ao+QCX9dozerhtRjxL/G+G0P5ZWb9DvhXlLja+5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8477
Subject: [virtio-dev] Re: [PATCH v11 02/10] admin: introduce device group and related
 concepts



On 4/3/2023 11:03 AM, Michael S. Tsirkin wrote:
> Each device group has a type. For now, define one initial group type:
> 
> SR-IOV type - PCI SR-IOV virtual functions (VFs) of a given
> PCI SR-IOV physical function (PF). This group may contain zero or more
> virtio devices according to NumVFs configured.
> 
> Each device within a group has a unique identifier. This identifier
> is the group member identifier.
> 
> Note: one can argue both ways whether the new device group handling
> functionality (this and following patches) is closer
> to a new device type or a new transport type.
> 
 From this point onward you can add,
--- line. So that it doesnt go to the commit log.

> However, I expect that we will add more features in the near future. To
> facilitate this as much as possible of the text is located in the new
> admin chapter.
> 
> I did my best to minimize transport-specific text.
> 
> There's a bit of duplication with 0x1 repeated twice and
> no special section for group type identifiers.
> I think it's ok to defer adding these until we have more group
> types.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> changes in v11:
> 	dropped Max's S.O.B.
> 	dropped an unmatched ) as reported by Parav
> 	document that member id is 1 to numvfs
> 	document that vf enable must be set (will also be reflected in
> 		the conformance section)
> 	document that we deferred generalizing text as requested by Parav -
> 	I think we can do it later
> 	minor wording fixes to address comments by David
> 	add concepts of owner and member driver. unused currently
> 	but will come in handy later, as suggested by Stefan
> ---
>   admin.tex   | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   content.tex |  2 ++
>   2 files changed, 65 insertions(+)
>   create mode 100644 admin.tex
> 
> diff --git a/admin.tex b/admin.tex
> new file mode 100644
> index 0000000..04d5498
> --- /dev/null
> +++ b/admin.tex
> @@ -0,0 +1,63 @@
> +\section{Device groups}\label{sec:Basic Facilities of a Virtio Device / Device groups}
> +
> +It is occasionally useful to have a device control a group of
> +other devices. Terminology used in such cases:
> +
Only one case so, singular "such case:".

> +\begin{description}
> +\item[Device group]
> +        or just group, includes zero or more devices.
> +\item[Owner device]
> +        or owner, the device controlling the group.
> +\item[Member device]
> +        a device within a group. The owner device itself is not
is a device within a group.
So that the sentence completes like above two items.

> +	a member of the group.
> +\item[Member identifier]
> +        each member has this identifier, unique within the group
> +	and used to address it through the owner device.
to form the complete sentence like rest of the items writing it as below:

uniquely identifies a member within a group and is used to address it 
through the owner device.

> +\item[Group type identifier]
> +	specifies what kind of member devices there are in a
> +	group, how the member identifier is interpreted
> +	and what kind of control the owner has.
> +	A given owner can control multiple groups
> +	of different types but only a single group of a given type,
> +	thus the type and the owner together identify the group.
> +	\footnote{Even though some group types only support
> +			specific transports, group type identifiers
> +			are global rather than transport-specific -
> +			we don't expect a flood of new group types.}
As as spec, better to avoid "we .."
How about,
too many new group types are not expected.?
> +\end{description}
> +
> +\begin{note}
> +Each device only has a single driver, thus for the purposes of
> +this section, "the driver" is usually unambiguous and refers to
> +the driver of the owner device.  When there's ambiguity, "owner
> +driver" refers to the driver of the owner device, while "member
> +driver" refers to the driver of a member device.
> +\end{note}
> +
> +The following group types, and their identifiers, are currently specified:
> +\begin{description}
> +\item[SR-IOV group type (0x1)]
> +This device group has a PCI Single Root I/O Virtualization
> +(SR-IOV) physical function (PF) device as the owner and includes
> +all its SR-IOV virtual functions (VFs) as members (see
> +\hyperref[intro:PCIe]{[PCIe]}).
> +
> +The PF device itself is not a member of the group.
> +
> +The group type identifier for this group is 0x1.
> +
> +A member identifier for this group can have a value from 0x1 to
> +\field{NumVFs} as specified in the
> +SR-IOV Extended Capability of the owner device
> +and equals the SR-IOV VF number of the member device;
> +the group only exists when the \field{VF Enable} bit
> +in the SR-IOV Control Register within the
> +SR-IOV Extended Capability of the owner device is set
> +(see \hyperref[intro:PCIe]{[PCIe]}).
> +
> +Both owner and member devices for this group type use the Virtio
> +PCI transport (see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus}).
> +\end{description}
> +
> +
> diff --git a/content.tex b/content.tex
> index 8098988..04592fb 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -493,6 +493,8 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
>   types. It is RECOMMENDED that devices generate version 4
>   UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
>   
> +\input{admin.tex}
> +
>   \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
>   
>   We start with an overview of device initialization, then expand on the

Apart from above rewording,

Reviewed-by: Parav Pandit <parav@nvidia.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

