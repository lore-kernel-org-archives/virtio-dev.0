Return-Path: <virtio-dev-return-11936-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBD9C761AF
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:00:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 03DB72AC48
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:00:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EEBDE986583
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:00:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E38389843C6; Mon,  3 Apr 2023 22:00:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CF0579863E4;
	Mon,  3 Apr 2023 22:00:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T07m8+kZcJjTFa2muTGqhfHkrBwxHO5iaLscPTgGYqSv2Skjj2rHdkiIvueduttd9jrSo0PWaz1nb8eq75q4vm1/D9z0eQBbnB49lvApwJ8gQP7oihcgyiUnFxsQWnshlvPHbBIrhiRKwZF9wlB5CmJnQVAroq4kughm/+RwdqmF/k+8NSrDfreS80pMqrgmXTNYHb6N7XFqkCSAeU1k92UVZP/RZpVS3tnCgctMkvgF1dz0PISPiYURT9imq1reb3jK5/p+AOc5KSi+NKn1tFV+fD2OAzF3Chae/VGQT6DJtmU5Y485dVV/XMXPAYE6933raVJiq+MNz+/yTDtMzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51I7HMh/fawRvfqFBjrE4qyo8fm3sQTR0jWkhOFmZ0k=;
 b=U5JuyUFJ8a+iHi3gJx7MUqkeMfW5SlnGlF6hIMc5miSGT0egx+KiohrPwDwwXTGyUpjBkPeWl7ULsswBk1GVvMGoOoTFY/L3uBaYXJv7ofx5F2rJ92JxmtONPrYLEb5/cfum0e9GGtApGbQe0bdm3voMnYnjvzji6fLHmd3QyDfuSwu1hzVJyrr2e/TsRh70/QF1Yzp8HLN7KeaPToGyqdyaoYwZ9eyHJPlH5+u0Tyg7OGrWNknF4jp8DK771iyBIu0KJi/QWoCO9Nas0duuK6Q+9MhuffnYAJBVNBnnyfYcHRrQ+c5GQVcKlyAdiDx/sy2mL1qLkL5aOHNveh3r2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <25d15176-042a-f579-0b59-d08f7eb7eafb@nvidia.com>
Date: Mon, 3 Apr 2023 18:00:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Shahaf Shuler <shahafs@nvidia.com>
References: <20230403105050-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D50080A3A7C5F81E3F62DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403110320-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EC65708410304D9C1EA3DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403111735-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813E4193BC32775BDB2019DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403130950-mutt-send-email-mst@kernel.org>
 <24e5437e-d6bd-d65c-9ec2-699277a113a3@nvidia.com>
 <20230403135446-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815AFE1FE7E1D2AAABBAF4DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403163730-mutt-send-email-mst@kernel.org>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230403163730-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0049.namprd04.prod.outlook.com
 (2603:10b6:806:120::24) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|MN0PR12MB6053:EE_
