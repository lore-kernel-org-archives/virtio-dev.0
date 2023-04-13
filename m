Return-Path: <virtio-dev-return-12201-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC0FC77B61
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 03:31:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D03C72A89F
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 03:31:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C570C986602
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 03:31:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B41199862A1; Thu, 13 Apr 2023 03:31:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9A4889865F6;
	Thu, 13 Apr 2023 03:31:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAbcxh8ujLZaYNmNEbc++WOOt7ZSUPSXtFU0Z/YwfbSgGhqgi8nqRMcU2/Zge/ZlwytyfHD2qyPbe1EubazknuijggiG+exYzVbJa9wD4AnNUh5A25aD171GcYgBGDISwN1z7ZtdZunbvg0Oa0IWnxqcraR6fL7M1veh7GOoajU+E6YP9/6i69g1Om/LY5jz9YcEG9UX4kBWPMF2fbQllhpP/LutHiHR4OfgG4MGQD3DXJoCNqj/2aNbLE87E7ywfEoPNDs4DtIcErcVm3wkhdlKoFOnga+K5jcNzfHrbe6Tl7v65m3C6O6oYg0SGKPAuwWoAOHZh6OknHbV60dG7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3gtQ0bUhmqCRWS/EflxgHpGh2hTF/X/MvkNOeAK7KE=;
 b=YBMunFC8WifmE011pr3dTRni/K9nezlIY8Xrhsy/jF4i71Xo0R7KCw7zTSvbI5FPwsPjn1xq0e18G/EKUaoJM7B5G6cjue12xoIg0o49E4KMXAX7pm7wnpiprFTcUxxfnNKD814SBsuAtZs3AKhQRKKLlF2ap/rDsP7pZo8P+ak3QEcIY7RRrKKrSwB+pmfH0nttOfVpabV4vMxHbgat90BpPR4vcefmJPBH72jkpsd3LEBoPftMMnXAhxaG2NbGaP4sPHhg3CCnMBKoCosUNquiNnXc/WbKBg87uoxE6aEmuWSD7RWLMsVSWIxuA5RkxMe4j9kKSEcFpSeabSOfnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <a74d3107-d38c-df15-e2ff-f848635f24bd@nvidia.com>
Date: Wed, 12 Apr 2023 23:31:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Yan Vugenfirer <yan@daynix.com>
References: <20230410020906-mutt-send-email-mst@kernel.org>
 <CACGkMEt2QAfhCgpYjSRNzf3n4W_HJLrMfE9JHzocR_gPH_Zrtg@mail.gmail.com>
 <20230411063945-mutt-send-email-mst@kernel.org>
 <CACGkMEufWUXHKahg3GLOKfV5aptbiek_DKwy+7rCfMya2GPaTQ@mail.gmail.com>
 <20230412000802-mutt-send-email-mst@kernel.org>
 <CACGkMEshNydwBD=Q0JW-SDY6xyiJ4uVrLn+pxbUrinycBKwsrw@mail.gmail.com>
 <PH0PR12MB548118F57BB4B4A4F8DC9D7ADC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvYsz1fSPG+fKpRaZ05Ut7ffKwvMPvR8xbRBsXA_6vGQw@mail.gmail.com>
 <PH0PR12MB548137D7A25C99EAA42B4D12DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshW82qztmGw8YJWJ8=QCoRd6cPxQ+ySazxsO_o+U6c4Q@mail.gmail.com>
 <PH0PR12MB548147CF939CB9C2A0586310DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu2B_GogDR9HUwB7mT8fkGh+Q_buPLz4nhwhK7h9k6BQQ@mail.gmail.com>
 <PH0PR12MB5481F0CF5A555A6BB2CE856CDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuNOYOxvcSzrs0UFEyk+xOkGUpOfhK8rOy_Mebz5b5wdg@mail.gmail.com>
Content-Language: en-US
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <CACGkMEuNOYOxvcSzrs0UFEyk+xOkGUpOfhK8rOy_Mebz5b5wdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0071.namprd05.prod.outlook.com
 (2603:10b6:803:41::48) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|DS0PR12MB9037:EE_
