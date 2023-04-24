Return-Path: <virtio-dev-return-12391-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABFDC77B76
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 22:27:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6D94729FC8
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 22:27:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6298C986659
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 22:27:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5405898644B; Mon, 24 Apr 2023 22:27:20 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3441D9863A5;
	Mon, 24 Apr 2023 22:27:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5BxZQnJlH846tzjoFA8VVueAvp+pzV0xoFKS7G29UXNhRMpgStqdN4IhC7eLmtq+SBbKh0Z2JAbMSZhuF/2+gQc7DTicqsqEeix8T9BBasCiGATcZC05Fi8H+VTEZSxORmVokLj4c5L/jPEzWlEHq1g4lkVfQweY/kvPEVhormBl2KAv3scZlTjSDWuDq5GP8v3fNh8lz3c8vG1uzilGjWMZpIxSN6YCHdaltlPDkTKcHbZkUUwN2vpMTMmztXk4u98z8EoCasC+f5XblR7f/FclTt3m5ufT0bhEL/CaN/veCm5OIzP6rdVVnySZqFJBxiY8En7lemBuAmbdXGnWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/JWX/g2tZMzjtfXP9nDCUqMK46NM5DhxZS++H6LcVk=;
 b=LnRVzNDnjN5V99Bel++evBDbQjOTfAdGhyucpGpLj8bm463Lc2x/XCrJvh4mWY+kuXaIhT5DocOKsmmjYHgLl8JHWbm1xYE55yS3bD82J9YpW0QoBEamK/0Lle0jMj9VmzJp4pN3Vgw4hKl0pq9vNzQtGLx5iA7FTbuFDBZLnqWAfmDKN8jIWpif5ZA3luzPL3f5jysKdihgpiJWJDrdOOP4osQVFaPVgXJOoxEYCaibyA+fZJRLIVa+mwLyjaRxC+fYnehj9Du/jHSortmMQPxWHLS3v7iuKDa5cqSfElq/HV+UMwYOzWuNxO0fenT/8+dDBK0RUBzOe3OggE2+4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <777a084d-fc5b-3609-dfbb-b14277d85e27@nvidia.com>
