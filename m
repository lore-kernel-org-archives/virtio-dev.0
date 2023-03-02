Return-Path: <virtio-dev-return-11367-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95E6C678D4
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:06:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CAC101FF88
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:05:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F338A98694C
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:05:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6D7B198685C; Thu,  2 Mar 2023 13:05:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EBADA986681
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 13:05:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 0RMR94uyMjyueQgAb4W6Ug-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677762306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2wr/EX1JRtI77rk9raot2cbaqFbczAhu++ouMjO+58=;
        b=78cfclr0n51MC75XDdOmCkyCtD3Ao4tXx0NBU5BJbm00O3e0I7yryhacC72nA4MT1R
         PXV3ZW9foNM9F1/smXChheomTdEWrHz/LZGFAkJyfWFUYD+T7lYaF6M5jrg02KR4rqwR
         e0P/hlWgnSSFHGVAP0GwY9SLxLK70THDP/DyDKYT16WxX2YeEotDjT3uRziAAF/AA46d
         en10ZJfA/Sdt97U3t6gSSdk3DS5Yod5xcafgRxGS4WzVY2OHiXP39gV4omvN0WeZ/0Ny
         ZIiStTIWkrqWtq0qvVb+FflS5UKa3pph6LM1V458sIEJt+S4HrrE2zbCscUps4JMgAv3
         C1bQ==
X-Gm-Message-State: AO0yUKWmiUyDDLSLEDx1Lg/ZZt1VlFyMgEHAoXot1+CuT8POmbIyN6iR
	segsFvEqjdNmY8OrLB7rnECyWL3tRbiF5CSK9nyGYiZMnIgK5HFYAN6tCO0i5hJ2lqcO2IwZ/Y7
	Z1aT9YhOgtmPaVMjaYe1DTYCfce5x
X-Received: by 2002:a05:600c:450f:b0:3ea:d620:570a with SMTP id t15-20020a05600c450f00b003ead620570amr7838092wmo.38.1677762306177;
        Thu, 02 Mar 2023 05:05:06 -0800 (PST)
X-Google-Smtp-Source: AK7set/whQjA7p/dv85TEbWuuij7sFumVFyzr8cGx9qwzQSLj1A7CHt/N3sCyWbiLt3T43jLHV2rEA==
X-Received: by 2002:a05:600c:450f:b0:3ea:d620:570a with SMTP id t15-20020a05600c450f00b003ead620570amr7838075wmo.38.1677762305857;
        Thu, 02 Mar 2023 05:05:05 -0800 (PST)
Date: Thu, 2 Mar 2023 08:05:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <910b3607a5f255134d30b3e1233e564f564eafb8.1677761896.git.mst@redhat.com>
References: <cover.1677761896.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1677761896.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] [PATCH v10 03/10] admin: introduce group administration commands

This introduces a general structure for group administration commands,
used to control device groups through their owner.

Following patches will introduce specific commands and an interface for
submitting these commands to the owner.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 admin.tex        | 108 +++++++++++++++++++++++++++++++++++++++++++++++
 introduction.tex |   3 ++
 2 files changed, 111 insertions(+)

diff --git a/admin.tex b/admin.tex
index 3dc47be..7e28b77 100644
--- a/admin.tex
+++ b/admin.tex
@@ -46,4 +46,112 @@ \section{Device groups}\label{sec:Basic Facilities of a Virtio Device / Device g
 PCI transport (see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus}).
 \end{description}
 
+\subsection{Group administration commands}\label{sec:Basic Facilities of a Virtio Device / Device groups / Group administration commands}
 
