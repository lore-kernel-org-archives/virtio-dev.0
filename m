Return-Path: <virtio-dev-return-12513-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A095C77B75
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 14:57:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8409D157EE9
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 14:57:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 766C09866C0
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 14:57:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6AE7A9865A1; Wed,  3 May 2023 14:57:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 56A6B986594;
	Wed,  3 May 2023 14:57:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjXlx+g5FuHZJzztjDVFjOzK0qV9Q22RQdh4GhtnkujK4sIzFZaGpIcIH+F6wJi4tRB/BVA87zC6olzKuotun3cBGKzkULalUVFkEmELZZEuaMjdWLtW4cUireWuKidKeLRTl4RSSiA32T3sZ6aaQwTMGojeuh5J9KNcgzcyyw6HP1I6yjxmqxZLLJdoQ/PlLKr7ISOCcey6z2/2wzxON6DzygG/wqqcHhheIs0+IMYj5pLysNs5qFSOZkbxnSd7OomaOR9IEfLSU14qc8I5fYyf/rJXDTeM/nsO8b11b/MMn9JNaR0BFgzXQZlWOckc8PBMzSlobD0cE1KJ8Z+FcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inbVKr8bJPzTGODgfLNbWPn8zIz6Nxs5DQdjWp4pOUk=;
 b=oZRT9OmRYzZzej/U2pMWCthy95zg7f2SPGbREQV5hcI6Txinoqyo+M6FSFyb/M8Wo9qKfk2ICbEhA4XqFqE3AUO7DND+bLjvpaRNQxgiq5rzd0exwGMulayIOMhVP4hXXw3Z5RNl7hZRe90v8wpdFKHVZtqHTItWWzkeqA3QHVNxXLlyqQ1SSlSedkaEMEdi/8bGEO7JnW+PkU69xIY4pAyQu/Zf5qab1OkyBOHbiK78KiPM5QhrgNL/+7gcQpfMtm97MEFxgUbNo/7PGRK/jmk1ZxSVcDvHSQc7PdClmb+nEjpqTaNg7lMSDnTjf7EDHnwqQ7XROKyeisXfgLLKOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <5d2eb229-c07d-0476-60b3-cfc2f5316fb2@nvidia.com>
Date: Wed, 3 May 2023 10:57:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
 david.edmondson@oracle.com, sburla@marvell.com, jasowang@redhat.com,
 virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
 Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>
