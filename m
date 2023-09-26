Return-Path: <virtio-dev-return-13969-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAAFE7E637
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 13:46:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 64A21157F15
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 13:46:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 526579864C6
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 13:46:48 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 427BD98640A; Tue, 26 Sep 2023 13:46:48 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2D7569863A6;
	Tue, 26 Sep 2023 13:46:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbIO1OCMwNNUSFplDSAA5pGCE076Fct28MZje9Ye+xrSx+2fYY/PZ0GZwXDEQwDkMqPIHB6lyqS8k9hSnFhMU79JJEM0qn8eqlly4pikTbcXDcEZbofuF8E0rMiWiYCVhk6I1cE/ve70dJVIu/PmL4TjP0DM4VA00RSy8+j5ZDdjid7XF17JdHQwQF/9Ed2ZowPArCA7cC937Y95ZU3VS2rDIsIAa+xu70mE/5iY4SYj2PAEJHFFop4MOGE1xdv/hsbKgLDiLdYwaKHF4ab6J09UiFJ16I+MhilisZ/18Y/zOjzbnEIeEgklrz2AbeIO6oJBSsXfnu7RBaS2zeEy4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTer7vDfg78g3Z5uaP5JsqfBVMdSVTo7ejuoD0OpSF4=;
 b=BzGoVm/zMau//LsatQD6DSdQDXfdD7LWXbjFahNutJioDz2iL/nFpYYu2cV47B82at//vlCL3ilSwMF6qMio5GRIqMoJC05wEUp5DkviErxSAh6Azg7AR9bIz0MlXJogv8I89Olv5ineo0rYG84CXZNTIB25AeBXrm0dEflBT4EBORMP7bAATO5rDe/oPF/O0GTCDtLLnFuZ1z2DifNb212WTzfAPuLgn8hwbEiJn9OANn1X6e8ZFLRaRa+pCDMI4xGMNqgP1cqH2DpK1GaweUZKMj9YK3oufcV1523qWWDXSMh8OFeBCHQNSYzLXZboH2E/vDQq9u587ZFqxUYN4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Message-ID: <a9de0110-99f4-bd32-53c7-0a4f3309822e@amd.com>
Date: Tue, 26 Sep 2023 19:16:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, jeshwanthkumar.nk@amd.com,
 Devaraj.Rangasamy@amd.com, Mythri.Pandeshwarakrishna@amd.com,
 Nimesh.Easow@amd.com, babulu.ellune@amd.com,
 virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
 Arnd Bergmann <arnd.bergmann@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
References: <80a2e4337affb043909c348395fb45aeeb693dc7.1695640593.git.JESHWANTHKUMAR.NK@amd.com>
 <904049f9-3ddf-7e88-c6f3-785a29a08210@linaro.org>
 <CAHUa44GzHPkntr=sFYYzokW0=9CCN7n6Ch1i6J7L7Uhh5U5P3A@mail.gmail.com>
 <CAFA6WYOsPhFkyrG0P7B6Ec=AnDvoUaerLocM89KtmybLmKbsaw@mail.gmail.com>
 <b15e849c-f424-1afb-4b99-ae2df954a044@amd.com>
 <CAFA6WYNMJ_njp95+AUu-p6H2wat+GCxntNX+WddKpufM4AVVYw@mail.gmail.com>
 <70848d35-6288-24d4-e4dc-01ca7e4e180a@amd.com>
 <CAFA6WYNPRzaa=5HDpqN191KN8bQv1nCF6gXo4RPSG0SZ55WOVA@mail.gmail.com>