Date: Mon, 24 Apr 2023 18:27:10 -0400
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
 <727452a1b73d5ada96c4636ec3e24ada70e339ee.1682354275.git.mst@redhat.com>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <727452a1b73d5ada96c4636ec3e24ada70e339ee.1682354275.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0132.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::34) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: 27397700-edae-4397-0d7d-08db45130e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q8fWu7SabGK4uHSIw11Fqe171TEFnjk9y4MjVzuEkKlby3bxXBzYUkkOx/0+kEZfql5y+UDLqbVtsN0AtTwwYOxs0Hn7HhhudoBudnpDuWlTimfpEICU8Gk0gtRqPKixhVpgSh/g+u8bivaVWmHfQg9ATdZlxq/tiGIYi5qwDvEd5yquEPnekEUHoFLf5lh/i5onVc/BPA27XylYN7j9lwygQZyHaEUb2LsCKcK6Kfszol8VeJYfbY+w/FrL8FNnF295nwFFA2R5e1ivJVpVxKmmY8Y/YIUti1gZzSd9wpcBBKU0SkUJ1chFvx+YH4HbsL82WI1H3WEBTlj/pVeWg8hJA5juk7ZIqn8LiygEgQlJwHRCm0ajwMdPOQ4OOA6Q0bxU6rg/3NXQ6CIgmswDkFoExAOk7lhXv4hZ2XJ4Hz0S9n2JUq+jzihAzuLDO5t+nCQXFOijdaHAzwdcjJvQHhgEhsFHApOSJGazS9yOb5YPFsjV3WA0AKdasDp0pM18w/JcfVDtAod5RW8LBteO6o8Ues1yi80y0AhYHQpkei5/byJO8FVOqd8m+WyZR/U0Q3hqNSRK9JtbL5Nvk4p6dmW/EF31x/Dl5HB1/tcN3nmaKJkVLVbYdvohcprtWmzQAsYQst6zHuUWeyUhNRB2awxFigk7Dqm6WtuQwDmlWV02fvwFfl0WF2z7BCkDFyAgQm506tRDlSvBeuEek4AdqQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199021)(36756003)(8676002)(8936002)(54906003)(478600001)(66476007)(66556008)(4326008)(66946007)(7416002)(921005)(316002)(41300700001)(2906002)(38100700002)(5660300002)(2616005)(86362001)(186003)(966005)(26005)(31686004)(6506007)(6512007)(53546011)(107886003)(31696002)(6486002)(6666004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXZQaFZJUUkzOUJmT1dqOUp6MnQ5aitCSDNHTEk3RWI4SGF3SnVNMVo1VEtS?=
 =?utf-8?B?L2s0cGk0SVp2RHIra1FvenVFVEw1ZXI0UWQvc0JSYkowQVBBeHp0akZZVGY3?=
 =?utf-8?B?RHN5OXhwVm5IVUhDbU10YVVFQ05UN0QwNEwxWXN0Q0pCdlNTWEx1L25iM2VM?=
 =?utf-8?B?ekxRZnQ2NjdmS0dFb2pRYnBPNnFrZVlUOG1wY1BMYVZpL2tZYzdTWmRiVzBO?=
 =?utf-8?B?eFVGeXJrdTB5ZXFiZnJWeStlYmh3V29yd3JkRzlOTXA2SWVoc24wUDhTL3hz?=
 =?utf-8?B?NnRoRGlGQk9vVjJFYzBGUmxBcUFSR016dW5xdVFIVkNhZDBKRWgvVDVTcW1k?=
 =?utf-8?B?aEF4M3A2RXdhS0FmdjMxZFdtc3dNMmJYVFpZRUI3V25ibmM0WHd5bFQ2Vnd2?=
 =?utf-8?B?V0MrZWJqTm5ZT0YwR1VyMkhIa1ozRzg2WUlKVlUwZDhYVSt2Q09veXZtZE10?=
 =?utf-8?B?VmJWRjlaNE1iSFByVjBLUXAwNTFjSlpad2R5UzU1a3Q3b2RsenROZXNJRTlx?=
 =?utf-8?B?Njdidnl2ODlYbFlIVGY4cEVDeXR6WmpUdjZ5aDJxSWNmRnIwdTZzMGswYStP?=
 =?utf-8?B?MVJQYk41YlgwYU1wSWZlRUFlUFdwTlplU3E3WFF0NVdmaGZPRVFld3FsN2pN?=
 =?utf-8?B?LzJxSUI1YnlmbVl4VldJT0prQWtaeW1TeEFkMmZqUDRoTnN1Zms4aXRLRlJD?=
 =?utf-8?B?NWVlS2k1M3lZYzdTWTFyUVlVRXVRYktqTjJ0Z3d0Vy8vRUdTOXBiNUxSRHow?=
 =?utf-8?B?MmxDVkJKSTcrbTJhTll3Y2tBZk8xNlhSdDZyaUpHbjg0eWwvRlhVZHQ5UzU0?=
 =?utf-8?B?TXBLWDdsWVVDM0QwL2ZnVFpabit2YlIxejZBNFJheGVGWENkRWErSjFMaStT?=
 =?utf-8?B?cHl6ZXIzWUtSVzRFejc5bi93SU5qakZIUTNkdjVWZEtWK1VMamMyZDJybzhN?=
 =?utf-8?B?RndlUmtPazlud2RlcW9iUnJLS0lpUWg3VEpORjRWMHZCdENieCtVV2J5QkJF?=
 =?utf-8?B?MnEzNTRCL3pSLzRXdlJWdlBpRlFvK0tuT2ZPL2U0M2trbDRyY09oZkVrYTJ3?=
 =?utf-8?B?LzlFYTF4Y1FmWXZTTkpXT085MHAxb0F5Ym8rZnRMdW9tdTRKcE5XLzhTbllH?=
 =?utf-8?B?Ry9wbW0wa0JtSEhBd2ZpUnVML3JET3JpRVZ3RnpvRngxYjMwOXNJMzdOTG5p?=
 =?utf-8?B?VmwyUHpEc2lHTE51dnY1ZmN4NFdOZHY3UXVlVVM0SlpNRVNwZGV2VlFtRTIv?=
 =?utf-8?B?RkYrUENmeEV4VDR3c3R1UnRDeUh6L3pqUG9qeWQvdlhzVkVmZTZlcjUvNHdz?=
 =?utf-8?B?SXhFdTd3cVowQ1R1cHVYbWJrdkw1ODZwSXVnOHM2NysyZHlUTzl0WVk3Wlpq?=
 =?utf-8?B?MWh6Mm91MktHQ05QcWV3L1hVdjJ1WTdFNmkyK09jR1FaRmJXd2VtaFlFTzhP?=
 =?utf-8?B?dzU4OFhITnUzcmJzaXNyQ3hlWTRMaUZoYkw5c0U3eEdnajQvWUJ3Vjg1WG1q?=
 =?utf-8?B?RU1pRmxuZkVEc1dTODR2L04wRVp0ZjVIcGdQZlBLcSt5U3FBeGdBTUpYaHlC?=
 =?utf-8?B?dHdVYWl1ODFzUEVoYnR6dEJEOXUyQ2VJMjN3enhLaTFwWlIxZzBDUGh2bEsw?=
 =?utf-8?B?NENtTTlWRVE3QkxISkhUdWVBbEFJWFFTYmFBb3lIbU9wY1hqcHQxWU9aZC85?=
 =?utf-8?B?Sm1tNW5yeVZ1cmQwZGFvS09Zb1ZaTnFDQUwvS08rckwvWG5HVis5Y2FRNE8x?=
 =?utf-8?B?c2Vmemwvd2ZaajlpWmh5K0xBNWhNcUt1SjVFSWRYK3g4MDE3SkFZRGtrOE8y?=
 =?utf-8?B?K0wrWk9HQmdBUDJBWlVEcDQ1RExYWTI1SS85NEdLdE5WcU84QS94YkZORFNv?=
 =?utf-8?B?V1R2d254QnB3WEhGeWhaMnVNS0dibnhJVzFvUTNpZkJUSCt6V2tUaXlWcXZ5?=
 =?utf-8?B?a296YUFJYm1LMmRMeHROWFRCU1E2M1ZndE51WVZwZ2VPclRnYkVvb01VSVhY?=
 =?utf-8?B?bE5ka2lPV2JlZ3VwbHQwZWhtUkdraXExcVJKM0ptaldyUG15Tk5SQ04vNVhC?=
 =?utf-8?B?RHJBbFZZZDB2b2dnYkVzdG1qQWw4OGhuOWRmQmJPVm9RY0VmN3p5TGFuWFpO?=
 =?utf-8?Q?vUYemOSGlAdtd+xU2eDbLNZgV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27397700-edae-4397-0d7d-08db45130e11
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 22:27:14.7403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwuJMB+TApQm1NPo2CNN+KhAGC3lq/czZpAHdXZqR9LdxAgYnqkYE1Hb474J6KCxFn08zKfr++o2nVNePE4dEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197
Subject: [virtio-dev] Re: [PATCH v12 08/10] admin: command list discovery



On 4/24/2023 12:44 PM, Michael S. Tsirkin wrote:
> Add commands to find out which commands does each group support,
> as well as enable their use by driver.
> This will be especially useful once we have multiple group types.
> 
> An alternative is per-type VQs. This is possible but will
> require more per-transport work. Discovery through the vq
> helps keep things contained.
> 
> e.g. lack of support for some command can switch to a legacy mode
> 
> note that commands are expected to be avolved by adding new
You missed to correct the spelling given comment [1] in v11.

[1] 
https://lore.kernel.org/virtio-dev/74a52ec2-da51-d739-176f-84e4357d9da6@nvidia.com/


> fields to command specific data at the tail, so
> we generally do not need feature bits for compatibility.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Zhu Lingshan <lingshan.zhu@intel.com>
> 
> ---
> 
> changes in v12:
> 
> devices->device address comment by parav
> 
> changes in v11:
> 
> dropped S.O.B by Max
> explain in commit log how commands will evolve, comment by Stefan
> replace will use with is capable of use, comment by Stefan
> typo fix reported by David and Lingshan
> rename cmds to cmd_opcodes suggested by Jiri
> list group_type explicitly in command description suggested by Jiri
> clarify how can device not support some commands
> always say group administration commands, comment by Jiri
> ---
>   admin.tex | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 101 insertions(+), 1 deletion(-)
> 
> diff --git a/admin.tex b/admin.tex
> index 91e0cba..68ee7e5 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -113,7 +113,9 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>   \hline
>   opcode & Name & Command Description \\
>   \hline \hline
> -0x0000 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
> +0x0000 & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver list of commands supported for this group type    \\
> +0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of commands used for this group type \\
> +0x0002 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
>   \hline
>   0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a different structure)    \\
>   \hline
> @@ -183,6 +185,104 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>   depends on these structures and is described separately or is
>   implicit in the structure description.
>   
> +Before sending any group administration commands to the device, the driver
> +needs to communicate to the device which commands it is going to
> +use. Initially (after reset), only two commands are assumed to be used:
> +VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE.
> +
> +Before sending any other commands for any member of a specific group to
> +the device, the driver queries the supported commands via
> +VIRTIO_ADMIN_CMD_LIST_QUERY and sends the commands it is
> +capable of using via VIRTIO_ADMIN_CMD_LIST_USE.
> +
> +Commands VIRTIO_ADMIN_CMD_LIST_QUERY and
> +VIRTIO_ADMIN_CMD_LIST_USE
> +both use the following structure describing the
> +command opcodes:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_list {
> +       /* Indicates which of the below fields were returned
> +       le64 device_admin_cmd_opcodes[];
> +};
> +\end{lstlisting}
> +
> +This structure is an array of 64 bit values in little-endian byte
> +order, in which a bit is set if the specific command opcode
> +is supported. Thus, \field{device_admin_cmd_opcodes[0]} refers to the
> +first 64-bit value in this array corresponding to opcodes 0 to
> +63, \field{device_admin_cmd_opcodes[1]} is the second 64-bit value
> +corresponding to opcodes 64 to 127, etc.
> +For example, the array of size 2 including
> +the values 0x3 in \field{device_admin_cmd_opcodes[0]}
> +and 0x1 in \field{device_admin_cmd_opcodes[1]} indicates that only
> +opcodes 0, 1 and 64 are supported.
> +The length of the array depends on the supported opcodes - it is
> +large enough to include bits set for all supported opcodes,
> +that is the length can be calculated by starting with the largest
> +supported opcode adding one, dividing by 64 and rounding up.
> +In other words, for
> +VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE the
> +length of \field{command_specific_result} and
> +\field{command_specific_data} respectively will be
> +$DIV_ROUND_UP(max_cmd, 64) * 8$ where DIV_ROUND_UP is integer division
> +with round up and \field{max_cmd} is the largest available command opcode.
> +
> +The array is also allowed to be larger and to additionally
> +include an arbitrary number of all-zero entries.
> +
> +Accordingly, bits 0 and 1 corresponding to opcode 0
> +(VIRTIO_ADMIN_CMD_LIST_QUERY) and 1
> +(VIRTIO_ADMIN_CMD_LIST_USE) are
> +always set in \field{device_admin_cmd_opcodes[0]} returned by VIRTIO_ADMIN_CMD_LIST_QUERY.
> +
> +For the command VIRTIO_ADMIN_CMD_LIST_QUERY, \field{opcode} is set to 0x0.
> +The \field{group_member_id} is unused. It is set to zero by driver.
> +This command has no command specific data.
> +The device, upon success, returns a result in
> +\field{command_specific_result} in the format
> +\field{struct virtio_admin_cmd_list} describing the
> +list of group administration commands supported for the group type
> +specified by \field{group_type}.
> +
> +For the command VIRTIO_ADMIN_CMD_LIST_USE, \field{opcode}
> +is set to 0x1.
> +The \field{group_member_id} is unused. It is set to zero by driver.
> +The \field{command_specific_data} is in the format
> +\field{struct virtio_admin_cmd_list} describing the
> +list of group administration commands used by the driver
> +with the group type specified by \field{group_type}.
> +
> +This command has no command specific result.
> +
> +The driver issues the command VIRTIO_ADMIN_CMD_LIST_QUERY to
> +query the list of commands valid for this group and before sending
> +any commands for any member of a group.
> +
> +The driver then enables use of some of the opcodes by sending to
> +the device the command VIRTIO_ADMIN_CMD_LIST_USE with a subset
> +of the list returned by VIRTIO_ADMIN_CMD_LIST_QUERY that is
> +both understood and used by the driver.
> +
> +If the device supports the command list used by the driver, the
> +device completes the command with status VIRTIO_ADMIN_STATUS_OK.
> +If the device does not support the command list
> +(for example, if the driver is not capable to use
> +some required commands), the device
> +completes the command with status
> +VIRTIO_ADMIN_STATUS_INVALID_FIELD.
> +
> +Note: the driver is assumed not to set bits in
> +device_admin_cmd_opcodes
> +if it is not familiar with how the command opcode
> +is used, since the device could have dependencies between
> +command opcodes.
> +
> +It is assumed that all members in a group support and are used
> +with the same list of commands. However, for owner devices
> +supporting multiple group types, the list of supported commands
> +might differ between different group types.
> +
>   \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
>   
>   An administration virtqueue of an owner device is used to submit

Reviewed-by: Parav Pandit <parav@nvidia.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

