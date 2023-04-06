Return-Path: <virtio-dev-return-12032-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A80C76196
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 03:59:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4F2C326A43
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 03:59:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4037B9865D8
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 03:59:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 355819865B5; Thu,  6 Apr 2023 03:59:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 203679865B3;
	Thu,  6 Apr 2023 03:59:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfDM900Uv35qMfqQiyXvIk16Dt7K1+uoAS02T03H78d/WBoUaxhIG9jnUuMXjh9h191UGwIk7pgwl27SNqgXjH8/0fBS+CsnMH5zB9EbN5yqB4tkKUrBe/lVufWvxOYi/l/bs5LBBDYZi9t6kp9YEnYvfG6Am04N3vj+0VhBncaykS8l4bizLi7f0YoigXK58mSByf16At7QHFcUgA/4THJe4FrTsXsZzEqXL05xLAkuF8fgNkLLUYhjIZaTsJAlDHQR7fFSOw+LUuxkRLhsjKlUVPszvKoO6NE5ddkFv1emd/cOKou11D50uzErhpkt0ZXp1EeFAy59/QzjJj5DBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30sj+/HBixBNO0o6NbhDvh6657FSAtX+uYjjrSMwKfE=;
 b=WUwsWGr7Q/1c+FWjQ82Uk3TPvE191j9sQ6doQ90RpSddiFRCKtY+RRRCKRb5erzgSZQkv0ZPbsluvnvDmy787hZ/HJ1U+vedWfONXAqy8pifpd0nBrnmv18w6VrsY+u8Os/PzYsAwTJPi4ftae1+1vXv4FmK9+1sdalcN86xouErj+K3HiklK/rPi0UhM6oMMz5CN1aKc3zxS5yFMLn4MjSzuZiSpwe8dEt4TrfAC6kC/ym4BZbYHBP9no32KbWxZHXRH8b6V3KsDRnoD1IfpY/hRzhCgVShH8iLMav2m93oP5vW1les316Zn4Fkr04ypTVIMhzPWtkfeiX3Oc1SrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <c8540cb3-a90f-5f46-c27e-cd1b7c25ea77@nvidia.com>
Date: Wed, 5 Apr 2023 23:58:51 -0400
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
 <93b34ea59bedbff0671ede2b171cacc1078f30ff.1680533760.git.mst@redhat.com>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <93b34ea59bedbff0671ede2b171cacc1078f30ff.1680533760.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0109.namprd05.prod.outlook.com
 (2603:10b6:803:42::26) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|BN9PR12MB5194:EE_
