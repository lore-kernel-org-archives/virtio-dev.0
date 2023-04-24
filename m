Return-Path: <virtio-dev-return-12387-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A77C77B7E
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 21:48:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 19D3A2C23
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 21:48:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0DA0698664C
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 21:48:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EF345983F7A; Mon, 24 Apr 2023 21:48:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D7CD39863A5;
	Mon, 24 Apr 2023 21:48:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSZBTHLI1P7FZRogrwJKkbSi0dHiwStJSsQvQlA4nqzg1MdO1s2wgT9SlK4Z/Hdvu03eD9Ixj1EUyZq7nVM5GOdQpp7ir5MOWMDX40A7Q2FZgN5fCPi9asXWNMUsLbQuNm4s4nsZvi+zR6+hNmYutEwu7UXQzmhNl0BWBgrsvGNeks2SHX8ulXvRz4MyIRsZ06EICNm0DGNeWiy0S1/tmtY9LDIIxgW3STXCUuxLTKp5gsPQbQsW7Rj+zLBsGOaEy+zAUqeBHOKa6zG4dKcm0ro9kkdL5am6C2d85U5TdLwQNplfB5R+pfyprdtMHZhakBd3pksEhC6eVWppVby3tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xnf/aaoKeNF4oyGfnYVXVHjCjMiISh8Xa35/UHZPVFQ=;
 b=RzOnel6tRvWujLwNiFAnp3TCyhsFn4ZHnCxld7ulGarXNcQGYkFt5T95XwRwe2n4nEl41I+0vDRbqB3hozkQGbaFCip0j+oOwNqYBncBhz5aNTqGY+0v0GwbLDjaNLBwqFj/EsNvivKJBHU40QzoXFMel5YEw72C/UL50Cpr/vG55RQJ3iQr9ndOH0NszvYYnYFOCNvG6dyzmF8KTMy+9TPoVPeoLMuaWM+M13IiiYvj4NUsvz3Jc7sP2kM1amqF83155y3ggTKvJVRcBfdBtYaha/nhTphWeDL2SA5QjNIiY6HWORAGwx3Q6CoiAgZBVHu9nL0JkKU5E7WuDSm8mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <916061a3-0efe-74ae-e3bd-cebf0eebba39@nvidia.com>
Date: Mon, 24 Apr 2023 17:47:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
 stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
 hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
 Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
