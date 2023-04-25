Return-Path: <virtio-dev-return-12394-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7D3C7618E
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 02:42:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D56FE29FCC
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 02:42:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CEDEE986449
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 02:42:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C49B098630A; Tue, 25 Apr 2023 02:42:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ACB199863A5;
	Tue, 25 Apr 2023 02:42:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdzKCOPebTJf+K2wms/lFZyXgG1aagw8Y/cDkbZqpxBuFo4JfA0j9OvzdE+ZiaixilzjgKqDZ6MrRtZd8uNpoV0n4pv+YbCEg/z8Kevv0+i4phOrCqbsN/g9atHS9LVFrkSbhqBN8EZLGn/Uih5SelDspH/uMjYWS0QlFyUS3Zd6Gpkqc9Gqje8GAGzcW/363gqs0F/yz4bW2WgbXDCeN2wADZ9jcA19U//Ij7aKOCwHaliqfnRuQ5yHYx8PvInr3VNLnR/6D1iwjHXP5suJZ3E47bPV9v6+fd9rYEEiYx4E477kwjc2ByaeynXLXea6Fm5RCenKd+J/kN8oEuJpjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDkbDVCY8Q4lUkXHJTjg5UpkuDcRajBMUn9IsaUyvFI=;
 b=Mxc7pY5K9/piP2MM2EFCjuLGJm5bPC1bGy2XHtzThEOfQFtXSf6cGAaQO0qG8fvsOtAWq3n16R3Firl4HGnFKi4TBUsQVgktYVvc7OUestVSMuKmbQbWRfdu5cik5c4T+7C9Lc2VpY4Xyms0DamLnerYPLkUKHyQUjlQj1Wx4gpZglQHo7KGDH6bNqJZvu/MNyTOxiectw6VDIW353sBeXiGgKrXYAB+P1r2nNTqyA/BW2IGD1uy+Uasm1gp+ymcrPj66OnXTemR4YrA9gM9fKghxJCJquLNmCNbqxBZgGrmRxHovrYwE8KaAphDRsIplm97SK6ZXuUruxzRunzg0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <f66589c5-63bb-0844-f128-a63d72a9d7ac@nvidia.com>
Date: Mon, 24 Apr 2023 22:42:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
 Satananda Burla <sburla@marvell.com>
