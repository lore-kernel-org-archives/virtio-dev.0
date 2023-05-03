Return-Path: <virtio-dev-return-12510-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26C1C7EE23
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 14:47:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E883A4293D
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 14:47:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DB0BC9866B3
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 14:47:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C597B98658B; Wed,  3 May 2023 14:47:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B0014986594;
	Wed,  3 May 2023 14:47:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrTH4qjCEWwomFsHIbK3PExZjlHjmyPgY6Kf8+EWSbGgBQS7VwBkMv/GRmZmn9EXywx36kHavQvfU7cJf7bKMbXCtpS0aG3jJTQ827ySDtoKkIWaMR9GkrDbzeUjt2Yp6dnIdqWe3ZGnpj0q1gQ6/kt8G/hThsEDg3K7MF8MHXrD+KNi2LtE02rGdABq+agl4Z3KjFelDtMwn/ZFpoJie6PuCcUemMw8alH/7C3hHZcpLHjPWgL9Le9OR3TOA105I5/MiVG2KcEYkE4vKYdUTHG4dVJN16xxMOl0La+V0ci7HyTpy1isvmVbisayaPSPbBjAPFj4tRuwXzEdqTYWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8p1/TRyt8pTdq368RQ574khyR63bWef1QOawllGWEs=;
 b=VlRayfD0NxR6QeSMFZCryxGpyzSXhHJTM7DfvagDjgmUK+2j3toMNRAg/RrzlUY8oKddcHLbbhYqU2W9999eVdp366poLa7sY69kVnX/Y7WZyZSBf4Is5UIxr/Fh5ngU8TVJicRIS77UUMhIO7zfh4zq49M2HHQzhChSrZfw2kqi1i++wtB+zw8vSx0WTioaj6wWHGnUeoovuRmJ5dytFKOwbBycM/Pp8f0H7D18V74ApPTa0rrajRV8HBwbOGMwQBTLKt4yGkuvmgapj9/dn4M7G4Iy3XtRc2+jROTYjiaYW37RNGKCy01EyBCPlKAvk2UuoMjgAtsScp5+w8cHgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <c0ece552-d618-cbe3-c841-6c6fe72e8f18@nvidia.com>
Date: Wed, 3 May 2023 10:47:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
 david.edmondson@oracle.com, sburla@marvell.com, jasowang@redhat.com,
 virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
References: <20230503032659.530330-1-parav@nvidia.com>
 <20230503032659.530330-2-parav@nvidia.com>
 <20230503011627-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230503011627-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:5:100::27) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|CH2PR12MB4969:EE_
