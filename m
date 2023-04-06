Return-Path: <virtio-dev-return-12033-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22080C76196
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 04:08:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 56415330B2
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 04:08:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 41E3E9865EB
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 04:08:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 36C67983EBE; Thu,  6 Apr 2023 04:08:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 246409865B3;
	Thu,  6 Apr 2023 04:08:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGFbkil+5IhkCR9E+GL11rn/5nD9n6avbcWhRNwxTXcU8+UAbGyD6PG/8LelfEv3FgtQA4TTgSQcLb9Y2Rg6EWu5VgiKrua6MfFCPpNJ3HvMIMfJKmco+z+0vyErqbQlr5+lfJX7RnuYPZaHfXww689TwgnEoQqXY1M9hMor7DiB0VUpO8hclflYfVpmplP6rSNMewyX7pAwtIwXCetzFOgxGIo8p9pBJ6l0ccpb6ZT2RtYGi5IRs1ju5yFJ/Mdbo4w3jY1DvZh5LvoYnhlXX0IMLNWJmRTSgurLRWL0N+fUQPvG1RFbaiq7dzKWCvzXVBT99uTR7bkbVQHAlFvhUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/D8uLeXZGRO5wwtYO52Xmdd+XqZSTLC7rURLeKVnvA=;
 b=MBjNfh+GybHvXYP3xRMPOW4sH7/DFGAeFKHspPw7CJnQG+jX/ij0zAYbOY7Iw4CkdVTvx4TblXhVMms40i/3DuNoGukIGggwX4nCgSTVnuL+Y628ZhIsfc5+RqolgU2QkQCqfTgV9arjRzQMofTYH8tGcJubF+ORtnGkWL3wqpeltFASkp+mfKDCdZBMUKDknjKSBaCR0tPCP0FWPJSKnLOLQzMZU8t2b2uI33ZJV9aEym74ht2PP89nPqXxYnETR2IKjAmwyHZbWWf9RcXxP+BHwcOUpm+v0pWhDt1piV52ju7Ma49KUQ58zPOCRCHRpp08jpVl7Df7mci76rvYjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <2ebedc33-1fa8-1fe5-67eb-8d657cf932db@nvidia.com>
Date: Thu, 6 Apr 2023 00:08:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
 stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
 hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
 Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