X-MS-Office365-Filtering-Correlation-Id: 79233fd3-df4e-49c0-3fea-08db3bcf9260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AQicLCDapQGgBdr5Z3aNzvZ9+rBR16LJJG4r5VrmMle6Xs4cT+JMrFYfOsVQi7vqtVfmXbopBp1xBNfYov5WPn5yjfN2bd+OZQMPSPzeBhuH0wMer7PPLOV3jSqOaSQw8xAtToVRXSohCw/qNM8pEHdNRxcrl7kximWzkg/6Vlzku5mjvGTEIIbTZnD9GKpZ2/3ZFJXEb9xi7fQ8F6YbP1iy4MOywD8xUb7JUkylOGMtUX1ivEAqF7H6fnah7UQPaVvUiHsr4xyQo7ojD68qpQqPg4T/YNel9D5R2UVps2wNmhhkfS6NJQ3IgrKfNO4xcFJXtRcGzgAh3SNFJMKScyzikewZt9jll0/vXF72hgjWpDQFZu5GaVW1+oGD6HkRvUm2g9Lv5fz7UAOR4/IsuKGxuphRm/eUCyyUZCTVkkcUa+hoAoQ7Wkphmy5XdU5QagBZgPvHcYx58ir08Hj4dKiKFkCzL14z7/WhDyiIzzqehFn9Sov3O7RJJiDdrqh5stVXb7FYmCCFnkehU+CPVFjZt84tQR2RR7MegmmESBvJUJG97lFyPJEYisQXZoiM4/LAN0jcrGosHL2Db3Qw2z1j+cgjrBRBSzzPtpVwlkZlcFkZJuvrLsoTGI1Fg88rYqTbF3yEnyk7BQQprXG0tg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199021)(31686004)(66899021)(478600001)(6512007)(83380400001)(36756003)(31696002)(2616005)(86362001)(38100700002)(2906002)(53546011)(316002)(6506007)(26005)(186003)(54906003)(5660300002)(66946007)(6486002)(66476007)(6916009)(8936002)(41300700001)(66556008)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODl1OERPTHM3L1p2QytmMGFtZU9NZlp1YndkOTUydHJBOGJ0VWtjcjNyMGZX?=
 =?utf-8?B?VTA3MW1KaWl4aFdydE5nT2xHTTNwMWxibU5aclIxUlpUTUJkUW5SeTlLMnVw?=
 =?utf-8?B?T00yNXd2VXg4RDhYTjdoOEpGQnZXdDFDL1Q1S1NxM3BoTXdUem5xRUZ2MDJ6?=
 =?utf-8?B?RERvOXN6K0hMbUFVRUV5b0dNRVJYMU1veHp5Y0o1c2dtVzFGdXNlVFNYRVNJ?=
 =?utf-8?B?VDJ1NFZzdkt4QnoxZW5KYytLWTYrWXRVcGVJT1RsWlljcmpVVXVDTFd2WUkv?=
 =?utf-8?B?QWNNaHBkRE13ZnhuQWd2RVJqQU40bzRQTlBWZU1LdVpKdmRNdlZzbHp5dFZJ?=
 =?utf-8?B?Q1BDeHlYMXBTYXN4WWZMUHVlN3JqTUdycGtDa0ZGV2tYbmVSREE4VGpCVzVT?=
 =?utf-8?B?d1NON0hHdHNUNFByMzU3OTk5YktFTk52SHEyNkFTblNjaVZtR2NoZDhJcEUr?=
 =?utf-8?B?RVM4MmsxZ08yc0thSTRVa2xXcGphaUl6aDh0QzluZnU1UjRHd3VxcCsydHMz?=
 =?utf-8?B?MFlYU01ZT1pSUnN3YUJKUUk4Ykh0aHNHQ1NUL2kzNFBBTmphQ0VaQjE4WUxi?=
 =?utf-8?B?a0lCWGVPeUxsOU9DL1VKdG5WaWZXQnBidGEweW4vWTViaExPeCs2aDJPMjRF?=
 =?utf-8?B?Ykp0ZVc2M3FLQ2Z6SC9zdU1Sd3o5T0QvdCtGd0w4NXR6RnVZRmJPVzA5OEp2?=
 =?utf-8?B?WFBBa0lsUE1rR0FYRlN5NGV3Q3BsaHhrNFRUeXBEZUFxMEgvZ1cycXVUOUF0?=
 =?utf-8?B?STdHUzRwWWZFcHdwN2JXMXBNaUVnSzBlQUlsVFFHZWxheEdXTUlNcUZxMmhs?=
 =?utf-8?B?WCtNRUtGQ0VKQnNxdWhiOUxaSkxiK04yVHlGTlpCTCtjVGNZdzBNN1FaaG80?=
 =?utf-8?B?QmlvS05nczE5bDRyR3R0dG5nd0FHbkwrWE0vQjMzRlJqMlZ4clpxbW51dDFT?=
 =?utf-8?B?emROZ3NPVVlQR2VkQmlaTFpWUGJ4U3RCdG5aSlNSaDhaZTI4b0ZOcGt1MkF0?=
 =?utf-8?B?ZDhabVlvT2J2SXhsN3ltaklYSDdpbGQ0ZDhocEZCbUxnRTlvcnkrQjhOU0Zz?=
 =?utf-8?B?emVlWjRBSDdBZVF0cDE5YnlVdC80OXBpditjMXpFdk1uR2FiZ0VneGlnbUhX?=
 =?utf-8?B?aHR2NXpRYTBOanlWY0dBMEl4Z05EbnNTWmR5Wkovak1MZy81WG1aSW56WUVw?=
 =?utf-8?B?bVhYRDNMeE1tUHVtUWtiSWpnb2NRcEhyVzBhelRzc0RkRjRxRWZRd3RETmZv?=
 =?utf-8?B?bG1jOXU2K0FYVjYxanYvaWgvaFhiTy9ZNHZNZi9DVnJ0Qmkxby9aRVdiQmM4?=
 =?utf-8?B?cUtIYWQ1Rm9OcVJ6a3BSR09JZHpHQUNtaUZwWm1Hd0VPOEt5Z21QSVd0aXRJ?=
 =?utf-8?B?TzFPbWh6WFc1ODQvNHhhWUxSWitMU2lERkxHVGtsZFpxeGkxYTNQc2RneVRS?=
 =?utf-8?B?c1p1amVpcktNeXZxYmVydGpEMHZQQUFXcnVqSFRGV2xwcDkxcG9zdHg5T0JT?=
 =?utf-8?B?NTRVZjI0eWF4VzlUM1l3YVE5eCttZTdjVGhMSThHWEVhaTFibzROdzJURTdO?=
 =?utf-8?B?ZldsczlvOHI5N1g2cElGOERuSk44eld6dnJ6aE5BWTNDWU8xZHJpN1JRenNi?=
 =?utf-8?B?dEVVN1dFT1ZCZzEzUFBKUFY3bGJIYUdJNmpHQkw4VkYyaEY4S1VWU0lCYVBI?=
 =?utf-8?B?a0tRSjRUOC8rY3ZBdVEzUGZVb3hMR0Y1eWJIcWNXTzBGT3lSbWl5VWdEdHpV?=
 =?utf-8?B?RkxqR1lyWU9YeDBwWGVpODZWK2VNbjVTNDRnYThHSkcrancybHBYUlZZRUo5?=
 =?utf-8?B?M3hTWC9mOUxSQ1M0cWtUV3I1SjhyVTZ2SStGUkVtb1ppakU2U1RxNnlNSklG?=
 =?utf-8?B?L3F2TlBrYVoyczRSUUx4ZGo2S2hDSWJIUURrSnplZ0tkaDUwNElZcFBDaUxu?=
 =?utf-8?B?TnhJZDM0THRQN0U3Y0w4VVNkLzYrQ2ZHc0NOWEdPaGpBSEhqN21YNmlIUllH?=
 =?utf-8?B?V3hvdCtZT3BWMmpKbGxRMDRQZElrSm1mTzlLZWdoMVJ0Wmd4WUV0Q3R6dXZI?=
 =?utf-8?B?Vy9udXF5NGJvNGJ3OU1ib0tHc2xDRWNqcitrOXVCOWVEdkVjZGJ1QXJ4RUV5?=
 =?utf-8?Q?DJvype+hLIqzfWIsWcF5alIHI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79233fd3-df4e-49c0-3fea-08db3bcf9260
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 03:31:30.5032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1WTuZOhtT3Iq46OkDg7atwB/lU6VTKa5nKUD1y1m0bm8XVDEn9pIG16n2o+tFYXxHxiOkaMr9FsQzqIRS8t6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9037
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers



