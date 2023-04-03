Return-Path: <virtio-dev-return-11918-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3594CC76196
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 17:29:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9617D42574
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 17:29:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8BFE59865A6
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 17:29:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7467698640A; Mon,  3 Apr 2023 17:29:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4D3829863E4;
	Mon,  3 Apr 2023 17:29:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtxZSbhJhQBIE/E6nziYfBTK27dtE9WcOdgF2lCgSPVqZP9HwRtpt10jzZRbelS4JvX2Aojjp03Sho0n+pI9lZ9IaaVWz3qn6jqhiSJjk5ZeRzc8gBETegfdgQGqEHWYMrxMFW1d1nYCSJcwqBGettNrh6XCG/zitpxq+DgtygjTT0kL9A8nrZv2m3DXCVC+jp9vOTDVEARomv/stPFovOXhAmlto7Fwc2Rj9KgUFvxWHcG771Jx7LX9UT8Q0nObm82VyfNn9R57yR+RaM9r3qTOwUwc3Ehrn/jq2VfC18yp9kB+5oxo3LM2nkZIzOvtmqSmmAMCtD5D1t+NWDmzEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mln6ky72Z0XFifuzvnva1IqAkAdc6HE3AuOaz16+34=;
 b=iY7+KxY1CQoIKvC++vuiDvobH9BXjt0I2I18x2WF3Z+UFXPgn7+ARAugGLt/0QPy+ZApRmhACKXwKE+trTsq71ZuL66EAV/HLUNLXLni4NfZ+w86bHtu7VQWseGjlUM3qZFDNTKt3cA8T6uDiLT21bi2jyUB+ecefmEASpNLIZTrLJNOwd+4V6RsU7OlNmFImiF6Av7EB2G3Pd1GYnxzqcjCv9+wR35V/iDg8bI+YXVSGttJqF8G4xmHJX0QJrgia8pMNT4x1EtZ934UPQadzjEkEyDwkdF/IS5MgGmvqJGjEai8hIgLjHJPDStBn4sza1jmRM3AbYlLNB0Rws5Jtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <24e5437e-d6bd-d65c-9ec2-699277a113a3@nvidia.com>
Date: Mon, 3 Apr 2023 13:29:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Shahaf Shuler <shahafs@nvidia.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230331024500-mutt-send-email-mst@kernel.org>
 <0dcd9907-4bb0-ef0d-678d-5bc8f0ded9ec@nvidia.com>
 <20230403105050-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D50080A3A7C5F81E3F62DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403110320-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EC65708410304D9C1EA3DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403111735-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813E4193BC32775BDB2019DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403130950-mutt-send-email-mst@kernel.org>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230403130950-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::10) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|DM6PR12MB4877:EE_
