Return-Path: <virtio-dev-return-11516-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0FAC6FD20
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 12:38:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6EBFD2AC6A
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 12:38:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5B1D19866F5
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 12:38:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4A0DC9866ED; Wed,  8 Mar 2023 12:38:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 322329866EE;
	Wed,  8 Mar 2023 12:38:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/j4NuKpry2jIvIBLy3ctyF6pA+KAhH+lEmQua/L/rD/WVwKWdi3MCg6CtH/wyCwFHgFH2p0Q9yEOD6nIOrW2MTkmEwol8JQSnWjt1PDFMMzbSkbVBgDsR4XMPr3CU/BBzrFr6V7aYnTqIxKDKvkQP4DuF5PQXSQwahVA1U2ldph/Dwu4EGe78ffd4Y5EW/Py+OBbd+JwZyOg816oTB6aeii/o+g2DQ/E9EmR1wapvvNr3V3BxeejSHfXLeW7CiHAw60Htx4KdlQzFmmLq+TG7qTUUVF0Zs2XDkmiyIJul+Qq1s16ON8xHbc6j0GCn6pMwI1ddrUiVP7q70k6cqSpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OsIipqfzSpzJH3DSVl2zRNXovA18cqrwSr6UW77rEM=;
 b=djI9A7/s1qQPaJ6PBoIgzXz96YsM7Z7i+uZ7eVZA6zBEKm5njXEyVXBlI+gZNtWgO3Ot3Z1EAD/KVHFcwrZZbaRV1PwlD3gplSztsvSb9pUHmP+mDyAGEjEC0LH6708kZwHBbA7VTpZBU0KZOewMkEJNJHMYgTZce3CifFhi8qSE0Kh1/X5P92GlR30x0Wy1uvVBPVW/oldRWY/dH+LirhGdiKsh5jX6rSbizlcg61AaVYfvvussVS/yZ1fdTK3+JKal1bePatad2CtYKVjg48tyrk50Ov+/Opv2rjqNk3THue/Cbnb/JTC1/62/QoPHlNzql0hzR271bR/9MCBW4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Wed, 8 Mar 2023 13:38:15 +0100
From: Jiri Pirko <jiri@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <ZAiBtzwKz9+xR1Vf@nanopsycho>
References: <cover.1677761896.git.mst@redhat.com>
 <80c4bc60c9119f68b66f5a003564cec719cc1487.1677761896.git.mst@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80c4bc60c9119f68b66f5a003564cec719cc1487.1677761896.git.mst@redhat.com>
