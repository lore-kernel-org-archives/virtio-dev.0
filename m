Return-Path: <virtio-dev-return-12519-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB32C77B7F
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 17:21:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DFFF771C8A
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 17:21:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D99A49866B9
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 17:21:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CFE46986594; Wed,  3 May 2023 17:21:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BC2789865A1;
	Wed,  3 May 2023 17:21:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjXJQSgakJ6H0A5Ll9W4TbK62BZG9rSJYE5YVLM4Ypt/f7+IPmn1sAI94oB+UQT3cOtVP2uC/J8HlpRZo2uR/GlLLnXts7FSIdHzvF5Q61V6wpRf0EdDhdYnaVNHcynGFBSpBRUoVCyhiIS5T2+vbS8DirLR1qSeT9A3Fic+qlAPY1sB6rWS8ERhrWvmZKXgR618fMMnSfwBh1p5ksmJxnct7WphcYsIBJlmmitWyxGUbfnx21uJBBzwJ/dqfpNo/hpYJBYBX4gNtgI7ZJ+B/THOQynNs75lLQUsE1Dfke9nGyP2kWFH3/DHhiefcMjPmSd9bM9bwEoHXrm1NdFvow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cM/f0sIQF7ZFzq4ZzVrKD/k2OWhUcYMukLT3CMYsHmk=;
 b=HcBiLfi0JbezxhIQAFXRTm3I3eDYwi45eVLF5lsNadL4kZJigdIyJHcoYKnqANFwHRTWLJxDJciIzF0VLgmr95xpN4oEuY5ZsB9f8fZ8EZXU4J7jSW0fNMQwGIH3PNiLVMgWVD8eGTOhtar3prbn7bWOqxJXMGhxLZeWXQrQRWBXTD5MysLO/yJ2Cnp2vpkI6lf//XNhFnhTshFuSsMVUNfgF1dNz54tbeKm8dWxU7ic9x/669kD4I6pe4ibSX85Op7yMVHYnINm/gAp1lBv85W2V1Viz3S/G8tqeZYyi5tbcYhAOLGlhvRgIzqx1N4qwNuekVlFQQzAy675GS28WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <ba053f8a-4adb-5395-ed75-ac1d0bfe20ee@nvidia.com>
Date: Wed, 3 May 2023 13:21:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
 david.edmondson@oracle.com, sburla@marvell.com, jasowang@redhat.com,
 virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
 Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>
References: <20230503032659.530330-1-parav@nvidia.com>
 <20230503032659.530330-2-parav@nvidia.com>
 <20230503011627-mutt-send-email-mst@kernel.org>
 <c0ece552-d618-cbe3-c841-6c6fe72e8f18@nvidia.com>
 <20230503124212-mutt-send-email-mst@kernel.org>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230503124212-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::25) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|SJ0PR12MB5502:EE_
