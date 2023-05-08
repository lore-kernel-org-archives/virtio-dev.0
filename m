Return-Path: <virtio-dev-return-12614-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76133C77B75
	for <virtio-dev@archiver.kernel.org>; Mon,  8 May 2023 17:08:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 604404454B
	for <virtio-dev@archiver.kernel.org>; Mon,  8 May 2023 17:08:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5514A9863F0
	for <virtio-dev@archiver.kernel.org>; Mon,  8 May 2023 17:08:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4626C9863DD; Mon,  8 May 2023 17:08:03 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 328789863DE;
	Mon,  8 May 2023 17:08:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pbo25DXLfxHLBEtoaKM5HRJQdkVXVLZa3Yt626Y35urWbP6rFu+yq53LjXnDeXyoI8PQtQgr7KDxnmWOjtKslbR02pg//ZiKYPBkLmH7SksN2lfME34xLXm7hesmFdMGaVaTcP5D/w5SJzrHdL96dtfXec2CbEVZI4Tgwd2bwGFUEpO/mVRNRkLqvO7C1RrG+Xz2ASlwCn0hmsUfX1B1ZbDcxCdzrmOrsfIczB1DH7QLgSysmg0F5lyQt+kXw4F1MF8nqddB+QzO6e66ZABSv2r1trIdXC2jthbwrsA31G7jOluyWWpqpPvsKZUiF2yJdewad9KnPTKyicu51s+nDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FD5PF6bhjss91c3yMtPFAevBD3UTjgxY8gtVgE8o5k=;
 b=Q2nKJ8q8XMymjVOsNGnIKBj0jPyXOOF4AlqXocecz8pEXSt5L8C5qNi62tQS6wZ6bcjdrm014wGN0rUsH8QA25DcJCs763s/O2mefg6oTKh4E7x/EJIna6MCv3Ko54LqorxI9syuLPVpbz+bwmHsxJVLLXL13dALH6uh3BGCsQl0+AyJO6nhVGp2Bgyo86ZUnQx6D8ogqXPjy/qvXTmsYKmWHNiMAiNolLx9Y3UfBLN4KCm7YclGxAoad5QQ3mT0+rpA7MdSO3h5YyxZovmF64d2SbZCBPboFzTVNFm+alHX1qmEfT39oCszL/UDT9kghU7fx/siHg1Zrw8wZLgeUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <b33fe999-8491-30b4-5021-589a2fe87398@nvidia.com>
Date: Mon, 8 May 2023 13:07:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
 david.edmondson@oracle.com, sburla@marvell.com, yishaih@nvidia.com,
 maorg@nvidia.com, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