X-ClientProxiedBy: FR0P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::23) To MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|SN7PR12MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: f9c38d0f-8272-45fe-dd95-08db1fd1ff77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OR0ApHCU/X+nw+s9L4HQJSqc7Uxyy8dn4GMLcWP1LYSritni2mx3Kp8+duHRk/FzgMDMrMRw1WCHKF3rchfqKVS/jBAkpcL7/VUYHGQTus+zLtP4EJAr8Uk6cFzy5+UD51KmrANc3X/kCsjbr+mlcFFFmLySqKWI7KkQAJBFX3lVF7Uwot75rJHW1SyXuHOmsoLvac4kr2HtPC2QW8Wrzjs+nnRcBvHilVnhRXhf93CLtwlop+eaKp0qKpgMznGEtWHcv4wHxjUciZNLS9qowMjfGUZu8qbDgO6X2agoDtdTO8jO7jlszqFzBGNbIQvwV8zy5dcYMXRaTPWwdHue3sXXVhpef8szYDP6iTp6xBkZDx8TK5014YhIw7I8+oaRlQziYu82CtgqP/aG4sy+RSEH/cbfW/Y3ltXXyZOhI1mMKJ/su+KWjCaJwQLUuI86bmGNXBlFltqR5y92kBMmBt44hCchpiH1aoKc4YJbjvM3uNWLT1veJABNsKo9WiwaBdc1gW8kT0Yb0rblhuoUM8qCr+4BK8wjVDnKV7TopfQL937NNmRQJJBc32NkuGpq6asiwRAES3m4kTRgzWxDLrEMdgqIy+J7bw+8VxRf7ngA5Ga+1GfHEVpKahL7/Hg3uGh3p9vvQNSYVcyN8X+ffqoE6s3IszxUa1xTZetCuoKD5gUENDe3wCdj0BkIzDJM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199018)(66899018)(54906003)(33716001)(316002)(83380400001)(86362001)(6506007)(6486002)(9686003)(186003)(66476007)(2906002)(7416002)(6916009)(6666004)(41300700001)(8676002)(66946007)(26005)(107886003)(6512007)(66556008)(478600001)(8936002)(4326008)(38100700002)(5660300002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fTN2NP5bEuOm/5fKVH0iXnRCZc+QFZpgZWDOoPeE44pKMkYlt+x+1OmUrE4V?=
 =?us-ascii?Q?PlyJzoAe2KoAbvXW7jlve+5qPBv1hizR4Cxd4C8Tuv8j51zZwSTGCVBdCcfm?=
 =?us-ascii?Q?NZYubYjB5j0XR9vgkWhhEslI3JjIRePQ90alDIgkgag62jW4kKUEX0oLZVru?=
 =?us-ascii?Q?uTPl2SuMRlp2EaEYGYnIedH9lEH8sqslu02M4svD7vFO8kw9vyzMPQBKNpx6?=
 =?us-ascii?Q?7uGQciGkLFQjUKogrSR9RIbhkqARurdDtJtv9k1+Rz8gnorbHz2eYhkngWVz?=
 =?us-ascii?Q?8dhWSY1mHZ2W92suaU3a4U1QM7LzuRVoopON8gKZ84RltnikGcqryKWLH2hh?=
 =?us-ascii?Q?EbLlZXytqraI0sLWZAGYWUc4Xpt13YwJ7BCognIdn/MXNWFXsf7jECFIwJFL?=
 =?us-ascii?Q?Ebte6rcrYcxBWHwbgdboS8LmuTj++Kn9QxGpDZeeZawwgmbjKN/OH6tFaX1p?=
 =?us-ascii?Q?japro7Lp4TnOj4o4BikZgHQ30wJpu7Sj5/jZPrkLEI4CpqoJVskztk9amtpQ?=
 =?us-ascii?Q?uetXY1sNlHT7i45gPPmC8B0K/fqaMGGRMbih2/GERQI8Be4k4bnpdYb9LP4C?=
 =?us-ascii?Q?o9zY1tdrt5beBgdWLUeE/kS0qblREk2d7lXf5x31IeszWXDhvcCVIXAbbzFp?=
 =?us-ascii?Q?1Sl+gh53hIeOM2NNEMUkXxhMBBm7f4tDV59N/GEtceSUTIvGruhbQ+Kin/hp?=
 =?us-ascii?Q?SFBmd5SEj0+OOnZFygmrb+KzghC40fw/RvkyizwnKG/lVunNL9I9ZXeiYZS4?=
 =?us-ascii?Q?Hlmedo12IqsKddD9HW2PrsaZRW0cdV3AGR7o8iKQNvjaTyxHEOIBk7ehElUH?=
 =?us-ascii?Q?1Jdwi87u6rBsYJ7Qlw7zsLfyv2s5CLEtahH03uaqZvnI9ofzbu0io6td02B/?=
 =?us-ascii?Q?CRlCrSvqEjki1MzbkW/CxOqiR6BaUDajrqjeSkRgFYrnfXdySRQm22ab4SI1?=
 =?us-ascii?Q?YxmCsMnlruhZ6UPx046fjhuv/EFxWyOu3TGUWW0ILDm/IGB8iKT1ulxz03bZ?=
 =?us-ascii?Q?NtEBudzF6q/rVdMmcHdp8513TUF7qvAMbrI8vufPdzxeyGgY7N974ODqWEKK?=
 =?us-ascii?Q?ez6uPKvlTp3bWBE2SD69tuaBs4uL+1wECeVunnepllAXcQj0TaGJbMO/2NLb?=
 =?us-ascii?Q?4NcQsB6W5JJbAZ4Uc3p2VJpYIfdvBNHERXAKM8wgJ8uOuizZFNPAsl9kTC6I?=
 =?us-ascii?Q?Ohsmi5ylSW2cZKKztrjxsRDpBTDEZR6QqVUtSXdDoDmXGQvqV8Kc2xjoeT+K?=
 =?us-ascii?Q?b+y1TYAptXTNtLRpvsFuhLJ9zhSWQRlUF109+WiKsGRn4AHG8mKuPwI/7JT9?=
 =?us-ascii?Q?c7J03v3umxdUJ+rWV0CGS/l80AGGz7klzVmhaD4diGflIP7epi+prBobAu0T?=
 =?us-ascii?Q?TB3TpGfaXv3SpZPlPEYciCxFcMI/ZH60pEiSCdVOQ3wjpRFHt0bEKKCRg9FG?=
 =?us-ascii?Q?+JE1HXIP3u2FVl5Ugd58b3kM0Jsrs/DgYfMkptuzz2AYkG/DAOoDqumESYi2?=
 =?us-ascii?Q?q3/RiDMJo/YqmTc0Ew3UutYlfnnaEbyXK1UTcgTxdtWkligoum1BGj8RgmfH?=
 =?us-ascii?Q?ns7+P5atQel0aD59P2O2PZTs4LBxUNoxibCRXcxh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c38d0f-8272-45fe-dd95-08db1fd1ff77
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 12:38:20.4914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXKnupVEbXH8HoY4/5K0LlRtnh3n7OUPltthCWIKrjD8X5uAlt6T4/4PbGBwqN9o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8028
Subject: Re: [virtio-dev] [PATCH v10 08/10] admin: command list discovery

Thu, Mar 02, 2023 at 02:05:22PM CET, mst@redhat.com wrote:
>Add commands to find out which commands does each group support,
>as well as enable their use by driver.
>This will be especially useful once we have multiple group types.
>
>An alternative is per-type VQs. This is possible but will
>require more per-transport work. Discovery through the vq
>helps keep things contained.
>
>Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>---
> admin.tex | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 96 insertions(+), 1 deletion(-)
>
>diff --git a/admin.tex b/admin.tex
>index 3ffac2e..1172054 100644
>--- a/admin.tex
>+++ b/admin.tex
>@@ -99,7 +99,9 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
> \hline
> opcode & Name & Command Description \\
> \hline \hline
>-0x0000 - 0x7FFF & - &  Group administration commands    \\
>+0x0000 & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver list of commands supported for this group type    \\
>+0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of commands used for this group type \\
>+0x0002 - 0x7FFF & - &  Group administration commands    \\
> \hline
> 0x8000 - 0xFFFF & - & Reserved    \\

This table would not be needed at all, as all the commands here are
"group administration commands". Could you remove it?


> \hline
>@@ -156,6 +158,99 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
> depends on these structures and is described separately or is
> implicit in the structure description.
> 
>+Before sending any administration commands to the device, the driver
>+needs to communicate to the device which commands it is going to
>+use. Initially (after reset), only two commands are assumed to be used:
>+VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE.
>+
>+Before sending any other commands for any member of a specific group to
>+the device, the driver queries the supported commands via
>+VIRTIO_ADMIN_CMD_LIST_QUERY and sends the commands it will use via
>+VIRTIO_ADMIN_CMD_LIST_USE.
>+
>+Commands VIRTIO_ADMIN_CMD_LIST_QUERY and
>+VIRTIO_ADMIN_CMD_LIST_USE
>+both use the following structure describing the
>+command opcodes:
>+
>+\begin{lstlisting}
>+struct virtio_admin_cmd_list {
>+       /* Indicates which of the below fields were returned
>+       le64 device_admin_cmds[];
>+};
>+\end{lstlisting}
>+
>+This structure is an array of 64 bit values in little-endian byte
>+order, in which a bit is set if the specific command opcode

Ah wait, you are having this as bitfield. How many commands do you
expect to have? I mean, could this be rather just plain array of
opcodes.

If you want to save some space, the opcode certainly does not need to be
64 bit. I think that 16 bits is more than enough for this :)

Then to make this consistent with struct virtio_admin_cmd,
where you use term "opcode" and with the rest of the text where you use
"CMD" and "cmd", perhaps "cmd_opcode" in struct virtio_admin_cmd
and "cmd_opcodes[]" here would work better?




>+is supported. Thus, \field{device_admin_cmds[0]} refers to the first 32-bit value

You say "32", it is "64".


>+in this array corresponding to opcodes 0 to 63,
>+\field{device_admin_cmds[1]} is the second 64-bit value
>+corresponding to opcodes 64 to 127, etc.
>+For example, the array of size 2 including
>+the values 0x3 in \field{device_admin_cmds[0]}
>+and 0x1 in \field{device_admin_cmds[1]} indicates that only
>+opcodes 0, 1 and 64 are supported.
>+The length of the array depends on the supported opcodes - it is
>+large enough to include bits set for all supported opcodes,
>+that is the length can be calculated by starting with the largest
>+supported opcode adding one, dividing by 64 and rounding up.
>+In other words, for
>+VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE the
>+length of \field{command_specific_result} and
>+\field{command_specific_data} respectively will be
>+$DIV_ROUND_UP(max_cmd, 64) * 8$ where DIV_ROUND_UP is integer division
>+with round up and \field{max_cmd} is the largest available command opcode.
>+
>+The array is also allowed to be larger and to additionally
>+include an arbitrary number of all-zero entries.
>+
>+Accordingly, bits 0 and 1 corresponding to opcode 0
>+(VIRTIO_ADMIN_CMD_LIST_QUERY) and 1
>+(VIRTIO_ADMIN_CMD_LIST_USE) are
>+always set in \field{device_admin_cmds[0]} returned by VIRTIO_ADMIN_CMD_LIST_QUERY.
>+
>+For the command VIRTIO_ADMIN_CMD_LIST_QUERY, \field{opcode} is set to 0x0.
>+The \field{group_member_id} is unused. It is set to zero by driver.
>+This command has no command specific data.
>+The device, upon success, returns a result in
>+\field{command_specific_result} in the format
>+\field{struct virtio_admin_cmd_list} describing the
>+list of administration commands supported for the given group.

Hmm, IIUC, the list is per group type (not group). If yes, could
you please consistently use "group type"?

Also, I think you are missing requirement for driver to
specify \field{group_type}.



>+
>+
>+For the command VIRTIO_ADMIN_CMD_LIST_USE, \field{opcode}
>+is set to 0x1.
>+The \field{group_member_id} is unused. It is set to zero by driver.
>+The \field{command_specific_data} is in the format

Missing \field{group_type} here as well.


>+\field{struct virtio_admin_cmd_list} describing the
>+list of administration commands used by the driver.
>+This command has no command specific result.
>+
>+The driver issues the command VIRTIO_ADMIN_CMD_LIST_QUERY to
>+query the list of commands valid for this group and before sending
>+any commands for any member of a group.
>+
>+The driver then enables use of some of the opcodes by sending to
>+the device the command VIRTIO_ADMIN_CMD_LIST_USE with a subset
>+of the list returned by VIRTIO_ADMIN_CMD_LIST_QUERY that is
>+both understood and used by the driver.
>+
>+If the device supports the command list used by the driver, the
>+device completes the command with status VIRTIO_ADMIN_STATUS_OK.

How can the device not support the command list passed by driver? In the
para above you say it is a subset of query list. Wouldn't it be better
to say that driver would have to pass cmd op which was not in the query
list? IDK, maybe better to emphasize this.


>+If the device does not support the command list, the device
>+completes the command with status
>+VIRTIO_ADMIN_STATUS_INVALID_FIELD.
>+
>+Note: drivers are assumed not to set bits in device_admin_cmds
>+if they are not familiar with how the command opcode
>+is used, since devices could have dependencies between
>+command opcodes.
>+
>+It is assumed that all members in a group support and are used
>+with the same list of commands. However, for owner devices
>+supporting multiple group types, the list of supported commands
>+might differ between different group types.
>+
> \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
> 
> An administration virtqueue of an owner device is used to submit
>-- 
>MST
>
>
>---------------------------------------------------------------------
>To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