X-MS-Office365-Filtering-Correlation-Id: f030cf73-1671-4807-e217-08db36533d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JbkVBVCH/KrkiOVyQdeRLaOQRsMR3OuS78u+T6XSeWYq7H3jyl9ax6EOrfWdPBm3FvdqYMcasQNp+RRvFQ9KelTjQi7jyot+R76eoIXkT9ymDNl05rD/nGqNtudaNBEXC058WAz14PxvNv5cHG47BnqgiGvfbkgoLNNlmT99PKSeKRHU1MP30YBylhtbFUJ8vBTMPOKxlw0vnyFEctH2ExJf2SaXXE1Wi8dQa0R1kiCyx23m1kTDxX39qC+Kw7MXeUJQ48y6SyiMfxLcWrN6XEE8H23W1zJgynO35wY/gJVhSJpa0vN3jvSAqa/pihf9eouOyT6NQfTE1epa9EFo92FO9cGeUeRBixT3C+ewSgAemo5k+joVzvIch2pMypa3wKVfRIPVTOaiv9k2UUo8aRTZqndA7sat5gk+A4HDJ/dwASay6ovusiLQrRnGbFVt3Or+3nhucFWL81GbFsAx4sLCdZ7nhlC33T4H74H9Wrij3UWCNjYLRfo8BB2+HQCFYP76gMKnaDRl7WrXX5BMa4Lk6ilt+uLt6iRE104e1nWL6MUvJweR2s+GMkOrbklncSSlbSjM0wsaamdoJLiH1bcKj6mex74R1zz39Hvx53gXHzamvRz3WHGVTjC17wdgTGEgacff7Nv83HvWBaRHSiyP9PCS0BiKb3ZG9NvEIfCN5sr5ucDDFmcJj9LuHF2F5sUI8J++IOko7Ve7xB+x/Iu7WUwr8X7eTf48vVSb/9CNg56BhEyV4Wvn8FOM04KZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199021)(186003)(4326008)(8676002)(66556008)(66946007)(66476007)(478600001)(54906003)(316002)(8936002)(41300700001)(921005)(7416002)(5660300002)(38100700002)(53546011)(107886003)(83380400001)(2616005)(6486002)(6666004)(26005)(6512007)(6506007)(31696002)(86362001)(2906002)(36756003)(31686004)(66899021)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzFXSFhlRFErVVJoYzhhM3VscE9WUXY4SWZCVHN2YzFvVG93akEvSzNsZzhU?=
 =?utf-8?B?bXBLMEIvSkpJeW1rOEVpNU44ODFTNTVydEg1UTJLT092Wlg0ZENha0lVcVhU?=
 =?utf-8?B?ZWI4VnJWbnRaaGliM0NwTm5RUFZpWE1aTlA1MkVaQ2hqQjd0SlVMNmJwL21F?=
 =?utf-8?B?T3JYYmdrQmhIZzYxTGh4TE1GTWVWV1hZYWxhWFlPVHdCYVJDS05Lc0JFUXFm?=
 =?utf-8?B?N1Z0SGJSNVFaZFVJdVZFeU1lUUVlbnRRNmErVWRVd0FPR2Jha2hFYjllMTE4?=
 =?utf-8?B?bTdHVS9TRitpWG9UUHhJdzl6bmRpN0c0NENRM3ZXaGlKdnYxdHllelRlb04y?=
 =?utf-8?B?UHo1M2xMYTRkcWVubnJVQ0hvOGhtZUNJSGlVdXF5SGJuYVgyMVVsblBKS1dE?=
 =?utf-8?B?dlJXVHRmc2J1WW9RSTJDdEdIUmhFb3JFa2xlRVQxNDNnUm43U09iaXFZNmJ4?=
 =?utf-8?B?ZVVqTTB0aU5JWVpBTDhRT3pHVFdSZUxYM2tpK0VJOXd3SW54cGs3UWwyQUNX?=
 =?utf-8?B?OUR5Y0FsU3phUnh5eVR0Ty9rYjBvRGlNdlQzbUxpRkJmNS9DdUNVUGFPYnVz?=
 =?utf-8?B?S3h0ZlllMzlDNk96TXBLNlR6b0h3MEtHVHE1R1RtaFVnWTJiNjY1bVVxY1pP?=
 =?utf-8?B?OHJuQjBVT3o4QjI2U1N2cWZhemd2OCtuUnR4U2U2MVcvR2hZYlBrUlJQb1lK?=
 =?utf-8?B?K1lmdTU2U3lOVGUzd2VLdHhyNVhpZS9xSENWVU5yaUVmdTA4Nmxobi9iSmtH?=
 =?utf-8?B?dmRxV3NUQ2p0bEtJSzFwL2tJNU5CcVJsNEZmcG8zZ0J3K1hkUFJpTHlxcFc3?=
 =?utf-8?B?NVd2T2FUbnJNUXhuamdRWXdLWk15azdrakpaazlTUnBTL1o3bkNlcmFuVGxC?=
 =?utf-8?B?QUNTd0doLzJIZHBvYS9xQjZ3cVNiUmJzVW5RTlBMOHBRN214RmxVaXYrQ1Bl?=
 =?utf-8?B?a2syR2dVUnpvbU15eGFJbmU1bWtQQjN5a3ZOUHhJdWR2YkVzMTA5dVdITm1F?=
 =?utf-8?B?MFNLYThzTnNObGpWc0Q2ZXdrNjFaNzBNMEtJM1daUTRkTjNiQmFwMlVwdjdC?=
 =?utf-8?B?cURtQ1hKN3h0SlNlbTBYU0k5eGlLTjB1ZG02bnFuQ3o3bm9ZK3V4cDdDdU9R?=
 =?utf-8?B?a1JZYkcvTmZqTlplWFJIUll4YUlsVkc1S3prWkFHNEo2TUZVeVlPQWplT0lD?=
 =?utf-8?B?N1hZUHd3N3BBdU1oeWNGSlVENkhYTXJEcWRISVdqa0NEQUtJUkx2R1VoNk42?=
 =?utf-8?B?Y1J1bmdqa0xjbDlyV0JMRGQ2amN3d2d5SWZ6MTFEZ2FjQWI0TjFBdE96OWUx?=
 =?utf-8?B?QVA5NGNCM3RWVTliNkpqMzFrTFcwY2M4N3VXcGFhMkFnQWttem5KR3JRaGh2?=
 =?utf-8?B?emhpTmcyQmlFTjJ3TGdvT2ZsUWV6eGVrb2NrdTE5Q1QwTTBwWi9NcEtXY0dX?=
 =?utf-8?B?UDB1dlpnWlV3THlKajRGVEcybnQ2SUVTdUMvUEpYZHltdnVFWDBpWnhVUGFh?=
 =?utf-8?B?cVJKa003aUdNMnZIaEFqTXF1Sy81TFdldk05NW9wUG1qNGlhM1RqZTl1T3Rt?=
 =?utf-8?B?UGhBbnY5NFBOQmE4V2JmdXMrL0l2aDNEaVd2b0Y4VTVJRlVaY0NtM2FpT21O?=
 =?utf-8?B?TTAybm9STkFUQmNrYnhpYlBqejFVME5lWlR1QlNRdkZNZ2tRQkVRSDFyMEV5?=
 =?utf-8?B?R25ML2d0Z2UzamZEeVpZVUJNSmNnWnBPVW4wbGRmT1k1Z2VpL2ZDdGVaRklt?=
 =?utf-8?B?eWduQUJjRktxWjA2OCttMzZEMEVVaXBGNGl1NHBHQVpOT2JsUXVhQzllOFFl?=
 =?utf-8?B?WU9iVHpySG5hWlFkWTBlZlEwMUhDNERYMXZPOEd0OHhpdXlYTEI2cHdVYzZh?=
 =?utf-8?B?dG9nZUthME96NG1yaFdSVlRIdEUvTURqZUZwTWtScW16bm8vSDlxWmZ2ZkVF?=
 =?utf-8?B?Wkh1Um51NzJNbFg0bFFudW14VTdJeThUbFd4Uzc4cnNHbGFMRVFHeFJ5UlBo?=
 =?utf-8?B?SDRSQmVUWVM0RnVZWUZYbFBvMHhGUjlqSkdydzJvTnZ6eFpmZjQrcExNL2lB?=
 =?utf-8?B?MkE4M2d6QmE1OGd6V0RvOGNKQVl4ZVM1bEdPcUJHVktRMENuRENMQmRQSi9n?=
 =?utf-8?Q?V9VqV8ccAu8IEg+XSdqbbqIWU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f030cf73-1671-4807-e217-08db36533d8e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 03:58:54.7921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q7GfvW4C6yVWwLrqbzdA6K0WuwzN8NWcQFaZ/8AMa81ZAEoVy/0VzMPWD+41kUxhknsb6JUP7jf924r7kS+2NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5194