References: <20230506000135.628899-1-parav@nvidia.com>
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0048.namprd13.prod.outlook.com
 (2603:10b6:806:22::23) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|PH7PR12MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: f463241d-960d-4dba-c815-08db4fe6c635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+2AEMB2jo4gUtMrY6E1ZE1YEXQpUJIRPO9flhegzFhi5jGb7QPG/XDbvJelARf+exNhiSmU+QLws9jiPvummP3yfh4UKnuqsjnXw4pRJ+VandfmKRQ6wDP4MPobe0rzD9/pZEV6R0dJVW0SzH4vNudrgkpa5OhIPZAONTIIoNb0hQ1+IyWdWiq/ypn6902SQZxigbto2rj2T0KVNV7gA5Po3ZP7uTnaZAOoWvQE8tXY94IdYrTAMhm2xLRU6cyL3w/GgoB0ohrauQXdVTF5zH3EbZzFCYLsx5AaMImw1Xc4tqy0UnSSlyq5VAsB4SqZ/foqmWvMn5Rg+SDWkEVRis9Q3n3vUULtjq+rqgua2cyYIm3G7pHkk1sP28QwbZMzoD7kNJX9XyZRlvQN6TWtyjlGSLYqElL9SnCipdQcY9oxQ1O4IGwqfumDviqXrye0rwFg9KcyYMKWm12vSxY1ND/LnfLMadqhOKVUyyqQ5eqovaOzXJtepbscD0esHCNRS1D2F3GXBaJWyzb0fw4dG6mCaqmWF0qngo6aeQztgS15d8wG4lUdXOqpz1ue9NEkGG+6a1Z2UtltCj6lspVhVdhZ2Rsyt4IQbrlztmVQG7aJx5/XAhewf7211SKTthh2P2MgO9vtk1JWATxEdYmUkR9dIzcDq8bwHppuLkOac/DDktjaH4jcj1TCgIPDUaKW4L+tzB6FOcRpUK1B4XbH7kkJQvRA9ctKQfwNAEc3T1wM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199021)(5660300002)(110136005)(31686004)(6486002)(8936002)(6666004)(41300700001)(316002)(8676002)(966005)(26005)(53546011)(66476007)(66556008)(478600001)(66946007)(4326008)(6512007)(6506007)(107886003)(2906002)(83380400001)(2616005)(186003)(86362001)(31696002)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Kyt6c2lHNTJQMHhSZ1VHMHFRcWVQU21hMjZwMENwZy9SM1ZyVFVaTW1BaVZC?=
 =?utf-8?B?Q05mSVdZQ3BHM2NkcDZMQ0lEd3QzZyttbFc3cmRFNzRpb2xpeUJxQkZIOEIr?=
 =?utf-8?B?d25EMk91andYdnppYzlLWk9rQ1ZLN0F4NHIyNkt1a3VSUEpEMUpUTnBqQXo1?=
 =?utf-8?B?S3pZTHVWRm00VTRPVmRKR1RFaUVrdEJKSHMwMXo3SmdlYVpQMlJ0VGVmaloy?=
 =?utf-8?B?QVlvM0tyUStzdnpqMXZwUkxkQUxGaEtyN0JTMG5LUWt0Zy8ydEJlZWhvQk8y?=
 =?utf-8?B?TFpRM3dYUkVkOHFvQW5kQlZ5MVJXUnJZZS82SysyZ3lacUNSUklka0NFL2J1?=
 =?utf-8?B?NTJuemhRK3duazJqV3ZVQ0QvcFlwRlloYnFLdlVQQjJwNWY5cXlqd0VuTHdG?=
 =?utf-8?B?OXo3dHRTSkU2Lzl5V09hWVFUMzMyeUloRVlIYWk4QXR6aUZYR1lYMGxFbXFH?=
 =?utf-8?B?ajlqaFBZZ0hXYXptUkNvZTllMnhhQ25JVXljVzhKSGlpamxmK3E5TWgxdC81?=
 =?utf-8?B?VlBhYmJ4d2ZMT3pIR0NPNlJjd1NDR3hTSzRDN2JLTElaUWtLYjFiS01xVE9Z?=
 =?utf-8?B?RUladm9acGpray9WUWdnZUMrS3BiTTd3V0hWWW52Q3pBVkJtQnRHK3dVZjd6?=
 =?utf-8?B?Q1F0SGRyNkV5dUpxczcvdE1iTEpQaVd4THZ4UXlsbkhlVmNmMjk4N29zbm5Y?=
 =?utf-8?B?WTFNNVVKWVlSZEtyUDJiKy9YUzE1dXVUVGs4ODhvb2xwUnBJLzljK3UvL2hp?=
 =?utf-8?B?NkhEWFVrUzlvM2xyRWNiRDhzUVpFRlFKYTJrS3ZaRVFvSmNiMUIxU1lsOXEz?=
 =?utf-8?B?Qk5CZGxyWUpWUXY4cU1Genk4YnJ1b2hwTjMrSUxuU3h3b2lBNllwdWZ3M21l?=
 =?utf-8?B?VVZyTTVROEN6VDlaSklBWUQzRUlmYjdETUJDSTdEVEM1bDVCejcwdnkwbHc4?=
 =?utf-8?B?K2pDSmxiWi9zSHRYNGJnS1BPemZOQmp2VWd4TjAyYVRwQmdrRklTRzMyZFk4?=
 =?utf-8?B?SnVaTmo0ZGsxMU9BY2hRWk96UGRTM1RjRWo1TzFqNTJwRURQaWRKV0U5eE1S?=
 =?utf-8?B?cmR1UjllWDFSNG5UNDFzZnNpN1Z2eUpocE5HS3AxZHovNE9jWTJNek5LTEZP?=
 =?utf-8?B?S0k1VXQrRjB5K0hhZ3lrTHZCVlFpMTYvbVNMbmdoVUU3QU9hNjlQdlFQWXVt?=
 =?utf-8?B?cUxsR2tCSzFNT2VQSm9hSVJqcG40Ni9mYWl2ZmZ5V2NLOTViM0dPNGx6RElJ?=
 =?utf-8?B?bGpBTTlEUmVicVcyZTR5NmVZdTF5LzlVbmZZakZXdFE0M3pkQXZoTFJYQ2hW?=
 =?utf-8?B?L2ZhazRORXN0Tnhaa1BvQTQ4bTY1dUFWYTAyZTA5RmY0cFVlSHp0UGgyTS90?=
 =?utf-8?B?RlJZSGdmWW4yMVl6RjgzVFpheEgvSysxcUF3RTVEY1lZR3J6M1dUN3pRUHRU?=
 =?utf-8?B?YTgzMlNLTW9xZUZIZU0xNUtSbDgrdGFGblRCZk0rWDIvUGIwbTBWRnlnVFo2?=
 =?utf-8?B?c2l3UEVVb1Bhd2xwNGIzUnFLRW1HSkhCOUxnSmFyajBHaHYxdVlKS3NXd1lH?=
 =?utf-8?B?MU43TXFsNVFPa0ZJVE9pZytSY0FsQzNYNjRMc25xaVhsc2VHSjl0Um4yclRL?=
 =?utf-8?B?RnJlU3RCbm1nL3oyYm5RVXlEbHJGdFRFdXZCOE45OG9IN2ZTb0xpUGI0WU5s?=
 =?utf-8?B?cks3ZjFndHBvNW9CTWx3b0V6TTZmSjRFb0NtY3Y4MVVEQmpvNG9nNmwxWW5J?=
 =?utf-8?B?VzJuTXQxS2gzZldqbjllMm9obC80a3pJSDV0bGpVZ0Y2d1k0MFpnVWVxMTZr?=
 =?utf-8?B?RjJWT1pWZ091ZENreGlzdStPNWxTU2hLWm5qNGs1aEx4eDFnQzJyQ3JaS1JH?=
 =?utf-8?B?SkJ1NHBORlVwQm9mUkdCT1FlMHVGQUJTejN5aUc5aGF5ZFpuNVRkaTNSOUE5?=
 =?utf-8?B?S0NVbmJRbE5HT2NidFpoY1dTOFFwYXpIVmJoait3TWZ3RFpNYkQ2dzQ5NDVh?=
 =?utf-8?B?cDNSRXROMWpEVklqa2lvc0R2ZnpXL0JTaTg3ZEtxZCtaV2p0ZGVkTXcxNE85?=
 =?utf-8?B?WDIyeVpzcFdXK0hWcUVienBLdFZUUTlWSHlOUWtVNGhHRXBiQlRUa045RDYy?=
 =?utf-8?Q?cDodBjgNnL0pkVuCvsaN0rG8q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f463241d-960d-4dba-c815-08db4fe6c635
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 17:07:59.1356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swreC5hbfi4QYaz5eT8Cmq3Zer9/myKRyP12wzWlP3MIqBUReWaGFKUXp2W61M8jkvqnv1ZVseEaurlRA8uKTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6564
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ



