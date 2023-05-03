Return-Path: <virtio-dev-return-12512-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FFBC77B78
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 14:54:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DD50DFD569
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 14:54:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D632D9866BD
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 14:54:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CA4309865A1; Wed,  3 May 2023 14:54:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B6E2C986594;
	Wed,  3 May 2023 14:54:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZniqlchskHqj5ML5zWi0oWfEHtB0bHqpn9K83KhbQ6NTwSik1bM7CE4CC58fcoZLhYTGmd88ohaRnyb+zUS97Fo6a7SbLEglHIoPpXmTRty1ZwSw86QI4HXwl77tDOhppa4QmKjc2J2PIPYZyzE7tn9E6RE/VzknUDPaa7O1RodIakggX9DvJRoOrXBkHXt6e5Mkky025swTm2k9WRe5pgwG4oximk+IH1mvvQAZpuKdEhUuJMlIT3L+Mhy7uSHYIXBHBBvxy6l+1nj4jaaTDXzLIrc1N/pg46REVBrts+mbV5fKgVJTZpBlvAZBcXNWJB93HbiHxwsWH5Hj+sQqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvhiuScdNHzUJwK5vn+XagF4ePKtpBP1YQvZJIn6NME=;
 b=KYf20wDfr1JcLKxr5cDzytNqayX6hJG8RNS/duvfpQHhpI2xCRJhwwktu7k003eBevdo7KDSvphc2kI1uAxr4T6yLcnUp4IAUkY/+BD0mIOWc3iEBd4GINdw1M4ZFhrQKfXiE0VW6L2lgetRk01p7ID+IboRTrVe/CUfpdZVICF1sapx1sGdJtH6aMYIjVXC3VmXBGb3hqRjDPaQxomZko0CoDZHMNMR7bhzKwBLIvDfc/xZctlgrWJVPBiIofkdMURObBhgR1Ge8TmskY06bpOA7bw0SmTYYknx/3VBKiepV+lfWgoBcSObRiBEofPIinnRuspGi1uOJw8fWV9F0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <f9ecf8f5-1be7-179c-4d96-1c44d4601710@nvidia.com>
Date: Wed, 3 May 2023 10:53:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
 david.edmondson@oracle.com, sburla@marvell.com, jasowang@redhat.com,
 virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