X-MS-Office365-Filtering-Correlation-Id: 203caded-bb5a-435a-2b2b-08db348ecf3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bIYo/Al2IWDORLu3M+n4CP6XnUm6BfsY/pi1oPFU1Hpe4OkLytDfVq0KFH634zr9Wy+S3NYmHcna+h+ed6nqBup2QpzrTe+OenIKyKLjL+nUWED9mA9B9PRHOOE62PXExbMfNP58c/GpcBG3xUoDKQ0zQh8ZnuNQfNesDR9qJsAPHJciiRtmSUoM1d+4qkqm4Qz7TrcdwL2oQAkGYrkt4ashc/yALh2U6oPrWkCzRv6/UMu8CCTSmAqb+RFLwLzSBkDiZoEGHO7JharjrZ/szreb5zElUzIhknpdTwIcEZ1JVwlhrQ02WInepvoDDO1/CFf+j5kEWAjMCDjyb/KmF8hAxpiNviIYMRLSpn5mFyKMK1YPAfTJn4M/El3AfMh3HuIPgh/L/XPYCrAQw9XiqeRNx7T1ROvdrX0R2eKsU5ua0G19eSuuq7rSJI1WL6WuV1RPlQ+EhebY3SXuFgspOUIX+UNkTGPCtg5hQyYGTAInyyNllliwmBZQHi8RYMTiXHs0LBdBy99hhJdpVzQmG7sYQbgUlPMu/LQWE5ZwI8wX7h18snW9LMWdqt74CsIEsuhO16FNQvCuuDwgH71Hh70b40G1Vtl9NU02q+iqk5rDcc9XPx6qrgx0RbUEfnPFbnrFLnsg3oTtNBTViQeOTg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199021)(31696002)(86362001)(2906002)(36756003)(31686004)(53546011)(2616005)(186003)(83380400001)(26005)(6666004)(6486002)(107886003)(6512007)(6506007)(66476007)(66946007)(66556008)(478600001)(8676002)(6916009)(41300700001)(5660300002)(38100700002)(316002)(54906003)(4326008)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REtvdElmaXRIeFpBY1BuSVl0OEx1YjltS3gwWHkzZC90dm1mN3pMWEJCRWN5?=
 =?utf-8?B?Sk5kM1Q4RE1lTnhiYnBiMm9xR3dkR0xkZk5OelNnU21jM2tHMzdYT0tINGNT?=
 =?utf-8?B?TjYyNXNNc1hFUnBJSjh0bGUzMjJKNHFiVDZlUDVQUVJSa2JZNGdLVFBpSkUz?=
 =?utf-8?B?SVRzV0swN0YxMXd0aFl1MTUreVVLd0dYa0gzb1hGQU5oWEtRQlk5S2NUQ3ZB?=
 =?utf-8?B?bmZKYUttRmVpNlFrakY0cXJ3N0xVbXhVVW8zdnR3S29PZUFvaVExODF0c0dL?=
 =?utf-8?B?QUtFSHNvZXZna1pna0Rxcm5EcVZjR1dkbnBqM1RmNWs1Nzg0UXdJZXlPUUlp?=
 =?utf-8?B?U2ZwNGhOTWZYbm52U3ZQZVVnY24zOE1pYms4eHAzUlcwTlBRVFJpckJ5eUt4?=
 =?utf-8?B?UFdBanVHWWpwYjBpbnVBK3c3dU1RL3hlT3QvT2xrZ1ppY0tsRHJuYWpRd1hu?=
 =?utf-8?B?UFVGL0xFY2tlOTJGN1pwcFNqb2J0V1RtNDY5cURwMmdmRGNrRjVyNjF3L09w?=
 =?utf-8?B?VmhVYTkySXphdFhrT0Vybnp1WnBiZEc5WEpxckYvY2hOUDRLemhMZUljYzVH?=
 =?utf-8?B?WktTbHRWdmFIdHZBZWtQZExqejlSUTd3Q1BoVVVac1UvZlpCb2s4eGZJQXRa?=
 =?utf-8?B?cTIzWHRpdnFzbmROWFJmWTlYbEpEcWVudndaT0RpS0VqSTdNR1JvMmhHMUNQ?=
 =?utf-8?B?NDd4dnRBTTQvVU5XUkFHWUd2c3lHM3Iwb2hOWUh0L1JCcjNmalpNTDBRQ0tC?=
 =?utf-8?B?RlhjYmxDQndQZ1htZDY5ZkJlL1JBeUdLb1d2bU5oZDU5blFQWmJBZ1NFM2lC?=
 =?utf-8?B?QXBrVE5ORE04bWwwQVJibGpSN3VSQWpSelVqZVhJU0d2M1BkS0RzQXg0NHFI?=
 =?utf-8?B?U25UbGJkNndneGZ3WDMreGxRZ2t0amtyb2lOV21oOCtGQnhJRE9DV000MjJZ?=
 =?utf-8?B?MzlubTU0bWljbUJLZTNvMjVTM1E5RHlvc3M5ZWNXMmkxNndGZjFTNUJaYXoy?=
 =?utf-8?B?Z3ZYYWtBV01IVGZ0dnBOWHFCUEhHUTlRZzhodzBNdXB0eVhjdlBpUElZZThp?=
 =?utf-8?B?eDVJNTJoRlNCNTg0TnZRNkxCS0E1em5MNGxvMUJBcCtmMGREWm0zVEkzNDNr?=
 =?utf-8?B?UEVhYWUyVElOV09ZaGlOUGkzUWJ6N0NNV2s5ZEZjNEZQK09LZE5pTU5pOXVP?=
 =?utf-8?B?Wmd5V3UrUTRpQWtzNk1YbFhlR0dxcEpoM3dsYkJ6djdidksycGlPZ2tVRHlP?=
 =?utf-8?B?M29qQ0svaFpLVW9pV1pmajdaTkpwNjVOYmJvQW9lRXRmbG1CWDlYQjdUbUVC?=
 =?utf-8?B?emxGSFRyYXNFVEZOV1RhRVpJMEpiTXZtQVBWSy9oR1VlbWVOeVV5Vk01dVFI?=
 =?utf-8?B?OXpPSkJoeUUrY3gwMktEUjN2azFaWEZFbGdOWmdmUmpaczMwc1JzOWd0UmVV?=
 =?utf-8?B?Y3UxbFUweFVjWFk0Ukc0dmp2YStXT0J6ME5PMWJtMFBzQ2lDUjdrSk1sbGJM?=
 =?utf-8?B?Q0RHWlIrRk1DS05kRnEyRTA3UGZ3VTcyWGM3L2dNS1BhelRPbDFlMW50dzl2?=
 =?utf-8?B?YnZ5MnZCRE1lOENJT3JSODkrQUFNemRDOE95K3lVMEtabXR0M2pXUEFrMnpS?=
 =?utf-8?B?SEYxSXdwNUxjMjdBWmI2bGJjWEFtbTNkMWVxKzNrS0ZNVnlkc21EdXJSd2Vi?=
 =?utf-8?B?YXZKWFp2S2d1QThrejc1MnRzNGphVU5DV2lJbnViZytuanB6eERKNUJ1OG5T?=
 =?utf-8?B?NXAzcE9MclkvRllOYytqN1doOHRoTTlYckc3MEVEQno5OERPamFWc3VkVk9r?=
 =?utf-8?B?T1pGQVFZZnhVVXR3SmpQZkRCVTRhOGxjWC9aTmJDL3JwNVd0dVN1WnRKOG81?=
 =?utf-8?B?UklnY2pPZnROcHhsS1pzZ0NFT2h1L3NKTUZBRWNtTXIzUmtiNktwWW8xQ2Nz?=
 =?utf-8?B?RXJRaGMxMTMrYklwUnBCK2wzYjVSUXF0Ym1hMUpsTUwxSlRvVWVudlI2L3BT?=
 =?utf-8?B?aGpwcmJVMW02VW5uL0l3OVcrNjZTZTZWUDVnM3FpNnplcGI2QW5wb04xb3do?=
 =?utf-8?B?Wk10bitFWVo1QStxZ1ROY21JenZnV1dJL3VOSUlZSGNUb3k5MmppRUtQRnRi?=
 =?utf-8?Q?jZjwv2UmdYmNmqPHJXue4Zjic?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 203caded-bb5a-435a-2b2b-08db348ecf3b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 22:00:17.1962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rln24e9ENG+1fe983CpVECxcEPG5d8uMmwRHIZj3lD8Basz1vYCqFgbozwFl6QYGhTpdVLEqW8FY9atOA8FJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6053
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 00/11] Introduce transitional mmr pci
 device



