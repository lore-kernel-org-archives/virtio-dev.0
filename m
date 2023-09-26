Return-Path: <virtio-dev-return-13961-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271CEE7D24D
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 08:17:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 76D0F120D53
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 08:17:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 63628986496
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 08:17:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 554809863A6; Tue, 26 Sep 2023 08:17:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4507598639D;
	Tue, 26 Sep 2023 08:17:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNqM/tWXzyaOnWrHewgLTfwvARpLIcQ+c16edbhf+4AFK/nhXitgsfB6adRSqNRvBJ4myhyhiMzWcp5s2MUR1OkKvKmfjS8AmJBJgd2oBjDU3pAcsR2ryOsrMLVbGpqa34yr35Ci0dYyPF+25R44KNQ1HZxKzCJHj68dpPLVD0zj7r+HdR2M2mw5r2aPXcZTky5Jdbd4pxJmWQG3Ggy636wNPGrr/0JR4wVgsZ5NhOoTeK4CNdsKPPKx8eLp2A/8CX0EMEl+lCL/I2WCxC6gdluWGYrEAvvRsnc5ov1ABR1rvJpHxtNmF4iSJFA0ZaICnuRTeX1gg/7kNGjGq9ru4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9bsM8oQbR2ij+T/485TcbVHjvmq65XIZn3Vab9UbrE=;
 b=gCDoth2tAoIreDlyTJgceIC1HE1dVlcXc2qUD81YxLBENAZ7q07vZeQnHPq2R70aapYQcaFgTlPJ+xXVWKdF6hDKZUffSwYOc47ECFEOErEsPmErweLhO9LOY+Y/gyAXoA0nB4wUB4Ib/S1YTGnefANXrBj4WfjISCL1JUFZU/3oFv/aFpZSpqk0WtWU2eZ4B8yQXkPS9vDGm4TBgorcx+fdq2fuiHpcllh7m/rcVBxbxFqxx1Q9jeEbRfySTd3ZGOeNzQPk3GRZ2Y3bP3gDvSMXzM+7RAyU6IKSG2ssSP0snR94GAWst36LQXQRi07wQyCsNxt6fCvixjT5vUZIww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Message-ID: <70848d35-6288-24d4-e4dc-01ca7e4e180a@amd.com>
Date: Tue, 26 Sep 2023 13:47:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, jeshwanthkumar.nk@amd.com,
 Devaraj.Rangasamy@amd.com, Mythri.Pandeshwarakrishna@amd.com,
 Nimesh.Easow@amd.com, babulu.ellune@amd.com,
 virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
 Arnd Bergmann <arnd.bergmann@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <80a2e4337affb043909c348395fb45aeeb693dc7.1695640593.git.JESHWANTHKUMAR.NK@amd.com>
 <904049f9-3ddf-7e88-c6f3-785a29a08210@linaro.org>
 <CAHUa44GzHPkntr=sFYYzokW0=9CCN7n6Ch1i6J7L7Uhh5U5P3A@mail.gmail.com>
 <CAFA6WYOsPhFkyrG0P7B6Ec=AnDvoUaerLocM89KtmybLmKbsaw@mail.gmail.com>
 <b15e849c-f424-1afb-4b99-ae2df954a044@amd.com>
 <CAFA6WYNMJ_njp95+AUu-p6H2wat+GCxntNX+WddKpufM4AVVYw@mail.gmail.com>