On 5/7/2023 10:23 PM, Jason Wang wrote:
> On Sun, May 7, 2023 at 9:44 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Sat, May 06, 2023 at 10:31:30AM +0800, Jason Wang wrote:
>>> On Sat, May 6, 2023 at 8:02 AM Parav Pandit <parav@nvidia.com> wrote:
>>>>
>>>> This short series introduces legacy registers access commands for the owner
>>>> group member PCI PF to access the legacy registers of the member VFs.
>>>>
>>>> If in future any SIOV devices to support legacy registers, they
>>>> can be easily supported using same commands by using the group
>>>> member identifiers of the future SIOV devices.
>>>>
>>>> More details as overview, motivation, use case are further described
>>>> below.
>>>>
>>>> Patch summary:
>>>> --------------
>>>> patch-1 adds administrative virtuqueue commands
>>>> patch-2 adds its conformance section
>>>>
>>>> This short series is on top of latest work [1] from Michael.
>>>> It uses the newly introduced administrative virtqueue facility with 3 new
>>>> commands which uses the existing virtio_admin_cmd.
>>>>
>>>> [1] https://lists.oasis-open.org/archives/virtio-comment/202305/msg00112.html
>>>>
>>>> Usecase:
>>>> --------
>>>> 1. A hypervisor/system needs to provide transitional
>>>>     virtio devices to the guest VM at scale of thousands,
>>>>     typically, one to eight devices per VM.
>>>>
>>>> 2. A hypervisor/system needs to provide such devices using a
>>>>     vendor agnostic driver in the hypervisor system.
>>>>
>>>> 3. A hypervisor system prefers to have single stack regardless of
>>>>     virtio device type (net/blk) and be future compatible with a
>>>>     single vfio stack using SR-IOV or other scalable device
>>>>     virtualization technology to map PCI devices to the guest VM.
>>>>     (as transitional or otherwise)
>>>>
>>>> Motivation/Background:
>>>> ----------------------
>>>> The existing virtio transitional PCI device is missing support for
>>>> PCI SR-IOV based devices. Currently it does not work beyond
>>>> PCI PF, or as software emulated device in reality. Currently it
>>>> has below cited system level limitations:
>>>>
>>>> [a] PCIe spec citation:
>>>> VFs do not support I/O Space and thus VF BARs shall not indicate I/O Space.
>>>>
>>>> [b] cpu arch citiation:
>>>> Intel 64 and IA-32 Architectures Software Developer’s Manual:
>>>> The processor’s I/O address space is separate and distinct from
>>>> the physical-memory address space. The I/O address space consists
>>>> of 64K individually addressable 8-bit I/O ports, numbered 0 through FFFFH.
>>>>
>>>> [c] PCIe spec citation:
>>>> If a bridge implements an I/O address range,...I/O address range will be
>>>> aligned to a 4 KB boundary.
>>>>
>>>> Overview:
>>>> ---------
>>>> Above usecase requirements can be solved by PCI PF group owner accessing
>>>> its group member PCI VFs legacy registers using an admin virtqueue of
>>>> the group owner PCI PF.
>>>>
>>>> Two new admin virtqueue commands are added which read/write PCI VF
>>>> registers.
>>>>
>>>> The third command suggested by Jason queries the VF device's driver
>>>> notification region.
>>>>
>>>> Software usage example:
>>>> -----------------------
>>>> One way to use and map to the guest VM is by using vfio driver
>>>> framework in Linux kernel.
>>>>
>>>>                  +----------------------+
>>>>                  |pci_dev_id = 0x100X   |
>>>> +---------------|pci_rev_id = 0x0      |-----+
>>>> |vfio device    |BAR0 = I/O region     |     |
>>>> |               |Other attributes      |     |
>>>> |               +----------------------+     |
>>>> |                                            |
>>>> +   +--------------+     +-----------------+ |
>>>> |   |I/O BAR to AQ |     | Other vfio      | |
>>>> |   |rd/wr mapper  |     | functionalities | |
>>>> |   +--------------+     +-----------------+ |
>>>> |                                            |
>>>> +------+-------------------------+-----------+
>>>>         |                         |
>>>>    +----+------------+       +----+------------+
>>>>    | +-----+         |       | PCI VF device A |
>>>>    | | AQ  |-------------+---->+-------------+ |
>>>>    | +-----+         |   |   | | legacy regs | |
>>>>    | PCI PF device   |   |   | +-------------+ |
>>>>    +-----------------+   |   +-----------------+
>>>>                          |
>>>>                          |   +----+------------+
>>>>                          |   | PCI VF device N |
>>>>                          +---->+-------------+ |
>>>>                              | | legacy regs | |
>>>>                              | +-------------+ |
>>>>                              +-----------------+
>>>>
>>>> 2. Virtio pci driver to bind to the listed device id and
>>>>     use it as native device in the host.
>>>>
>>>> 3. Use it in a light weight hypervisor to run bare-metal OS.
>>>>
>>>> Please review.
>>>>
>>>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/167
>>>> Signed-off-by: Parav Pandit <parav@nvidia.com>
>>>>
>>>> ---
>>>> changelog:
>>>> v1->v2:
>>>> - addressed comments from Michael
>>>> - added theory of operation
>>>> - grammar corrections
>>>> - removed group fields description from individual commands as
>>>>    it is already present in generic section
>>>> - added endianness normative for legacy device registers region
>>>> - renamed the file to drop vf and add legacy prefix
>>>> - added overview in commit log
>>>> - renamed subsection to reflect command
>>>
>>> So as replied in V1, I think it's not a good idea to invent commands
>>> for a partial transport just for legacy devices. It's better either:
>>>
>>> 1) rebase or collaborate this work on top of the transport virtqueue
>>>
>>> or
>>>
>>> 2) having a PCI over admin virtqueue transport, since this proposal
>>> has already had BAR access, we can add config space access then it is
>>> self-contained so we don't need to go through every corner case like
>>> inventing dedicated commands to accessing some function that is
>>> duplicated with capabilities. It will become yet another transport and
>>> legacy support is just a good byproduct.
>>>
>>> Thanks
>>
>>
>> I thought so too originally. Unfortunately I now think that no, legacy is not
>> going to be a byproduct of transport virtqueue for modern -
>> it is different enough that it needs dedicated commands.
> 
> If you mean the transport virtqueue, I think some dedicated commands
> for legacy are needed. Then it would be a transport that supports
> transitional devices. It would be much better than having commands for
> a partial transport like this patch did.
> 
>> Consider simplest case, multibyte fields. Legacy needs multibyte write,
>> modern does not even need multibyte read.
> 
> I'm not sure I will get here, since we can't expose admin vq to
> guests, it means we need some software mediation. So if we just
> implement what PCI allows us, then everything would be fine (even if
> some method is not used).
> 
> Thanks