References: <20230503032659.530330-1-parav@nvidia.com>
 <20230503032659.530330-3-parav@nvidia.com>
 <20230503014259-mutt-send-email-mst@kernel.org>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230503014259-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:806:21::7) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|DS0PR12MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: 349790a2-434a-4a55-5ca8-08db4be63a1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qfaZVjTx/2dYkPQ2V+dRdGaUdtVdePvaQYGYmazshuRww+9g29pu1nGgwlAh7DNC6SnkkFNeomIIwUjUJ3EWTxPY1C5j9qEjM135uUXaSkzzrTPNVptjA1aDN2HHUzVK210CjwMdJamSIR0GHPoITeMv7Ft2saEJRiUj0r3IiJI4g1EniLPfYLn3kCSDetTVT91/7Ke3SeVOS5yVwX4w5HQ7PkmWUWyHksMEgiqiCWxrf89QiRMQli1UkKeILdBjjYThwVzeuiDt/0ZrBd2jkwYOBWgOCaRZlm4JhumpmyGa+L880Xc2a1x4xWqsQR3+ILjM148x968javE4aOEhkhzdsZtr4UutWxQ8EApds4r5GlOv1G2VC7eZv0l1bXa1I9aK4q/aKaUuLnogXRWY7D7/XTx9FU+O3Pq8yxkD6U3Y1QU4XlcjXqGIR2HLuudAQPXbyRRevInVmJ0M6Tw7HNPeElqihBrrQsdyqlFJxuPiUDMG5QPWHjrgo542+jJrLpQblgkrtJYpcTdppTVeKAzK2Kvw9jDdhyi4DIjoK++pIqm3wDEJNJsbBL3p6w9TTLn5EpEoZackdoAIL2Lek+0lfFu6Ll4/kklTu/Z3jo3ALgf6vNwT1amuqnvzoborlCAfHAr6V53ceMsL1mPWdkNVyDVUGxFYR081NORLUcr6tQDuWmZSLRmqB22kGe6m
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(6512007)(6506007)(26005)(5660300002)(2906002)(53546011)(31696002)(6666004)(186003)(38100700002)(6486002)(316002)(107886003)(83380400001)(66946007)(31686004)(6916009)(66556008)(66476007)(41300700001)(36756003)(4326008)(478600001)(86362001)(966005)(8676002)(8936002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkhSUXB3MHBNU2t2UVBoNVRhVW5XTW9aRW9sb05BMFYyVHdlRFd3ZjI0WENU?=
 =?utf-8?B?eXluNlRJSnp1ZWRDc3FXSEh3RXFBN2hjWjNNVnVuakQ0WEdwVjhONk9jbGR5?=
 =?utf-8?B?ME5Kd0lKdkVIZmJDNHZSUmFmMG0yeUNIVmY2TDdNc21ZQm5VUG5lQlNDTFZk?=
 =?utf-8?B?MDZ5cCszODdTa0tmMVIrWFVKdnRLRVM0SWdJMGZxT1l0bGU0cUt0dFBBQVMr?=
 =?utf-8?B?SkdaUTFrbGliUjg4OWdpcTljYys0QU5xdGxhbGltaDQ2eHhjYTc3a2dodTNY?=
 =?utf-8?B?a1I3ckVYUHZsVUlWWGZGVkI2K3VBN01GQ1BVZ2syUStlWnBXd2xvbnhURWdB?=
 =?utf-8?B?aGIxRWFJa05yQlNJbFFFaGNaR1ZZaEFid3ZuUFN3cmplLy9tM0lpeEFGbldw?=
 =?utf-8?B?V3V4WTVWN0N5T0xvaElkUGRJZXhOdVRlODNXVWloOXlQcUZBc2FxY1hrajU5?=
 =?utf-8?B?V3ZQQUZZTWZldkZGN3dBMklXR0t0Z0FCSUN4VnY2UXkvZ2M5SVlvUVloZ0xh?=
 =?utf-8?B?YzhtN3hEQzRpdHRBWThFVHNCeHdzRTlxTG1lK0F3ZjY4dHQxNTdHa2Z5c2lK?=
 =?utf-8?B?Uis4SndwV2RDNlVCUWJ3bFdoaGg5LzhqTDdiUjJWUE81Zmd6ekpoVEk1a1FF?=
 =?utf-8?B?OUdYcW1TaENucmlBTm9hOEZldW9ZSlE4aFBOTTVQbncyZ1dzQm5SM3FFRXlU?=
 =?utf-8?B?WUJhSEgrTTZpSGJvQUw4NWpJaFc4Q29ud29HV0tZNlp1TXV4WjY2dHZwRlNP?=
 =?utf-8?B?SU1iOTFQbzluOU9iOWlvaHBkbnp4RElaVisrbXByeTl2cjZmcEVzN1d0Ymxz?=
 =?utf-8?B?YnJLS2ZYUnIrSWdGd09LVmZJUFRGRnp5a0VnM2xUaU14U0hsTmVNdkN6Wld3?=
 =?utf-8?B?M2E2Z0k3VUJ5ZlA4YWVLeEkwb3hnVGJzSzM5cjgyeDVWdmxETEh3azF2aFpj?=
 =?utf-8?B?ZnVCMkxyOGZ1ckYvL05PWkF2SEN2bkNqVm5ObUgzcHBIclp4TURUMmFzdVNG?=
 =?utf-8?B?NldZbmQvWm5TRlkzMm9zOVZyMlJVVWNtTjEzVXFTUFJjVVBCVkRncVl4MkRB?=
 =?utf-8?B?Z0xWdjZGcm1LbG54RVRralNLdVNULzBoL2FiT3NUMjNJNGVyZEUwNGNQc1Zp?=
 =?utf-8?B?dHRVMUFiQWcyUVIxODBWd0psbmoyZTdGeHV3SmdLNEN6MjF5SmhWd2R4alUx?=
 =?utf-8?B?dythWE11M0s5ZDViQ3JUOEpQdWtyRG1NNUFZTytYcHhHQWEyMlpHUU5NSkJa?=
 =?utf-8?B?SE11ak96NklxdGRGNk9xYVV4VUFlSmhLdEUrdEpHTk5ZRy9LbVNwQUF2SHhn?=
 =?utf-8?B?STJobG1ScDFwKzBtbHV5YldLOHNlWFNPa3Rvc2N0SktwMkFpZUZIdHcvYlJ5?=
 =?utf-8?B?enNlVHRVeFZEelA3d2ZNRUZBb09rdnNhTC9FMmpaOS9kK21GQUJnNDUydGto?=
 =?utf-8?B?bXJOdzNUYXAxdC8yR3lwd2xDNktWdjJoRGtNNEJkWVJrVzQxVFY3bzhIZnln?=
 =?utf-8?B?NENoejQvNjRFRHRRTFlsS0hZR01zamJMTGhtYk0ra2VMMy82NGdGUW5RWDhh?=
 =?utf-8?B?UjAybjBhNUcrb1NSZjhZcTcvQ3dMNWVISXcxaExqMEdJYWFnMUhLSy9aaGx0?=
 =?utf-8?B?MTJzdWROREd2SUJ0dEZ6Nm4yTmVPOXZqVnpXQnJFNWlNNTF0S1hJMkNtalEz?=
 =?utf-8?B?UXY0RnFxd095NzMveWNVMFJVaFRjUU5jeVRyY2s3eU5NNUo5cUlSczZSQXd6?=
 =?utf-8?B?MnY5dHV3YVdybFJWWDFmdkFOK3F2OTlOSGhmQ3NlSzBiWk00TnlXR1hXZ2t3?=
 =?utf-8?B?S3QvaHZaeGJrdlhIdDJocnI4VElQR3UzN2lWNmJRRWpabk5OcTE1QndDQzNZ?=
 =?utf-8?B?OTRMUm1KUHZlT2hON1l1Z0JjY0VuY2tUNm9YUEV6R0JyZTBjVERuSFNZbUZI?=
 =?utf-8?B?aHdTUEwvdkdVeXhZREhxdkNpb3dxaS8rMDlRRDFWT0VLa2xKanBhTmNxVGo2?=
 =?utf-8?B?cDRjSC9NNkJpTnFBTU5LRmxKYllEY2FxeUhZR2NWbG5zZS9jaGY5eWE0WklQ?=
 =?utf-8?B?N1VKR3NEZmVYVVRVNE9wb0paVlBpWmliT0hIS2xZR2N4QjkwQ0lHTjd0bFNV?=
 =?utf-8?Q?dmTjuOu/lttH9IrxD6l6v42OS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 349790a2-434a-4a55-5ca8-08db4be63a1b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 14:53:59.4471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88nuXDZpXCUJXSvZZoWEK4YX/GLJcTKllYxTQQwx0/h4BreEanOvdVFyFbWSX0GXHlRtedRWu2IP+UFXJIE07w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8814
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v1 2/2] transport-pci: Add legacy
 register access conformance section