X-MS-Office365-Filtering-Correlation-Id: eae99d60-1cf1-4925-4e41-08db4be551ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3O/x3y/vfCcBR8f/lIKZHesW6Aqmkl0RyDpVaFq/IbpOXnoK4YGysrxvoObbB4w/6YEFLjLJZeFM980vYrEgld2xvVuctde2Ed+61K9U7emUNVOweKCLy9EndMoWonnPvFoPbWFqIEAvEm9NFEv3wiTwCKjDKH9PDjHk5YjRWzGgWxgkQGCU6AWdsI1f+kP1Wa8Kgw5rL7UQS6i/vWpV5X/46SJyVXrtxNunBjrrkKTel4lRyvv/EgRZwcqNiNgxxmgMSynM08XG6uOycAQ493MUxla7GxRIQWuJoofgGUamt4Ogwicf7tVY0qyEj9MjRZ/t36iNUfFVa/OPT/QfdAOcemPLB4gYuL828FIyhvhN+VCPwD7Rfmj5hR/GPjVT/i1p0t5t8hS0jlDmEOly4jVjOcC91qqUIcBUhAUdO8EYhjhcIB4PGhgz6fndPvwXNwgN1xNSE09op5NIQWND8C3bqzTEeL9wk1C0av1hSLT4uvHmVpnKk81+ptxXvjjatq8FJJmz5bMHonPyrJVE9wpFy81+hr9/FRC+DITZgYmUUk3B1OVtROmTfq9a9bpPOtLrCG97z/IbSsHfNyNgecjMmLvu8Dr6n1ygV6nwAlSldegSvFyufG/D77xlxrCax89JdLIJCsPGAN9zno72mA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199021)(83380400001)(2616005)(31686004)(8936002)(8676002)(316002)(186003)(41300700001)(5660300002)(6512007)(6506007)(4326008)(26005)(6916009)(53546011)(38100700002)(66946007)(66476007)(66556008)(107886003)(6486002)(6666004)(31696002)(86362001)(478600001)(36756003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkovbUZpRFJVM2VlNzBRSHlyT01sSEE4KzZPNEUyVmIya2NUbHdYRjg0OHZH?=
 =?utf-8?B?ZFhoanBRVkVSK0tpSTM5U0VJOWFiWm9RRTZEUVVYbVNPRXBZeHdzZERwNUpa?=
 =?utf-8?B?cTN1S3dLM25Xc3dQYmdrWFV2V2UxWklyL09nWnczZ1FzbHA3YUVHRDlHT0tj?=
 =?utf-8?B?Z1hnVWpaZzlqYytyWExxeVhqb1k0NWhVVmhNQWxIWXBUMXZCajVoa1FKUXMy?=
 =?utf-8?B?Smd6NlRCTGN2Z21FalZzYXJWTktTMlViU2ZlNjc5dWFrdTJLaTlCYnFUN1Jz?=
 =?utf-8?B?ekpQRWFYS2V5M3F1dE40QStYcUk0TFZOZlRvQUFyVis3aERlZXFINDVMUlY1?=
 =?utf-8?B?RDdTTDFLa0V5TUlKMTRvUVF5RURyNk5yaDRBbmpaM0N3SFIvYklDbnUrZXJV?=
 =?utf-8?B?RkN2WHdrQXE0VktJSTRjY1BOOUJaWVJOQ3M1N0xnbEc0ZlBRYlJyTVFuZXh3?=
 =?utf-8?B?MGtSQWVHYTlqUkc0cmdDUWVSSGZ1Y3NlU3U2WjdHVDNKOEFTYlBtb3JOOVpz?=
 =?utf-8?B?Z2lMQ1NjZ0F2WUJ1M0NSd29pSnBHRWVZSVBiQTVRNnlaaTdkTzBGbkt5MEZ3?=
 =?utf-8?B?RzZJM0tpaWtsVjFyOEZmSmhlZHYrMGRDTmdiQThYOEszd1pvMG1PbjNmbnFN?=
 =?utf-8?B?QWpaTzhYY2I5WGhiNitadU90WGlRNnlsLzNWaGxja3FEbjMxa0tCZlBhaE95?=
 =?utf-8?B?OVhZZGV1UDNlRHNEV0VhdHdXVWk0L1lrZVFWSWRvbklZaW0rRThqbE1VTG1R?=
 =?utf-8?B?VURHbFhBTlZDMlc1Y1Y0TzFYSTNLNkFVdm1RRERrMTc0cEQ3d3NPdW5mcTh2?=
 =?utf-8?B?My9SQ2swKzhyQ3BXYzF0MTVVaGsvU0h0QW5kcnZlM0ErTGYxaUFXVXRYKzk5?=
 =?utf-8?B?UnNlVUQyZSt2QWYxVlFNNkp5aXpXOW12eG5rQ24wSVQ2YkNtcjdLVThMSWhZ?=
 =?utf-8?B?UFhTSGY1TVB4akV5TDkvcTdqQWNOOGNHK1NodHZyRjFGMUlWT1RYUFprV2VR?=
 =?utf-8?B?ZXp3RzlROHNsbWJxcXI2b0JJRVV3UUdlN1lERWlROEQxeXRZTm9oTTNWdjdC?=
 =?utf-8?B?VFNsQlZubS9ldmdVZERPLzV1UnhXNTFRSk40UGdaSGVLbDM0N3I4K1FQUmRV?=
 =?utf-8?B?SWV0ZXY1bWdqeldSTGp1ZkdVQ3QyVUg5b2hSMmlBVjVRazBhZ0MzNWtmckNr?=
 =?utf-8?B?RHhRN1l3VXFjRnlMNUNhby8ydGM4eTdZRHdvOEJudkk0QjcwbE1ldVY0NGIr?=
 =?utf-8?B?Ym5KZ2V5NzJxejYxMkxXaFdrUisxZ0RrRzdJZS9OdTY0SmpBR0JDYTRIVUFq?=
 =?utf-8?B?aEhFajNyWCsrVFNpNG90WFRYTTBVLzJJd2xUeDdDK3B2S0RIdTdHVUd3anpQ?=
 =?utf-8?B?VjdRNHo4NUlQMWI5cjRyKzZzczJJcGVHYnJMcHpBZlpCTHdqNkgyWWVuQUVL?=
 =?utf-8?B?RENLRnRIL2wzOVJ3TEpqcHhFbzREREdzVVJqY3Bab1drLzJlMVkzdCtUVkU1?=
 =?utf-8?B?bE1VaDcxcDl2aGZneXROcmpFVUhGQSs0dlZUbXhHMW1lRnc3eXBWekVpVWRS?=
 =?utf-8?B?a2g2Y0Z1MkdDK1gzOEpna05hTS9wUDFUVFVUbDJvdEYyRitOMEdnVmd3dW83?=
 =?utf-8?B?dTJBYVRHRkZoaEs0dStzd0wvR0tkbnBYYXRYQU5WQ1dwS0svTEhSZG55TWVa?=
 =?utf-8?B?b2JjbWllRys2a0xOVlB5S0JxTStZMWtpanhDMTlGMTRuQldIbXNpK0FENEtG?=
 =?utf-8?B?TFNTQXRtb21DOXd6M1Jic2ROcjQ2aGM1NmI2enBrNUhDWXRpVmx4T3dUdFBP?=
 =?utf-8?B?MllRTUdVM0IvVkRiOXBPaWxaMWxYemw3dUUwbnJZcTFrcEUyZG1OVkpBSmo1?=
 =?utf-8?B?aGVaajJlVThqUFdpU2J3TDgvbDVGVjR1dU56b3ZrdllDMGdRMG5SaXhZYUFM?=
 =?utf-8?B?MjFjc1lFRllXei8vZ3NCVHlKVHBnL0FIU0k5clNEMkphandYM1Y5KzRqdmg0?=
 =?utf-8?B?bkdmZmV3dzdzODZHOE1rbXpFNGErZU55VmNzMERFSW1vRmcxUjgwWXBmb0Ji?=
 =?utf-8?B?TWtFOWdvSDRHNmU3Mnk1UW1DS2kyeHU4a2xWSmE2Z0M0U2twZ1RlZFZyNnU2?=
 =?utf-8?Q?gCBnmfeyMK2XrN69lX6oX9l5t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae99d60-1cf1-4925-4e41-08db4be551ac
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 14:47:29.4701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Hs43ioIkLqeP76QW5bk2eMb7eO4WVxQakerfVkgGI3yeAOjyRRVzE5T0wyBo2LPEjjsDnLf8qbs3UsXNBERDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4969
Subject: [virtio-dev] Re: [PATCH v1 1/2] transport-pci: Introduce legacy registers access
 commands



On 5/3/2023 1:42 AM, Michael S. Tsirkin wrote:
> On Wed, May 03, 2023 at 06:26:58AM +0300, Parav Pandit wrote:

>> diff --git a/transport-pci-vf-regs.tex b/transport-pci-vf-regs.tex
>> new file mode 100644
>> index 0000000..16ced32
>> --- /dev/null
>> +++ b/transport-pci-vf-regs.tex
> 
> I'd like the name to reflect "legacy". Also I don't think this has
> to be SRIOV generally. It's just legacy PCI over admin commands.
> Except for virtio_admin_cmd_lq_notify_query_result
> which refers to PCI? But that
> one I can't say for sure what it does.
> 
It is for legacy now, in future it can be renamed if this is supported.
We already discussed in v0 that non legacy should not involve hypervisor 
mediation. May be you still it should be. In such case lets park that 
discussion for future. This proposal is not limiting it.

> 
>> @@ -0,0 +1,84 @@
>> +\subsection{SR-IOV VFs Legacy Registers Access}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / SR-IOV Legacy Registers Access}
>> +
>> +As described in PCIe base specification \hyperref[intro:PCIe]{[PCIe]} PCI VFs
>> +do not support IOBAR. A PCI PF device can optionally enable driver to access
>> +its member PCI VFs devices legacy common configuration and device configuration
>> +registers using an administration virtqueue. A PCI PF group owner device that
>> +supports its member VFs legacy registers access via the administration
>> +virtqueue should supports following commands.
> 
> As above. It actually can work for any group if we want to.
True. As defined by the PCIe spec, for virtualized VFs and SFs devices, 
VI is not necessary, and many devices in PCI space are avoiding 
hypervisor mediation, so whether to tunnel or not is really a question 
for future for non legacy registers.

