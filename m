Return-Path: <virtio-dev-return-12036-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34644C76196
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 04:27:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7981133991
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 04:27:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6E8CA9865DB
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 04:27:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 62A6C9865B8; Thu,  6 Apr 2023 04:27:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5141F9865B7;
	Thu,  6 Apr 2023 04:27:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKlnq2cjvLrMO444ZaTVuP+teGEprbi1LsEUksivigpGBBi60jHnj/qTGi4z001fTow0Vq5nWXYxOi0ryWkIn/LFSJCWUKZDcxh2kbKMlg/oGCdQKqV8k+62mRuHINPNFPt1dlIdWMAVCBKxAIQP4APU+YXWEcr65FmIvd4YyaoFNrISFnj7Wn8z+6zkK9W7ft2B2tsNoRo8ZhcQ05Q+Tdv2CPV9Vcc92kIXalkKbQy2If6kz/L4qR05yZabNafElMVhStJyrHm+v0H8Hu58ax6DS+iURTEtkmfIWPozcAo0EP/0SGZu88IzuacJtssg7zj2ZkFfh62z80WRoaK9Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmXAc/BwJnslfBDB+MWnDwZBBuljlDxBWe3k3L3j7e8=;
 b=H3gOavpvGBAMg7I/tdP4u6K2YKBpdhSotl2LlOKl6e8rib7xmufMB5T/gOuuL7hcpH+grvTJfy2pmWCqFUaD257eLslSWiDqJH2eesC9sSQKlqi0AZn6QqKIXqrrKlLEP6qwaFFdUinCqvG7/05Kl53bxUGZWuFe0WAjpSyaL3xSnM/CLLot/9COv5gWgzo2xDAn/ZTeocEvnckCpz4dkp4y/kl1zIFKV0c01pNOEoDhInY3Gbo/Dw5jMJJdtJZeE4g5ZKF1am6Mr1Qd+T4VHXrWDJ1qf2T1giUfVwU1p62hCxX3KX0Xostb3i/30IbpSiCeydD+iCiJIzoXWpeyhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <74a52ec2-da51-d739-176f-84e4357d9da6@nvidia.com>
