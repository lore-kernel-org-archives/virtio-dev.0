Return-Path: <virtio-dev-return-12592-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BA7C77B75
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 16:03:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CE9E52AEE1
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 16:03:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C68209866D7
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 16:03:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B70589866C3; Fri,  5 May 2023 16:03:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A3BB29866C4;
	Fri,  5 May 2023 16:03:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/RlWhb9rMtQyrGqtjxjEPgrK8c5Hw8uVRd1CnojsBpgTnJgkz6Gyq2m7lZH4UC/sVMSWhbF0Lby1ornDJdbenGI+fgK65fitcBa2UXa6ayXIkYGM25KyAUZ+Q1wBVyJO8gaVCPX51CgELyVF77x1fdxoCOqCj8oAm86cbxH7O6bWSwCxVOgNo89jg4eNCAh1RRwWto96A9bg9KeIK1ABucrubR2w4hSem3aJWr7uyaQUH1X17jVqP+iU6gjnwyQpkUmqbqgBilBQQ9llAmE/4q/Ki0Idhs9Dx/VvHh6ZnwgF4p5LINkhDsB2BizJFZ3PvaspXqBnjo4GUSbgbJDyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aJk3V1YvyRHzlJwBjAE+bcHLz/g1VOUnHlejYgIMlk=;
 b=Ue2J+I5oXl1hrUcaeiAQrnMdvKnC0vyI6VXncLZ63rHquTd8ruuUtPfXxME0wS0x/NNmeOhM70pq+TjpNTKSKZXmOnft3tRmZZ2bERoTbCaK5GP/CuBGRxFJ0VCWMuKxWJCpa0ANqMTnOfrmpXcObyvORJgGhdZkOiFPHZfA/hgKqzt+ACeZrGWoGSJEkFr2YXExhNHAiwsV7VYfc6SHX7SOMlY0qcx3GRPL0x1+HRwbMElh0E6yRCUBFX3ufQ3O0Is+nKMdkMPhIxMBT0W6Xq9OXGJ0cWv7zxZN6vJhJMj7Dnuwle6aPun05wYvpUgA8pK4vyucO+NK4nUGWm3QRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <3a618d58-3b34-7919-446f-0e99d67d410b@nvidia.com>
Date: Fri, 5 May 2023 12:03:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: "Michael S. Tsirkin" <mst@redhat.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
 stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
 hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
 Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
References: <cover.1683301091.git.mst@redhat.com>
 <dc246cd15fce198dabb47f2de9b34dcf16820744.1683301091.git.mst@redhat.com>
