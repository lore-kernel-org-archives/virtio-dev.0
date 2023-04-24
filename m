Return-Path: <virtio-dev-return-12388-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0533FC7618E
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 22:07:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 58C2A1318C4
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 22:07:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4B18A98643E
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 22:07:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 40065983F7A; Mon, 24 Apr 2023 22:07:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2F65A9863A5;
	Mon, 24 Apr 2023 22:07:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7vVJ8hiBr2QcrhngaCHqtFcIC1G4S+pknOyfAQL7IlhivPaMa/5rK0MKIrxaZbvBcn7Z4/wx5aZBEfy56WwBm6nvE179McsdC3xm/3jrCfDOsVdxL3cb3Bh+EIK9C1arhMegKfpwSRCO1bAwuRintfvPW8gw0uOp+IMJvvZxNdoXp3y+gw14cV4m2/WngQw7SlJ0HNgRIkn+rLBRJV70t1ZseJw79nbkKD16MzGjuK0fDqQKFhSJ2uk6p3EtNfFS+6u4Z0W5Skxk/ipR4qSms2HePYbTTib8rNennhPUWRgUYGUrEwuMEajIp72yPEs595jxq120xPMzCO3PU0vzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fZ1WvA63hIY5rOj4YHOoCgW80N1U5Kl44c3Hmentvg=;
 b=mBFS0+818PE+SMaiYFk8zGSbe0pH6VEKS85j1QG5IwXtlMOvKokEzqWTGbY9U7krwjX7pXF2w4bbgpsV7IHAGVvTSFq4dusyJV5OpUwMdDUahhO/UNhRmiPAXXy1xcaWqu7r3v9YBKx04LUn0mHleXtltihMdKawM4tULhpnUXYG7QxwuFuBF8P4gYHMRm1eYEyKt1uqCT6aNmelPuppBJMz091buOwsYGOKfYZwyAxMb+2LZLjR7ZQRAabCblaHXzvIkcaE3rQPnjrHfKn0QUgVVq6kh8FKdiD+L88ubYQuUin5k9EI06DAODIdMie8UMbwSEmoUr7h2Q/DZTL6dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <e9256f17-f9ab-de6d-0377-d9fc210a7cc0@nvidia.com>
Date: Mon, 24 Apr 2023 18:07:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
 stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
 hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
 Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
References: <cover.1682354275.git.mst@redhat.com>
 <79c27bca6f72e4ea5d1d0e3a6b1a54369b03fb30.1682354275.git.mst@redhat.com>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <79c27bca6f72e4ea5d1d0e3a6b1a54369b03fb30.1682354275.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:5:40::15) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|DM4PR12MB5136:EE_