From: Rijo Thomas <Rijo-john.Thomas@amd.com>
In-Reply-To: <CAFA6WYNMJ_njp95+AUu-p6H2wat+GCxntNX+WddKpufM4AVVYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::13) To CH0PR12MB5346.namprd12.prod.outlook.com
 (2603:10b6:610:d5::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5346:EE_|MN2PR12MB4487:EE_
X-MS-Office365-Filtering-Correlation-Id: 46bf2f3a-7396-4f7b-94d8-08dbbe6909a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LkQteEyF4q6RgmitAxVpTvP6byLNeA7p7bDhAYjHCWZ21Yyfr94MTxH22k43s9y+KAz5p2pFK2f3xOgMxz+5hTsjOBIKdlrKI0jEAdgMjz3PZB6STNhVHAidv0xBwU9GK9L+L8GfJ1MfWJYy6EZIsm/vr2gATa5Rk3uTzN40Py/3tQHS5BzCMlzn/9G+931mAfa/rQqzEeFotY19CefhRWRaMd6UvUGl+yIZIc0k4DhT7xLjeT9AjLMvBjRD8RvqGltNIjA3t/eVqsu4kpCUpHAjDPomp9XHQYmlBRmAJnKt5gDl9eTwSz/6cZecYErdUIqo+UqlGCE3pr10s+1o/fSRADfKMZ+h+dbrWyxlj3w5UHOW73aWR8O9svrA6zhCR58bCByRFJ693RfJeH4obrKERZLDj1eQJitAG5dtFBSSOqqhYvX9yRq8wh4XaDoeED7RnWpzTjido/AayNLH9tWAlVIYlU64Qol6te4mC7Jjf0E4euCJ4CQY2e7eY/qMdUIjvW4uZsz2QoomTbpJCRynQR342C28cR21jNdFF5uCzAbafldjOOBBu3SajhyKiH5fhnohFUwObfYQneMWE06oQHJDu7ugcA6+Vy2b158thvy+drmKBqujVJjSctDqgIEL5TbN6tGqPNoScj47ew==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5346.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(186009)(8936002)(4326008)(8676002)(31686004)(26005)(2906002)(478600001)(66476007)(41300700001)(316002)(6916009)(54906003)(66556008)(66946007)(5660300002)(6486002)(6506007)(6666004)(53546011)(6512007)(36756003)(2616005)(83380400001)(86362001)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1FlQjRLL2drS1dPRE1EQkkzR3oybmdkMzJQZ3V4M1pNL2RPaTFBR0Erdzla?=
 =?utf-8?B?VHpweGtiNUNjaStDVDR0TmhlUlVwQXh1bWRIMnQvTmhZNE9HRW1MaFlzdkk1?=
 =?utf-8?B?Ky8xVSs4VmErbXBHV2t1Qi9CVFZCZW9sMGRBNFdOT0w4SDlBSVc0TEJKeWxY?=
 =?utf-8?B?WjVQRG50S2lzQ3MyT3VDS2M2OG1sdm1BZnVDOG00STNvcVU1cEtXRjh6SXBo?=
 =?utf-8?B?THhoS1FNOEYvVVVCVERRano2Vkdyc0RObm93WjUzbmhSbHNDRC9YNk4ybmlT?=
 =?utf-8?B?YVhoaFRlUExqOUtrZDFUUU1iaDdhN09sdytUVnhxZm1lTStNeUxwN2h6SFdP?=
 =?utf-8?B?MzVVQUFzOGE1d3k5dDdXVUFoVzhhR00vR0g1dWt6SVd0YTQ1a05Dc2dPa1Vs?=
 =?utf-8?B?dUwrOG95TzY5d25aUElkbzdJUUlGK3RzTUtQSDR6eDVsQWYySW00VXYzalBY?=
 =?utf-8?B?aGZ3eGd6TDJQTHJQQm96ZXN4ZWZSUkxhUU1GQXVYaGRmdDZLd091b1ZaREZG?=
 =?utf-8?B?K3VFNk1wNnFhS3YzZDU1c0NITk9DOUU0OUhtNlN5ZWhIMGFEd1IrTFJBZC9O?=
 =?utf-8?B?M2RGRkRCa3ZlQjNBY3E5TytsR1ZjaEhTSEE0UURuTlNWOXVWZ0NQRU0zUXIw?=
 =?utf-8?B?eGFUZEdzZmtuT2YvNWVxRi9OKzZDWVl2ZzYyUGZmQlNOS0Qwc0VEbkNwUnJy?=
 =?utf-8?B?OVJlaENONU9yMDFzZkdIam1ubXlNSE92YlpLWG1QTkFuWmU3UnplWTRDZ2hZ?=
 =?utf-8?B?SURuMUJpejZlL1A0WGlLZ2h6S0NzdlNVNU56d1B0VW9xcGFac2VOU1VReUVW?=
 =?utf-8?B?N2NFUENiSWFGL1h1SlU4WjhZbEhWQkJ3dlFXa2lnSFExbE9sOEFUSSthYmxl?=
 =?utf-8?B?ME5GV1RXcnEzVE8vb3lSYnExZFJTMFFKcmVNQXR5YWdPWEJVa0J4aDM2cmpT?=
 =?utf-8?B?YnYzb3VQQUJDT3loK0JyZ0JZUExuWlkyempEWHRMMFpmbkVkYlVncHRrMU9Z?=
 =?utf-8?B?MGVtNlVuTUxHSExqVTNlSXEreFA3TlBBS3UvMS9KODdseXd6VXNKcCtnYzRN?=
 =?utf-8?B?OUJaa1YyV1RGMEFjSW91anFVODlMZGlKUk5jamRwQ0lKMk92TDNGd1pHcTFJ?=
 =?utf-8?B?d3Q2UnpnTXYvblJrZEIxcitFN3NqR09PUE1vQzNiWDFrODZnR3orTUJKVlZp?=
 =?utf-8?B?TFhkaVA4OGtYbklaa25NN3ZCWnA3RE03ZkpVL1E3b0FLY1BXR2NNemxQUHNa?=
 =?utf-8?B?OWppQ3JoWHpmNnBHck1uWG9NMlQ3c2RYYkVDbElMWjZ3WnA4TDRsVHhDNjUy?=
 =?utf-8?B?bzdUMEpnQngvNXFjTk84bXpMMlBOek1zdFl6TG9uTkdEd3NBQThNVWtpb0Jn?=
 =?utf-8?B?dWJ1ODBXNDJXUm5TQ0s2a24zdE5aSE9YTFVPM25rU05zQmVqdkZBcjNDMlhT?=
 =?utf-8?B?WElzV2xma05vcDlLdXY3UlNrUTllTkREbmh1QlhVK3NmL2ROdVFkeHh1OFhR?=
 =?utf-8?B?Uk5qRkg1Q21LSDRNQWovZFdyQk1kRk9scWxsRnFWdk4rVXYzb2VkNk82N1BM?=
 =?utf-8?B?ODl1Q0hhM1VIM0hLRXJ6NGlPU2dHanllc0NwNm5MSDZ5VHBGdWJjWDV3RHhU?=
 =?utf-8?B?ampDRmx2YnpuK2dVV0VOdndDbUIydW53Z1p5Y0tWOHBPVC9FaDJkWEVLZFli?=
 =?utf-8?B?QlVYVXM4SHFSR2p1T09VMk1MWHlDRHRTZFhTbThZdmRrU3JBaTJOOXFZa2dI?=
 =?utf-8?B?QURVUlhYU01haS9TRGg2SWVKUjlBc0Y5K2JzcFlpM0QrbVZLRTVhN1p3QzFY?=
 =?utf-8?B?SkJyRHZ4OUw2ZUVyeHdSK3dxTlFhbUcyU3phMzNFczFhS1NKOERFSXpIN0dQ?=
 =?utf-8?B?dzhvMlVvTW5keFJSYVhaUDJ2VENld2Y5QVlSZzUyVmdvNDFvSmIySFBjUHdo?=
 =?utf-8?B?emw5UlJIbzRENnl1MjdJa29qV3lwSEFEVDl4MWliTWFPNWJMa0E1VzBBTGpl?=
 =?utf-8?B?VXF6RDhzS0loVktGR1hMYTluWmtUTXliNHNYZStacERXS0c1VXEzUTkwaWpr?=
 =?utf-8?B?QWx0c2RJbFVYQjlJTExySHp3MW1LelUwNlhPL0FaK0FJcmU2ajlVbFlQcllj?=
 =?utf-8?Q?5zylKIio5tFokI14Y6iYyDRPg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46bf2f3a-7396-4f7b-94d8-08dbbe6909a8
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5346.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 08:17:34.9406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h57uQbEeKtDMJmNueuOUim8mWAhILHuynguf2/E2AVoQjHKQE3ecHQTSURinotWa6vYZ6ObQROQxwz+IRDRASg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487
Subject: Re: [virtio-dev] [PATCH v2] virtio-tee: Reserve device ID 46 for TEE
 device



On 9/26/2023 1:19 PM, Sumit Garg wrote:
> On Tue, 26 Sept 2023 at 12:53, Rijo Thomas <Rijo-john.Thomas@amd.com> wrote:
>>
>> On 9/26/2023 12:14 PM, Sumit Garg wrote:
>>> +cc Alex
>>>
>>> On Tue, 26 Sept 2023 at 08:16, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>>>>
>>>> Hi,
>>>>
>>>> [+cc Arnd]
>>>>
>>>> On Tue, Sep 26, 2023 at 8:00 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>>>>>
>>>>> +cc Jens
>>>>>
>>>>>> In a virtual environment, an application running in guest VM may want
>>>>>> to delegate security sensitive tasks to a Trusted Application (TA)
>>>>>> running within a Trusted Execution Environment (TEE). A TEE is a trusted
>>>>>> OS running in some secure environment, for example, TrustZone on ARM
>>>>>> CPUs, or a separate secure co-processor etc.
>>>>>
>>>>> I have been exploring this area quite recently with an effort to have a common VIRIO interface which can support different trusted OS implementations. I guess you intend to test it with AMD-TEE, right? Any plans to test it with OP-TEE? As currently we have these two supported upstream.
>>>>>
>> Yes, we have tested with AMD-TEE. We have not yet tested with OP-TEE. Sure, we will try it out.
> 
> Glad to hear that. I can help get it tested with OP-TEE as well.
> 

We will test it out internally. Shall let you know in case we need help.

>>
>>>>> Do you currently have any virtio frontend/backend implementations for this?
>>>>>
>>
>> Yes, we have. Frontend is a Linux virtio-TEE driver, and backend is virtio-TEE device emulated in QEMU.
>> We used the Xen hypervisor.
> 
> Can you share corresponding references? I can give it a try using Qemu with KVM.
> 

We will share it in next couple of weeks. We have not yet hosted the code for external consumption.

>>
>>>>>>
>>>>>> A virtual TEE device emulates a TEE within a guest VM. Such a virtual
>>>>>> TEE device supports multiple operations such as:
>>>>>>
>>>>>> VIRTIO_TEE_CMD_OPEN_DEVICE – Open a communication channel with virtio
>>>>>>                              TEE device.
>>>>>> VIRTIO_TEE_CMD_CLOSE_DEVICE – Close communication channel with virtio
>>>>>>                               TEE device.
>>>>>> VIRTIO_TEE_CMD_GET_VERSION – Get version of virtio TEE.
>>>>>> VIRTIO_TEE_CMD_OPEN_SESSION – Open a session to communicate with
>>>>>>                               trusted application running in TEE.
>>>>>> VIRTIO_TEE_CMD_CLOSE_SESSION – Close a session to end communication
>>>>>>                                with trusted application running in TEE.
>>>>>> VIRTIO_TEE_CMD_INVOKE_FUNC – Invoke a command or function in trusted
>>>>>>                              application running in TEE.
>>>>>> VIRTIO_TEE_CMD_CANCEL_REQ – Cancel an ongoing command within TEE.
>>>>>>
>>>>>
>>>>> How about shared memory support? We would like to register guest pages with the trusted OS.
>> We have a command VIRTIO_TEE_CMD_REGISTER_MEM for registering shared memory buffer with Trusted OS.
> 
> I suppose the commit message has to be appended then. Do you have the
> draft virtio-tee device specification ready for review? I would be
> interested to review that.
> 

Yes, the command is missed out in the commit message.

We are in the process of preparing virtio-tee device specification. We will be sending it out to this
list.

>>
>> In this command, the guest pages are copied into a shadow buffer in the host OS. And this shadow
>> buffer is mapped with Trusted OS. So, buffer-copy is involved.
>>
>> One limitation, that we had was that the guest pages were non-contiguous. So, the number of physical
>> pages that had to be mapped with Trusted OS was exceeding 64 entries when we were testing out the
>> registering of guest pages. AMD-TEE Trusted OS can map a physically non-contiguous buffer, but the
>> number of sg entries for such a buffer must be less than 64. So, we resorted to using a shadow buffer
>> that is allocated within host, and gets mapped with Trusted OS.
> 
> I don't think OP-TEE OS has such a limitation on non-contiguous pages.
> So I would suggest you to keep VIRTIO_TEE_CMD_REGISTER_MEM as part of
> the ABI. It can be an optional feature for a particular trusted OS
> implementation to support.
> 

Currently, the reg_mem (register memory) control is dictated by a flag in virtio-tee qemu code. This flag
for our testing was hard-coded as false. We will enhance our code, so that it is configurable. The value
of reg_mem shall be set to true/false depending upon whether the underlying TEE driver reports TEE_GEN_CAP_REG_MEM.

Thanks,
Rijo

> -Sumit
> 
>>
>> Thanks,
>> Rijo
>>
>>>>
>>>> Coincidently Arnd and I (among others) discussed this in person last
>>>> week and the conclusion was that only temporary shared memory is
>>>> possible with virtio. So the shared memory has to be set up and torn
>>>> down by the host during each operation, typically open-session or
>>>> invoke-func.
>>>
>>> Agree as I was part of those discussions. But I would like to
>>> understand the reasoning behind it. Is there any restriction by VIRTIO
>>> specification that we can't register guest page PAs to a device (TEE
>>> in our case) to allow for zero copy transfers?
>>>
>>> Alex mentioned some references to virtio GPU device. I suppose I need
>>> to dive into its implementation to see if there are any similarities
>>> to our use-case.
>>>
>>>> That might not be optimal if trying to maximize
>>>> performance, but it is portable.
>>>
>>> IMO, the ABI should be flexible enough to support a TEE with optimum
>>> performance.
>>>
>>> -Sumit
>>>
>>>>
>>>> Cheers,
>>>> Jens
>>>>
>>>>>
>>>>> -Sumit
>>>>>
>>>>>> We would like to reserve device ID 46 for Virtio-TEE device.
>>>>>>
>>>>>> Signed-off-by: Jeshwanth Kumar <jeshwanthkumar.nk@amd.com>
>>>>>> ---
>>>>>>  content.tex | 2 ++
>>>>>>  1 file changed, 2 insertions(+)
>>>>>>
>>>>>> diff --git a/content.tex b/content.tex
>>>>>> index 0a62dce..644aa4a 100644
>>>>>> --- a/content.tex
>>>>>> +++ b/content.tex
>>>>>> @@ -739,6 +739,8 @@ \chapter{Device Types}\label{sec:Device Types}
>>>>>>  \hline
>>>>>>  45         &   SPI master \\
>>>>>>  \hline
>>>>>> +46         &   TEE device \\
>>>>>> +\hline
>>>>>> \end{tabular}
>>>>>>
>>>>>>  Some of the devices above are unspecified by this document,

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