X-MS-Office365-Filtering-Correlation-Id: fdfe966e-4394-47ba-a2b2-08db4bfadd1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fHXj2nsRrL9UurZ69H2P0LQZXWxiXefzNwkXWKnkAfoAI+30NMRugtk4NgM1lxpfGfAXs2/gw/kc9D0lGOO45fPxVefORfCKWK9Z1OVsi1QPOKLvvpTA9GkDvlbf1p0jEB6qbEb6El4GNdOmpZAekRU8LaNSXorB/gtyKPkPo9Y78X1l6W/rdYqX0aTIV+8mK0kH8gC06jQEbHuQ2ndaPoQ3alRlpymHO98TVNJKdFOud8zWOo4mfsTo0weitdWy8W85O9ZLU4NoI2UgCYR2OqcmcaX7add7Gls8b1JcKScWm4iTjoi0DDRDKtMQk0pbI1dFgjI8Ppcb7hgwx14Ik2tON1ADUf+ZLTaVCOWNkwr6yrJjqcoXFT5mMvzFvKPKXpPYlzttZs3l/HHGVVWKYapof9K3x8BWBFmCQ1LMCamAaGwklwhmJbuTOdyVCumgnasvwibYx3Y0TFFf+LfcS38ivgNa6XHPPplfvx+mz5nyA+2pqxLVwTcgi255OeFYpQ6ukbKfvK0/fByLij9abJ7rV+oz8xiIRpIUP0Cz+Whg4Z5v7sYXZifBucZcPIHtuBN2XWxA7hBExRpjgq1nK8ROTILXplFA5+z88hvUku4aAc6ch47JmPQqSmISaRtwbLOnY8O36bPQyySqTVBVoA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(53546011)(36756003)(107886003)(26005)(6506007)(6512007)(8676002)(8936002)(2616005)(186003)(5660300002)(316002)(66946007)(66556008)(66476007)(54906003)(4326008)(478600001)(6666004)(6916009)(6486002)(41300700001)(38100700002)(86362001)(31696002)(83380400001)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXYzS2IrdnMvdEhlbTVGa3NrRkhlbTEveWwzVUFPMjR2akhDMTRkaXJCTDAy?=
 =?utf-8?B?TUZjaStMOHpkbWlwOHZNZ1daS1BUNzd1L2h0aGVFZTRsbFZhMExSVWlOVGx4?=
 =?utf-8?B?cTJ5Sno5K1h5ZHpqMWF2dkhZTXo1eUIrbDZnZjlOU21uQUFPQklLL01FcUVZ?=
 =?utf-8?B?ZUFJOEI1N3JHZUtOVE1HUXlLeTc4ZHhsWmJlS0V1TjlhQjg0Ui9iSE9TRFE5?=
 =?utf-8?B?OHcxMDFHdGx5VlRVSVA4V2JQM1IrNTFxaWlPMzdsNVVZeFNuRlNhKzVFQnQ5?=
 =?utf-8?B?TjR2a2diS3MzZm5RSVVYaUduQndHcFFFMEdHR3Y3eThOSW9FNXhtMFhSbCtO?=
 =?utf-8?B?RzZZNklOR05VVWhHeXJGRW5hL3ZXNnVDaGFrbWM0SUZjNXhjb09SSU1EVXBo?=
 =?utf-8?B?eHoxOE9zcmpjQ2Y5MEU2WE01SjJScWl0bGFGbnkzc1BPMko0OXVmeDUvWk5L?=
 =?utf-8?B?SmZHTDNtVXN5dG9KSjhWWE5oVjB6UGNSVFltZGJJRDY0RyszL09FdE1qQ2t3?=
 =?utf-8?B?ejZXSmt4ZXB6dXlaZ1RmNE9FUzM4Smt3Vmx1SUE2Q1BnVE5VWk4xbWFJUk5R?=
 =?utf-8?B?ZlBzYnBXUHZRVnFUNlh6RXNCVVJxUUhySzNkTzdwR3B1MkxyOGZ5ZlZlK1FZ?=
 =?utf-8?B?ZTdPME1uTmVaK1BHUmZPNkRmZ0pMaFZ2U2lRR2x1b25NRC9ZdFJrMFpoRUov?=
 =?utf-8?B?a29yTkpRMUFvUmpJUkJGNXppc0RnZGRUcUNZOGFXSERMeGVvZEhNbWcwVEVW?=
 =?utf-8?B?eEc1d1NKcXhZc1pPTk1GSGorNncxbzIvVXdpMis2TTJXYVdGVXdPSDVkcEdK?=
 =?utf-8?B?SkNvVDFZb2J3QmNZVmdzNXNGUmZmOUpBNzdjenlNVGNjYmNXdlRiY2o1ZkZD?=
 =?utf-8?B?SEZnemRBdEtCamlZYnhPV2lLVGxzazU3Y0FaSjVhWjFLaDRuV0s0ekxQR1g5?=
 =?utf-8?B?TXlCajVwaEJTWWNTbytINUI4RnpVY29oQU94ODY0eUpKemV4YUl6RStSNUZO?=
 =?utf-8?B?dXQ0MWRoaDdpRW5mTDIxcFJ5dmMwalQ1WTRRRU9HWE9mUHNISHJoOEVBMk5z?=
 =?utf-8?B?ZTlUeVhnVFFMZEczMkRtYzdMVE1nZXJGWUZ4bjUvQWc5YXBLNHE1dkxkY3Bx?=
 =?utf-8?B?NFFHU3lMUUdRN2U2ZUozMHl0Z2JjRkh3TFV3MHZOWFowSFF6ZGRxVFVTcnBW?=
 =?utf-8?B?MDVKUVpZYnlaVzVCUGgybDI2V0YwQ1VnTE5DTnp1dTdUNS9FSXVVeXU3SE1T?=
 =?utf-8?B?Sm95ZTJOZ0NxbUpsQnJmTVVXc202bVV4SzRuMzg5M0VYMkR5TU0wdmhheFdU?=
 =?utf-8?B?cVZiYlE1MXZWNmRETzVUazNGU0lXMyswcXFmVVdDdnF6d3p6R1R4SXdNNUMv?=
 =?utf-8?B?bXNLMjhWZk5ZQ25YWVJueVdGRmt4MHhYZFRUTzRneDk1SlRhZTA3QStXK0tJ?=
 =?utf-8?B?emIxd0NOVVIvQTdHS21FQVh6ZWpsL1Q1LzlFdlhaYldjMVlldzJmajhmcElO?=
 =?utf-8?B?bVFoYm1UYm9Qb2R2c1p4RUJWazNmaDEwTHM0Sk8weTFvN2oxeEE2RFN4Qk5n?=
 =?utf-8?B?Wm1JN3JVTnJRVHZRblNzUjRTb282MDYvOWxhSHJudDJlY0FDT09LSzI3T3pO?=
 =?utf-8?B?ZUxVb3Y5NmprWW5JbjZFNm5iWWZMT2dPTTVaRWpISUlHaXFlbXBCUWg4Nk5Y?=
 =?utf-8?B?UXhKK0M0bkVrYU4wNmVVT0MrY1F5ZENFZ05zUkt0MW9BUWRvQ3VWSlhmcFVw?=
 =?utf-8?B?SUFGaTEvY2p0MnF4S2ZlMFpveThnL01iTUZQVndVWEk3S0ZmU00wZE1xeVJ4?=
 =?utf-8?B?QnpMcnRIejBpUWlFdGJsQmZHVkpjajcxUjBxR1d6bzZmdEdjbEsxalZHeTRu?=
 =?utf-8?B?YmViTnpyMEVZWmVML0ZGd0MwRFoycnN1ODkwTGhONXM3U000bWxYOHZRYStU?=
 =?utf-8?B?ZzZwbHZHTnUwaENuQ1VBU2FoSU9vWXptUE1wL2RHTmIyVUdNNlI4NnRKakdH?=
 =?utf-8?B?bnFyOFZSYTRBbUU4cHlUdUljM3gxSFRsZHdTU1BVT2xtbzdubjlzN2FUSkk2?=
 =?utf-8?B?blBWbnd2bGdidWNYV2JnY0Q2QWxaa1VxRkgyWlZOK2U1eXYwQWkyN0RXcElW?=
 =?utf-8?Q?GuHE5S8/wp8lRIHV5FwKZXFvc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdfe966e-4394-47ba-a2b2-08db4bfadd1a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 17:21:42.7932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8adxCWnxEYJWcr6G05O1F2G4WqFJh4y/w1o2CKigQCWAIscspobHJH3qFrbv7EXflkXSijWbFhAhwQI/x4dyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5502