On 4/12/2023 9:48 PM, Jason Wang wrote:
> On Wed, Apr 12, 2023 at 10:23 PM Parav Pandit <parav@nvidia.com> wrote:
>>
>>
>>
>>> From: Jason Wang <jasowang@redhat.com>
>>> Sent: Wednesday, April 12, 2023 2:15 AM
>>>
>>> On Wed, Apr 12, 2023 at 1:55 PM Parav Pandit <parav@nvidia.com> wrote:
>>>>
>>>>
>>>>
>>>>> From: Jason Wang <jasowang@redhat.com>
>>>>> Sent: Wednesday, April 12, 2023 1:38 AM
>>>>
>>>>>> Modern device says FEAETURE_1 must be offered and must be
>>>>>> negotiated by
>>>>> driver.
>>>>>> Legacy has Mac as RW area. (hypervisor can do it).
>>>>>> Reset flow is difference between the legacy and modern.
>>>>>
>>>>> Just to make sure we're at the same page. We're talking in the
>>>>> context of mediation. Without mediation, your proposal can't work.
>>>>>
>>>> Right.
>>>>
>>>>> So in this case, the guest driver is not talking with the device
>>>>> directly. Qemu needs to traps whatever it wants to achieve the
>>>>> mediation:
>>>>>
>>>> I prefer to avoid picking specific sw component here, but yes. QEMU can trap.
>>>>
>>>>> 1) It's perfectly fine that Qemu negotiated VERSION_1 but presented
>>>>> a mediated legacy device to guests.
>>>> Right but if VERSION_1 is negotiated, device will work as V_1 with 12B
>>> virtio_net_hdr.
>>>
>>> Shadow virtqueue could be used here. And we have much more issues without
>>> shadow virtqueue, more below.
>>>
>>>>
>>>>> 2) For MAC and Reset, Qemu can trap and do anything it wants.
>>>>>
>>>> The idea is not to poke in the fields even though such sw can.
>>>> MAC is RW in legacy.
>>>> Mac ia RO in 1.x.
>>>>
>>>> So QEMU cannot make RO register into RW.
>>>
>>> It can be done via using the control vq. Trap the MAC write and forward it via
>>> control virtqueue.
>>>
>> This proposal Is not implementing about vdpa mediator that requires far higher understanding in hypervisor.
> 
> It's not related to vDPA, it's about a common technology that is used
> in virtualization. You do a trap and emulate the status, why can't you
> do that for others?
> 
>> Such mediation works fine for vdpa and it is upto vdpa layer to do. Not relevant here.
>>
>>>>
>>>> The proposed solution in this series enables it and avoid per field sw
>>> interpretation and mediation in parsing values etc.
>>>
>>> I don't think it's possible. See the discussion about ORDER_PLATFORM and
>>> ACCESS_PLATFORM in previous threads.
>>>
>> I have read the previous thread.
>> Hypervisor will be limiting to those platforms where ORDER_PLATFORM is not needed.
> 
> So you introduce a bunch of new facilities that only work on some
> specific archs. This breaks the architecture independence of virtio
> since 1.0. 
The defined spec for PCI device does not work today for transitional 
device for virtualization. Only works in limited PF case.
Hence this update. More below.

