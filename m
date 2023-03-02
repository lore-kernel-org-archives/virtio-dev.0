Return-Path: <virtio-dev-return-11371-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71701C7EE30
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:06:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2063071C80
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:05:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 10F31986682
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:05:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 057B8986679; Thu,  2 Mar 2023 13:05:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E9FF5986674
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 13:05:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: GuEvpXRVMRy7SefmVjiEFA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677762326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLmwQYXV7Qln1DMQeSF7VfcnI//8vJ4XragOkJMesXw=;
        b=7f44krJO72ZHdNrgoh+y/8O+eExnVaUwIbK03H65myzPxmpWBiA/+/KPGXSrmcAH61
         /SKAJKJRF04Oh0Pj45w0cGo/zB3/WXzQcLIPQNXV7lpTlC1cX0vj973qVtqSqkybbmwR
         Nm+YhhiJdQH0A2iQMjlA8486Uvo0aXTZy05x5jkryubFfLpVT4nduKRxdxsAMg9m2i8h
         GvWOlaUsyNxRE6i6RxPP6aMeFin2YRuMiDIlTHnkyzKbVTzD2mXIVgOhk71VZNeqJoCE
         JIgnYlS2G99tVo15VN5PxKLoNt9uHUtcZATgwOjQbvoG8E1qIVfYR3s6LeQ3oV3xjAwt
         HtTA==
X-Gm-Message-State: AO0yUKW8td6QGjECQUqWAdTleCnZO8eooQ0770OBlDYTP0wKkVk7Riev
	vU3NlvmftVyT2j2jV/Psx5Ppkc0Ly/oaIEwhyo3bhFdZX9mouXnKGuvje5uC/RAKLSTLY2yWTHq
	o8vviy7ZvhhTtYMavG/CIsiY+LvtZ
X-Received: by 2002:a05:600c:4da4:b0:3eb:3843:9f31 with SMTP id v36-20020a05600c4da400b003eb38439f31mr7810754wmp.10.1677762326362;
        Thu, 02 Mar 2023 05:05:26 -0800 (PST)
X-Google-Smtp-Source: AK7set8RnyQINxf/k9+DyHfxiwKuFun+77lrFzHc00RP3qGXu61BOsmK5ZEQ9X3Atx+ievX+Q3aqaw==
X-Received: by 2002:a05:600c:4da4:b0:3eb:3843:9f31 with SMTP id v36-20020a05600c4da400b003eb38439f31mr7810730wmp.10.1677762326056;
        Thu, 02 Mar 2023 05:05:26 -0800 (PST)
Date: Thu, 2 Mar 2023 08:05:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <80c4bc60c9119f68b66f5a003564cec719cc1487.1677761896.git.mst@redhat.com>
References: <cover.1677761896.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1677761896.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] [PATCH v10 08/10] admin: command list discovery

Add commands to find out which commands does each group support,
as well as enable their use by driver.
This will be especially useful once we have multiple group types.

An alternative is per-type VQs. This is possible but will
require more per-transport work. Discovery through the vq
helps keep things contained.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 admin.tex | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/admin.tex b/admin.tex
index 3ffac2e..1172054 100644
--- a/admin.tex
+++ b/admin.tex
@@ -99,7 +99,9 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 \hline
 opcode & Name & Command Description \\
 \hline \hline
-0x0000 - 0x7FFF & - &  Group administration commands    \\
+0x0000 & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver list of commands supported for this group type    \\
+0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of commands used for this group type \\
+0x0002 - 0x7FFF & - &  Group administration commands    \\
 \hline
 0x8000 - 0xFFFF & - & Reserved    \\
 \hline
@@ -156,6 +158,99 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 depends on these structures and is described separately or is
 implicit in the structure description.
 