X-MS-Office365-Filtering-Correlation-Id: 008d2937-357c-4d8d-db96-08db3468fdf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l6CEsoUPsVg/pSXEHoB+MN3+LGCC4WEMnMkT4US1rm9W6V163n/Fql4A1AcEV+4fNxkOJFrWYRsh/h4x8SPj+XvmHOdPprm2JNv8aH6w/ofMaG+ore+yxlMIIxpRPpfZZEAY7iOFXJiKA9R1GEHjjiuDyWmavIsAoh5yndsl60qbPaF//AGH/T5heUs990cGETMhjYBaUo+X2vMu9LgwhLp+OpT5BhZ4KGDl562VJv102jIF5GwNFX7YogReUGAuVQQWGKXQ8iPq2RDVvi9zx0IFIM0tQg9g7GlSvHR7cIN6EyORJM44hs8WQ77QjPGMZoBWgASQ6R3Sa/wworE3r73cZjY0MBCodt2k0AW++RojLfEhqo3CjkneKJirt55h7kGPho7ci8M8PW0/SuAUf/bq+sglOzph5aJ+flIrgu3cKr48RXupzVCRDc8R9Tgva472JgcicrJhyk4spEhq5rfmoF8iq2zgZSiSwybfmZMZqYya8QT7DQu20wZimcDn2x9uO/8JAdyF1gVqZEHENc2sJL1qHybPTZIzBhwKjP7KQkjoPOYaNmZA8taIqXqKY9DOB1ZIIZCJxPPUWLAbHnTblayA+Sb2K+X2iWqeLNE1og9zAMV29R7L2J0sE9tLONWDaqxgUix0c5F8hlpMpA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(6916009)(66556008)(66946007)(66476007)(8676002)(478600001)(316002)(54906003)(8936002)(5660300002)(38100700002)(41300700001)(4326008)(53546011)(186003)(83380400001)(2616005)(6486002)(107886003)(6506007)(6512007)(26005)(86362001)(31696002)(2906002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHNMbXJ5aldiMElTamRkYmtXWmxnbXFpZHh1MEU3YnJxVnhDcThYN3dDaWxE?=
 =?utf-8?B?TzdnVnBiOEwzUENFcjFHdlVGcHV3V2ZydDdaRUlLamM1OTY2VStVdnhMNkt3?=
 =?utf-8?B?Rnl1bG9COEpVbFk3MURSUFJZRS96S2NUNmpabGRPTXRWVXJsRW1xWUtvMnFu?=
 =?utf-8?B?dHVaYmtwand1RThIRlQyaDZTendnbUlNK0pYZ2hUbnhEa0o0WjZSOWcxWktT?=
 =?utf-8?B?Z2ZtaUY0VDNrTU80KytDWXFGYmo0NjUrSi9ETkdBY1M1YUFFcmR6N0h2VFJy?=
 =?utf-8?B?L3JIVGVvSVZOYUdsQTdaREp5QVBLN3U3ODNUN3hqMFFsaWFKTWRGa0lsWFdQ?=
 =?utf-8?B?QWJEeDYvZjJHc3c5YUNVUjB3S3dvK2ZHOStiZVM2endJcHN1Qm5VcVFKMFJ5?=
 =?utf-8?B?ZzNBckxWOVNyeTVnbTZBOTQrZ3JqUkFEOVZ2MTE4SEdXMjBiT0RrRHNMRUUw?=
 =?utf-8?B?UTNHaDJtRXFseUd6UUYyNEhKK0F4a2xZeHVMMmJBc3JoMVg1bzJjS1MyR1Zv?=
 =?utf-8?B?c3ptN0I5UlZYbHU3THE5N3Y2VG15L0VhNnpSYU0wcVhlN2paejFseXJjcy9w?=
 =?utf-8?B?dlZ3TFFFMjlPOS8vNlE2UFhkMzVFV0RTRTF5TnVKNkZZYWducWJqbm9EMWNq?=
 =?utf-8?B?TXFzMGJUWXp5bVlDTm0zdGdENTBlQlQ0c0dwZEpjS2VYNk9mNmpGZVJRN1d5?=
 =?utf-8?B?UkNGdzE1TjVBaDZxSzNaU29PWFpLRk5PUGZqd0R6Nks2V0E5Z2FuYUJvQ3Bq?=
 =?utf-8?B?ZlZaWmt3NzRncTNZamhsRkQxclBwWmxqZFZ1T2hHREw3WEc2QnY5R0N5aVU4?=
 =?utf-8?B?N0hBNGJHeXBxVFlYNDJjNWx0T1E3VXkyT1N1aUZ1VllmT2Jvbmh1VFErSlpi?=
 =?utf-8?B?V2RzQVhXQ24wVEdQc2FUS3FPelZoWUtPRDJQOHp3bVVzbW82YUlxVFVXZ3B5?=
 =?utf-8?B?bWJkM0tuUjZsSWR0Z3hRcmdhNkswTDZPcWtNOEJYcEVhN0poU0ovWCtkbVo2?=
 =?utf-8?B?RTB0dEE5ZzNBeHdjUFBBZlVHRm0yeHpPNGJ3SWtsT3dzUFZNZ0d2dmVkdURq?=
 =?utf-8?B?YWhXOWFVTlhuU1dmRXh5Rkp3ZS9ObXNseFNtTnpzS1RLTEdtTmgzSFhLcnhx?=
 =?utf-8?B?MFVDK2xlMWtFYzYrdzhlb3F1M0ZVTHExN1l4OXFPcTZSc210MDFZellvQzg1?=
 =?utf-8?B?S3BwWnNvb0xRdis2bnJPcUpnWDhVK2NtQTVXdFRQWGZuaEFnTEtIYXhFaDRx?=
 =?utf-8?B?K0Y2eDQ4eWQyRjdwYTJPRmp5azViSmZqQURWVHN4Q01sQ1dFYXdqZDkxcUxv?=
 =?utf-8?B?T3dzWTVzRU4wQUNENUVielhDQ3pyQW9Gd2prUXd0S2tFZmlhMHhNcFgvQ2RD?=
 =?utf-8?B?cWJVdjVxZnhEdUtyRnpiMkNmK0dZUEgwWktjVm9iZnE0Z3ZqTk15OG5jZXdi?=
 =?utf-8?B?STJXdm5OMzRmcm5PeDZnMFNuMzlvMG1LT2tVeUJQNUZxSEowSmdmNHBHNzBn?=
 =?utf-8?B?b015VHdMaC9MNGZwaGR0ajlaTS9nWHRrK2xpaTNmSXdGa3RTUHJnWmk1QkhB?=
 =?utf-8?B?NXNxV0VTZWxmNzdLZ0owcXVHMEhCNVB4QTVtUGRpaXdoZVVpZUtMbjZWeGVG?=
 =?utf-8?B?TVMyTWI1SG51NUQ3U1NMUEh4d3Y5dWNkZ2VmTy9YREs0cHNuT0JCamp4UGRB?=
 =?utf-8?B?NkRzQnhjdi9NUXpYVHVuMkh6UjVUN29SU3o4TjZnV3Nmdmpzem5RSFlUbmRy?=
 =?utf-8?B?TzhUaXhLWlFZMFhCb0MvWkZSclRSZkhaM2F1bS9RNUdVY3FiZGRiMEpFQUFB?=
 =?utf-8?B?TzBNblQ4OGo4SDFMbWVOb3hqMStBRXdGcHdFNk5KQlAwOEZDcGszODdtV3VP?=
 =?utf-8?B?aDkrcDAvbE5JTktFbDlNRk0xMDgra1dsdzVad3dYOGp0NlF6OUxia2VyKzly?=
 =?utf-8?B?WDNSY3hRMmpvdVpCY1Y2QTUxckllb0xydmc1VHVVbjRxeUdDbUgvNTFFZW1O?=
 =?utf-8?B?T2FnTDk1VTh0S2hhc0lNVWxvY1F0M21ScTlYN3QycS9ZYStLaEQyQ1dzbDNl?=
 =?utf-8?B?OWJqbUpNM29HMVpEVnllQ3RRZzhBSzg0UGl2TlpDVDRuOUxUdHkzcWs5MzNv?=
 =?utf-8?Q?Us+zzYLNv9fncX76GLK3IkjqS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 008d2937-357c-4d8d-db96-08db3468fdf9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 17:29:34.6744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9sHeKfV+MqrWFW3RStv/p3KveMMkezfKXV17IfxuqpSLm+AemEPxJwsF8bQP6pdWf4A02cKd1SiOCp02ZIiVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4877
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 00/11] Introduce transitional mmr pci
 device