> The root cause is legacy is not fit for hardware
> implementation, any kind of hardware that tries to offer legacy
> function will finally run into those corner cases which require extra
> interfaces which may finally end up with a (partial) duplication of
> the modern interface.
> 
I agree with you. We cannot change the legacy.
What is being added here it to enable legacy transport via MMIO or AQ 
and using notification region.

Will comment where you listed 3 options.

>> And this is a pci transitional device that uses the standard platform dma anyway so ACCESS_PLATFORM is not related.
> 
> So which type of transactions did this device use when it is used via
> legacy MMIO BAR? Translated request or not?
> 
Device uses the PCI transport level addresses configured because its a 
PCI device.

>> For example, a device may have implemented say only BAR2, and small portion of the BAR2 is pointing to legacy MMIO config registers.
> 
> We're discussing spec changes, not a specific implementation here. Why
> is the device can't use BAR0, do you see any restriction in the spec?
> 
No restriction.
Forcing it to use BAR0 is the restrictive method.
>> A mediator hypervisor sw will be able to read/write to it when BAR0 is exposed towards the guest VM as IOBAR 0.
> 
> So I don't think it can work:
> 
> 1) This is very dangerous unless the spec mandates the size (this is
> also tricky since page size varies among arches) for any
> BAR/capability which is not what virtio wants, the spec leave those
> flexibility to the implementation:
> 
> E.g
> 
> """
> The driver MUST accept a cap_len value which is larger than specified here.
> """
cap_len talks about length of the PCI capability structure as defined by 
the PCI spec. BAR length is located in the le32 length.

