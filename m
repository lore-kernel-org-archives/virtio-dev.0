Return-Path: <virtio-dev-return-12586-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED60EC77B7F
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:41:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 73CBD419A6
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:41:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6B09A9866BF
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:41:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5EB2E9866BC; Fri,  5 May 2023 15:41:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DBF7198674A
	for <virtio-dev@lists.oasis-open.org>; Fri,  5 May 2023 15:41:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: xRX0pgiLOa2mMajBRbJyWw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683301265; x=1685893265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5WzcH2i2mvswvBi8XdyC3PeKReVhH9Cl63AxY5Z09s=;
        b=Bwm0X++SR3apHas/TewRGj9CaUwXs/38aSVKHFeqJORzX8DHkmYo6qsDoNr2zPDUtS
         vh5XyS3r8oGpYgKA1GtZGoKFX+SzSxQFJ9dTp2IBWoV89WFBSJVWVGpXgGyCSxwI1qET
         ofxSduIpJnSGheHMcl0Vdw1pB2QRSWrDFXqQVNND+5fOuNLh8lvPDBLL7upwCfdGVI3j
         mzShCenBMiG/grV7Wt+mnzFjNOCX2fAdsSWX28hG5Y0z5237RQr1eHs7KJsdy2wl96cX
         G9f1RCufeAYi9kk8OqgVqOyvZ7PIqZE8lGPyrGZUBcxVqhh3pDTPax+ybLIY17sUrLxs
         9UhA==
X-Gm-Message-State: AC+VfDz6CW2YAB5SZo25EhxUiJJAdjwqtXw1VO+o//sqSBL7dj5MH4BX
	676PXpazTWhct6HvfV6aSjjci3MpNYnZHW0DqGLY6GEeNFEPl8bK4Hdu9HLEed79E4eN+zuSjCn
	VlMzgKNuxxhy5TjFcMkk8nEURzOJR
X-Received: by 2002:a7b:cd04:0:b0:3f1:9527:8e8a with SMTP id f4-20020a7bcd04000000b003f195278e8amr1513723wmj.21.1683301265548;
        Fri, 05 May 2023 08:41:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4gaXr2DgzKWkfhTL2uRq9iVVECgbhLzii0bbad1eHuGEjzWqKPsn2jA/m2T1owumJTTcoDYA==
X-Received: by 2002:a7b:cd04:0:b0:3f1:9527:8e8a with SMTP id f4-20020a7bcd04000000b003f195278e8amr1513714wmj.21.1683301265338;
        Fri, 05 May 2023 08:41:05 -0700 (PDT)
Date: Fri, 5 May 2023 11:41:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <9848a0e23c02cfc4ca03bf72e37860578c58b18b.1683301091.git.mst@redhat.com>
References: <cover.1683301091.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1683301091.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] [PATCH v13 08/10] admin: command list discovery

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

Based-on-patch-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Zhu Lingshan <lingshan.zhu@intel.com>

---

changes in v12:

devices->device address comment by parav

changes in v11:

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
index 5acec67..d940503 100644
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
+VIRTIO_ADMIN_CMD_LIST_USE both use the following structure for
+\field{command_specific_result} and \field{command_specific_data}
+respectively describing the command opcodes:
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
+Note: the driver is assumed not to set bits in
+device_admin_cmd_opcodes
+if it is not familiar with how the command opcode
+is used, since the device could have dependencies between
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