References: <cover.1682354275.git.mst@redhat.com>
 <1c8fd21fc009897b5d338976888c25fa81ac896f.1682354275.git.mst@redhat.com>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <1c8fd21fc009897b5d338976888c25fa81ac896f.1682354275.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0019.prod.exchangelabs.com (2603:10b6:805:b6::32)
 To PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|IA0PR12MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: ca119f6c-feed-4c40-33ec-08db450d9210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nzz0+1eCZ1ENb4fmrKeHWn+dJT30MhY4OBFbV3K6lX41SNu8+fO6AvoHwLgLv9s1i1tEeiCBIe7F3vKXFyydIk53L6ldArWBMsVdNH9XCqe27krJS7ofckfAByBAE1AfKxAIup7HHi6ePHv1Gc4kkaZ8ai2hPtDXPrNLt5MDFle0yhYfxj/534T5EYtwMjJ6UddOW0FdM1KxGROeYLe4TnnUqc63TNtFbDQFJ+MEE0kRfGK35DnWH5IwGZg1kkD9TZ9Rv3Oev+XuGMTlC4qUySkDTAI15E7aehGf0tkseCnF0XxR7ICDfY3Q8FNTdkr7Ty8vXQHv1A5NoNGipHjG2Yldyh3t6dqAEW2w6CTY94jqMXs64FdsFzGXjF7YJKo/IU1PB7GUG6jENusfBOEqr6G1OxX2yifmSBXRHnChEq07X3krh3hynXegkl2/K6mt0FFgKyMDX2jujBMy3SmNYEEU5gA3sZS/O+/c2XI51OJEuTQ9QTGPU9d43bC0oP2Da/eX/2zKsAsvt2VDRbLMVJC0w87FCPLFIkBx6psIX/yweIcMy8yPZ8ZioE/12alftMlQQpjINnqHI41MTu/gDBHSvdbhiS8o5xl7+ixmVhBeTKyJCEWJiWAJTuzbtMj6k7/SXN/ivT0oCr4IhNV0u4RN4LwCq8GKP9RNhMON9ZM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(107886003)(53546011)(6506007)(26005)(6512007)(2616005)(36756003)(83380400001)(186003)(921005)(38100700002)(66946007)(478600001)(31696002)(86362001)(66556008)(66476007)(31686004)(8676002)(8936002)(54906003)(7416002)(5660300002)(6486002)(41300700001)(2906002)(4326008)(6666004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0N2N3VGajlqaWQycm81T2VIN3U4TEt0aVdrWXdFMEkwVlgxV2QrOTZ3Z3VN?=
 =?utf-8?B?MkFRS3l2ODA1UDBGT2hWMFVhQnZDTmp1blVoRkFHcG01VldIMlhlbXBaeHVD?=
 =?utf-8?B?QmJiK3NrS3hhRDhoQW1XSVZIOU5VY1p0dXljVStYZndnYXB0dEJ1WCtPdjc5?=
 =?utf-8?B?TUNOaHVuQ1hsOW93bm10amhybHdmMUZFcjc0dW1RazJoajF6a0ZOejZOUnJ1?=
 =?utf-8?B?bWdkYkQxRzU1dFZCV3psUnZqc1c2Q0FGRHN2eG5HbWd3V3B6NlFjZ01pY2NS?=
 =?utf-8?B?cXhRaFlzaUE0NGR3WDdDa1ExbFBkMWdzc0MzRVZiT3RhWlUrdUdTV3M5WFl3?=
 =?utf-8?B?OEdNRTJ5bTBnMXlGZTVJUU84ZDdpOHU5ZXRuTFBiMy9udzVYWnF0ZlVpdXRz?=
 =?utf-8?B?bXBLeWVpdkNEREZyY2xLM2h2R1RQRUZlaGNQZ1hTWjJpbnYvTGFaL1dhcGVM?=
 =?utf-8?B?TXdSWVVmVVIzS2hBMFIzbWxtN2E5cDcwRHhLSjZSa0pKUWxxVDVNNXpZQXRP?=
 =?utf-8?B?Tkx6T25YRDh2QmwxdU1vYVVmOWRBOUsxWjk3b0drT2g3MWhMMFVteDg2VWR3?=
 =?utf-8?B?c2d3OUoyVG9oOVBWMUxQaUUzQjhSUHEvNE9YYWJ3UzI2YTlhTjlnR1V2NFBW?=
 =?utf-8?B?b0ZjQmN2WGxYSmcrZlZkU2FuOG9rU3lqbGVlVkRJc2JBaCtJbFlYVjZBb0xx?=
 =?utf-8?B?YUhWVW1vY0kzMEJWSUY1ZGttZFlneU1iMXBWYThsQ1ROb21WaEhMblN1YVJB?=
 =?utf-8?B?bGQ5T1JpWG1LQW5YSDkya1RxZ1BjZ2dFTVRsbWZhQ0ltT3NVbmhoem9kNmor?=
 =?utf-8?B?TkR3cjBlaVJaVm1INVJia2U1R1NDclRHY1EzeDI1QzNqTHIxakZNbGhkK3Q2?=
 =?utf-8?B?WnphVHAzOVFTZVZUVStCVURxUUZqbWU4U3RnL2JDdGVhanZaVUFzOWZiaXdR?=
 =?utf-8?B?OXZkbzNkUkJqYm5TL21QMTF1a1l0blI0UENnbjhIZUV1WlZGem40NUlHclRr?=
 =?utf-8?B?M0xaaW1vcmFxNlVSQytOcjhhUGNLeG9IcDQ0MGxULzlRYU9laGVJOUR4SnE4?=
 =?utf-8?B?aHB3emR5OWs4dnAxVkVhTWFtTGthMDQzZTlCVWV2NlpoVnRKRlBKK0JTL2lw?=
 =?utf-8?B?aWVVNDlKajAvcEYzWjVUNUNmdVRWU1FrOWNGakF5VjZtL1JoQUtCSTRSNkg3?=
 =?utf-8?B?OTBGMzZVQVFGRXNQZnZmditwZllqVnh0Z1F6SldLcUdTZ3RvdWFYNW9seVBT?=
 =?utf-8?B?dTR5L0xYTzZVaUR0R1F5Tm9lODJDMFJ3MG9tRGIwTVNQd3ZteWFjS01LajVz?=
 =?utf-8?B?WjUzSmtlRmZPSzg5Mm50NUVKMk42V1NRcHVGVUhZYnREOEhFNTZVNUtTL0Jo?=
 =?utf-8?B?REQ0b0wwVXdOZ3A3VDRkSGpaU05nL3RiRjJ1NDFXVnBiaG9PcCtWWCtOVkN1?=
 =?utf-8?B?M2ttcy9BdVhpcmQvYThaT2wyMVArZGFQTUEySjdUcVhmaFJGZXdtajBJcDd0?=
 =?utf-8?B?QlFmV0xSallLZFcycFNJc2hXZW1INGlrVElDRmFxTExJTEtMckY1cXh5aUZz?=
 =?utf-8?B?NTlJV1kva2pPbWNucEVqUTIwaEtjM3VENk9LY0JVZVlqb0dIK2ZuME0vQzhw?=
 =?utf-8?B?alVGUEhHYm5CcVhCV3BKWTd3dTBvOW1ZNE83UHZXd3kydEthaVhJV3JkY2tW?=
 =?utf-8?B?VHRGSU93WXVGYlRPdERid2JQaHZ2aCsxTGZCcFZ4QnBoc2RzT2lWa1ZjdnRS?=
 =?utf-8?B?TEp1WTlrY2Z6M0dwd1F1RlNtakdSTWx0YVpGbC9rYXBRZnlxY1o1WTQ5OHVG?=
 =?utf-8?B?cUVhdXdaMXRZSC9lYUgyOHVOUHBKMURhUllaRlpraUNhWis1L0VHNmFQR2p0?=
 =?utf-8?B?NTNjZlp4a2F6dEREMk15SXJkYTZTQjNVUU5DUlJSS0VEelpyR25MV3pENTZy?=
 =?utf-8?B?UTRJczlkTjZsbHBJWmVaU1B4ZnNXemhISC9wZ245ampZZnFBZUdWclF2djRw?=
 =?utf-8?B?Vm9BVjJIY3RWb0hRbmpiamQxRGRVU2ZxVjgwZDJESk1LQ042cHp3c3V0eFBI?=
 =?utf-8?B?M1VReXRQd0hmdWU4NWo0RGJnN25IK003aGRyeFdrM0xKZmFNV3YzWG5aZHhW?=
 =?utf-8?Q?BJMWlShWv+2412tc8MHY5v4Hs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca119f6c-feed-4c40-33ec-08db450d9210
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 21:47:59.1985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZEvyilwonahdy2wWpg6kafY8N46fvR5oBNgVBn4BA3vIdy2Dfr+7DZDpKJbK6ATOo3mknHJY6u2ThEBI0l8rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7722
Subject: [virtio-dev] Re: [PATCH v12 02/10] admin: introduce device group and related
 concepts



On 4/24/2023 12:44 PM, Michael S. Tsirkin wrote:
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
> However, it's expected that we will add more features in the near
> future. To facilitate this as much as possible of the text is located in
> the new admin chapter.
> 
> Effort was made to minimize transport-specific text.
> 
> There's a bit of duplication with 0x1 repeated twice and
> no special section for group type identifiers.
> It seems ok to defer adding these until we have more group
> types.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> changes in v12:
> 	stefan's ack
> 	minor commit log tweaks, Parav
> 	use neutral tone, Parav
> 
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
> index 0000000..05d506a
> --- /dev/null
> +++ b/admin.tex
> @@ -0,0 +1,63 @@
> +\section{Device groups}\label{sec:Basic Facilities of a Virtio Device / Device groups}
> +
> +It is occasionally useful to have a device control a group of
> +other devices. Terminology used in such cases:
> +
> +\begin{description}
> +\item[Device group]
> +        or just group, includes zero or more devices.
> +\item[Owner device]
> +        or owner, the device controlling the group.
> +\item[Member device]
> +        a device within a group. The owner device itself is not
> +	a member of the group.
> +\item[Member identifier]
> +        each member has this identifier, unique within the group
> +	and used to address it through the owner device.
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
> +			a flood of new group types is not expected.}
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
Please take care to remove above two empty lines when you merge these 
changes. We don't need v13 for it. :)

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
Reviewed-by: Parav Pandit <parav@nvidia.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