On 4/3/2023 1:16 PM, Michael S. Tsirkin wrote:
> On Mon, Apr 03, 2023 at 03:36:25PM +0000, Parav Pandit wrote:
>>
>>
>>> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
>>> open.org> On Behalf Of Michael S. Tsirkin
>>
>>>> Transport vq for legacy MMR purpose seems fine with its latency and DMA
>>> overheads.
>>>> Your question was about "scalability".
>>>> After your latest response, I am unclear what "scalability" means.
>>>> Do you mean saving the register space in the PCI device?
>>>
>>> yes that's how you used scalability in the past.
>>>
>> Ok. I am aligned.
>>   
>>>> If yes, than, no for legacy guests for scalability it is not required, because the
>>> legacy register is subset of 1.x.
>>>
>>> Weird.  what does guest being legacy have to do with a wish to save registers
>>> on the host hardware?
>> Because legacy has subset of the registers of 1.x. So no new registers additional expected on legacy side.
>>
>>> You don't have so many legacy guests as modern
>>> guests? Why?
>>>
>> This isn't true.
>>
>> There is a trade-off, upto certain N, MMR based register access is fine.
>> This is because 1.x is exposing super set of registers of legacy.
>> Beyond a certain point device will have difficulty in doing MMR for legacy and 1.x.
>> At that point, legacy over tvq can be better scale but with lot higher latency order of magnitude higher compare to MMR.
>> If tvq being the only transport for these registers access, it would hurt at lower scale too, due the primary nature of non_register access.
>> And scale is relative from device to device.
> 
> Wow! Why an order of magnitide?
> 
Because vqs involve DMA operations.
It is left to the device implementation to do it, but a generic wisdom 
is not implement such slow work in the data path engines.
So such register access vqs can/may be through firmware.
Hence it can involve a lot higher latency.