The fundamental reason for not accessing the 1.x VF and SIOV device 
registers, config space, feature bits through PF is: it requires PF 
device mediation. VF and SIOV devices are first class citizen in PCIe 
spec and deserve direct interaction with the device.

Hence, the transport we built is to consider this in mind for the coming 
future.
So if each VF has its own configq, or cmdq, it totally make sense to me 
which is bootstrap interface to transport existing config space interface.
The problem is: it is not backward compatible;
Hence a device has no way of when to support both or only new configq.

So eve growing these fields and optionally placement on configq doesn't 
really help and device builder to build it efficiently (without much 
predictability).

Instead of we say, that what exists today in config space stays in 
config space, anything additional on new q, than its deterministic 
behavior to size up the scale.

For example, a PCI device who wants to support 100 VFs, can easily size 
its memory to 30 bytes * 100 reserved for supporting config space.
And new 40 bytes * 100 fields doesn't have to be in the resident memory.

If we have optional configq/cmdq for transport, than 30*100 bytes are 
used (reserved) as 3000/(30+40) = 42 VFs.

Only if some VFs use configq, more VFs can be deployed. It is hard to 
build scale this way. Therefore suggestion is to place new attributes on 
new config/cmd/transport q, and old to stay as-is.

The legacy infra is unfortunately is for the exception path due to the 
history; hence they are different commands as Michael suggests.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