Subject: [virtio-dev] Re: [PATCH v1 1/2] transport-pci: Introduce legacy registers access
 commands



On 5/3/2023 12:48 PM, Michael S. Tsirkin wrote:

>>> As simple as it is, I feel this falls far short of describing how
>>> a device should operate.
>>> Some issues:
>>> 	- legacy device config offset changes as msi is enabled/disabled
>>> 	  suggest separate commands for device/common config
>> This is fine and covered here. The one who is making msix enable/disable
>> knows which registers to access before/after disable/enable and device also
>> knows it as it is supplying the register.
>> So they just follow the standard legacy register access behavior.
> 
> But do VFs support INT#x? I will have to re-read the spec.
> 
VFs do not support INTx.
When hypervisor knows that it cannot support msix for the guest, it can 
avoid using the VF for the guest.

>>> 	- legacy device endian-ness changes with guest
>>> 	  suggest commands to enable LE and BE mode
>> guest endianeness is not known to the device.
> 
> But is known to hypervisor.
> 
It can be an extension command in future as part of the VF 
administration command to set it by the hypervisor PF.

>> Currently it is only for the
>> LE guests who had some legacy requirement.
> 
> I don't like tying this to LE implicitly some devices might be BE only.
> With my idea device can support command to set LE, command to set BE or
> both.
> 
It can be an addition in future if needed.

>> and PCIe is LE anyway.
> 
> PCIE config endian-ness does not matter heere.
> 
>>> 	- legacy guests often assume INT#x support
>>> 	  suggest a way to tunnel that too;
>> INT#x is present on the PCI device itself. So no need to tunnel it.
>> Also INT#x is very narrow case. When MSI-X is not supported, a hypervisor
>> can choose not to even connect such device to the guest VM.
> 
> devices will support MSI. But *guest* might not support MSIX you only
> find out late when it is driving the device.
> 
It is a pathological case that may not exist because legacy drivers and 
linux kernels all the way upto 2.6.32 have msix support.

And in case if hypervisor sw wants to support for unknown scenario, it 
can use the one msix based interrupt to emulate intx.

>>> I expected to see more statements along the lines of
>>>           command ABC has the same effect as access
>>>           to register DEF of the member through the legacy pci interface
>>>
>> Yes, good point. I will add it in the theory of operation section for this
>> mapping detail.
> 
> OK, and overall if you see an existing statement about legacy do not
> copy it, just explain how it is mapped.
> 
Yes, will not copy, only the mapping part to add.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

