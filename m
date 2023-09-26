Return-Path: <virtio-dev-return-13959-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C540FE7D242
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 07:33:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 39FFC61269
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 07:33:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 31C51986496
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 07:33:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 244D6983DE3; Tue, 26 Sep 2023 07:33:20 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 12B4798639D;
	Tue, 26 Sep 2023 07:33:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjsIgRUMdibcNc0RC/ZUd91y90EaICdyLXJUbvLCIW0LJFe0bEsTbVYudxzt90gXb7iRofM3istw36VtDqvbOBzeeloOQSXX72ugya6I+45dyiJb9wOGJXmWgjztu4oQYVGrVtNT1i2juYFiFldH21RlPJcxlHJz/zMNhEQrlRBRixP3xkqXCfZodNJTeCyUtzPgAHvgBob0Vep1ypJ4e0VJsknkB+YQAEJ4waFEaJj5hJZIJi1fWn2l+F+Do2fVqwcX4iEDiquSRadCfwf/jw7ITmXDvPCETLY0HaohiBDn82VaPgyC/VWn8wBT3mQOzZRHiSvozOPEhL3NWoJPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFJrOF6+0ENXsHfc7OGOuigs/zHCocmFqtw38UJ3wn8=;
 b=Gb8tf02zAXFIVeEnsBO0Z3InWc+VxOv64sp0dKmQh+Bk+VHrLs2SKQo7MQQcH2a2Eib6qTh/9X+S6PylPgMHm2eZe9gduwrUN5wMRewUGIpOzfVPSrLBnatKv4YYDM53ittpsN4vWhKa+HPcsFEPktOMe1b7gWAlegCAmm50aTKqNIMgf58FRyay/IDw24zE/CAVJgdXM46ykYGZ6mZR1/VGvmWGvxamFmcM6hVE+26JpEYrSp1K18N35fnH38chwrMBI8ns6Qk7CXrTYQMejBAbocfuU5auFSrSulaRsEi0QMqhun1iGSic6vZ5WpE8HBTSVrydUhRRFQDAh0ThPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Message-ID: <13b4d5a6-7e3f-e5cd-900a-694a076e7cf9@amd.com>
Date: Tue, 26 Sep 2023 13:03:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Cc: jeshwanthkumar.nk@amd.com, Devaraj.Rangasamy@amd.com,
 Mythri.Pandeshwarakrishna@amd.com, Nimesh.Easow@amd.com,
 babulu.ellune@amd.com, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org, Arnd Bergmann
 <arnd.bergmann@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <80a2e4337affb043909c348395fb45aeeb693dc7.1695640593.git.JESHWANTHKUMAR.NK@amd.com>
 <904049f9-3ddf-7e88-c6f3-785a29a08210@linaro.org>
 <CAHUa44GzHPkntr=sFYYzokW0=9CCN7n6Ch1i6J7L7Uhh5U5P3A@mail.gmail.com>
 <CAFA6WYOsPhFkyrG0P7B6Ec=AnDvoUaerLocM89KtmybLmKbsaw@mail.gmail.com>
