Return-Path: <virtio-dev-return-11903-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575ABC76188
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:06:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E897C7562A
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:05:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E452298640C
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:05:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D5E049863D6; Mon,  3 Apr 2023 15:05:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 988E498655C
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Apr 2023 15:04:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: XzUqTs8xOw2jf8mqPqMjrw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680534236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0h7R+yNAjsI1GAgNme8oPXPs4BCdv3mAxhoIkV94XWo=;
        b=OxQ7hDvsG2IbMg8mQavVxvDIoH97MLVomNMr39eAc6j8KOyiwRIFHnsiAaP65TgaAY
         7XDEmwsBVAVKglUNhFjY6XnS7BnGEYwTUicicX/8/9v9hFzA448mz3xB4MXfvhP20wNe
         YYRnKFp9TtSBmn80ihwyI5lMJ2OOf5rW0aaG1hRaUYq0XQ8B9OcDFaVqxsd0B2Xd6Ey7
         +VCJhs8Ojkq0nmMxYPxGPXQ2TwZMAKug07pTZatk/f3PsX/SpEJEDToWEcNQ3tBr2Sjt
         EKxf6HQgFJAZt6wYTdzwNlG3MK0N/r2VwnMNAT5mQH6YiaQ2+PC6WunN4ZPe2zgfEFqZ
         CcFw==
X-Gm-Message-State: AAQBX9eTrGVJvrV9DieTzq7/WYxaI0qajfFhJhihOcN4MZtWG1Ai1Xrr
	6Ba52TqE7rbtFe0o5qOrVNMNOePk786NeXolfRWAw+l/MhPEcEhP6KmTeKXd3LqYth7PT0S32q8
	n/NTwlgGgt1qdfNxnzS6OwK7xKPF2
X-Received: by 2002:a05:6402:1394:b0:502:9a70:3a39 with SMTP id b20-20020a056402139400b005029a703a39mr4374684edv.1.1680534236390;
        Mon, 03 Apr 2023 08:03:56 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZIrcitHYCjupRGHbfCeFuSMz1o6kxQws8uLFsBX1ejPLsa7xmfVOavXkF6Rd/HhvExSaVIfQ==
X-Received: by 2002:a05:6402:1394:b0:502:9a70:3a39 with SMTP id b20-20020a056402139400b005029a703a39mr4374651edv.1.1680534236024;
        Mon, 03 Apr 2023 08:03:56 -0700 (PDT)
Date: Mon, 3 Apr 2023 11:03:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <84cf421ad95111b37cddb52b2a7bf625b7955ae6.1680533760.git.mst@redhat.com>
References: <cover.1680533760.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1680533760.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] [PATCH v11 08/10] admin: command list discovery

Add commands to find out which commands does each group support,
as well as enable their use by driver.
This will be especially useful once we have multiple group types.

An alternative is per-type VQs. This is possible but will
require more per-transport work. Discovery through the vq
helps keep things contained.

e.g. lack of support for some command can switch to a legacy mode

note that commands are expected to be avolved by adding new
fields to command specific data at the tail, so
we generally do not need feature bits for compatibility.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---
dropped S.O.B by Max
explain in commit log how commands will evolve, comment by Stefan
replace will use with is capable of use, comment by Stefan
typo fix reported by David and Lingshan
rename cmds to cmd_opcodes suggested by Jiri
list group_type explicitly in command description suggested by Jiri
clarify how can device not support some commands
always say group administration commands, comment by Jiri
---
 admin.tex | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 1 deletion(-)

diff --git a/admin.tex b/admin.tex
index f201bcd..9552797 100644
--- a/admin.tex
+++ b/admin.tex
@@ -113,7 +113,9 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 \hline
 opcode & Name & Command Description \\
 \hline \hline
-0x0000 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
+0x0000 & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver list of commands supported for this group type    \\
+0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of commands used for this group type \\
+0x0002 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
 \hline
 0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a different structure)    \\
 \hline
@@ -183,6 +185,104 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 depends on these structures and is described separately or is
 implicit in the structure description.
 
+Before sending any group administration commands to the device, the driver
+needs to communicate to the device which commands it is going to
+use. Initially (after reset), only two commands are assumed to be used:
+VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE.
+
+Before sending any other commands for any member of a specific group to
+the device, the driver queries the supported commands via
+VIRTIO_ADMIN_CMD_LIST_QUERY and sends the commands it is
+capable of using via VIRTIO_ADMIN_CMD_LIST_USE.
+
+Commands VIRTIO_ADMIN_CMD_LIST_QUERY and
+VIRTIO_ADMIN_CMD_LIST_USE
+both use the following structure describing the
+command opcodes:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_list {
+       /* Indicates which of the below fields were returned
+       le64 device_admin_cmd_opcodes[];
+};
+\end{lstlisting}
+
+This structure is an array of 64 bit values in little-endian byte
+order, in which a bit is set if the specific command opcode
+is supported. Thus, \field{device_admin_cmd_opcodes[0]} refers to the
+first 64-bit value in this array corresponding to opcodes 0 to
+63, \field{device_admin_cmd_opcodes[1]} is the second 64-bit value
+corresponding to opcodes 64 to 127, etc.
+For example, the array of size 2 including
+the values 0x3 in \field{device_admin_cmd_opcodes[0]}
+and 0x1 in \field{device_admin_cmd_opcodes[1]} indicates that only
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
+always set in \field{device_admin_cmd_opcodes[0]} returned by VIRTIO_ADMIN_CMD_LIST_QUERY.
+
+For the command VIRTIO_ADMIN_CMD_LIST_QUERY, \field{opcode} is set to 0x0.
+The \field{group_member_id} is unused. It is set to zero by driver.
+This command has no command specific data.
+The device, upon success, returns a result in
+\field{command_specific_result} in the format
+\field{struct virtio_admin_cmd_list} describing the
+list of group administration commands supported for the group type
+specified by \field{group_type}.
+
+For the command VIRTIO_ADMIN_CMD_LIST_USE, \field{opcode}
+is set to 0x1.
+The \field{group_member_id} is unused. It is set to zero by driver.
+The \field{command_specific_data} is in the format
+\field{struct virtio_admin_cmd_list} describing the
+list of group administration commands used by the driver
+with the group type specified by \field{group_type}.
+
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
+If the device does not support the command list
+(for example, if the driver is not capable to use
+some required commands), the device
+completes the command with status
+VIRTIO_ADMIN_STATUS_INVALID_FIELD.
+
+Note: drivers are assumed not to set bits in
+device_admin_cmd_opcodes
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