Subject: [virtio-dev] Re: [PATCH v11 03/10] admin: introduce group administration commands



On 4/3/2023 11:03 AM, Michael S. Tsirkin wrote:
> This introduces a general structure for group administration commands,
> used to control device groups through their owner.
> 
> Following patches will introduce specific commands and an interface for
> submitting these commands to the owner.
> 
> Note that the commands are focused on controlling device groups:
> this is why group related fields are in the generic part of
> the structure.
> Without this the admin vq would become a "whatever" vq which does not do
The abbreviation vq for virtqueue looks good here :)

> anything specific at all, just a general transport like thing.
> I feel going this way opens the design space to the point where
> we no longer know what belongs in e.g. config space
> what in the control q and what in the admin q.
Better to refer them as control vq and admin vq like above.

> As it is, whatever deals with groups is in the admin q; other
admin vq.

> things not in the admin q.
admin vq.
> 
> There are specific exceptions such as query but that's an exception that
> proves the rule ;)
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> changes since v10:
> 	explain the role of status vs status_qualifier, addresses
> 		multiple comments
> 	add more status values and appropriate qualifiers,
> 		as suggested by Parav
> 	clarify reserved command opcodes as suggested by Stefan
> 	better formatting for ranges, comment by Jiri
> 	make sure command-specific-data is a multiple of qword,
> 	so things are aligned, suggested by Jiri
> 	add Q_OK qualifier for success
> ---
>   admin.tex        | 121 +++++++++++++++++++++++++++++++++++++++++++++++
>   introduction.tex |   3 ++
>   2 files changed, 124 insertions(+)
> 
> diff --git a/admin.tex b/admin.tex
> index 04d5498..c869a1a 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -60,4 +60,125 @@ \section{Device groups}\label{sec:Basic Facilities of a Virtio Device / Device g
>   PCI transport (see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus}).
>   \end{description}
>   
> +\subsection{Group administration commands}\label{sec:Basic Facilities of a Virtio Device / Device groups / Group administration commands}
>   
> +The driver sends group administration commands to the owner device of
> +a group to control member devices of the group.
> +This mechanism can
> +be used, for example, to configure a member device before it is
> +initialized by its driver.
> +\footnote{The term "administration" is intended to be interpreted
> +widely to include any kind of control. See specific commands
> +for detail.}
> +
> +All the group administration commands are of the following form:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd {
> +        /* Device-readable part */
> +        le16 opcode;
> +        /*
> +         * 1       - SR-IOV
> +         * 2-65535 - reserved
> +         */
> +        le16 group_type;
> +        /* unused, reserved for future extensions */
> +        u8 reserved1[12];
> +        le64 group_member_id;
> +        le64 command_specific_data[];
> +
> +        /* Device-writable part */
> +        le16 status;
> +        le16 status_qualifier;
> +        /* unused, reserved for future extensions */
> +        u8 reserved2[4];
> +        u8 command_specific_result[];
> +};
> +\end{lstlisting}
> +
> +For all commands, \field{opcode}, \field{group_type} and if
> +necessary \field{group_member_id} and \field{command_specific_data} are
> +set by the driver, and the owner device sets \field{status} and if
> +needed \field{status_qualifier} and
> +\field{command_specific_result}.
> +
> +Generally, any unused device-readable fields are set to zero by the driver
> +and ignored by the device.  Any unused device-writeable fields are set to zero
> +by the device and ignored by the driver.
> +
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
> +
> +Each command uses a different \field{command_specific_data} and
> +\field{command_specific_result} structures and the length of
> +\field{command_specific_data} and \field{command_specific_result}
> +depends on these structures and is described separately or is
> +implicit in the structure description.
> diff --git a/introduction.tex b/introduction.tex
> index 287c5fc..0d849a9 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -68,6 +68,9 @@ \section{Normative References}\label{sec:Normative References}
>   	\phantomsection\label{intro:FUSE}\textbf{[FUSE]} &
>   	Linux FUSE interface,
>   	\newline\url{https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/fuse.h}\\
> +	\phantomsection\label{intro:errno}\textbf{[errno]} &
> +	Linux error names and numbers,
> +	\newline\url{https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/uapi/asm-generic/errno-base.h}\\
Above link is broken because "uapi" is twice.
Please remove one "uapi/".

>           \phantomsection\label{intro:eMMC}\textbf{[eMMC]} &
>           eMMC Electrical Standard (5.1), JESD84-B51,
>           \newline\url{http://www.jedec.org/sites/default/files/docs/JESD84-B51.pdf}\\

With above url link fix,

Reviewed-by: Parav Pandit <parav@nvidia.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