+Before sending any administration commands to the device, the driver
+needs to communicate to the device which commands it is going to
+use. Initially (after reset), only two commands are assumed to be used:
+VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE.
+
+Before sending any other commands for any member of a specific group to
+the device, the driver queries the supported commands via
+VIRTIO_ADMIN_CMD_LIST_QUERY and sends the commands it will use via
+VIRTIO_ADMIN_CMD_LIST_USE.
+
+Commands VIRTIO_ADMIN_CMD_LIST_QUERY and
+VIRTIO_ADMIN_CMD_LIST_USE
+both use the following structure describing the
+command opcodes:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_list {
+       /* Indicates which of the below fields were returned
+       le64 device_admin_cmds[];
+};
+\end{lstlisting}
+
+This structure is an array of 64 bit values in little-endian byte
+order, in which a bit is set if the specific command opcode
+is supported. Thus, \field{device_admin_cmds[0]} refers to the first 32-bit value
+in this array corresponding to opcodes 0 to 63,
+\field{device_admin_cmds[1]} is the second 64-bit value
+corresponding to opcodes 64 to 127, etc.
+For example, the array of size 2 including
+the values 0x3 in \field{device_admin_cmds[0]}
+and 0x1 in \field{device_admin_cmds[1]} indicates that only
+opcodes 0, 1 and 64 are supported.
+The length of the array depends on the supported opcodes - it is
+large enough to include bits set for all supported opcodes,
+that is the length can be calculated by starting with the largest
+supported opcode adding one, dividing by 64 and rounding up.
+In other words, for
+VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE the
+length of \field{command_specific_result} and
+\field{command_specific_data} respectively will be
+$DIV_ROUND_UP(max_cmd, 64) * 8$ where DIV_ROUND_UP is integer division
+with round up and \field{max_cmd} is the largest available command opcode.
+
+The array is also allowed to be larger and to additionally
+include an arbitrary number of all-zero entries.
+
+Accordingly, bits 0 and 1 corresponding to opcode 0
+(VIRTIO_ADMIN_CMD_LIST_QUERY) and 1
+(VIRTIO_ADMIN_CMD_LIST_USE) are
+always set in \field{device_admin_cmds[0]} returned by VIRTIO_ADMIN_CMD_LIST_QUERY.
+
+For the command VIRTIO_ADMIN_CMD_LIST_QUERY, \field{opcode} is set to 0x0.
+The \field{group_member_id} is unused. It is set to zero by driver.
+This command has no command specific data.
+The device, upon success, returns a result in
+\field{command_specific_result} in the format
+\field{struct virtio_admin_cmd_list} describing the
+list of administration commands supported for the given group.
+
+
+For the command VIRTIO_ADMIN_CMD_LIST_USE, \field{opcode}
+is set to 0x1.
+The \field{group_member_id} is unused. It is set to zero by driver.
+The \field{command_specific_data} is in the format
+\field{struct virtio_admin_cmd_list} describing the
+list of administration commands used by the driver.
+This command has no command specific result.
+
+The driver issues the command VIRTIO_ADMIN_CMD_LIST_QUERY to
+query the list of commands valid for this group and before sending
+any commands for any member of a group.
+
+The driver then enables use of some of the opcodes by sending to
+the device the command VIRTIO_ADMIN_CMD_LIST_USE with a subset
+of the list returned by VIRTIO_ADMIN_CMD_LIST_QUERY that is
+both understood and used by the driver.
+
+If the device supports the command list used by the driver, the
+device completes the command with status VIRTIO_ADMIN_STATUS_OK.
+If the device does not support the command list, the device
+completes the command with status
+VIRTIO_ADMIN_STATUS_INVALID_FIELD.
+
+Note: drivers are assumed not to set bits in device_admin_cmds
+if they are not familiar with how the command opcode
+is used, since devices could have dependencies between
+command opcodes.
+
+It is assumed that all members in a group support and are used
+with the same list of commands. However, for owner devices
+supporting multiple group types, the list of supported commands
+might differ between different group types.
+
 \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
 
 An administration virtqueue of an owner device is used to submit
-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