From: Rijo Thomas <Rijo-john.Thomas@amd.com>
In-Reply-To: <CAFA6WYNPRzaa=5HDpqN191KN8bQv1nCF6gXo4RPSG0SZ55WOVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::18) To CH0PR12MB5346.namprd12.prod.outlook.com
 (2603:10b6:610:d5::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5346:EE_|CY8PR12MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: 002fa6a6-fa52-476e-513d-08dbbe970411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CBXhEI7+/xVWZFv401YbpUSdBAqnNfA3NZPns18IZHDwcu2/6y8VSZj3/vUnOo6muDBoekoy+uJ91pdpTJmE99rgK/jFYYghZ0Cfeerrlbz8/s+1lbhfx37P9UKjUzy2ycyaGMT19RBBwmlqHy5/yVJt0WlnqhiMSC4xrm7sxkhkGIyh7oWM0QhXeVzXrsSyg64ZZgm13njkEldyMhfwSu5kxywORU5Mp6itSchjTNei05CLIA3OdhloiGIfgyhSGt5IEN+cQsz9Y0hXIiXL+1+OBj4A4gBrJn5G3qrmlWz5CRBh3Lye6O7diGOUZcTsk75mx/7ezZ8IHV/AXjDXyAQH1geifnlbL6zvaFgm5fVSjM3kMOJxuXLNdNBf1x8SKfg46ZTaQqBpjW9v1Hew+JQIAqYPKChWPs+yN6ebrEZpOfMdx6v6bUCio/L8ZgrIjO/yjIeL4QKbDY75rpxlQd8yYrY9zqldBGV5GdO4atH1SYY/KOmYZyfh/srxbXhG+9Eszidcln72BPq7CXwfEszdT2fUZcAoGhRlDsrfrAAxJXky0ZKlaizyyZKDpFu7ZnWba1eJgF/O7EJQYGvFiykhDXxuPOKnKpu2zRrTwJjh816/dVzFtnLDYRbUp3jbJmlxHrRqYrOq2fC6neoMPg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5346.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(31686004)(53546011)(6486002)(6506007)(6666004)(8936002)(31696002)(86362001)(36756003)(41300700001)(38100700002)(2906002)(6512007)(83380400001)(478600001)(2616005)(5660300002)(6916009)(4326008)(316002)(8676002)(66476007)(54906003)(66946007)(26005)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGZldmZkRlljYU95Mlk2SjNWazdjbCtsTzhPQ1RxdldhODdBNVR0SThBeVV4?=
 =?utf-8?B?ZHNNdkV3WlhQQ3V4TmxGaTZBSDhvcUFEc0txRVBvUlJabGg0ZTdxQjZ3TlRx?=
 =?utf-8?B?UUR3VzBZZ2RqbkFEZHAvTGNTaHphYkFlVyswcUxNSUwvbVd6amtHTklCbDJm?=
 =?utf-8?B?dUdjS2k2T0liN2VwVCs0MVRpN3JMa2F0TkpnMlZBTDFPa1VjN2JRZzZadUJR?=
 =?utf-8?B?OWp2b2tWbHJPYXRYeVAyWUx5L01Nek5mZUg1bk1iMC94MXFoYWtwYlVKUkxz?=
 =?utf-8?B?YitBL3NYc3JtaGpOMGluZ2IyS3MrcGg0c0pMZWpMSFUyVVl2TTZIL0x2STF4?=
 =?utf-8?B?VjNVMVI0Vys1TWNnSnhyODJkM3lVSnVaaHVWaG5Kcm5UZkdiMmpVK2dSaEdu?=
 =?utf-8?B?ME90MGhrN3pic0RKVkVqc0RMeFpVMjdLRmd3UUQ5Ris3ZUpnYVFFTVNtL2pp?=
 =?utf-8?B?bFhiTWgvWHRwa29kQ2p1OFdkekFiNHFLUnpMS0RKcjZvc1hkTzBhM0RhQUQ1?=
 =?utf-8?B?aVdPOGF1SjdNNHlROW05Y05EbzNsSWdEWmVpbzJGS09sSFNvREdFSVhDQ1Yx?=
 =?utf-8?B?cHdXMzBmcVNKVE1TclFtK2dJSkM5UldTeXF4RkZCTGcwbDFhdzdVR3dOblZS?=
 =?utf-8?B?dklCSDJLWnUrcU9PQlpyOWZzNklHRUxDT0JkRkNNenZQV1pPdzN2aFE5VUJD?=
 =?utf-8?B?NWQyanpUYVhHZUZZV1RWVFI3d2lobEZuQjhVZitVN3I1c1VDL0ROVUpvM3pm?=
 =?utf-8?B?cUFJUm9iODI1dWVnR1lURWxnQTVQOE5JZUtoc0tpNW5SbFhRQ1FkWVpwSTh2?=
 =?utf-8?B?ZDRiSTZLYXJKMXJrUlJzMlZhWFhHSDB2azFtY2V1M1YzOTdWY1Y5c3RPOUk5?=
 =?utf-8?B?TEZiQmVybENUMmJRdnp3OEYzeUw4RG9keHhwWnZnRmtJUFFkVHhoYWs0VTEr?=
 =?utf-8?B?SlF3bGtyeFJ0RCtoa3N3L3VkZ0d3RE1YUmZkQWl2QXUwajJRVS83WG5WQ1Zj?=
 =?utf-8?B?dWh2dm9JQ2xVOXIrNy9mb2ZTVVc1Q25nQk5TUVMvQW11SitSNVB4b1MreDc4?=
 =?utf-8?B?OUhaczdKdDhCeXJSY1I1TFFMYUVqL1BMUHp0OU5ZZEJ5SHQ5TmhHaHpXT2RZ?=
 =?utf-8?B?bThIalhEUFVtUTBmaGZIV3hDMTA3eExhR3JUNTJsMHhObEZRbFNWbFNZbWg4?=
 =?utf-8?B?ZHozeXJGLzYwVGJQUGV1a3ZRbVRma3E5aDZ5WnRWWTZVZzBZbE54WTNObExR?=
 =?utf-8?B?SFF3eDM5bnhHRExCU2FwZldVRkdlUWpDNEJUaXJrQjVZVmpQb0FNUlRLTk1G?=
 =?utf-8?B?NjZBc3I4NmRRd3cxdEZqblFQenNkb0NXZ2k5SW1VMmJzTlF3WEJWTTd4bEtv?=
 =?utf-8?B?aXloSi9GZU5IRG1qZ3dZN2hFQmFscTZmaTI4bmJ5Y1poMENHam5PT0k3YmMv?=
 =?utf-8?B?eHBVR1ZqU3hEWjJUZ2pPN0dyOFRpVklNTm9xejV1SysyRjZBOHFJYyttKzBu?=
 =?utf-8?B?WGdCT08zSThLYTI5NGJGVXYwdE5OMnJkUWdWQmtUekkwbUZPQXE2VXQzanky?=
 =?utf-8?B?WEVISU91Z2hxS3drbGVLWTdGcjgyUEo0YVFoTTFVMitMVGNTUm5SVlRRcGJ1?=
 =?utf-8?B?bkZBOVNKWTlZZi9odHh4OHkxdWkzc1FwNW9VWlBJM2IzdUFlcklQR0FuUGNZ?=
 =?utf-8?B?empRclRZbThRc2lyTVNPN0UvMW5KVXlNZnlwTEN3QWVZZi8vcDY4bmRYQ1BR?=
 =?utf-8?B?N29HanZWd3FCR0g3SGlSNmxGV0JtRVVoS1NqaHh4Um1EQTZZaU5OSzhyWTdQ?=
 =?utf-8?B?a1dtNFVIZFFxaUJNWEl1OUljejd5NzBDM0dJTUhHQkJMV2l3bGhBWlJReE1n?=
 =?utf-8?B?ZVUrMk5qRnB5TEJaYThucTlqRnVTRHhudUFDOXk5ek8vYUJSeW9qanJtWGtJ?=
 =?utf-8?B?Ri8zeklhTStqNDRPV053a09pYlRkL3h6NEZNaVZUeHU5YlM0QUVMbktZdTVl?=
 =?utf-8?B?d1pMK0R2ZUd5ZEkyZTNCeXZFMzdCM0ZEUVI4czZxZEZyeXBlUGV6eE56YXUr?=
 =?utf-8?B?WkRxZ1daT09admtrbkZtZEVzWFNodWZ4NHdqOGVNdkd0anNBZXNpeE02MEIw?=
 =?utf-8?Q?eDpD4CmYKu6LO3LFujKZWR5d1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 002fa6a6-fa52-476e-513d-08dbbe970411
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5346.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 13:46:42.5509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gp8kdGlLkEsw1IpBo158SVoHLXT4SQOSxO/9tTiX9FCpt1fTIosRbgecCt+iTI4PM5+4GHZh+IvFGIqvVXMm1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7435
Subject: Re: [virtio-dev] [PATCH v2] virtio-tee: Reserve device ID 46 for TEE
 device



On 9/26/2023 6:02 PM, Sumit Garg wrote:
> +cc OP-TEE ML
> 
> On Tue, 26 Sept 2023 at 13:47, Rijo Thomas <Rijo-john.Thomas@amd.com> wrote:
>>
>> On 9/26/2023 1:19 PM, Sumit Garg wrote:
>>> On Tue, 26 Sept 2023 at 12:53, Rijo Thomas <Rijo-john.Thomas@amd.com> wrote:
>>>>
>>>> On 9/26/2023 12:14 PM, Sumit Garg wrote:
>>>>> +cc Alex
>>>>>
>>>>> On Tue, 26 Sept 2023 at 08:16, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> [+cc Arnd]
>>>>>>
>>>>>> On Tue, Sep 26, 2023 at 8:00 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>>>>>>>
>>>>>>> +cc Jens
>>>>>>>
>>>>>>>> In a virtual environment, an application running in guest VM may want
>>>>>>>> to delegate security sensitive tasks to a Trusted Application (TA)
>>>>>>>> running within a Trusted Execution Environment (TEE). A TEE is a trusted
>>>>>>>> OS running in some secure environment, for example, TrustZone on ARM
>>>>>>>> CPUs, or a separate secure co-processor etc.
>>>>>>>
>>>>>>> I have been exploring this area quite recently with an effort to have a common VIRIO interface which can support different trusted OS implementations. I guess you intend to test it with AMD-TEE, right? Any plans to test it with OP-TEE? As currently we have these two supported upstream.
>>>>>>>
>>>> Yes, we have tested with AMD-TEE. We have not yet tested with OP-TEE. Sure, we will try it out.
>>>
>>> Glad to hear that. I can help get it tested with OP-TEE as well.
>>>
>>
>> We will test it out internally. Shall let you know in case we need help.
>>
>>>>
>>>>>>> Do you currently have any virtio frontend/backend implementations for this?
>>>>>>>
>>>>
>>>> Yes, we have. Frontend is a Linux virtio-TEE driver, and backend is virtio-TEE device emulated in QEMU.
>>>> We used the Xen hypervisor.
>>>
>>> Can you share corresponding references? I can give it a try using Qemu with KVM.
>>>
>>
>> We will share it in next couple of weeks. We have not yet hosted the code for external consumption.
>>
>>>>
>>>>>>>>
>>>>>>>> A virtual TEE device emulates a TEE within a guest VM. Such a virtual
>>>>>>>> TEE device supports multiple operations such as:
>>>>>>>>
>>>>>>>> VIRTIO_TEE_CMD_OPEN_DEVICE – Open a communication channel with virtio
>>>>>>>>                              TEE device.
>>>>>>>> VIRTIO_TEE_CMD_CLOSE_DEVICE – Close communication channel with virtio
>>>>>>>>                               TEE device.
>>>>>>>> VIRTIO_TEE_CMD_GET_VERSION – Get version of virtio TEE.
>>>>>>>> VIRTIO_TEE_CMD_OPEN_SESSION – Open a session to communicate with
>>>>>>>>                               trusted application running in TEE.
>>>>>>>> VIRTIO_TEE_CMD_CLOSE_SESSION – Close a session to end communication
>>>>>>>>                                with trusted application running in TEE.
>>>>>>>> VIRTIO_TEE_CMD_INVOKE_FUNC – Invoke a command or function in trusted
>>>>>>>>                              application running in TEE.
>>>>>>>> VIRTIO_TEE_CMD_CANCEL_REQ – Cancel an ongoing command within TEE.
>>>>>>>>
>>>>>>>
>>>>>>> How about shared memory support? We would like to register guest pages with the trusted OS.
>>>> We have a command VIRTIO_TEE_CMD_REGISTER_MEM for registering shared memory buffer with Trusted OS.
>>>
>>> I suppose the commit message has to be appended then. Do you have the
>>> draft virtio-tee device specification ready for review? I would be
>>> interested to review that.
>>>
>>
>> Yes, the command is missed out in the commit message.
> 
> With the commit message updated to include support for shared memory,
> feel free to add:
> 
> Acked-by: Sumit Garg <sumit.garg@linaro.org>
> 

Okay. I have asked Jeshwanth to post a revised patch with updated commit message.

>>
>> We are in the process of preparing virtio-tee device specification. We will be sending it out to this
>> list.
> 
> I would also suggest you to CC: op-tee@lists.trustedfirmware.org for review.
> 

Okay.

Thanks,
Rijo

>>
>>>>
>>>> In this command, the guest pages are copied into a shadow buffer in the host OS. And this shadow
>>>> buffer is mapped with Trusted OS. So, buffer-copy is involved.
>>>>
>>>> One limitation, that we had was that the guest pages were non-contiguous. So, the number of physical
>>>> pages that had to be mapped with Trusted OS was exceeding 64 entries when we were testing out the
>>>> registering of guest pages. AMD-TEE Trusted OS can map a physically non-contiguous buffer, but the
>>>> number of sg entries for such a buffer must be less than 64. So, we resorted to using a shadow buffer
>>>> that is allocated within host, and gets mapped with Trusted OS.
>>>
>>> I don't think OP-TEE OS has such a limitation on non-contiguous pages.
>>> So I would suggest you to keep VIRTIO_TEE_CMD_REGISTER_MEM as part of
>>> the ABI. It can be an optional feature for a particular trusted OS
>>> implementation to support.
>>>
>>
>> Currently, the reg_mem (register memory) control is dictated by a flag in virtio-tee qemu code. This flag
>> for our testing was hard-coded as false. We will enhance our code, so that it is configurable. The value
>> of reg_mem shall be set to true/false depending upon whether the underlying TEE driver reports TEE_GEN_CAP_REG_MEM.
> 
> Sounds good to me.
> 
> -Sumit
> 
>>
>> Thanks,
>> Rijo
>>
>>> -Sumit
>>>
>>>>
>>>> Thanks,
>>>> Rijo
>>>>
>>>>>>
>>>>>> Coincidently Arnd and I (among others) discussed this in person last
>>>>>> week and the conclusion was that only temporary shared memory is
>>>>>> possible with virtio. So the shared memory has to be set up and torn
>>>>>> down by the host during each operation, typically open-session or
>>>>>> invoke-func.
>>>>>
>>>>> Agree as I was part of those discussions. But I would like to
>>>>> understand the reasoning behind it. Is there any restriction by VIRTIO
>>>>> specification that we can't register guest page PAs to a device (TEE
>>>>> in our case) to allow for zero copy transfers?
>>>>>
>>>>> Alex mentioned some references to virtio GPU device. I suppose I need
>>>>> to dive into its implementation to see if there are any similarities
>>>>> to our use-case.
>>>>>
>>>>>> That might not be optimal if trying to maximize
>>>>>> performance, but it is portable.
>>>>>
>>>>> IMO, the ABI should be flexible enough to support a TEE with optimum
>>>>> performance.
>>>>>
>>>>> -Sumit
>>>>>
>>>>>>
>>>>>> Cheers,
>>>>>> Jens
>>>>>>
>>>>>>>
>>>>>>> -Sumit
>>>>>>>
>>>>>>>> We would like to reserve device ID 46 for Virtio-TEE device.
>>>>>>>>
>>>>>>>> Signed-off-by: Jeshwanth Kumar <jeshwanthkumar.nk@amd.com>
>>>>>>>> ---
>>>>>>>>  content.tex | 2 ++
>>>>>>>>  1 file changed, 2 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/content.tex b/content.tex
>>>>>>>> index 0a62dce..644aa4a 100644
>>>>>>>> --- a/content.tex
>>>>>>>> +++ b/content.tex
>>>>>>>> @@ -739,6 +739,8 @@ \chapter{Device Types}\label{sec:Device Types}
>>>>>>>>  \hline
>>>>>>>>  45         &   SPI master \\
>>>>>>>>  \hline
>>>>>>>> +46         &   TEE device \\
>>>>>>>> +\hline
>>>>>>>> \end{tabular}
>>>>>>>>
>>>>>>>>  Some of the devices above are unspecified by this document,

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