On 4/3/2023 5:04 PM, Michael S. Tsirkin wrote:
> On Mon, Apr 03, 2023 at 08:25:02PM +0000, Parav Pandit wrote:
>>
>>> From: Michael S. Tsirkin <mst@redhat.com>
>>> Sent: Monday, April 3, 2023 2:02 PM
>>
>>>> Because vqs involve DMA operations.
>>>> It is left to the device implementation to do it, but a generic wisdom
>>>> is not implement such slow work in the data path engines.
>>>> So such register access vqs can/may be through firmware.
>>>> Hence it can involve a lot higher latency.
>>>
>>> Then that wisdom is wrong? tens of microseconds is not workable even for
>>> ethtool operations, you are killing boot time.
>>>
>> Huh.
>> What ethtool latencies have you experienced? Number?
> 
> I know an order of tens of eth calls happens during boot.
> If as you said each takes tens of ms then we are talking close to a second.
> That is measureable.
I said it can take, doesn't have to be always same for all the commands.
Better to work with real numbers. :)

Let me take an example to walk through.

If a cvq or aq command takes 0.5msec, total of 100 such commands will 
take 50msec.

Once a while if two of commands say take 5msec, will result in 50 -> 60 
msec.


> OK then. Then if it is a dead end then it looks weird to add a whole new
> config space as memory mapped.
> 
I am aligned with you to not add any new register as memory mapped for 1.x.
Or access through device own's tvq is fine if such q can be initialized 
before during device reset (init) phase.

I explained that legacy registers are sub-set of existing 1.x.
They should not consume extra memory.