From: Rijo Thomas <Rijo-john.Thomas@amd.com>
In-Reply-To: <CAFA6WYOsPhFkyrG0P7B6Ec=AnDvoUaerLocM89KtmybLmKbsaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::9) To CH0PR12MB5346.namprd12.prod.outlook.com
 (2603:10b6:610:d5::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5346:EE_|PH7PR12MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: e8995b92-64c5-42e7-8d1f-08dbbe62d6fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7UZ+7mdHm+eqjrjw9LpA8X4ueMJuiP4Xoemy8fSpeVFSXcstM7T4RnFf5iFjoHfiVGmKG075VkKKUoNaNalUJ8Kimmg2GBahheV2s8yrTZtQAUInUZky15cXkbx7xOOueJeDSzAcEhQE32ABWoN/r/KJcISVN4EBLTUeYvJFDjrxmD4UZUH30qtScHH8bTpOn2kOyl/zkE4I7GxtRS2F8cebiBLn8H+iegMqxFcgFaiNAWRkNHvCUwx8Laq/ntyNELIWINaKq9fWNG8EPvZUSBoXq3iH3xnBLMa19QYn6pekFmyGREj0X2htD92NVgHOXRl+AcPLiP78McLN4hJyygcKOqPCom6vXzrqHuXpCffjYtl1WDd4LqSgsK76s1hA0LuT5z5TfH/xKTncbZTXMRx/2JbhggP+3QYVgwLkXbB9Gd2PdH3QrtG+oW+hyv9kQkVQ0ToTEsfQ43TPMwZi/vSOU+dvguXAYydQdkL1Rj9FnJ3ThjcqQjIVvCL24AYsZi5dta1CLilQdYtyyTOyrzmJy+eDcehyn3dEtMAeBVMtVk/ImoIlZ8OsLBT9LclxZyQIDtfUBDLCiCbSTahXtNWoSobe1fYXpyejBEFPHOVzPeUMNYyB9kTcxSFY/TPIH+hDFtJGs5kL19pvC7q7FA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5346.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(451199024)(1800799009)(186009)(316002)(41300700001)(2616005)(6512007)(26005)(53546011)(6666004)(6506007)(83380400001)(6486002)(478600001)(38100700002)(36756003)(31696002)(86362001)(66556008)(66946007)(110136005)(54906003)(66476007)(2906002)(31686004)(8676002)(8936002)(5660300002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1pNdmlZVlczbFYwTktHcnpmWFczc0RNRWdjU2FyQ21FY3lJMDVsaFlmNFZE?=
 =?utf-8?B?a3Q5ckFTUGZEd08zUFgzaU5hTjQwclh5TVJ1SWlwZThGN3JNNVBNU3VoTUJZ?=
 =?utf-8?B?SUdsTWJ6dWE0MmJadGQzTXRHc3pCMEZpZE5mZzVMaExUOEMwRVRtTFZWR3dj?=
 =?utf-8?B?NWNENXFxTG92cjNkc0p0Tm45SkZXZXU0cHMwVEFDbFJYTnZBSVJMTkhaYUNq?=
 =?utf-8?B?eWxuM25ueFdTcEZ6ajJ6RW9QNnNaUnl4V2VQQWxSYW16cUhwSGJBTjVnOXhK?=
 =?utf-8?B?SFJkVUwyaUxXS05FSml4K2ZwZFdvRkRjZFZ3bVdnQm5IdFIwTWZTTFFyRGtx?=
 =?utf-8?B?WlVGeU50UENFTDdhMUJvRnJmbXBSaFRRakFJMlJUd05DTHk5ZURTSHlGN2xi?=
 =?utf-8?B?RURuc0VQckNudndUcW9hcUpucUxSRVA0WWthbCtRMEpjQUdpNEJSSUtpUlZU?=
 =?utf-8?B?WG51TnhTTmo1ZVlpckQ0TG5KWExyZ1czT2MzVzA0SWdMbjQvUSs0SGxwOCtL?=
 =?utf-8?B?cW82bXp1YzdUaktvbUUydDFYWjNveFQxbU9OTmoxb3F3MVAyRGRsRExMdUx0?=
 =?utf-8?B?VXNDQXJXYzhMTk45U01PcjliUnBYZ0gzU2ZvaFhMZDVkeVFGdmpzSExPMDlC?=
 =?utf-8?B?QnJiNUtZN3V1bS8yRE4rQlZFN0syQlA2OHpVc0ZOY2RCMDE3di9BZm14VXRI?=
 =?utf-8?B?N2k5bEtFZ0lrU1JhSHpzcmQ3RFZYbWxGelp6bFhmYldVNzdvNFo2TGhYaGlD?=
 =?utf-8?B?ZmxYZktmZ2R6U2JvM0liSkJLUW9GRFRvNEY3Wmt1bXFJUkE2a3l2NzJuUXRF?=
 =?utf-8?B?TG5YQ3BBYnZ0V0hQWlBFOVRnRmdjS1dGSVVSQmsyVjh3Y2w3ZFNXWW13Smw3?=
 =?utf-8?B?Vmd3WkJEdlV5R08yUkZuMjhrTDFHQTdzYWk2NU96T0hmQ3Mva041ZTloeE5q?=
 =?utf-8?B?SkZWNWY4d0xMbE5BZHNrUm53YTR3MDZQLzIranlBQ080K3h0K3orWVdFS0tD?=
 =?utf-8?B?RmpCaHpkd3VOOGFhdzVBZGt6bktOM3BwNms4dXY2VWFUTG5ISUJJdis2aWJu?=
 =?utf-8?B?TW1RRGkzT3JpOXFPNG0vSnIweVlQbExZdUhuV2lmVEFCUDdGcGplaWNKWFZD?=
 =?utf-8?B?UjNSUTBxUEFjU1B0N0pmYUd2Vm8xQnJWQXgwdGlGTlA0TVVsck9xdTRzMXJM?=
 =?utf-8?B?MWRocE9CQ2V6NjhvY0M5a281bG44NnZXL0pPMmhWNTU1WmlLalJ5a3lqRXBN?=
 =?utf-8?B?YjlHenB0Qmx1L0huODVaRlJtcU16VHc1a1ExYTNxbXRLSkF3RzA5N3BMNUla?=
 =?utf-8?B?Y1pDaVJJbWtrTjVxM2JzQVBHZnhzbk9ITzFzNFp1cTloUE5Bai9FWHZPRGgr?=
 =?utf-8?B?SGd6ZlU3bE5aMld5ZWpwc1Z1eGQ3RTcxTGM0VTZpMWIxNnNjM3czSjRDVFh6?=
 =?utf-8?B?Z1RCbkNySUpNQzVvL2tqbG8yVUR2aWxJclhsVm1CblV1RzR4a09oYlhGVks2?=
 =?utf-8?B?aGZ5Kys4c3duZHNBK0JtV041MjcyVzhPTS9vRUtaTW5ZQy9PTWNQVHdTRUJX?=
 =?utf-8?B?UDBCNHFzUE02eUxLbVpTOTZsTnRCcWI5WnI4V2NEUDBoaU9OeHNaT21nZ2Jy?=
 =?utf-8?B?cGdnelFjc0R4Nmd1ZXV0OCtKdXc3VWl4aytFZU5TQlgwWG0ydHg5U1JXS2hH?=
 =?utf-8?B?Wms3K3J0MHg0b3FhREU2L3JFTVJvMU5pRXhuZDFaeWYwbVRaVjB4aldFWHB6?=
 =?utf-8?B?L2d5SHhabmU0ZTRjM3docjk2Y2dSWHV4MmNSbWl0MDBRZXBhazRLekl4QS9n?=
 =?utf-8?B?UmlCOVptbENEeGhUcFhyeDVuM0dNTGFrMEkwamVrMVRFUWxndmZaQ1dMdmZX?=
 =?utf-8?B?eUUwTUdISHFiZlhGWjd0K0lIME5KY0lqLzh6MUh6NDdJeEl0dk1KWUk0TGZV?=
 =?utf-8?B?MmNVTUVlUXFLdTBGWlpBdTV5S1NHbVFsbEI5MXU1VDZWdFVmc0R0NFJrQmM3?=
 =?utf-8?B?bTVmUDBUR1RvTGVmRzVnQXRvWmt4bkZlNHVCNHpPV3Y5MFJXSVN3UDdKUW5O?=
 =?utf-8?B?em1ZeVR0czE0UGttMXFGTTI3TlRpVnFSeUNtYkloci93YWRmQTA4SG9aQVFJ?=
 =?utf-8?Q?IkYnsE7xj/iqOEwb9ZRuYfZbD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8995b92-64c5-42e7-8d1f-08dbbe62d6fd
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5346.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 07:33:12.9625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8pkFFawYHIDQnEqJMDVhYVltJLgzLr14ZI66TtuK9Z4L54yWcr/md3ReQOx8OZagzoxnJn0A0VZUKcjOSwpDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9151
Subject: Re: [virtio-dev] [PATCH v2] virtio-tee: Reserve device ID 46 for TEE
 device



On 9/26/2023 12:14 PM, Sumit Garg wrote:
> +cc Alex
> 
> On Tue, 26 Sept 2023 at 08:16, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>>
>> Hi,
>>
>> [+cc Arnd]
>>
>> On Tue, Sep 26, 2023 at 8:00 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>>>
>>> +cc Jens
>>>
>>>> In a virtual environment, an application running in guest VM may want
>>>> to delegate security sensitive tasks to a Trusted Application (TA)
>>>> running within a Trusted Execution Environment (TEE). A TEE is a trusted
>>>> OS running in some secure environment, for example, TrustZone on ARM
>>>> CPUs, or a separate secure co-processor etc.
>>>
>>> I have been exploring this area quite recently with an effort to have a common VIRIO interface which can support different trusted OS implementations. I guess you intend to test it with AMD-TEE, right? Any plans to test it with OP-TEE? As currently we have these two supported upstream.
>>>
Yes, we have tested with AMD-TEE. We have not yet tested with OP-TEE. Sure, we will try it out.

>>> Do you currently have any virtio frontend/backend implementations for this?
Yes, we have. Frontend is a Linux virtio-TEE driver, and backend is virtio-TEE device emulated in QEMU.
We used Xen hypervisor.

>>>
>>>>
>>>> A virtual TEE device emulates a TEE within a guest VM. Such a virtual
>>>> TEE device supports multiple operations such as:
>>>>
>>>> VIRTIO_TEE_CMD_OPEN_DEVICE – Open a communication channel with virtio
>>>>                              TEE device.
>>>> VIRTIO_TEE_CMD_CLOSE_DEVICE – Close communication channel with virtio
>>>>                               TEE device.
>>>> VIRTIO_TEE_CMD_GET_VERSION – Get version of virtio TEE.
>>>> VIRTIO_TEE_CMD_OPEN_SESSION – Open a session to communicate with
>>>>                               trusted application running in TEE.
>>>> VIRTIO_TEE_CMD_CLOSE_SESSION – Close a session to end communication
>>>>                                with trusted application running in TEE.
>>>> VIRTIO_TEE_CMD_INVOKE_FUNC – Invoke a command or function in trusted
>>>>                              application running in TEE.
>>>> VIRTIO_TEE_CMD_CANCEL_REQ – Cancel an ongoing command within TEE.
>>>>
>>>
>>> How about shared memory support? We would like to register guest pages with the trusted OS.
>>
We have a command VIRTIO_TEE_CMD_REGISTER_MEM for registering shared memory buffer with Trusted OS.

In this command, the guest pages are copied into a shadow buffer in the host OS. And this shadow
buffer is mapped with Trusted OS. So, buffer-copy is involved.

One limitation, that we had was that the guest pages were non-contiguous. So, the number of physical
pages that had to be mapped with Trusted OS was exceeding 64 entries when we were testing out the
registering of guest pages. AMD-TEE Trusted OS can map a physically non-contiguous buffer, but the
number of sg entries for such a buffer must be less than 64. So, we resorted to using a shadow buffer
that is allocated within host, and gets mapped with Trusted OS.

Thanks,
Rijo

>> Coincidently Arnd and I (among others) discussed this in person last
>> week and the conclusion was that only temporary shared memory is
>> possible with virtio. So the shared memory has to be set up and torn
>> down by the host during each operation, typically open-session or
>> invoke-func.
> 
> Agree as I was part of those discussions. But I would like to
> understand the reasoning behind it. Is there any restriction by VIRTIO
> specification that we can't register guest page PAs to a device (TEE
> in our case) to allow for zero copy transfers?
> 
> Alex mentioned some references to virtio GPU device. I suppose I need
> to dive into its implementation to see if there are any similarities
> to our use-case.
> 
>> That might not be optimal if trying to maximize
>> performance, but it is portable.
> 
> IMO, the ABI should be flexible enough to support a TEE with optimum
> performance.
> 
> -Sumit
> 
>>
>> Cheers,
>> Jens
>>
>>>
>>> -Sumit
>>>
>>>> We would like to reserve device ID 46 for Virtio-TEE device.
>>>>
>>>> Signed-off-by: Jeshwanth Kumar <jeshwanthkumar.nk@amd.com>
>>>> ---
>>>>  content.tex | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/content.tex b/content.tex
>>>> index 0a62dce..644aa4a 100644
>>>> --- a/content.tex
>>>> +++ b/content.tex
>>>> @@ -739,6 +739,8 @@ \chapter{Device Types}\label{sec:Device Types}
>>>>  \hline
>>>>  45         &   SPI master \\
>>>>  \hline
>>>> +46         &   TEE device \\
>>>> +\hline
>>>> \end{tabular}
>>>>
>>>>  Some of the devices above are unspecified by this document,

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

