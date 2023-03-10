Return-Path: <virtio-dev-return-11592-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8E3C64EC4
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 08:14:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 95E0D26A4C
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 08:14:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 86DD8986722
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 08:14:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7495B986717; Fri, 10 Mar 2023 08:14:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5E4EC986718;
	Fri, 10 Mar 2023 08:14:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="317068295"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="317068295"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="801488177"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="801488177"
Message-ID: <31b2762f-d7fa-52e9-365a-0b5a588ab802@intel.com>
Date: Fri, 10 Mar 2023 16:14:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
 stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
 hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, pasic@linux.ibm.com,
 Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>
References: <cover.1677761896.git.mst@redhat.com>
 <80c4bc60c9119f68b66f5a003564cec719cc1487.1677761896.git.mst@redhat.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <80c4bc60c9119f68b66f5a003564cec719cc1487.1677761896.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v10 08/10] admin: command list discovery



On 3/2/2023 9:05 PM, Michael S. Tsirkin wrote:
> Add commands to find out which commands does each group support,
> as well as enable their use by driver.
> This will be especially useful once we have multiple group types.
>
> An alternative is per-type VQs. This is possible but will
> require more per-transport work. Discovery through the vq
> helps keep things contained.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   admin.tex | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 96 insertions(+), 1 deletion(-)
>
> diff --git a/admin.tex b/admin.tex
> index 3ffac2e..1172054 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -99,7 +99,9 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>   \hline
>   opcode & Name & Command Description \\
>   \hline \hline
> -0x0000 - 0x7FFF & - &  Group administration commands    \\
> +0x0000 & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver list of commands supported for this group type    \\
> +0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of commands used for this group type \\
> +0x0002 - 0x7FFF & - &  Group administration commands    \\
>   \hline
>   0x8000 - 0xFFFF & - & Reserved    \\
>   \hline
> @@ -156,6 +158,99 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>   depends on these structures and is described separately or is
>   implicit in the structure description.
>   
> +Before sending any administration commands to the device, the driver
> +needs to communicate to the device which commands it is going to
> +use. Initially (after reset), only two commands are assumed to be used:
> +VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE.
> +
> +Before sending any other commands for any member of a specific group to
> +the device, the driver queries the supported commands via
> +VIRTIO_ADMIN_CMD_LIST_QUERY and sends the commands it will use via
> +VIRTIO_ADMIN_CMD_LIST_USE.
> +
> +Commands VIRTIO_ADMIN_CMD_LIST_QUERY and
> +VIRTIO_ADMIN_CMD_LIST_USE
> +both use the following structure describing the
> +command opcodes:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_list {
> +       /* Indicates which of the below fields were returned
> +       le64 device_admin_cmds[];
> +};
> +\end{lstlisting}
> +
> +This structure is an array of 64 bit values in little-endian byte
> +order, in which a bit is set if the specific command opcode
> +is supported. Thus, \field{device_admin_cmds[0]} refers to the first 32-bit value
I think this should be "the first 64-bit"
> +in this array corresponding to opcodes 0 to 63,
> +\field{device_admin_cmds[1]} is the second 64-bit value
> +corresponding to opcodes 64 to 127, etc.
> +For example, the array of size 2 including
> +the values 0x3 in \field{device_admin_cmds[0]}
> +and 0x1 in \field{device_admin_cmds[1]} indicates that only
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
> +always set in \field{device_admin_cmds[0]} returned by VIRTIO_ADMIN_CMD_LIST_QUERY.
> +
> +For the command VIRTIO_ADMIN_CMD_LIST_QUERY, \field{opcode} is set to 0x0.
> +The \field{group_member_id} is unused. It is set to zero by driver.
> +This command has no command specific data.
> +The device, upon success, returns a result in
> +\field{command_specific_result} in the format
> +\field{struct virtio_admin_cmd_list} describing the
> +list of administration commands supported for the given group.
> +
> +
> +For the command VIRTIO_ADMIN_CMD_LIST_USE, \field{opcode}
> +is set to 0x1.
> +The \field{group_member_id} is unused. It is set to zero by driver.
> +The \field{command_specific_data} is in the format
> +\field{struct virtio_admin_cmd_list} describing the
> +list of administration commands used by the driver.
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
> +If the device does not support the command list, the device
> +completes the command with status
> +VIRTIO_ADMIN_STATUS_INVALID_FIELD.
> +
> +Note: drivers are assumed not to set bits in device_admin_cmds
> +if they are not familiar with how the command opcode
> +is used, since devices could have dependencies between
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


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