So new MMIO region can be of any size and anywhere in the BAR.

For LM BAR length and number should be same between two PCI VFs. But its 
orthogonal to this point. Such checks will be done anyway.

> 
> 2) A blocker for live migration (and compatibility), the hypervisor
> should not assume the size for any capability so for whatever case it
> should have a fallback for the case where the BAR can't be assigned.
> 
I agree that hypervisor should not assume.
for LM such compatibility checks will be done anyway.
So not a blocker, they should match on two sides is all needed.

> Let me summarize, we had three ways currently:
> 
> 1) legacy MMIO BAR via capability:
> 
> Pros:
> - allow some flexibility to place MMIO BAR other than 0
> Cons:
> - new device ID
Not needed as Michael suggest. Existing transitional or non transitional 
device can expose this optional capability and its attached MMIO region.

Spec changes are similar to #2.
> - non trivial spec changes which ends up of the tricky cases that
> tries to workaround legacy to fit for a hardware implementation
> - work only for the case of virtualization with the help of
> meditation, can't work for bare metal
For bare-metal PFs usually thin hypervisors are used that does very 
minimal setup. But I agree that bare-metal is relatively less important.

> - only work for some specific archs without SVQ
>
That is the legacy limitation that we don't worry about.

> 2) allow BAR0 to be MMIO for transitional device
> 
> Pros:
> - very minor change for the spec
Spec changes wise they are similar to #1.
> - work for virtualization (and it work even without dedicated
> mediation for some setups)
I am not aware where can it work without mediation. Do you know any 
specific kernel version where it actually works?

> - work for bare metal for some setups (without mediation)
> Cons:
> - only work for some specific archs without SVQ
> - BAR0 is required
> 
Both are not limitation as they are mainly coming from the legacy side 
of things.

> 3) modern device mediation for legacy
> 
> Pros:
> - no changes in the spec
> Cons:
> - require mediation layer in order to work in bare metal
> - require datapath mediation like SVQ to work for virtualization
> 
Spec change is still require for net and blk because modern device do 
not understand legacy, even with mediation layer.
FEATURE_1, RW cap via CVQ which is not really owned by the hypervisor.
A guest may be legacy or non legacy, so mediation shouldn't be always done.

> Compared to method 2) the only advantages of method 1) is the
> flexibility of BAR0 but it has too many disadvantages. If we only care
> about virtualization, modern devices are sufficient. Then why bother
> for that?

So that a single stack which doesn't always have the knowledge of which 
driver version is running is guest can utilize it. Otherwise 1.x also 
end up doing mediation when guest driver = 1.x and device = transitional 
PCI VF.

so (1) and (2) both are equivalent, one is more flexible, if you know 
more valid cases where BAR0 as MMIO can work as_is, such option is open.

We can draft the spec that MMIO BAR SHOULD be exposes in BAR0.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