> 
> 
>> +
>> +\begin{enumerate}
>> +\item Legacy Registers Write
>> +\item Legacy Registers Read
>> +\item Legacy Queue Notify Offset Query
>> +\end{enumerate}
>> +
> 
> Pls add some theory of operation. How can all this be used?
> 
ok. I will add in this section.

>> +\begin{lstlisting}
>> +struct virtio_admin_cmd_lreg_rd_result {
>> +	u8 registers[];
>> +};
>> +\end{lstlisting}
>> +
>> +\subsubsection{Legacy Queue Notify Offset Query}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / SR-IOV Legacy Registers Access / Legacy Queue Notify Offset Query}
>> +
>> +This command returns the notify offset of the member VF for queue
>> +notifications.
> 
> What is this notify offset? It's never explained.
> 
ok. will add it.
It is the notification offset where a hypervisor driver can perform 
driver notifications.

>> This command follows \field{struct virtio_admin_cmd}.
>> +Driver sets command opcode \field{opcode} to VIRTIO_ADMIN_CMD_LQ_NOTIFY_QUERY.
>> +There is no command specific data for this command.
>> +Driver sets \field{group_type} to 1.
>> +Driver sets \field{group_member_id} to a valid VF number.
> 
> I think ATM the limitation for this is that the member must be a pci
> device, otherwise BAR is not well defined. We will have to
> find a way to extend this for SIOV. 