References: <cover.1680533760.git.mst@redhat.com>
 <9cbecf20548a7adf4d97d07b17e40eb3c1c50209.1680533760.git.mst@redhat.com>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <9cbecf20548a7adf4d97d07b17e40eb3c1c50209.1680533760.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0055.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::7) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|DS0PR12MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: d05cb2d8-b1bd-408f-880d-08db36548716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iHO04tRpuNiylQz/XMgwWyJu2mEffzXbI0eAAQw+lugR6UqFkuetWSWS3tH+kxExDwaDKgRpfJkn944ANJwdQWMrCNXbVhdZSFxOB/Tef0wvhFztRsaXPAfdtqGyV4gzA5sssNoHFf49mEceb4esQ2GWBG3GgNVYzZSFvdw93GW5PrCEAJWFyqJtbQZ4kaV9HUw8LlKqQPOp7eSn/6eYi9Yoom0PZTp21XmT1Ipeb8yFApRpKMukPQmI5AfHdUOqED7VBwiHoyohCVDty14x03pizjbm9RLh7jrR1F9F4JNugEt0ercHx2gLHkwi+PblpHVwicKcmZ6vQR6AFI6d0L/0UXsk+JiHo6y2KDmYFcy5ZzTGOjX2abEyT14A1Q3sJI/wdtVUN4eQG97PDF+F8Xo2DufugRLzSCGvGJlWGhrvOmJYl5mFZiQHx/cNxnRx5C6qPpi3ajSQWOBIJ5D4NeGf0vE6+e23Ft50gLrJ3UpThAN40r6/E/87xSgboe0XPAeVbd68KjTDh/vDMQDYVKwLYzqZ6PHLXTxbF/pmLRaXHVHp19v9Wc9qMHMg00OEMbkiVPvp868nP+SAdVuNo3ICeYp+D3hY1AsWh0wN63C+abXhCsRkz4KAfFYb8QAQG6ViQTuyOocqMurq68poUf+vu6+mjUxZ4//kKzuVJGQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199021)(107886003)(41300700001)(6666004)(86362001)(36756003)(31686004)(54906003)(186003)(4326008)(921005)(8676002)(31696002)(478600001)(2906002)(38100700002)(66556008)(66476007)(83380400001)(66946007)(316002)(6486002)(8936002)(26005)(5660300002)(53546011)(2616005)(7416002)(6512007)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGhkbWhqZ1VaUVBZUmFCaVNmTWxRUkJKK0c1Y0I3cGxtRTUyMlN6MHVpN2ph?=
 =?utf-8?B?TXVNdmZOeC9MdU10LzYxTVlCSDAzQjVKa2orTGhieE1DMll4T2I4M2ZhM3BB?=
 =?utf-8?B?TVJFbHV3M3ZyQ2lqd2tJa1Y3VmZLbk5TY255VUR2ZldYMm1oSTFsdnJ2NTM2?=
 =?utf-8?B?Sjh3Q25vdTRPaURsYlRXdVl0eGd6MmJUR1RCd1VKRUJrekttTGpNNmt0QXZ1?=
 =?utf-8?B?UHl2UkFncEFBbEFxOWh1QW9rd3dhdDVOS1djRFJadWw0aDd0L0NlYmhMck03?=
 =?utf-8?B?V1JWbDZoK3pxVWtDVmN0N3J4M2sxYzQvMGJWbTUycG1KcWpLNXQrY2RNQkxU?=
 =?utf-8?B?MG4vU0NDc2grVVdHdEMyV3c3K3AwQXI2TEVTS3NFRVhWZ0dJYnRVTWhWWW1Q?=
 =?utf-8?B?ak9WM05XT0pnMjQyVFlQNEY1RVF4T3NQOVhCOERKRXNMaTkxQ0Y0U1lVQlJl?=
 =?utf-8?B?YjZFamx1L25rdFkzMWhSdmRidzRzdE1ITXVDckpNZ1Zsa2FhMzYwc2huMzNI?=
 =?utf-8?B?T0o4ZmUzQUZDUVQrSkUrN2pvWVhPTnBoQXRna2FNNEcxQ0cyalBKM3EyZ0Rl?=
 =?utf-8?B?RDFnb1pYYjdLNzR3b2svVDFDZzU4U3pFUllERHkybHRoMlI2eVhRVGFoWVVX?=
 =?utf-8?B?VFpGYzF0ZjJmbzB3VFBUV1FyRjRBa2RXQlU0WXVvRHdadTRMTFV6dSs1ZENK?=
 =?utf-8?B?eUFoVGhpZldud0ZDTFlDR0YwNjZRQndBTW1jZGtpSjhCRlplcWlxYVVncWdD?=
 =?utf-8?B?eTgyeTVmZjFtSjZKMHE5OVowVmp4a0R6TzFkMEM3aVFFUTlWa1dVR3dTalRx?=
 =?utf-8?B?ZXFFdHFnTXBQSkhnMTZMU1RlYlNWT3FFbFNQOTQ1d1pueUtJek0wT2EzeFpD?=
 =?utf-8?B?V3dTVjZ3WmhxcmFOMmcwSXRZQmhoTS9WcEpaYitXanA0S3duOC80SmVVckti?=
 =?utf-8?B?amtVMG9PQ1c1dmpUUjBXZzFBQWhFMjRZVmZONzRVWU9EQmdiRkpnVGlZb0o4?=
 =?utf-8?B?SFBDMCt2WUkvYlRTci84VzdtdU9WaFhnVVEyNlBwZGRZTjk0TU4rbC9HZ0E3?=
 =?utf-8?B?M2FlSHVWRkJTOWcrOHNST25yQWtVVDlFQjNEUldkOEx0bTlrTHhiU2FNUGt3?=
 =?utf-8?B?aG90QXNKdVlGclB1cXdmbDhUcjVuUjBsMzZ1Z25WNks2ZUdHOWw3a3pFWFRu?=
 =?utf-8?B?U2lSa29mNVdVWmo1Yngyc2R3SzBYWE9leU9pRkk5SE12QWZkSUlJaXNGN3pw?=
 =?utf-8?B?Qy9iWGUvSU1nem93TWhPVXl1dVh6WTc0eG9tczd4dG5Pd3dKb0VqUjJoMWV0?=
 =?utf-8?B?R2JtaDA4ZXczcWJwZThUY1JqVG51RmNzTlJkRDJEVkhuZW1KaW9vTEFpWVNn?=
 =?utf-8?B?YlUxTzNSVTJXVityS0hTNDAzR0lRZ3FyQ0o4a2d5NlZUelNuVjBYaTdaMTRh?=
 =?utf-8?B?WHRKWVNYTVQzbTJ4SzE3VkF0NC84R2JEMWcwZjNiemlSQ0JyUXNSQWlQOHpS?=
 =?utf-8?B?R3Y4QmlnTFd6VC83WGxHd3RNcGhSNkZodStsSTJMK3ZYTm9zeHdNNWN1NWps?=
 =?utf-8?B?TWVuM0x0NkxEL3pzc3N3UGlmS1lwR1pDWnl5ZTFBRHRnMit6OENjb0lhOVlC?=
 =?utf-8?B?YllHRTlodmV2Q25lZUtIS3J4Rno1SmtsR1hMZjBzTEpTcHF4NlY5OHFqQjF6?=
 =?utf-8?B?SzJoT3dCRlBhaWd3UHR5MGdMT0VnT251bngrWm94NE9WTjZ0Rkl4bTZnNkVn?=
 =?utf-8?B?dUNqZnVRSkcxdFhQQnRVSHRPcXVMTUdWcUh4cHIrY3JEdk1SZ2N2YnVYM0xM?=
 =?utf-8?B?K0dreHlWRWJYNE9JSEJxbDltYnNOazh0QkdnNHRiQk8xTUFYNGhYZjJ1aDF4?=
 =?utf-8?B?Q09GUVRFZTN1YnBnZENmU09CRi9jYjlSbUZLUVY5emlRcElBZWxRMnNvRTBI?=
 =?utf-8?B?VWpKZ3piNWJFK0JtRGc3dExraG9kWTBsNU9PaWg3V0tZTm15WFJCcXJLRXJ4?=
 =?utf-8?B?N1c5WXVsN3NuaDNqTFpXWDYxZDhGTDJ4SHo0ZGJ3dTRuOGY3VkZuZW1hTXpm?=
 =?utf-8?B?ZC96ZkZyemZxSUZmd3E4Q3B1Tyt0dmtMSVdVMTlLdHRRdHh1OS9zSXVBanR1?=
 =?utf-8?Q?OzfqfEOj9Ix+QBMuBq2Zb5K3G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d05cb2d8-b1bd-408f-880d-08db36548716
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 04:08:07.6449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: edjLTR3VIdEZyhR/4X1ikfDnESNgq06trs4QmPDbULMwnqRvL47+c4uXQ3IEyELXsSX+QfrDRnD9wljGNsaoLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8245
Subject: [virtio-dev] Re: [PATCH v11 04/10] admin: introduce virtio admin virtqueues