+The driver sends group administration commands to the owner device of
+a group to control member devices of the group.
+This mechanism can
+be used, for example, to configure a member device before it is
+initialized by its driver.
+\footnote{The term "administration" is intended to be interpreted
+widely to include any kind of control. See specific commands
+for detail.}
+
+All the group administration commands are of the following form:
+
+\begin{lstlisting}
+struct virtio_admin_cmd {
+        /* Device-readable part */
+        le16 opcode;
+        /*
+         * 1 - SR-IOV
+         * 2 - 65535 reserved
+         */
+        le16 group_type;
+        /* unused, reserved for future extensions */
+        u8 reserved1[12];
+        le64 group_member_id;
+        u8 command_specific_data[];
+
+        /* Device-writable part */
+        le16 status;
+        le16 status_qualifier;
+        /* unused, reserved for future extensions */
+        u8 reserved2[4];
+        u8 command_specific_result[];
+};
+\end{lstlisting}
+
+For all commands, \field{opcode}, \field{group_type} and if
+necessary \field{group_member_id} and \field{command_specific_data} are
+set by the driver, and the owner device sets \field{status} and if
+needed \field{status_qualifier} and
+\field{command_specific_result}.
+
+Generally, any unused device-readable fields are set to zero by the driver
+and ignored by the device.  Any unused device-writeable fields are set to zero
+by the device and ignored by the driver.
+
+\field{opcode} specifies the command. The valid
+values for \field{opcode} can be found in the following table:
+
+\begin{tabular}{|l|l|}
+\hline
+opcode & Name & Command Description \\
+\hline \hline
+0x0000 - 0x7FFF & - &  Group administration commands    \\
+\hline
+0x8000 - 0xFFFF & - & Reserved    \\
+\hline
+\end{tabular}
+
+The \field{group_type} specifies the group type identifier.
+The \field{group_member_id} specifies the member identifier within the group.
+See section \ref{sec:Introduction / Terminology / Device group}
+for the definition of the group type identifier and group member
+identifier.
+
+The following table describes possible \field{status} values;
+to simplify common implementations, they are intentionally
+matching common \hyperref[intro:errno]{Linux error names and numbers}:
+
+\begin{tabular}{|l|l|l|}
+\hline
+Status (decimal) & Name & Description \\
+\hline \hline
+00   & VIRTIO_ADMIN_STATUS_OK    & successful completion  \\
+\hline
+22   & VIRTIO_ADMIN_STATUS_EINVAL    & invalid command \\
+\hline
+other   & -    & group administration command error  \\
+\hline
+\end{tabular}
+
+When \field{status} is VIRTIO_ADMIN_STATUS_OK, \field{status_qialifier}
+is reserved and set to zero by the device.
+
+When \field{status} is VIRTIO_ADMIN_STATUS_EINVAL,
+the following table describes possible \field{status_qialifier} values:
+\begin{tabular}{|l|l|l|}
+\hline
+Status & Name & Description \\
+\hline \hline
+0x00   & VIRTIO_ADMIN_STATUS_Q_INVALID_COMMAND   & command error: no additional information  \\
+\hline
+0x01   & VIRTIO_ADMIN_STATUS_Q_INVALID_OPCODE    & unsupported or invalid \field{opcode}  \\
+\hline
+0x02   & VIRTIO_ADMIN_STATUS_Q_INVALID_FIELD    & unsupported or invalid field within \field{command_specific_data}  \\
+\hline
+0x03   & VIRTIO_ADMIN_STATUS_Q_INVALID_GROUP    & unsupported or invalid \field{group_type} \\
+\hline
+0x04   & VIRTIO_ADMIN_STATUS_Q_INVALID_MEMBER    & unsupported or invalid \field{group_member_id} \\
+\hline
+0x05-0xFFFF   & -    & reserved for future use \\
+\hline
+\end{tabular}
+
+Each command uses a different \field{command_specific_data} and
+\field{command_specific_result} structures and the length of
+\field{command_specific_data} and \field{command_specific_result}
+depends on these structures and is described separately or is
+implicit in the structure description.
diff --git a/introduction.tex b/introduction.tex
index 287c5fc..0d849a9 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -68,6 +68,9 @@ \section{Normative References}\label{sec:Normative References}
 	\phantomsection\label{intro:FUSE}\textbf{[FUSE]} &
 	Linux FUSE interface,
 	\newline\url{https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/fuse.h}\\
+	\phantomsection\label{intro:errno}\textbf{[errno]} &
+	Linux error names and numbers,
+	\newline\url{https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/uapi/asm-generic/errno-base.h}\\
         \phantomsection\label{intro:eMMC}\textbf{[eMMC]} &
         eMMC Electrical Standard (5.1), JESD84-B51,
         \newline\url{http://www.jedec.org/sites/default/files/docs/JESD84-B51.pdf}\\
-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