Date: Thu, 6 Apr 2023 00:27:36 -0400
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
 <84cf421ad95111b37cddb52b2a7bf625b7955ae6.1680533760.git.mst@redhat.com>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <84cf421ad95111b37cddb52b2a7bf625b7955ae6.1680533760.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::27) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|MW4PR12MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b95e5a-ac2f-4801-dde6-08db365743a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Tu23mazgaobLpjC1V30zESg63xsJEDElGf8qEtW1zEYL4yd6ffXk1H8PUlrqi+3cfT4zS3sTVcnPuXLy5obf+HxBpycqa34lexzWaGx7fi1RW0rdmft+fG2eP9f1BnXIUrEEdhpt1fc0IBr+9cQopYQMTIlK4YXt9YF4hq40DFQ0UKdbGkrbIJFEBxuJI9Jkxg54hFpcYSq3XSGcbXyIbbgHKBJRnyeiqO91Vx7TL0lv1njlacqMAlcQ7Trov2JhGgJoXPoeV9MrND64pfX1GEYDN0C/r7LgQk6HxuvqW9xWpcvTjExBtZDPv1ljojQYLjHi1FQ9Vlgd2eJqxD1dQ/keozO7b51ZV0ui0hl5eQ6X2+0S7r1UAI0axVVVAtFiawG5tOmB2/QpUHd1Fzb2GWd5yyonOiQIGpeMm8wnx8lD3VXGYD93wZG2rP3NWWkmlk3CanyZcYqx4Dni2z2aBea8KJGQ8tWZHcfz3ULbV7iucOD+SQ7IwqVcLA12w5AebSQm00OoeRn/uRgTuMDReNKN1S+pERmFoTtG+7zn1vVEjXUrh1OOMCIK4F+ts2pVGyupNmsius6c2TuaMEwCP17WRetoN1P1A9WpmwQWYU5Qj4f87kxFQUHMsHrMfXGltpwwQMYx/8mhnepARsRQHpDFIGEQ1bkzMU4N5I2iVs4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199021)(186003)(107886003)(6666004)(6512007)(2906002)(6506007)(26005)(53546011)(38100700002)(31696002)(86362001)(36756003)(921005)(2616005)(83380400001)(8936002)(41300700001)(7416002)(5660300002)(316002)(6486002)(478600001)(54906003)(31686004)(66556008)(66476007)(8676002)(4326008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGlaL0RWZ2dnM0JHVTEvRlJTdWR6RTNxbk1QbHh5MDRMNkVpUUxvM0NRVWU1?=
 =?utf-8?B?dm1NdkpjclZoZEg4dDhyVU9YUkNQdlZYLzV1cEF5ajlWNWZBTkZtSE5aVFFn?=
 =?utf-8?B?VmZWMDNrQkY2dUQvd0VqS3FNK25kNDVjOGFCUXRzNGV5MS9nYWVKVm5xdk94?=
 =?utf-8?B?WlZWNnFVZmRtcmlQWTJxajZadE14bGI5eUZhV2pGaTFTdmZqajhFQnZqejZF?=
 =?utf-8?B?T1pEUGJsNXNVNjlOeUJIeTI5ZE9LcUlhZDdKb1oxaUlkNm1ONk1uSE50REVI?=
 =?utf-8?B?cktGcXZxM2E2L3ZHOE5kM0JhY2h6bjhVVjlMa2VycnUvQXZ1OWZ4QU56TGpD?=
 =?utf-8?B?dnBHd244cGNvS29WNUtxUitXSGNCQmlQODAzUWhCYTl6OCtVV3RWRGJQaTNX?=
 =?utf-8?B?UU16bnlwOGZQakZBak9BbXBjVWtTMGk4WU5IbHczbDJFTmZmNUxuV1diZHNJ?=
 =?utf-8?B?MHA1Vll2NmExZVY3OGhyTEttRVRUUlFqSTFoYldZWnZ2dUQ1ODd1UmtndThm?=
 =?utf-8?B?ZGxQYlB0S1FDT00wL0tZTzdkZStsQUVKTFhSakh2L1RFaWRJVVRtNVF0SXFn?=
 =?utf-8?B?OWpVQWxDazY5N2MxakdIaWtHQk9sWjMxd1VSem5GcnBSVVBzUXBLVWtjeVl1?=
 =?utf-8?B?bXpUMUlCWnE1TFU3RXd3b20vWDRpcVFkclQzdVdpKytxdEhlQVZZcDczdXdO?=
 =?utf-8?B?c1BLN21haGFxRnRZNGo0YVloa3o1dyt6NzBnZlNBblF5UlYrUm5DbGplVGlV?=
 =?utf-8?B?aVlva09QNVJGTnVGaEVteTgySFpRaFFDRDlRcHIvdjhNaG9XUkxnckhLK1Zw?=
 =?utf-8?B?ZXNQMHB6NzJwdDVLaytMQlFmVER3dkkvVFo2ZzBLODdTclJEc005c21tTlM3?=
 =?utf-8?B?WkYxM1VNOXFtdXp6OGNnK2V5bE11T3QzWGpuZzRuZFFoR2hLTjl3TEpBcnl6?=
 =?utf-8?B?T2Vhb0hlVFJ3SERxTERGTWNKY3EvYkFqWTZ5clZsS3AyL2ViNCtnK2kwNnBK?=
 =?utf-8?B?RXFOZ0JWOU81Y1pLUGd3U3ovU0dJZ2pnUGc4UXgxczVveUY1Z0dQQ213UFIx?=
 =?utf-8?B?eGRqU016cUN0U1pFSE16NlJjME9iRkl1RThrTzdWcnFNRUVWUzJDQWF0R01s?=
 =?utf-8?B?MmcrTGdFODBBZVFaRHZLWFIzd1J3RFBZZGZtbEVCdERldEpmL2k0QTZsK3Ur?=
 =?utf-8?B?NEYxZHhZbTdqcFlnVjdmeG9RM1loSXQvRWtuK0s0U1RibG5uei9ERnZuM0Ur?=
 =?utf-8?B?OURQL1RuZWcxRkNSUGxuSDJxWVhpdTBpYnNVKy9mcm91S0t1Zm1EaW5CWTlL?=
 =?utf-8?B?SmpNWDF4eDJCNkUzK2hjbFhqWHpuNmhQeSsrOXRNd0ZJR0JseGs2Y1FiVW1F?=
 =?utf-8?B?ZzUxK2h6dERGejJ4ZjVrcWxVc0t1N0t3TWxveEdzMTdxbHo4OU1UaUozOGVZ?=
 =?utf-8?B?dGpXaTJlUSs2UDVuaTFKeDZPN01idHl4ZXRHa3Baa3hHV1hsWmlxYWpjVExs?=
 =?utf-8?B?QlJrYXRPcDRQR2ovZUU5Vll4R3JVRDRmcFBseS9VY2wxVWlQWDdSdUlZWEpt?=
 =?utf-8?B?UEYvWlZ4TjQrdngzZVNVTitqYXdSNFJvQlJiakljWnhremVNSm9PaGt0b21l?=
 =?utf-8?B?UGRNZ3VETHVJR0JZaUZNc2kyRTYrZ1h6OGRDM1RvRVhCUDJzUGJCSlBMWDFi?=
 =?utf-8?B?Mkw2RkVaM1hGQ3Z5YTZKK1ZYaFAwUW01Tk5xeXNjMGZqR1dEc0RPOWtYbVg2?=
 =?utf-8?B?V2U3MUpCNWNQZ0xIcXRFYW5XYk8yWW0vTFluSFdRdjlwOThVVlZnQ3ZNSVVr?=
 =?utf-8?B?aHZZSVNncjVxekVvZXZ5TS9aeVVDYXJWMFY5bHo2aG9NbnhnUEdMQ1ZNM2h6?=
 =?utf-8?B?cUIzRElpQWpxcUxWNkswaHRQYnVyek5xdGFvSzNIT25OWVVKSHRuTHdEam95?=
 =?utf-8?B?eTBEV3EwQnBzWUUyVVFXeU5CaDJwc0d6K1B0N2JRVG15dkJHbUdZZExaZU54?=
 =?utf-8?B?dHk0bk1uMUpMREFvL2lpV1dFUWx5QXljeG9jVFlLdXpSbE1XQU93dGhiZU1D?=
 =?utf-8?B?V1I2b1U3OEJpcUJJd3Z4enZENEt4bzZ5cFhad1dJOU1TUXd5ZWEwOGdDdEt6?=
 =?utf-8?Q?FNTNifVgqj5i+pvuD9Y3AK4F4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b95e5a-ac2f-4801-dde6-08db365743a9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 04:27:43.0240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gcm8xIrNIhygjMWC6fqLW/kYeanaMJjd3cW/UVkvtcwUCcLyIqY7zflGVxUhdKTHZRXUtXU33t97SIkc/2Aw7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7483
Subject: [virtio-dev] Re: [PATCH v11 08/10] admin: command list discovery


On 4/3/2023 11:03 AM, Michael S. Tsirkin wrote:
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
Above description about legacy is not clear. what is legacy mode in 
context of admin vq?
> note that commands are expected to be avolved by adding new
s/to be avolved/to evolve/

> fields to command specific data at the tail, so
> we generally do not need feature bits for compatibility.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ---
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
> index f201bcd..9552797 100644
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
We need to clarify that if LIST_USE command can be called only one time 
or multiple times.

For example first time for limited functionality, it enabled 10 commands 
specific to SR-IOV.
Later when user wants to use SIOV, it enables additional SIOV specific 
command set.

> +If the device supports the command list used by the driver, the
> +device completes the command with status VIRTIO_ADMIN_STATUS_OK.
> +If the device does not support the command list
> +(for example, if the driver is not capable to use
> +some required commands), the device
> +completes the command with status
> +VIRTIO_ADMIN_STATUS_INVALID_FIELD.
> +
> +Note: drivers are assumed not to set bits in
> +device_admin_cmd_opcodes
> +if they are not familiar with how the command opcode
> +is used, since devices could have dependencies between
> +command opcodes.
> +
Can you please change to use the singular notion for device and driver 
in the note like rest of the above description?

> +It is assumed that all members in a group support and are used
> +with the same list of commands. However, for owner devices
> +supporting multiple group types, the list of supported commands
> +might differ between different group types.
> +
>   \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
>   
>   An administration virtqueue of an owner device is used to submit

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