On 5/3/2023 1:48 AM, Michael S. Tsirkin wrote:
> On Wed, May 03, 2023 at 06:26:59AM +0300, Parav Pandit wrote:
>> Add device and driver conformanace section for legacy registers access
>> commands interface.
>>
>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/167
>> Signed-off-by: Parav Pandit <parav@nvidia.com>
>> ---
>>   conformance.tex           |  2 ++
>>   transport-pci-vf-regs.tex | 31 +++++++++++++++++++++++++++++++
>>   2 files changed, 33 insertions(+)
>>
>> diff --git a/conformance.tex b/conformance.tex
>> index 01ccd69..dbd8cd6 100644
>> --- a/conformance.tex
>> +++ b/conformance.tex
>> @@ -109,6 +109,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>>   \item \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / PCI configuration access capability}
>>   \item \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / MSI-X Vector Configuration}
>>   \item \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Notification of Device Configuration Changes}
>> +\item \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / SR-IOV Legacy Registers Access}
>>   \end{itemize}
>>   
>>   \conformance{\subsection}{MMIO Driver Conformance}\label{sec:Conformance / Driver Conformance / MMIO Driver Conformance}
>> @@ -194,6 +195,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>>   \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / MSI-X Vector Configuration}
>>   \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Used Buffer Notifications}
>>   \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Notification of Device Configuration Changes}
>> +\item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / SR-IOV Legacy Registers Access}
>>   \end{itemize}
>>   
>>   \conformance{\subsection}{MMIO Device Conformance}\label{sec:Conformance / Device Conformance / MMIO Device Conformance}
>> diff --git a/transport-pci-vf-regs.tex b/transport-pci-vf-regs.tex
>> index 16ced32..7d0574b 100644
>> --- a/transport-pci-vf-regs.tex
>> +++ b/transport-pci-vf-regs.tex
>> @@ -82,3 +82,34 @@ \subsubsection{Legacy Queue Notify Offset Query}\label{sec:Virtio Transport Opti
>>   	le64 offset; /* Byte offset within the BAR */
>>   };
>>   \end{lstlisting}
>> +
>> +\devicenormative{\paragraph}{SR-IOV VFs Legacy Registers Access}{Virtio Transport Options / Virtio Over PCI Bus / SR-IOV Legacy Registers Access}
>> +
>> +If the PCI PF device supports legacy registers access, it SHOULD set
>> +corresponding bits for commands VIRTIO_ADMIN_CMD_LREG_WRITE,
>> +VIRTIO_ADMIN_CMD_LREG_READ and VIRTIO_ADMIN_CMD_LQ_NOTIFY_QUERY in
>> +command result of VIRTIO_ADMIN_CMD_LIST_QUERY in
>> +\field{device_admin_cmd_opcodes}.
> 
> Don't repeat documentation of VIRTIO_ADMIN_CMD_LIST_QUERY please.
yeah, I had dual thoughts, I am fine if this looks duplicate.
Will remove.

> just say all these must be supported.
> In fact what are you saying here? That all 3 are supported
> or none at all? What about just
> VIRTIO_ADMIN_CMD_LREG_READ/VIRTIO_ADMIN_CMD_LREG_WRITE?
> Looks like a slower but working way to do notifications
> is through a common config write, no?
Notifications to be done using the notification region exposed and 
queried using the 3rd QUERY command.
> 
>> +
>> +The device MUST support legacy configuration registers to its defined width.
> 
> what is this?
> 
Each register has its defined width as 8-bit, 16-bit, 32-bit etc.
So device support the access to its defined width.
May be to rewrite it differently?

>> +
>> +The device MAY fail legacy configuration registers access when either the
>> +access is for an incorrct register width or if the register offset is incorrect.
> 
Spell checkers didnt capture the error of incorrct. Need to find better 
tool.

> with which error code?
EINVAL
but should we repeat the general section here?

> 
>> +
>> +The device MUST allow access of one or multiple bytes of the registers when
>> +such register is defined as byte array, for example \field{mac} of \field{struct
>> +virtio_net_config} of the Network Device.
> 
> so which accesses need to be supported then?
> 
Not sure I follow the question.
Can you please explain?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