References: <20230503032659.530330-1-parav@nvidia.com>
 <20230503060538-mutt-send-email-mst@kernel.org>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230503060538-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0176.namprd13.prod.outlook.com
 (2603:10b6:806:28::31) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|DM4PR12MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f677ec7-6cc5-4ff0-a49f-08db4be6bfc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ySjyt6XjjxU4VDT8INbium5G11lIQf/5j3DSsrq0Xs4T3/5A04sp3rhWUE0r939SkVoKHEZg++lrb3APaJLcC7v1VjuXoMiknaPx6DR4Moo0RYSn7zzKINKuVWL+BjRgmcwfj3NvayFUqBF2ZI18JQFl6NBkby2LjM6oCN568kwDyMUG6J58REXcDKncAjouSEz6JAyFoMvjdN5S0x2QJjhn69De5H6K5srOe9CVmZl9kTJVCQevOG0c+zmriUN4wNyM3qSS/k5ErgaUKVEW3j1nD+mfD/W55hfjk3HJ5+bcGJhnUeADB/E6s/s+wYJR6nAl50LPc64t/dHe3SKJwa86P1RQLGIalgZIKxC4dMCq4NEk7sKPoJduvkyZz8b9iERiFP+eatAwgZ1ZGwmHxMwjSISXpDwfevrPSmTcx4FDXwHS5UggWj3seNUgdGQncQHgM8BOo6TTbfEaVtzOvC015NQJ57Z7L3wLkwJIRtvoinM36sqNOXs7UzFu3mlkwe9JQSbI1czOxtRqQ+AqRwoTuk11pNGHFd+88wHsGTSCHBRmInX1Zz04Bv4K++AEuC2X0qXER46n/16xR267W26rT9Fm5PAKsEp5GFgzckjcC9c5KcjLg0hVlSxnbZg6+MvoaWRHGiJPTLm1xs9skPThqXlWc7vpNBZYt4MvLFvM/fFFJWQA3wHkzaRREnA9TNmvEyhKi3kcY7dB6rjE4RUW2ph0b3ejFnkESXVQyeE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199021)(6506007)(186003)(26005)(966005)(38100700002)(107886003)(53546011)(83380400001)(2616005)(5660300002)(8676002)(8936002)(2906002)(36756003)(6666004)(31696002)(54906003)(86362001)(6486002)(478600001)(6512007)(316002)(41300700001)(4326008)(66476007)(6916009)(66946007)(66556008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q21NRDQwdkJNVXhadDhjRmw4a1RxK0x2cWR5MWNic00rbm9ub0RQQ1JyVWRl?=
 =?utf-8?B?QVdWN0ZWbWMvRThweU10NVRESUwweTJxUEhSdFZsZ284eWk1RXhxRW0vT05l?=
 =?utf-8?B?dCtvdnN4bWM3QlZ2WHRWVEVmVkN3RE5MUlNRN0JRMWNXN3dNeERGNkQvTG5o?=
 =?utf-8?B?SXFFbCtpeUorWnE3YUZRQWZPTlladERKS1pjS3JyMjJzV25nS0dBd3BnNlls?=
 =?utf-8?B?d2NjOGtXeDBVV2c4YjFZTmNpeWhUYis2MGozcHVZQkIrbEtDcmp4TmlLNnZU?=
 =?utf-8?B?N2F1eXl6UkkxZ0krYmd3OENUUFFaS1ZYN0FFRFJ6cm80RU5DTnpyVWtHbk9y?=
 =?utf-8?B?eXo1enFIM0hSNnozWlgwVUN6cGpHZDlPRkJ1VTZ1dnp4a1c2YUVkR1YrcnJr?=
 =?utf-8?B?YzlmbnhWb0lrMGJUcnN0aVVWZS8wdDRUN1J0Y0lya2ZBeEpqbFd4VWRTQzl2?=
 =?utf-8?B?YXM4czFjQ0FsMnJiL25ucEJ4RU12c3o3WmFycmFhRlJHSTd5VlZXRlFWSUph?=
 =?utf-8?B?Tys3elNOYzNxQVhlRGJ3VThqeXJvcXIxM3graEs4eERuajVqMTFKcjJGdVdB?=
 =?utf-8?B?MHlBQkZWNEZKcEhjM1BDTWU4WTcrdXYzSmRMTUo5blBIdFQzSzIrU2tCYVVI?=
 =?utf-8?B?aFQ5d0gwLzBmdWVGdUMrY0xCZURlcm4rRGhjOC95RE15N0Q5eWY3M0xyLzNG?=
 =?utf-8?B?Z1pOZjc4SUhRNVZTTW4weG1lMk5KTHpJQXRyYnRwL3c5anljTzdROVk1dEYy?=
 =?utf-8?B?a09IOU15MHU5RkdJZ3FtWSt4VWs0ZWlvNXBoRElQRnhydEl6UXB5L2RiSlFp?=
 =?utf-8?B?dFd6UW5lc0YyOTkrRHF4a1IxTmtXR1N0UjlVamJiSVlya2oxU3N3MXJoYTNj?=
 =?utf-8?B?WFloSGM1alhXK3lTK0sxWEQrTDZockxVak1jZVpIZ2dTdENkbHNLSisxY2hl?=
 =?utf-8?B?R3o4enBCUmcvZnlwa2NRYjF5cVpLZHBxMzI2UVl4ZTl3NzhnTnc0eFFlMTVs?=
 =?utf-8?B?OHJ1a1pTK2tXVE51cHhXc0REcWs3VEZyMnFvaENZYnBFK1Mrbkl0SDlneHNt?=
 =?utf-8?B?bFdwaStuRnR1Z25CcEJ4azNoek5rOG9wVkFKSFBZTjlnNm5NK3RkUkVLK20x?=
 =?utf-8?B?cUY0KzNtZlpRSmtxUWxtak9yOWErQXNOY2poWG13aHJKUCsyVHpQZlBYcFVK?=
 =?utf-8?B?VEg4QSsza0FnSHFyL292WEliTitvMFdsKzFWdElNc0hNVFBCajBzSWtkK1FL?=
 =?utf-8?B?NGFYZlZIdEg3V3FDdjF1elYrMU5OdEFNSFNHb1p5R05NcjBCU0VnTFpFeHVj?=
 =?utf-8?B?QUlJbGxqbW00Y3RLaFBxY2hjWnQxUTc3TEtybFVHY3VtVHl0dW5kMU5DbEVv?=
 =?utf-8?B?N0F2b0dPTXdxZDNDVWdyUlhJWU1uWjd6cGprM3pNVE8xbTZDRXQ1dVR5dlJY?=
 =?utf-8?B?QTBEQitNbUp0d05IamxYQkNZY3lPVWRXR1Z4eWwxUGdHQ2owZkR4Ynl1ZXhS?=
 =?utf-8?B?elIvSUIvWkovRkJ1WTNZcWxlS200dWFnalA4M3A4WE5zU0haMk52aTBrNjlF?=
 =?utf-8?B?eHBOVWxpd3h3eEdiVmwreUM1b1hUVDJhdXF5c291c0I4Z1hya1hJU2tGSU05?=
 =?utf-8?B?K2dGd1dVYUN0aEEwdVdwU2wwNEtVMzQ4MnpPSVdCQmQzVzFmcWpGQURwK2xr?=
 =?utf-8?B?N3lPWXpFaksvNlhZYW8yYzliTERHdEZTN0VXN3lQUXhlZWRvMlRQRGMwTmFC?=
 =?utf-8?B?aGozNHJnRlA1R1ZaZUhpWGZyWXJRY3Z6Ulpsd3ZkZ24wZFp6cHZvanZvTmVQ?=
 =?utf-8?B?R1NNWmUwRWk1ejU0ZjZRcjlDRlpHRkhqdGlBMWQ2dGJ0UUpvd0xRTEd2YmNU?=
 =?utf-8?B?WnZTTjJ1T3UzZVZXZGY0bUlVN1R1ODlodVBhKzlacTMrRVFzbTJJQ3ZJdi9F?=
 =?utf-8?B?ZzMvMi9NUnhkVC9GNUNYMVRkSytMYTNmVWwyNzMvTnFmWEN4MGk2NDJVc29r?=
 =?utf-8?B?UjVOZEJSbzRCd2FLLzM1RzJTQjdkdWZBbHMvNGQyTDFPd2FUSTRlRHUrTjA4?=
 =?utf-8?B?alBuQkxFTzhJWU9HMHg1NW85UHJaZjROcmNtb2ZyNEdoZC8wa3hEbmFTM1hV?=
 =?utf-8?Q?V6OC5UPLpSBByiOJxU5uUqJud?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f677ec7-6cc5-4ff0-a49f-08db4be6bfc8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 14:57:43.7328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEL6MAl/bJ2nh8wKMizU04ypyizWIpbIP23ZNcKTXKI3Tla9iHvGp4MrAJ/3l6RHNeLoMEvZdAfmvu9D7jCgmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6110
Subject: [virtio-dev] Re: [PATCH v1 0/2] transport-pci: Introduce legacy registers access
 using AQ



On 5/3/2023 6:16 AM, Michael S. Tsirkin wrote:
> On Wed, May 03, 2023 at 06:26:57AM +0300, Parav Pandit wrote:
>> This patch introduces legacy registers access commands for the owner
>> group member PCI PF to access the legacy registers of the member VFs.
>>
>> If in future any SIOV devices to support legacy registers, they
>> can be easily supported using same commands by using the group
>> member identifiers of the future SIOV devices.
> 
> Absolutely, but maybe we should not create work for this
> case by repeating PF/VF terminology everywhere?
> 
If we omit the PF, VF it is kind of hard to explain things without any 
tangible objects.
For example in your series lot of documentation of AQ is around SR-IOV 
and VFs. If you take out that notion of VFs for inclusion of undefined 
SIOV objects its hard as well.

So I think we can continue to talk about PF and VFs as is. When SIOV 
enters, it will be easier to talk about it as VF or SIOV VDEV or 
something similar.

>> More details as overview, motivation, use case are further described
>> below.
>>
>> Patch summary:
>> --------------
>> patch-1 adds administrative virtuqueue commands
>> patch-2 adds its conformance section
>>
>> This short series is on top of [1].
>> It uses the newly introduced administrative virtqueue facility with 3 new
>> opcodes and uses the existing virtio_admin_cmd.
>>
>> It is expected to go another rebase once v13 for [1] is rolled out and merged.
>>
>> [1] https://lore.kernel.org/virtio-comment/cover.1682354275.git.mst@redhat.com/T/#t
>>
>> Usecase:
>> --------
>> 1. A hypervisor/system needs to provide transitional
>>     virtio devices to the guest VM at scale of thousands,
>>     typically, one to eight devices per VM.
>>
>> 2. A hypervisor/system needs to provide such devices using a
>>     vendor agnostic driver in the hypervisor system.
>>
>> 3. A hypervisor system prefers to have single stack regardless of
>>     virtio device type (net/blk) and be future compatible with a
>>     single vfio stack using SR-IOV or other scalable device
>>     virtualization technology to map PCI devices to the guest VM.
>>     (as transitional or otherwise)
>>
>> Motivation/Background:
>> ----------------------
>> The existing virtio transitional PCI device is missing support for
>> PCI SR-IOV based devices. Currently it does not work beyond
>> PCI PF, or as software emulated device in reality. Currently it
>> has below cited system level limitations:
>>
>> [a] PCIe spec citation:
>> VFs do not support I/O Space and thus VF BARs shall not indicate I/O Space.
>>
>> [b] cpu arch citiation:
>> Intel 64 and IA-32 Architectures Software Developer’s Manual:
>> The processor’s I/O address space is separate and distinct from
>> the physical-memory address space. The I/O address space consists
>> of 64K individually addressable 8-bit I/O ports, numbered 0 through FFFFH.
>>
>> [c] PCIe spec citation:
>> If a bridge implements an I/O address range,...I/O address range will be
>> aligned to a 4 KB boundary.
>>
>> Above usecase requirements can be solved by PCI PF group owner enabling
>> the access to its group member PCI VFs legacy registers using an admin
>> virtqueue of the group owner PCI PF.
>>
>> Software usage example:
>> -----------------------
>> The most common way to use and map to the guest VM is by
>> using vfio driver framework in Linux kernel.
>>
>>                  +----------------------+
>>                  |pci_dev_id = 0x100X   |
>> +---------------|pci_rev_id = 0x0      |-----+
>> |vfio device    |BAR0 = I/O region     |     |
>> |               |Other attributes      |     |
>> |               +----------------------+     |
>> |                                            |
>> +   +--------------+     +-----------------+ |
>> |   |I/O BAR to AQ |     | Other vfio      | |
>> |   |rd/wr mapper  |     | functionalities | |
>> |   +--------------+     +-----------------+ |
>> |                                            |
>> +------+-------------------------+-----------+
>>         |                         |
>>    +----+------------+       +----+------------+
>>    | +-----+         |       | PCI VF device A |
>>    | | AQ  |-------------+---->+-------------+ |
>>    | +-----+         |   |   | | legacy regs | |
>>    | PCI PF device   |   |   | +-------------+ |
>>    +-----------------+   |   +-----------------+
>>                          |
>>                          |   +----+------------+
>>                          |   | PCI VF device N |
>>                          +---->+-------------+ |
>>                              | | legacy regs | |
>>                              | +-------------+ |
>>                              +-----------------+
>>
>> 2. Virtio pci driver to bind to the listed device id and
>>     use it as native device in the host.
>>
>> 3. Use it in a light weight hypervisor to run bare-metal OS.
>>
>> Please review.
>>
>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/167
>> Signed-off-by: Parav Pandit <parav@nvidia.com>
> 
> I don't see an overview here though.
> 
I will add it in v2.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