References: <20230330225834.506969-1-parav@nvidia.com>
Content-Language: en-US
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230330225834.506969-1-parav@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0084.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::25) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|IA1PR12MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 577f134f-1b7d-4c3b-dcfc-08db4536acda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6o1o0VVPF2ZKpF4JYI9j4DWaXofNY+xn/FoiPkYXQuLKGPdefUBtinJbPAmHmZXBDHnPAErdV0/3Qd4ZqLQ8/N2XDjBtGOovg2Xzl1AH9Iiz61YR4xXWnsYPKOSyN111PBpZ7aydP2DKkPrpuGLuGB0xkgXz8ziRQRENAOj0uFRZ4/2u4Y2IUf/OXtfMJYdxmujJ8FIkO7W00fiA5ZGS2i3QTMH4k93jfu8cJsfNx0EWpUvWCV+EisUthUH1tvQ2/yLaLa89xnNo+YhDbUf037sNocglfWxc5Vv/FVBhrVDEHwTepqqfKcd16Pd4hZneanYHzvLriqMRjvOrf4uzo4YqXtjrfmkFY/n4Jtflso+hSq86oRLEeP4ykfOpTLI6t5ol67yMpwQawI04ofUKRSf1Ho1dcKwnrBANdxuhGprZj79u790VTpE0Bo6uHi7+e3Ja80fZr15U+rW+ZT8gWi8PIVRqmJL8j8JE2/6LgxRbJZr226wWp4MOsf0DvVtPVsL7IZwCImutndbZ2jWSaU1GKIxiqE3LOz1wDL7IUwcfZ8xHg1nnX8k/y1qzFXF6jRsdzMUPAcCBRJG13jJjfCRIzOLp/+vShmr2zuR/ZDezDAVa7HWmrO/WNuCOQ8h8wNYZkI0DwcSc3bkkl8p+pA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199021)(2906002)(6486002)(6512007)(6506007)(2616005)(186003)(53546011)(66556008)(66476007)(66946007)(8676002)(8936002)(41300700001)(4326008)(316002)(26005)(478600001)(5660300002)(38100700002)(36756003)(86362001)(31696002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1psTWJqK2xIalVYRlBtV3BPN2NaWDJkbk5vdWd5NVJ0cjVLcTQzc1gyb0ND?=
 =?utf-8?B?VWFyODkwVGRIV0RkNzhlUG15L3ZQREQ5UFlZNG1oSmY3Y2oxNlR5dTk3L3Vl?=
 =?utf-8?B?eHFWU3dUMWd1eVJ2UkxkcTdsclZCKzZRTUtjV0w4aFppcXRGZjNqNExSNE5m?=
 =?utf-8?B?MHBFdzNqZlVObnlUWGFhWlFXbVk2Yndxc3NtcGsramh0VnZZaTkrYVQvcmov?=
 =?utf-8?B?WlUrL2JRd1NVaVdNcG9JYmhNQjNuVXplSERMTVViVEJJcUhoS3VsbEhnUDlZ?=
 =?utf-8?B?ZUs4K2dVR3BMaEdQTVVqN29VbVR6bUIzcFRWVHBDLzI3VGxIS1lObHMxN3BS?=
 =?utf-8?B?N1hTU2tUbk5zQTJoT3dzSkpWYURSNkpYd0pNUTBIWGROVzAzZUk2M0MrZHpl?=
 =?utf-8?B?MUpDTkFlS2psV0x1c2NyNjVZcldaRXN1TXAwRmhCYUdxY21zVUVBZGpWekRP?=
 =?utf-8?B?WHdpTHF5dWNuVURmK2xwTUE4cTlVZ2J1b1Yya1RqOXlyUXROdURERzJDQjNi?=
 =?utf-8?B?R29rVTFTRjRuYnIwNjdiN1dVNHE4OFdFM0hKS2IrQTdWSEQ0NS92V3NvNDR1?=
 =?utf-8?B?dWNsVW5BOEdBRDVWYTdSbmpybWRBelNWL0J2NGI5aGFsWloxTXkxZnNLU0k5?=
 =?utf-8?B?ZUJyUmI4NUxqTkVFdFYrajhQcHBlNmR4ZFZHa1hTcXZaaDR4eWpZRTZySjNk?=
 =?utf-8?B?emxJcWZzS1haRzgwN3BkSXlMQ01TWkJiMDVzOUxPZEx6Ti8wZFZRalhZV2JI?=
 =?utf-8?B?c0xlZWVuaWhMQStyaTk5WXBPZ21MNWJ5WktrQ3BIQXdpK0tiWGJXaTVLaHRp?=
 =?utf-8?B?NE1ad0Y0aTI0eXF3Y3BxME4vVHRYY0JJTWZPVlE4aFoyNXZZakw2c0JuT2pu?=
 =?utf-8?B?Z01MRGV2OUpzOUJxOW5wa1NmaGZXSW94ZXM4SEIxYW1JS3p1L0ZSbkRFQnV3?=
 =?utf-8?B?L3NXRVl5T0hqdzBBdkd3eW8xQnQ4eUo0N29wU0FnMzllNUFoSE81VkwxOGtT?=
 =?utf-8?B?Q01wSCtUd2p4NitsMjhrT3hSQ2R5aFpHOTUxVXFvRk14a0V1MGtWVWVXajFO?=
 =?utf-8?B?RmlxajJUdnU5eEJFY05ENzNHRmYyK1VTaXJsK29XcU0rQVU1NEZ0RnNhcjRr?=
 =?utf-8?B?ditIVUh2RlppQVpjdTVJQTNmemlXSnhmejRIVDBSdlhqM3c1L3dRZGtkb2VM?=
 =?utf-8?B?eHVuSnZqRlMyKzh4MTFGNmJsdHAyeUdWYTN6TjMxNkIzY0NQRkpzSm5mL2xu?=
 =?utf-8?B?eGplMEQ3MEx2aHliVmRwbzYxdEcyUnNNUjV4aXFTb2ZFY095bjdsTnpxMVNi?=
 =?utf-8?B?cndtME8rbmlhNE9wc0ZPay9OVVJIU0pzTmNmbWVYN1JOR0Qxam1rbFV1UWJh?=
 =?utf-8?B?TWMvaGdVME14ZU1Bai9zUmdrYnp0T3l3TURaQ25qcXBtL2VlVnJIdkg1Y29a?=
 =?utf-8?B?eE5jSDhRRGt0dHRCQmpFSkxjUUx4N1h6UGtjdFI0Z2ozd0k3eG4xM3UrSHFN?=
 =?utf-8?B?MVhCb2poUVp2TEEwK1dvMWxBc2RBck5yQllxNFhidC9HWUtGUTFhanFOdUFE?=
 =?utf-8?B?aHdFMjc2TCtER2ErMXk0YmoxN1VhWnVWMnhKNnNHOVdlN2NmVXFxazFVOUlw?=
 =?utf-8?B?L3VrT1NsY25iazJxQUVwMTY2VXdkQU1ROTZWZW9ONzR1MWxrd3JCRU16TFdO?=
 =?utf-8?B?c3krT3JqTEJqMDBPdlgwTDFrTC9mTTBHbjJvUUJ6ZE85STZ2VWV6UTR4Rzdv?=
 =?utf-8?B?Q1FzNzJvMndaUlljL2xuTDZOV3ViOVdZNVhMNE1LeDg1N2x6SXhFbkdaNzZl?=
 =?utf-8?B?MUY2Qi9PNlJXMlZ4SThlaTcwQjVhbW90NlY1TFVlQkN4TUFzVFYwNkRCcTNt?=
 =?utf-8?B?cEpmUEVSZzNxRlhIbXFNS3dmbVVzWnovODZYcEc1ckRlTWxjc3VySDBIOCtq?=
 =?utf-8?B?YXdQM0RGd2pvNU9FS0o4eHdyYllMZjYvaTlGSUNWRFBnY1ZHUFc2d2hkNjJX?=
 =?utf-8?B?ZjBEc2l2OTZOQ2RIQnY3UFZ3M2FnTnNpUlJWTERiM1FIa3h3U3FDbEhQTGlz?=
 =?utf-8?B?OXd4SDNkQWR1eFNvOHY1WlltcVFxaFgwMUkvTDZIMmNaTmRyaE9Pa0NCTFB0?=
 =?utf-8?Q?wEaiwzqkLj2RX6jGWyQQF3aYU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 577f134f-1b7d-4c3b-dcfc-08db4536acda
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 02:42:13.5310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SC9lgj460oT3pXe+8kxDRnHWfQtPkb2tcD6F8NXH1Pw4WgNgmIO3sScKlcWGw0dO9j1TJLuY0LGy1AvfWRerug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541
Subject: [virtio-dev] Re: [PATCH 00/11] Introduce transitional mmr pci device



On 3/30/2023 6:58 PM, Parav Pandit wrote:
> Overview:
> ---------
> The Transitional MMR device is a variant of the transitional PCI device.
> It has its own small Device ID range. It does not have I/O
> region BAR; instead it exposes legacy configuration and device
> specific registers at an offset in the memory region BAR.
> 
> Such transitional MMR devices will be used at the scale of
> thousands of devices using PCI SR-IOV and/or future scalable
> virtualization technology to provide backward
> compatibility (for legacy devices) and also future
> compatibility with new features.
> 
> Usecase:
> --------
> 1. A hypervisor/system needs to provide transitional
>     virtio devices to the guest VM at scale of thousands,
>     typically, one to eight devices per VM.
> 
> 2. A hypervisor/system needs to provide such devices using a
>     vendor agnostic driver in the hypervisor system.
> 
> 3. A hypervisor system prefers to have single stack regardless of
>     virtio device type (net/blk) and be future compatible with a
>     single vfio stack using SR-IOV or other scalable device
>     virtualization technology to map PCI devices to the guest VM.
>     (as transitional or otherwise)
> 
> Motivation/Background:
> ----------------------
> The existing transitional PCI device is missing support for
> PCI SR-IOV based devices. Currently it does not work beyond
> PCI PF, or as software emulated device in reality. It currently
> has below cited system level limitations:
> 
> [a] PCIe spec citation:
> VFs do not support I/O Space and thus VF BARs shall not
> indicate I/O Space.
> 
> [b] cpu arch citiation:
> Intel 64 and IA-32 Architectures Software Developer’s Manual:
> The processor’s I/O address space is separate and distinct from
> the physical-memory address space. The I/O address space consists
> of 64K individually addressable 8-bit I/O ports, numbered 0 through FFFFH.
> 
> [c] PCIe spec citation:
> If a bridge implements an I/O address range,...I/O address range
> will be aligned to a 4 KB boundary.
> 
> [d] I/O region accesses at PCI system level is slow as they are non-posted
> operations in PCIe fabric.
> 
After our last several discussions, feedback from Michel and Jason,
to support above use case requirements, I would like to update v1 with 
below proposal.

1. Use existing non transitional device to extend the legacy registers 
access.

2. AQ of the parent PF is the optimal choice to access VF legacy 
registers. (As opposed to MMR of the VF).
This is because:
a. it enables to avoid complex reset flow at scale for the VFs.

b. it enables using existing driver notification which is already 
present at notification section of 1.x and transitional device.

3. New AQ command opcode for legacy register access read/write
Input fields:
a. opcode 0x8000
b. group and VF member identifiers.
c. registers offset,
d. registers size (1 to 64B)
e. registers content (on write)

output fields:
a. cmd status
b. register content on read

4. New AQ command to return q notify address for legacy access.
Inputs:
a. opcode 0x8001
b. group and VF member identifier or this can be just constant for all VFs?

Output:
a. BAR index
b. byte offset within the BAR

5. PCI Extended capabilities for all the existing capabilities located 
in the legacy section.
Why?
a. This is for the new driver (such as vfio) to always rely on the new 
capabilities.
b. Legacy PCI regions is close to its full capacity.

Few option questions:
1. Should the q notification query command be per VF or should be one 
for all group members (VF)?

Any further comments to address in v1?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