Content-Language: en-US
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <dc246cd15fce198dabb47f2de9b34dcf16820744.1683301091.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0058.namprd07.prod.outlook.com
 (2603:10b6:5:74::35) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|DS0PR12MB6606:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc63ead-eaf6-4b01-ca73-08db4d8238c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H6Zd4RlxgDyQnEkeqE2WKGMM317W42bSDpk7q4H/59JWgtn1KvsdUZaGjMTb4j8v85UlM332KygYWSwYXDUUGlCifurJNuXDT2Hx+TqEkGW4pTSYk0XuqcUxdYtErpX3HYbo0G392LBvtzOdIX/o254bnFgesFEyKRhUsgddM/TlkHzvvbEkduWrXqj/0htJIUM0PUdIbEfQYcksZfUSPFIdwFd1vmDuRm0qsugDKWLA7pyFzQbpiU+5rsGsLn6zSaV8qYwRHErY6aKHHhZBFdmRq6OZt2FJzSlgj9O/EY595QHMoAJAI9QhHEv+7dBFJsLxxrV+bSJIxscAYjfv4JfBpwUtBiAGdIdy98TMzmTOfEYYSFDYgbLu3qwe0CyN6CinrX9Rgu711hK9ouJ2YoDA9C/M6Cgk/GXFjNHSCL04sZeayzcUBGHmdUl8ZlQw8cdPCRqSSi7hGDLQdyYvLDQI0UBduS97VRaoO4e9MbYiGmp93goHruCRko2XpozdBcZDX0982aJ+aS7sNd3p1wVVSAD1E0pnKlqTnaGZ+/4aprv5Zhh21DQJXpBd0RlWwUvjNOcFVFppI31ehIruffmLiSSAcK5BveDOH7jVY8OiG8HTAVzTiyZ2tLMjLF9TUbKI5jmnWJbiSWfPxtDaJeyuzKcp2wZ+rWiGpQ0AUmTMK6MqWJ4aiqAvSCRbuaTeBOAT8XDw3UlvG4hfR83rKg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199021)(36756003)(6666004)(31696002)(86362001)(966005)(316002)(54906003)(4326008)(66556008)(478600001)(6486002)(66946007)(66476007)(8676002)(8936002)(5660300002)(2906002)(41300700001)(7416002)(38100700002)(186003)(921005)(107886003)(26005)(53546011)(6506007)(6512007)(83380400001)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3hlS3E4bDZ4SUtjOG5BQXBDdHY4REdQbks0c2VreGJFdTZ6WmEwdm1lWFFT?=
 =?utf-8?B?K0J4MHF5UWdJdWRqUTVhbjVQbzh3b2tiWlQ4Z2dBMmtrb25aLzZNaVJSdk80?=
 =?utf-8?B?WHpac0FJeE96TWVZTVBoVHF2VmtlanFGem9OdGNHeVF2M1ZSOU1ma0RzdGQw?=
 =?utf-8?B?N1h6Vm0vYXM0SlFZaXZUYXRDWTB5S3orSzkraEFiMldsc2lmZjcrUFdhbVF0?=
 =?utf-8?B?UFdEMHN5NzhoTElGSEdPczdlMllwSlBhVG5HWkRvRGRoT2REUzJrRUNJaEtp?=
 =?utf-8?B?eGtEUjJudUVBalYyQzQ1cXpMZkJEUVhYVkkySEJrdlRmL3N1MkNrNngwYm1V?=
 =?utf-8?B?WDVmdnA5d2VnS3ZJNVhpbmFDK3lNWEJYaitKSmZ1VzVTaUVSa1J6eG5FTkcw?=
 =?utf-8?B?S3lZZzMvSHREMFhJRTlGNWdERGlVZlEwd3dRZjBiUHY0WlNoUk9zcFNtb25V?=
 =?utf-8?B?d1FXcGR6bWNqOURGMVNBMmIwYU9MbVEwMVJJNWZaSmtyejFEZDBWbjI2OVlT?=
 =?utf-8?B?ZnJwbjEvS3RzendSR2FKaldEK1N1Q0Rpem9qWkZqNStvcUlMVkVTeDhzSURF?=
 =?utf-8?B?OGNsNk51Z0lyU3BvcC9pQzJSMDN3U1F0NDhZUTBtQmk1RWVTcEpHa2JrN0Zx?=
 =?utf-8?B?SEx4SDJ0N2IvN01UY1I5RU9DTHRxY0V6cXE4Zis0ZGE3V0M5WjJmd05kZURt?=
 =?utf-8?B?NXVnc3Z5ekwvbDA4WmJXdW1XMW15ZzU4ekZlUHJYY1IzNTNhOVYyUi9iNzkr?=
 =?utf-8?B?TG1BK0ZpcUc2TjFBWlprTzNOS3RwYlYwV2E3UDJxbnVPUjBRK0NKSzNwbk1a?=
 =?utf-8?B?SlR1bERYdStlL1ZWQTFWYlMyZm9veExwTmJWOFNQZUh1ZXhmOVZRVGMzbmRS?=
 =?utf-8?B?dkt4L055ZEs2SmJJNUNwaW12TG9lM01jWUpZY0FJYnhtRXpxNFA5dnBCK3Vt?=
 =?utf-8?B?MnpCNjJLc0d5SkNrTzJzL0x4MEhkbWNxR3ppR3NNSGM4eUwvU0pDZHdDUzRO?=
 =?utf-8?B?d2lremtrd2J1ZFR4UnNteGI3Q3VzK2ExOHpnNTEzUWI1dGduNFhUUytxQk1I?=
 =?utf-8?B?ZjNMMk84YVVvWUFJWGFjQWxpRXIzYlIrdjhyV0xNa05Yc3QrTGUwYWRvZFFI?=
 =?utf-8?B?MmduVnpMeWJPWFhPSVVBTWZ0MVZRdGxadjdyUkJnb2xOY2NYY09UTmh3eGlZ?=
 =?utf-8?B?Q2tsYVlWbXkvREd3aFFOK3YyQTdNdnhBMjkrQXZaNmRZWmZ1TksvdzYwRk5i?=
 =?utf-8?B?WlpTYkNyQUJubkhiSnpFRzNnSE1QNSs4Qm5JZW15NHFaQzV4NDhHNkYreVlt?=
 =?utf-8?B?ekhjeDRDTnJvUUtiMmk3dlN5aTZWbmxhVjBOZVQ1Wk5JYU1yM1BtM3NYK0lT?=
 =?utf-8?B?MXdET0pKYnpYbUkrYTlqUnZsc3ZFS2ZCd21kVm5oUHpZeDU5Y1lyVHJGT0N2?=
 =?utf-8?B?dWVaZElocW1ZY2V5cE9QZm0vZEowZTAyQmlGRkN2OXRCMGNmZVdTOHVqT1My?=
 =?utf-8?B?VXorK0hJV2VZbURxUGpDRWo1SGxBQ2phd3NPQndBVjU5Q2VyOG94Q1lxSEY4?=
 =?utf-8?B?SlJDekF4aWI1MHNOTUhxWjVjMUZYRE0wUE96WGczZ3BrNUZyNVNHQ2dpUWZu?=
 =?utf-8?B?WUY1bUkvWkRpVFpmQ1pyNXZTeklVRXl6eGUzWU9yd1ExVjlkRGkvVmdOOENX?=
 =?utf-8?B?c0YxUGZPM0FuU0QwYWdjaFZETkNpZEw3VlRJazhVY2ExRFI5RGtqUGdkVE5I?=
 =?utf-8?B?SXQrejBMMko4a1VaQlRRbUlhWTErMW95Rnc3SDExTytQQ3dIcUxNTHZYTVNB?=
 =?utf-8?B?YVhwdXBjbkdsYzB4dnlVYkFRK2FmdlRyaFlVMzZBT2pHenpHbDlsOEp5R0lw?=
 =?utf-8?B?WTU1cmRJS25hSzU1bDNiNHAyZWV3alNsRENpRjRuQlpKZHRaQStWb0JCT3lr?=
 =?utf-8?B?aEtFWU5YTXh2OEJIblhsSWx3VU9NZEFIdXVxWXluSUNmUytobncvQzF5bTBK?=
 =?utf-8?B?akhZc0dJb053WWhBcmxvK3RkM3VEaktFV1ErbTd5cVd1TjBpcVAva0ZoVnFW?=
 =?utf-8?B?U2Z5NWFibXEyTE9xR0xwcjBORUNzQXg3bGVoUzI3ZFQ1Mm4xZTVlT1Q1YjZL?=
 =?utf-8?Q?u6dATmDInSznradphiGXmuai7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc63ead-eaf6-4b01-ca73-08db4d8238c4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 16:03:09.8176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEoR+44pRmdETIMiAn7+svGILRszdM9fyGyfCF5+0igvqbxYUyez6lazPzoOS4bH9iK/pz9J524AJH6l7B4yBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6606