SIOV device will also have the BAR and offset of the parent PF.
The limitation of current AQ is currently is it indicates the BAR of the 
member device (and does not allow group owner for SIOV), but we can 
craft it via SIOV device BAR and it will be fine. SIOV spec is not yet 
released for this details at all. So we can wait.

> But that is all, please do
> not repeat documentation about virtio_admin_cmd header, we have that in
> a central place.
> 
Make sense. I will omit it here.

>> +
>> +When command completes successfully, command result contains the queue
>> +notification address in the listed format:
>> +
>> +\begin{lstlisting}
>> +struct virtio_admin_cmd_lq_notify_query_result {
>> +	u8 bar; /* PCI BAR number of the member VF */
>> +	u8 reserved[7];
>> +	le64 offset; /* Byte offset within the BAR */
>> +};
>> +\end{lstlisting}
>> diff --git a/transport-pci.tex b/transport-pci.tex
>> index ff889d3..b187576 100644
>> --- a/transport-pci.tex
>> +++ b/transport-pci.tex
>> @@ -1179,3 +1179,5 @@ \subsubsection{Driver Handling Interrupts}\label{sec:Virtio Transport Options /
>>           re-examine the configuration space to see what changed.
>>       \end{itemize}
>>   \end{itemize}
>> +
>> +\input{transport-pci-vf-regs.tex}
> 
> As simple as it is, I feel this falls far short of describing how
> a device should operate.
> Some issues:
> 	- legacy device config offset changes as msi is enabled/disabled
> 	  suggest separate commands for device/common config
This is fine and covered here. The one who is making msix enable/disable 
knows which registers to access before/after disable/enable and device 
also knows it as it is supplying the register.
So they just follow the standard legacy register access behavior.

> 	- legacy device endian-ness changes with guest
> 	  suggest commands to enable LE and BE mode
guest endianeness is not known to the device. Currently it is only for 
the LE guests who had some legacy requirement.
and PCIe is LE anyway.

> 	- legacy guests often assume INT#x support
> 	  suggest a way to tunnel that too;
INT#x is present on the PCI device itself. So no need to tunnel it.
Also INT#x is very narrow case. When MSI-X is not supported, a 
hypervisor can choose not to even connect such device to the guest VM.

> 	  though supporting ISR is going to be a challenge :(
> 	- I presume admin command is not the way to do kicks? Or is it ok?
> 	- there's some kind of notify thing here?
> 
Right.
We already discussed this in v0.
Summary of it is: admin command can, but it wont work any performant 
way. The device and driver uses the notification region already present 
on the PCI VF device, which is queried using NOTIFY_QUERY command.

> I expected to see more statements along the lines of
>          command ABC has the same effect as access
>          to register DEF of the member through the legacy pci interface
> 
Yes, good point. I will add it in the theory of operation section for 
this mapping detail.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