X-MS-Office365-Filtering-Correlation-Id: f007e15a-da12-46e7-8b8f-08db45104407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iv2lw+mu18PcJIJGwXiBzvdZIwaRLOdIwDKs8KygYLh0cMyp70bLHZH4KOjuF/fUFl4HfudqxEZn5NoNcXIj0Ua/N/Iw7NwMHiTsHfwudAhCwyHCdpRXZnP5oxGP01dwTnSqYpr0sAQNL5RKTr/k2eTNdn3BZcRWZmyPTYJs2M4BETull8P9n6/wXKgKeb0Fe0zAsYL1tzOAt2GYVJDO6wDYGde8M0xepVtO0txv8qG6E65o9sqzfrMqjTKmz5cOWmtnxfeaqn/2sBZfGSHzxpW0EWDQjt4cuLoxIlz2JXdOjYZKrIqSO4VBRK5PBPMljdCD2czeaIJAYIkM45PcTnsk+T2AcytNlqtUNU3KOH1NvrqPkggwNg8VBo5Z1LJsMIxPKWBPk0BLygfM8Qwlm8h9lGkhCd5/iH2qy8CLyJb/K5rD1vyZwxYYxoiUDzAbh2BV8dXihaEhp5+S3L3BJzYkKmzspRmRwbCJigvnZyNbAkPFwjghFngsj+PsW8VetaTj9LLHbh9vHu8jzmpNKKYipyT4zGRIxxpACBUNcOlf8+gJQfQt+ljDqAXHu/1eTrGDvk2hlPy0t/opE3rXIwGCRdQgA4kTftKt6uJtgGBPu75ohnBOwgo/Z/5Qtv/5Otd4QCLBLE+D8jIiEiP5eLzw2mJEfqUwbEEviYTedOSIS6nDVmX3doEQAF5N9FOeu5+kge1EvWs3xUhlSoFGSI1hJ/jkd2sD+zwhiig3UuPGJ8h2ND43yMdOyjMynehk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199021)(2906002)(6486002)(107886003)(2616005)(6512007)(6506007)(6666004)(186003)(53546011)(26005)(66946007)(66556008)(66476007)(8676002)(8936002)(41300700001)(4326008)(316002)(478600001)(7416002)(5660300002)(54906003)(921005)(38100700002)(36756003)(86362001)(31696002)(83380400001)(31686004)(66899021)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkdDVnh2d0VEME5aUU9hazRVV1FJaDY4Z1UrRzhodGNldlR1Z2ZidEZrdkpL?=
 =?utf-8?B?ZDdhQnNyWEtvZVJBTzhKSStxUjNsK1lvUUNmTUZ5cXo3a1MzTmhudEFmTlNO?=
 =?utf-8?B?VUFMQTMxendUTy84SDVsdVpXM3pEdnRTdzlSSnQ4R2FOVGV0MnhQTEd1Wkow?=
 =?utf-8?B?U3BIQVg3SFBpKzdiNGV0cWFLNDBqaXJJN3l0UGZydHpiVzRPcGtEOEFvNkc2?=
 =?utf-8?B?eXd5WEVicy9YTE1BL25BUlBaM0Q4VFowWTdNQjF0ODNuUXNadHFFWWhKMm9a?=
 =?utf-8?B?ODJPYjBOMXEybFVNcWdaeW0zSHBpVmVSYjZhM3IrRWRhTVZwZWF3cjQ4YVN2?=
 =?utf-8?B?TElSdkRyODV3OVNyeSs5OElmSE5waGFhcmNkamxXbmc2dUViUHJzOXYyUmVN?=
 =?utf-8?B?NlY0WXRSbmdRU05kTkVhekF0dlRYdFJMMjI5TFc0ZkxBbnBvOUNTYUlZUnJM?=
 =?utf-8?B?VUlpaDlmano5S3JzWUwrdmxvdmIvc3daL29PRGsyTCtBYzVjV2MwdDRhT0Fk?=
 =?utf-8?B?dHNFMUxZODJwV3psSVdscWRLbVhpOWMyN0t3ZXErelY4MGN4RDdjbHhlRkZC?=
 =?utf-8?B?WTkrbWx4U0hFanFVbUZlRlhuVWNnOFI5UTNnMk1maGthNzRIZmt5WktDdHE2?=
 =?utf-8?B?NDA2SmdkVjVhQTUwNHkwd1dkaEdCZXVQSlhkalJYWDltQS8vZVNNNXNvWm5S?=
 =?utf-8?B?TUVQcndsMnFmQXJOSXB3UmJkUW9kbTJ4V2NPaXVlTVQyc1Z1MTZuOG5FOFlR?=
 =?utf-8?B?NDlhRjR4dFdnMGplZnFVcmRZeGwzLzRMZ3oxbDRONEowRVdwUXZPRUE0QXl0?=
 =?utf-8?B?b20xdzZYNHBxdTNjMm5xSjJiL2JrVTNHWThyRm50aUtKWlBBOEgvNk90YW9i?=
 =?utf-8?B?bnh1ZDJTSjVvNmd6K3FxQnc4U1lPSUJpcURIWkRJTlZXblRGbitxbEZmKzVh?=
 =?utf-8?B?RWhiWEJNYi9uRWtGUnJPRVB0NStDS2JMdkU1bWtJb3VCK25IbVBiMi92bUFK?=
 =?utf-8?B?dXJhb0J4eGZlNFJNRzZxM0JZTUVhK2M4TVJmeFVlM3hMdDdLelNIeWFtMGU1?=
 =?utf-8?B?MmViSE9VVldQa3NEODlLY1ZicGxoS0JmdTJNRE0zQjE3RCszdWRhYjlYUDVC?=
 =?utf-8?B?MDFYVkZSRUhKRzFSWFhiSEZ3SFg3dkVJS0tMYkJLYmhrdG04Zzc0MGFvUmRF?=
 =?utf-8?B?aEowck51NlJTMDBWRll2K0lqS1RYZ0tXWWJBZ1ptOWhTREtJZjlmT3pWVytK?=
 =?utf-8?B?bnI4cmZqK3V2WmV1VW9PZ25ZL2ltblM0b04yL1ZScDk1em1QTzdyS1ZaZUQw?=
 =?utf-8?B?THFnQ05USzRTVG5lcjNpeTZCWGlsWFJTL2hJZk5GSkRNTFp6SjdDUkJFUzhB?=
 =?utf-8?B?RTNvTzkrdUpZZGVYNXc5VmJibHZTUkZkWHJJMzlpdm5SOTFPWXA5cEtVeW9U?=
 =?utf-8?B?a3p6dUErN0pCcmFhNmdsQkFWaGdCUjZWSVR3d2NVaFcrS2lHMlg4MU13a1hN?=
 =?utf-8?B?M0pnUzVCR0RjMjZyKzhqUW0yaXBRa3hwLzQ0MDRUUXlIT25GUUNCSUpQNjFX?=
 =?utf-8?B?Y3ZOdEpESFZHRDFIY2cwQlJrK3BucVpvanhSZmpxc25KTis5OHN2cm9UbXJ3?=
 =?utf-8?B?aGxNTFVIdFpGTWtKL0d5WXg2clhLTXVyd2JTNXZ5MHY5dG1ENmNuUDJ3UXFa?=
 =?utf-8?B?N2w4SVVlcSthQlF1c1Q5RzkzdkhLN3dwVEZGc1JML0NKeVhGZjZ0NTNEYzU4?=
 =?utf-8?B?NlFpMmtldHI1Y0d6KzQ2clRNU1ZyMGlBV0hkTkxtWU5VNzZVd2NsT1B2NDRO?=
 =?utf-8?B?OFMveENKMm9RM1pyZTg5RUlNM2lFMDd3SmM2M0c0bk5Felp4bG9PTWkrZkpw?=
 =?utf-8?B?YWVmSVJTQTFLaTRoY3BFMFBtVUFNak1lTFRsSzIwZU1WVlBHY2ZvaFc2OGp2?=
 =?utf-8?B?NlVHUFJndUhJd0JGVVZkdHMxYmp0Q0NSa012Z1U2a24xREdmSUVUeVY4QWNP?=
 =?utf-8?B?Ly94Zkg4d3RVUkhlSHhZbVJCUHMzZFIxSENudlh0c3UzTEkzUzBCalpVVmpz?=
 =?utf-8?B?cExvdHVrRzhROXluMGtkNHNaeE8yUHhGTkhXTVNWVWI5SUFPNTBOYzhxYk5x?=
 =?utf-8?Q?8uBXpyjNQXnoG9h0El6uoLCRY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f007e15a-da12-46e7-8b8f-08db45104407
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 22:07:16.8030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46y/u+07tUDpDL3MK8f48Os1WC9c/0V5VDjD0yQh2hYH4oiU0zLW7/PBd+D3/2XVmrvd11/geELnSzi11Kmfjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5136
Subject: [virtio-dev] Re: [PATCH v12 03/10] admin: introduce group administration commands