Lets walk through the merits and negatives of both to conclude.

>>> Let me try again.

> If hardware vendors do not want to bear the costs of registers then they
> will not implement devices with registers, and then the whole thing will
> become yet another legacy thing we need to support. If legacy emulation
> without IO is useful, then can we not find a way to do it that will
> survive the test of time?
legacy_register_transport_vq for VF can be a option, but not for PF 
emulation.
More below.

> 
>> Again, I want to emphasize that register read/write over tvq has merits with trade-off.
>> And so the mmr has merits with trade-off too.
>>
>> Better to list them and proceed forward.
>>
>> Method-1: VF's register read/write via PF based transport VQ
>> Pros:
>> a. Light weight registers implementation in device for new memory region window
> 
> Is that all? I mentioned more.
> 
b. device reset is more optimal with transport VQ
c. a hypervisor may want to check (but not necessary) register content
d. Some unknown guest VM driver which modifies mac address and still 
expect atomicity can benefit if hypervisor wants to do extra checks

>> Cons:
>> a. Higher DMA read/write latency
>> b. Device requires synchronization between non legacy memory mapped registers and legacy regs access via tvq
> 
> Same as a separate mmemory bar really.  Just don't do it. Either access
> legacy or non legacy.
> 
It is really not same to treat them equally as tvq encapsulation is 
different, and hw wouldn't prefer to treat them equally like regular 
memory writes.

Transitional device exposed by hypervisor contains both legacy I/O bar 
and also the memory mapped registers. So a guest vm can access both.

>> c. Can only work with the VF. Cannot work for thin hypervisor, which can map transitional PF to bare metal OS
>> (also listed in cover letter)
> 
> Is that a significant limitation? Why?
It is a functional limitation for the PF, as PF has no parent.
and PF can also utilize memory BAR.

> 
>> Method-2: VF's register read/write via MMR (current proposal)
>> Pros:
>> a. Device utilizes the same legacy and non-legacy registers.
> 
>> b. an order of magnitude lower latency due to avoidance of DMA on register accesses
>> (Important but not critical)
> 
> And no cons? Even if you could not see them yourself did I fail to express myself to such
> an extent?
> 
Method-1 pros covered the advantage of it over method-2, but yes worth 
to list here for completeness.

Cons:
requires creating new memory region window in the device for 
configuration access

>>>> No. Interrupt latency is in usec range.
>>>> The major latency contributors in msec range can arise from the device side.
>>>
>>> So you are saying there are devices out there already with this MMR hack
>>> baked in, and in hardware not firmware, so it works reasonably?
>> It is better to not assert a solution a "hack",
> 
> Sorry if that sounded offensive.  a hack is not necessary a bad thing.
> It's a quick solution to a very local problem, though.
> 
It is a solution because device can do at near to zero extra memory for 
existing registers.
Anyways, we have better technical details to resolve. :)
Lets focus on it.

> Yes motivation is one of the things I'm trying to work out here.
> It does however not help that it's an 11 patch strong patchset
> adding 500 lines of text for what is supposedly a small change.
> 
Many of the patches are rework and incorrect to attribute to the 
specific feature.

Like others it could have been one giant patch... but we see value in 
smaller patches..

Using tvq is even bigger change than this. So we shouldn't be afraid of 
making transitional device actually work using it with larger spec patch.

>> Regarding tvq, I have some idea on how to improve the register read/writes so that its optimal for devices to implement.
> 
> Sounds useful, and maybe if tvq addresses legacy need then focus on
> that?
> 

tvq specific for legacy register access make sense.
Some generic tvq is abstract and dont see any relation here.

So better to name it as legacy_reg_transport_vq (lrt_vq).

How about having below format?

/* Format of 16B descriptors for lrt_vq
  * lrt_vq = legacy register tranport vq.
  */
struct legacy_reg_req_vf {
	union {
		struct {
			le32 reg_wr_data;
			le32 reserved;
		} write;
		struct {
			le64 reg_read_addr;
		};
	};
	le8 rd_wr : 1;	/* rd=0, wr=1 */
	le8 reg_byte_offset : 7;
	le8 req_tag;	/* unique request tag on this vq */
	le16 vf_num;

	le16 flags; /* new flag below */
         le16 next;
};

#define VIRTQ_DESC_F_Q_DEFINED 8
/* Content of the VQ descriptor other than flags field is VQ
  * specific and defined by the VQ type.
  */

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