On 4/3/2023 11:03 AM, Michael S. Tsirkin wrote:
> The admin virtqueues will be the first interface used to issue admin commands.
> 
The admin virtqueue

> Currently the virtio specification defines control virtqueue to manipulate
> features and configuration of the device it operates on:
> virtio-net, virtio-scsi, etc all have existing control virtqueues. However,
> control virtqueue commands are device type specific, which makes it very
> difficult to extend for device agnostic commands.
> 
> Keeping the device-specific virtqueue separate from the admin virtqueue
> is simpler and has fewer potential problems. 

> I don't think creating
> common infrastructure for device-specific control virtqueues across
> device types worthwhile or within the scope of this patch series.
>  > To support this requirement in a more generic way, this patch introduces
> a new admin virtqueue interface.
> The admin virtqueue can be seen as the virtqueue analog to a transport.
> The admin queue thus does nothing device type-specific (net, scsi, etc)
> and instead focuses on transporting the admin commands.
> 
> We also support more than one admin virtqueue, for QoS and
> scalability requirements.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ---
> explain ordering of commands as suggested by Stefan
> dropped Max's S.O.B
> reword commit log as suggested by David
> minor wording fixes suggested by David
> ---
>   admin.tex   | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   content.tex |  7 +++--
>   2 files changed, 80 insertions(+), 2 deletions(-)
> 
> diff --git a/admin.tex b/admin.tex
> index c869a1a..f201bcd 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -182,3 +182,78 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>   \field{command_specific_data} and \field{command_specific_result}
>   depends on these structures and is described separately or is
>   implicit in the structure description.
> +
> +\section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
> +
> +An administration virtqueue of an owner device is used to submit
> +group administration commands. An owner device can have more
> +than one administration virtqueue.
> +
> +If VIRTIO_F_ADMIN_VQ has been negotiated, an owner device exposes one
> +or more adminstration virtqueues. The number and locations of the
> +administration virtqueues are exposed by the owner device in a transport
> +specific manner.
> +
> +The driver queues requests to an arbitrary administration
The driver enqueues
> +virtqueue, and they are used by the device on that same
> +virtqueue. It is the responsibility of the driver to ensure
> +strict request ordering for commands, because they will be
> +consumed with no order constraints.  For example, if consistency
> +is required then the driver can wait for the processing of a
> +first command by the device to be completed before submitting
> +another command depending on the first one.
> +
> +Administration virtqueues are used as follows:
> +\begin{itemize}
> +\item The driver submits the command using the \field{struct virtio_admin_cmd}
> +structure using a buffer consisting of two parts: a device-readable one followed by a
> +device-writable one.
> +\item the device-readable part includes fields from \field{opcode}
> +through \field{command_specific_data}.
> +\item the device-writeable buffer includes fields from \field{status}
> +through \field{command_specific_result} inclusive.
> +\end{itemize}
> +
> +For each command, this specification describes a distinct
> +format structure used for \field{command_specific_data} and
> +\field{command_specific_result}, the length of these fields
> +depends on the command.
> +
> +However, to ensure forward compatibility
> +\begin{itemize}
> +\item drivers are allowed to submit buffers that are longer
> +than the device expects
> +(that is, longer than the length of
> +\field{opcode} through \field{command_specific_data}).
> +This allows the driver to maintain
> +a single format structure even if some structure fields are
> +unused by the device.
> +\item drivers are allowed to submit buffers that are shorter
> +than what the device expects
> +(that is, shorter than the length of \field{status} through
> +\field{command_specific_result}). This allows the device to maintain
> +a single format structure even if some structure fields are
> +unused by the driver.
> +\end{itemize}
> +
> +The device compares the length of each part (device-readable and
> +device-writeable) of the buffer as submitted by driver to what it
> +expects and then silently truncates the structures to either the
> +length submitted by the driver, or the length described in this
> +specification, whichever is shorter.  The device silently ignores
> +any data falling outside the shorter of the two lengths. Any
> +missing fields are interpreted as set to zero.
> +
> +Similarly, the driver compares the used buffer length
> +of the buffer to what it expects and then silently
> +truncates the structure to the used buffer length.
> +The driver silently ignores any data falling outside
> +the used buffer length reported by the device.  Any missing
> +fields are interpreted as set to zero.
> +
> +This simplifies driver and device implementations since the
> +driver/device can simply maintain a single large structure (such
> +as a C structure) for a command and its result. As new versions
> +of the specification are designed, new fields can be added to the
> +tail of a structure, with the driver/device using the full
> +structure without concern for versioning.
> diff --git a/content.tex b/content.tex
> index 04592fb..2eb15fa 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -99,10 +99,10 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
>   \begin{description}
>   \item[0 to 23, and 50 to 127] Feature bits for the specific device type
>   
> -\item[24 to 40] Feature bits reserved for extensions to the queue and
> +\item[24 to 41] Feature bits reserved for extensions to the queue and
>     feature negotiation mechanisms
>   
> -\item[41 to 49, and 128 and above] Feature bits reserved for future extensions.
> +\item[42 to 49, and 128 and above] Feature bits reserved for future extensions.
>   \end{description}
>   
>   \begin{note}
> @@ -7684,6 +7684,9 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>     that the driver can reset a queue individually.
>     See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}.
>   
> +  \item[VIRTIO_F_ADMIN_VQ(41)] This feature indicates that the device exposes one or more
> +  administration virtqueues.
> +
>   \end{description}
>   
>   \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}

Reviewed-by: Parav Pandit <parav@nvidia.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