On 4/24/2023 12:44 PM, Michael S. Tsirkin wrote:
> This introduces a general structure for group administration commands,
> used to control device groups through their owner.
> 
> Following patches will introduce specific commands and an interface for
> submitting these commands to the owner.
> 
> Note that the commands are focused on controlling device groups:
> this is why group related fields are in the generic part of
> the structure.

Below paragraph is no longer applies as we already discussed more use 
cases of the AQ such as accessing the PCI VF's legacy config space 
registers. Please drop below paragraph.

> Without this the admin vq would become a "whatever" vq which does not do
> anything specific at all, just a general transport like thing.
> I feel going this way opens the design space to the point where
> we no longer know what belongs in e.g. config space
> what in the control q and what in the admin q.
> As it is, whatever deals with groups is in the admin q; other
> things not in the admin q.
> 

A PF can use same or different AQ with a new struct 
virtio_legacy_register_access with a different opcode range.

AQ doesn't replace the control vq, so that part description is fine.

> There are specific exceptions such as query but that's an exception that
> proves the rule ;)
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
> 
> changes since v11:
> 	acks by Stefan and Lingshan
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
> index 05d506a..d6042e4 100644
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
> index 287c5fc..b7155bf 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -68,6 +68,9 @@ \section{Normative References}\label{sec:Normative References}
>   	\phantomsection\label{intro:FUSE}\textbf{[FUSE]} &
>   	Linux FUSE interface,
>   	\newline\url{https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/fuse.h}\\
> +	\phantomsection\label{intro:errno}\textbf{[errno]} &
> +	Linux error names and numbers,
> +	\newline\url{https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/asm-generic/errno-base.h}\\
Thanks for fixing this link. Missing in commit log changes for v12. 
Hopefully after b4 integration, this will be smooth.

>           \phantomsection\label{intro:eMMC}\textbf{[eMMC]} &
>           eMMC Electrical Standard (5.1), JESD84-B51,
>           \newline\url{http://www.jedec.org/sites/default/files/docs/JESD84-B51.pdf}\\

Other than commit log change,
Reviewed-by: Parav Pandit <parav@nvidia.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