>>>>
>>>>>>> And presumably it can all be done in firmware ...
>>>>>>> Is there actual hardware that can't implement transport vq but
>>>>>>> is going to implement the mmr spec?
>>>>>>>
>>>>>> Nvidia and Marvell DPUs implement MMR spec.
>>>>>
>>>>> Hmm implement it in what sense exactly?
>>>>>
>>>> Do not follow the question.
>>>> The proposed series will be implemented as PCI SR-IOV devices using MMR
>>> spec.
>>>>
>>>>>> Transport VQ has very high latency and DMA overheads for 2 to 4
>>>>>> bytes
>>>>> read/write.
>>>>>
>>>>> How many of these 2 byte accesses trigger from a typical guest?
>>>>>
>>>> Mostly during the VM boot time. 20 to 40 registers read write access.
>>>
>>> That is not a lot! How long does a DMA operation take then?
>>>
>>>>>> And before discussing "why not that approach", lets finish
>>>>>> reviewing "this
>>>>> approach" first.
>>>>>
>>>>> That's a weird way to put it. We don't want so many ways to do
>>>>> legacy if we can help it.
>>>> Sure, so lets finish the review of current proposal details.
>>>> At the moment
>>>> a. I don't see any visible gain of transport VQ other than device reset part I
>>> explained.
>>>
>>> For example, we do not need a new range of device IDs and existing drivers can
>>> bind on the host.
>>>
>> So, unlikely due to already discussed limitation of feature negotiation.
>> Existing transitional driver would also look for an IOBAR being second limitation.
> 
> Some confusion here.
Yes.
> If you have a transitional driver you do not need a legacy device.
> 
IF I understood your thoughts split in two emails,

Your point was "we dont need new range of device IDs for transitional 
TVQ device because TVQ is new and its optional".

But this transitional TVQ device do not expose IOBAR expected by the 
existing transitional device, failing the driver load.

Your idea is not very clear.

> 
> 
>>>> b. it can be a way with high latency, DMA overheads on the virtqueue for
>>> read/writes for small access.
>>>
>>> numbers?
>> It depends on the implementation, but at minimum, writes and reads can pay order of magnitude higher in 10 msec range.
> 
> A single VQ roundtrip takes a minimum of 10 milliseconds? This is indeed
> completely unworkable for transport vq. Points:
> - even for memory mapped you have an access take 1 millisecond?
>    Extremely slow. Why?
> - Why is DMA 10x more expensive? I expect it to be 2x more expensive:
>    Normal read goes cpu -> device -> cpu, DMA does cpu -> device -> memory -> device -> cpu
> 
> Reason I am asking is because it is important for transport vq to have
> a workable design.
> 
> 
> But let me guess. Is there a chance that you are talking about an
> interrupt driven design? *That* is going to be slow though I don't think
> 10msec, more like 10usec. But I expect transport vq to typically
> work by (adaptive?) polling mostly avoiding interrupts.
> 
No. Interrupt latency is in usec range.
The major latency contributors in msec range can arise from the device side.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