Subject: [virtio-dev] Re: [PATCH v13 03/10] admin: introduce group administration commands

Hi Michael,

On 5/5/2023 11:40 AM, Michael S. Tsirkin wrote:

> +\field{opcode} specifies the command. The valid
> +values for \field{opcode} can be found in the following table:
> +
> +\begin{tabular}{|l|l|}
> +\hline
> +opcode & Name & Command Description \\
> +\hline \hline
> +0x0000 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
> +\hline
> +0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a different structure)    \\
> +\hline
> +\end{tabular}
> +
> +The \field{group_type} specifies the group type identifier.
> +The \field{group_member_id} specifies the member identifier within the group.
> +See section \ref{sec:Introduction / Terminology / Device group}
> +for the definition of the group type identifier and group member
> +identifier.
> +
> +The \field{status} describes the command result and possibly
> +failure reason at an abstract level, this is appropriate for
> +forwarding to applications. The \field{status_qualifier} describes
> +failures at a low virtio specific level, as appropriate for debugging.
> +The following table describes possible \field{status} values;
> +to simplify common implementations, they are intentionally
> +matching common \hyperref[intro:errno]{Linux error names and numbers}:
> +
> +\begin{tabular}{|l|l|l|}
> +\hline
> +Status (decimal) & Name & Description \\
> +\hline \hline
> +00   & VIRTIO_ADMIN_STATUS_OK    & successful completion  \\
> +\hline
> +11   & VIRTIO_ADMIN_STATUS_EAGAIN    & try again \\
> +\hline
> +12   & VIRTIO_ADMIN_STATUS_ENOMEM    & insufficient resources \\
> +\hline
> +22   & VIRTIO_ADMIN_STATUS_EINVAL    & invalid command \\
> +\hline
> +other   & -    & group administration command error  \\
> +\hline
> +\end{tabular}
> +
> +When \field{status} is VIRTIO_ADMIN_STATUS_OK, \field{status_qualifier}
> +is reserved and set to zero by the device.
> +
> +The following table describes possible \field{status_qualifier} values:
> +\begin{tabular}{|l|l|l|}
> +\hline
> +Status & Name & Description \\
> +\hline \hline
> +0x00   & VIRTIO_ADMIN_STATUS_Q_OK               & used with VIRTIO_ADMIN_STATUS_OK  \\
> +\hline
> +0x01   & VIRTIO_ADMIN_STATUS_Q_INVALID_COMMAND  & command error: no additional information  \\
> +\hline
> +0x02   & VIRTIO_ADMIN_STATUS_Q_INVALID_OPCODE   & unsupported or invalid \field{opcode}  \\
> +\hline
> +0x03   & VIRTIO_ADMIN_STATUS_Q_INVALID_FIELD    & unsupported or invalid field within \field{command_specific_data}  \\
> +\hline
> +0x04   & VIRTIO_ADMIN_STATUS_Q_INVALID_GROUP    & unsupported or invalid \field{group_type} \\
> +\hline
> +0x05   & VIRTIO_ADMIN_STATUS_Q_INVALID_MEMBER   & unsupported or invalid \field{group_member_id} \\
> +\hline
> +0x06   & VIRTIO_ADMIN_STATUS_Q_NORESOURCE       & out of internal resources: ok to retry \\
> +\hline
> +0x07   & VIRTIO_ADMIN_STATUS_Q_TRYAGAIN         & command blocks for too long: should retry \\
> +\hline
> +0x08-0xFFFF   & -    & reserved for future use \\
> +\hline
> +\end{tabular}

Did you miss taking my 3 changes here I posted at [1]?
https://lists.oasis-open.org/archives/virtio-comment/202304/msg00532.html

Or you sent some older version by mistake?

or they got fixed in some later hunk in this series?

Without this changes pdf generation is broken and manual intervention of 
script generates pdf table which is messed up.

It is not too late, to fix and resend quickly.

Or probably list down the known issues and I will create the follow up 
patches as these are mandatory non cosmetic editorial changes.

Please let me know how shall we proceed.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

