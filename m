Return-Path: <virtio-dev-return-11263-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31239C64ED8
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 22:24:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9320F44348
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 22:24:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 876999867E5
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 22:24:12 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 74B579867AF; Fri, 24 Feb 2023 22:24:12 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 01C869867C7;
	Fri, 24 Feb 2023 22:22:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrMDWa3QMpDvjZTjlL5IA+MgH+nrMx+Ek/O+LjbabWoxFeHxN2cTtcOTIdv0Rx7TT+zzt091TcDaezJ1Q1eldPsQEL4dB+CML8f6DvW4OeILSMFK0utgdpgFNvc24K6cetuo+loF1es5sF93/y1jQK0huyZO9Yp8DzjrWLiW53bSeTXYksEph+hQoci7otHCCVyiK15/ii/Tuji7SBi9fb2lpCZdHHzCHJ8u6JsS5Yz0EYyQWKQbcVHDdEJ/y6NMNiYCEhlxDIQ2K/VPpdb4/7msCtDe+cwqE1vqx5KuVGYIsYey2Tv/+ntzchg6lwfq/MZxTEj8IP+8s2ZHFuDfFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63QbMpm1JzFztLsgVSUYhNfaWzhUjuIgfhe16nTFWa8=;
 b=Liw1AHPJXY9aj8vmhJrnV/LZ2MhcxW72dR8eOpouCEHH5FkxyDJ4zLPBcVoSyq+2+SmVP3o55Y6TKzo5FS94kNsf9bYgOHgIxa3+CAtgecH/QYYHiGaUgk2MGq9F2jyuokHxoDbhf/N0t2fWQGBjiYP6KlTMVoYSOol1D2TlQKlNB/viY6AFkUSNiML8ZJyJvjAJpVn+s3ovZSuUrp+137UdQTX1JPHr5nQYgvhmEcYXdAeGTaThT1YmD7vLOCz6QpKkEN5a0IG+jY/oAcB3JFgDAsTjZGWbeqkQrM7npVKiJSKPNVZiqWkBl3fC0DEcOTEA0Ql7mM57Xk5D2O0xPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Sat, 25 Feb 2023 00:22:12 +0200
Message-ID: <20230224222215.339715-4-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230224222215.339715-1-parav@nvidia.com>
References: <20230224222215.339715-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT094:EE_|BL0PR12MB4932:EE_
X-MS-Office365-Filtering-Correlation-Id: 88287d18-f746-4196-3cb9-08db16b5a44d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ybaye9Vd/w+e5bqQSh18HoWzceh4zbjvj3zfwlZHtngksH0YBlHedA2dS9R+tkCDA7Xb6q1tuz5UYTSsiL6XwKGFd0Q2I+QDFssmmchXW5tJQBmJI4cQjHy9WPvvqxtym8fPjgZiE/KeMMQtO/XmnaOKq1Ut1gDz0tjVT96++xb9Y/5GtFNFUSEXBVWzlaTastk5jOxhJddUQmyan6gcuVjbC/9wcuXYWCEF4sDr2OMFyF8KPLOvy8/KWSHxlwWeRrXe16henH1seWB2VBt84+vch03kUaRLUqer/d0wNRzRR4XpXMnZzI0MgA7wJCWX1dip6CVlVKgPOaz8/2kJboGmcXDPsqV1EFu/4iWQXNaKhWN03kTt1IRonheb2NUoF1yF19Z/SvpR8aDjcbL24zku0iQE8QJ0tmVOdQYmSRO1Qe33rp5Af9CaY6E8dGn3SOuoaHfe2dfhxjDt8EUcuUrDDLZgOVE3fGi2I00xeGbypOy1Z6Qi7W/d2rzDEZX3cl52eqzVnNQ3Y6+XtzeWa6OjD55B5JWiaz+gvqM/hrN89DTGPaNfXnDmuB4v6zizuA2Zpg2ZfDApAYJ62Qx9LfT5ooWbZjWtfMr0JirMg8FmwPGfu+c4KA8y3fAAP68iRbDeUPQLkBd5UNBtC2hx6T/ZEcLn4Sxtq7niXeNrP5iJZHdF+p7ppNK26JlZ45WgyXAJR5Wa0/2K2hGgyvmODbI1OPtfoT/1BVt8oGd6TiYyDXtE0y44RFtaJYUTbm7rJaWm0YkRV8iDglHKNFQYDQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199018)(36840700001)(40470700004)(46966006)(30864003)(110136005)(70586007)(70206006)(54906003)(8936002)(5660300002)(41300700001)(66899018)(478600001)(4326008)(8676002)(2906002)(316002)(40480700001)(966005)(107886003)(6666004)(1076003)(2616005)(26005)(16526019)(186003)(40460700003)(36756003)(336012)(82310400005)(34020700004)(36860700001)(426003)(47076005)(7636003)(83380400001)(82740400003)(356005)(86362001)(579004)(559001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 22:22:40.3067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88287d18-f746-4196-3cb9-08db16b5a44d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4932
Subject: [virtio-dev] [PATCH v5 3/6] transport-ccw: Split Channel IO transport to its own file
Message-ID: <20230224222212.L9zNql36T1XnVHrmZBQZC1IhM0iVAW2GHUd-DddE0xA@z>

Place Channel IO transport specification in its own file to
better maintain it.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/157
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v1->v2:
- renamed file to transport-ccw.tex
---
 content.tex       | 603 +---------------------------------------------
 transport-ccw.tex | 601 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 602 insertions(+), 602 deletions(-)
 create mode 100644 transport-ccw.tex

diff --git a/content.tex b/content.tex
index 80c28df..cff548a 100644
--- a/content.tex
+++ b/content.tex
@@ -581,608 +581,7 @@ \chapter{Virtio Transport Options}\label{sec:Virtio Transport Options}
 
 \input{transport-pci.tex}
 \input{transport-mmio.tex}
-
-\section{Virtio Over Channel I/O}\label{sec:Virtio Transport Options / Virtio Over Channel I/O}
-
-S/390 based virtual machines support neither PCI nor MMIO, so a
-different transport is needed there.
-
-virtio-ccw uses the standard channel I/O based mechanism used for
-the majority of devices on S/390. A virtual channel device with a
-special control unit type acts as proxy to the virtio device
-(similar to the way virtio-pci uses a PCI device) and
-configuration and operation of the virtio device is accomplished
-(mostly) via channel commands. This means virtio devices are
-discoverable via standard operating system algorithms, and adding
-virtio support is mainly a question of supporting a new control
-unit type.
-
-As the S/390 is a big endian machine, the data structures transmitted
-via channel commands are big-endian: this is made clear by use of
-the types be16, be32 and be64.
-
-\subsection{Basic Concepts}\label{sec:Virtio Transport Options / Virtio over channel I/O / Basic Concepts}
-
-As a proxy device, virtio-ccw uses a channel-attached I/O control
-unit with a special control unit type (0x3832) and a control unit
-model corresponding to the attached virtio device's subsystem
-device ID, accessed via a virtual I/O subchannel and a virtual
-channel path of type 0x32. This proxy device is discoverable via
-normal channel subsystem device discovery (usually a STORE
-SUBCHANNEL loop) and answers to the basic channel commands:
-
-\begin{itemize}
-\item NO-OPERATION (0x03)
-\item BASIC SENSE (0x04)
-\item TRANSFER IN CHANNEL (0x08)
-\item SENSE ID (0xe4)
-\end{itemize}
-
-For a virtio-ccw proxy device, SENSE ID will return the following
-information:
-
-\begin{tabular}{ |l|l|l| }
-\hline
-Bytes & Description & Contents \\
-\hline \hline
-0     & reserved              & 0xff \\
-\hline
-1-2   & control unit type     & 0x3832 \\
-\hline
-3     & control unit model    & <virtio device id> \\
-\hline
-4-5   & device type           & zeroes (unset) \\
-\hline
-6     & device model          & zeroes (unset) \\
-\hline
-7-255 & extended SenseId data & zeroes (unset) \\
-\hline
-\end{tabular}
-
-A virtio-ccw proxy device facilitates:
-\begin{itemize} 
-\item Discovery and attachment of virtio devices (as described above).
-\item Initialization of virtqueues and transport-specific facilities (using
-      virtio-specific channel commands).
-\item Notifications (via hypercall and a combination of I/O interrupts
-      and indicator bits).
-\end{itemize} 
-
-\subsubsection{Channel Commands for Virtio}\label{sec:Virtio Transport Options / Virtio
-over channel I/O / Basic Concepts/ Channel Commands for Virtio}
-
-In addition to the basic channel commands, virtio-ccw defines a
-set of channel commands related to configuration and operation of
-virtio:
-
-\begin{lstlisting}
-#define CCW_CMD_SET_VQ 0x13
-#define CCW_CMD_VDEV_RESET 0x33
-#define CCW_CMD_SET_IND 0x43
-#define CCW_CMD_SET_CONF_IND 0x53
-#define CCW_CMD_SET_IND_ADAPTER 0x73
-#define CCW_CMD_READ_FEAT 0x12
-#define CCW_CMD_WRITE_FEAT 0x11
-#define CCW_CMD_READ_CONF 0x22
-#define CCW_CMD_WRITE_CONF 0x21
-#define CCW_CMD_WRITE_STATUS 0x31
-#define CCW_CMD_READ_VQ_CONF 0x32
-#define CCW_CMD_SET_VIRTIO_REV 0x83
-#define CCW_CMD_READ_STATUS 0x72
-\end{lstlisting}
-
-\subsubsection{Notifications}\label{sec:Virtio Transport Options / Virtio
-over channel I/O / Basic Concepts/ Notifications}
-
-Available buffer notifications are realized as a hypercall. No additional
-setup by the driver is needed. The operation of available buffer
-notifications is described in section \ref{sec:Virtio Transport Options /
-Virtio over channel I/O / Device Operation / Guest->Host Notification}.
-
-Used buffer notifications are realized either as so-called classic or
-adapter I/O interrupts depending on a transport level negotiation. The
-initialization is described in sections \ref{sec:Virtio Transport Options
-/ Virtio over channel I/O / Device Initialization / Setting Up Indicators
-/ Setting Up Classic Queue Indicators} and \ref{sec:Virtio Transport
-Options / Virtio over channel I/O / Device Initialization / Setting Up
-Indicators / Setting Up Two-Stage Queue Indicators} respectively.  The
-operation of each flavor is described in sections \ref{sec:Virtio
-Transport Options / Virtio over channel I/O / Device Operation /
-Host->Guest Notification / Notification via Classic I/O Interrupts} and
-\ref{sec:Virtio Transport Options / Virtio over channel I/O / Device
-Operation / Host->Guest Notification / Notification via Adapter I/O
-Interrupts} respectively. 
-
-Configuration change notifications are done using so-called classic I/O
-interrupts. The initialization is described in section \ref{sec:Virtio
-Transport Options / Virtio over channel I/O / Device Initialization /
-Setting Up Indicators / Setting Up Configuration Change Indicators} and
-the operation in section \ref{sec:Virtio Transport Options / Virtio over
-channel I/O / Device Operation / Host->Guest Notification / Notification
-via Classic I/O Interrupts}.
-
-\devicenormative{\subsubsection}{Basic Concepts}{Virtio Transport Options / Virtio over channel I/O / Basic Concepts}
-
-The virtio-ccw device acts like a normal channel device, as specified
-in \hyperref[intro:S390 PoP]{[S390 PoP]} and \hyperref[intro:S390 Common I/O]{[S390 Common I/O]}. In particular:
-
-\begin{itemize}
-\item A device MUST post a unit check with command reject for any command
-  it does not support.
-
-\item If a driver did not suppress length checks for a channel command,
-  the device MUST present a subchannel status as detailed in the
-  architecture when the actual length did not match the expected length.
-
-\item If a driver did suppress length checks for a channel command, the
-  device MUST present a check condition if the transmitted data does
-  not contain enough data to process the command. If the driver submitted
-  a buffer that was too long, the device SHOULD accept the command.
-\end{itemize}
-
-\drivernormative{\subsubsection}{Basic Concepts}{Virtio Transport Options / Virtio over channel I/O / Basic Concepts}
-
-A driver for virtio-ccw devices MUST check for a control unit
-type of 0x3832 and MUST ignore the device type and model.
-
-A driver SHOULD attempt to provide the correct length in a channel
-command even if it suppresses length checks for that command.
-
-\subsection{Device Initialization}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization}
-
-virtio-ccw uses several channel commands to set up a device.
-
-\subsubsection{Setting the Virtio Revision}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Setting the Virtio Revision}
-
-CCW_CMD_SET_VIRTIO_REV is issued by the driver to set the revision of
-the virtio-ccw transport it intends to drive the device with. It uses the
-following communication structure:
-
-\begin{lstlisting}
-struct virtio_rev_info {
-        be16 revision;
-        be16 length;
-        u8 data[];
-};
-\end{lstlisting}
-
-\field{revision} contains the desired revision id, \field{length} the length of the
-data portion and \field{data} revision-dependent additional desired options.
-
-The following values are supported:
-
-\begin{tabular}{ |l|l|l|l| }
-\hline
-\field{revision} & \field{length} & \field{data}      & remarks \\
-\hline \hline
-0        & 0      & <empty>   & legacy interface; transitional devices only \\
-\hline
-1        & 0      & <empty>   & Virtio 1 \\
-\hline
-2        & 0      & <empty>   & CCW_CMD_READ_STATUS support \\
-\hline
-3-n      &        &           & reserved for later revisions \\
-\hline
-\end{tabular}
-
-Note that a change in the virtio standard does not necessarily
-correspond to a change in the virtio-ccw revision.
-
-\devicenormative{\paragraph}{Setting the Virtio Revision}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Setting the Virtio Revision}
-
-A device MUST post a unit check with command reject for any \field{revision}
-it does not support. For any invalid combination of \field{revision}, \field{length}
-and \field{data}, it MUST post a unit check with command reject as well. A
-non-transitional device MUST reject revision id 0.
-
-A device SHOULD answer with command reject to any virtio-ccw specific
-channel command that is not contained in the revision selected by the
-driver.
-
-A device MUST answer with command reject to any attempt to select a different revision
-after a revision has been successfully selected by the driver.
-
-A device MUST treat the revision as unset from the time the associated
-subchannel has been enabled until a revision has been successfully set
-by the driver. This implies that revisions are not persistent across
-disabling and enabling of the associated subchannel.
-
-\drivernormative{\paragraph}{Setting the Virtio Revision}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Setting the Virtio Revision}
-
-A driver SHOULD start with trying to set the highest revision it
-supports and continue with lower revisions if it gets a command reject.
-
-A driver MUST NOT issue any other virtio-ccw specific channel commands
-prior to setting the revision.
-
-After a revision has been successfully selected by the driver, it
-MUST NOT attempt to select a different revision.
-
-\paragraph{Legacy Interfaces: A Note on Setting the Virtio Revision}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Setting the Virtio Revision / Legacy Interfaces: A Note on Setting the Virtio Revision}
-
-A legacy device will not support the CCW_CMD_SET_VIRTIO_REV and answer
-with a command reject. A non-transitional driver MUST stop trying to
-operate this device in that case. A transitional driver MUST operate
-the device as if it had been able to set revision 0.
-
-A legacy driver will not issue the CCW_CMD_SET_VIRTIO_REV prior to
-issuing other virtio-ccw specific channel commands. A non-transitional
-device therefore MUST answer any such attempts with a command reject.
-A transitional device MUST assume in this case that the driver is a
-legacy driver and continue as if the driver selected revision 0. This
-implies that the device MUST reject any command not valid for revision
-0, including a subsequent CCW_CMD_SET_VIRTIO_REV.
-
-\subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Configuring a Virtqueue}
-
-CCW_CMD_READ_VQ_CONF is issued by the driver to obtain information
-about a queue. It uses the following structure for communicating:
-
-\begin{lstlisting}
-struct vq_config_block {
-        be16 index;
-        be16 max_num;
-};
-\end{lstlisting}
-
-The requested number of buffers for queue \field{index} is returned in
-\field{max_num}.
-
-Afterwards, CCW_CMD_SET_VQ is issued by the driver to inform the
-device about the location used for its queue. The transmitted
-structure is
-
-\begin{lstlisting}
-struct vq_info_block {
-        be64 desc;
-        be32 res0;
-        be16 index;
-        be16 num;
-        be64 driver;
-        be64 device;
-};
-\end{lstlisting}
-
-\field{desc}, \field{driver} and \field{device} contain the guest
-addresses for the descriptor area,
-available area and used area for queue \field{index}, respectively. The actual
-virtqueue size (number of allocated buffers) is transmitted in \field{num}.
-
-\devicenormative{\paragraph}{Configuring a Virtqueue}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Configuring a Virtqueue}
-
-\field{res0} is reserved and MUST be ignored by the device.
-
-\paragraph{Legacy Interface: A Note on Configuring a Virtqueue}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Configuring a Virtqueue / Legacy Interface: A Note on Configuring a Virtqueue}
-
-For a legacy driver or for a driver that selected revision 0,
-CCW_CMD_SET_VQ uses the following communication block:
-
-\begin{lstlisting}
-struct vq_info_block_legacy {
-        be64 queue;
-        be32 align;
-        be16 index;
-        be16 num;
-};
-\end{lstlisting}
-
-\field{queue} contains the guest address for queue \field{index}, \field{num} the number of buffers
-and \field{align} the alignment. The queue layout follows \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}.
-
-\subsubsection{Communicating Status Information}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Communicating Status Information}
-
-The driver changes the status of a device via the
-CCW_CMD_WRITE_STATUS command, which transmits an 8 bit status
-value.
-
-As described in
-\ref{devicenormative:Basic Facilities of a Virtio Device / Feature Bits},
-a device sometimes fails to set the \field{device status} field: For example, it
-might fail to accept the FEATURES_OK status bit during device initialization.
-
-With revision 2, CCW_CMD_READ_STATUS is defined: It reads an 8 bit status
-value from the device and acts as a reverse operation to CCW_CMD_WRITE_STATUS.
-
-\drivernormative{\paragraph}{Communicating Status Information}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Communicating Status Information}
-
-If the device posts a unit check with command reject in response to the
-CCW_CMD_WRITE_STATUS command, the driver MUST assume that the device failed
-to set the status and the \field{device status} field retained
-its previous value.
-
-If at least revision 2 has been negotiated, the driver SHOULD use the
-CCW_CMD_READ_STATUS command to retrieve the \field{device status} field after
-a configuration change has been detected.
-
-If not at least revision 2 has been negotiated, the driver MUST NOT attempt
-to issue the CCW_CMD_READ_STATUS command.
-
-\devicenormative{\paragraph}{Communicating Status Information}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Communicating Status Information}
-
-If the device fails to set the \field{device status} field
-to the value written by the driver, the device MUST assure
-that the \field{device status} field is left unchanged and
-MUST post a unit check with command reject.
-
-If at least revision 2 has been negotiated, the device MUST return the
-current \field{device status} field if the CCW_CMD_READ_STATUS
-command is issued.
-
-\subsubsection{Handling Device Features}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Handling Device Features}
-
-Feature bits are arranged in an array of 32 bit values, making
-for a total of 8192 feature bits. Feature bits are in
-little-endian byte order.
-
-The CCW commands dealing with features use the following
-communication block:
-
-\begin{lstlisting}
-struct virtio_feature_desc {
-        le32 features;
-        u8 index;
-};
-\end{lstlisting}
-
-\field{features} are the 32 bits of features currently accessed, while
-\field{index} describes which of the feature bit values is to be
-accessed. No padding is added at the end of the structure, it is
-exactly 5 bytes in length.
-
-The guest obtains the device's device feature set via the
-CCW_CMD_READ_FEAT command. The device stores the features at \field{index}
-to \field{features}.
-
-For communicating its supported features to the device, the driver
-uses the CCW_CMD_WRITE_FEAT command, denoting a \field{features}/\field{index}
-combination.
-
-\subsubsection{Device Configuration}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Device Configuration}
-
-The device's configuration space is located in host memory.
-
-To obtain information from the configuration space, the driver
-uses CCW_CMD_READ_CONF, specifying the guest memory for the device
-to write to.
-
-For changing configuration information, the driver uses
-CCW_CMD_WRITE_CONF, specifying the guest memory for the device to
-read from.
-
-In both cases, the complete configuration space is transmitted.  This
-allows the driver to compare the new configuration space with the old
-version, and keep a generation count internally whenever it changes.
-
-\subsubsection{Setting Up Indicators}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Setting Up Indicators}
-
-In order to set up the indicator bits for host->guest notification,
-the driver uses different channel commands depending on whether it
-wishes to use traditional I/O interrupts tied to a subchannel or
-adapter I/O interrupts for virtqueue notifications. For any given
-device, the two mechanisms are mutually exclusive.
-
-For the configuration change indicators, only a mechanism using
-traditional I/O interrupts is provided, regardless of whether
-traditional or adapter I/O interrupts are used for virtqueue
-notifications.
-
-\paragraph{Setting Up Classic Queue Indicators}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Setting Up Indicators / Setting Up Classic Queue Indicators}
-
-Indicators for notification via classic I/O interrupts are contained
-in a 64 bit value per virtio-ccw proxy device.
-
-To communicate the location of the indicator bits for host->guest
-notification, the driver uses the CCW_CMD_SET_IND command,
-pointing to a location containing the guest address of the
-indicators in a 64 bit value.
-
-If the driver has already set up two-staged queue indicators via the
-CCW_CMD_SET_IND_ADAPTER command, the device MUST post a unit check
-with command reject to any subsequent CCW_CMD_SET_IND command.
-
-\paragraph{Setting Up Configuration Change Indicators}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Setting Up Indicators / Setting Up Configuration Change Indicators}
-
-Indicators for configuration change host->guest notification are
-contained in a 64 bit value per virtio-ccw proxy device.
-
-To communicate the location of the indicator bits used in the
-configuration change host->guest notification, the driver issues the
-CCW_CMD_SET_CONF_IND command, pointing to a location containing the
-guest address of the indicators in a 64 bit value.
-
-\paragraph{Setting Up Two-Stage Queue Indicators}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Setting Up Indicators / Setting Up Two-Stage Queue Indicators}
-
-Indicators for notification via adapter I/O interrupts consist of
-two stages:
-\begin{itemize}
-\item a summary indicator byte covering the virtqueues for one or more
-  virtio-ccw proxy devices
-\item a set of contigous indicator bits for the virtqueues for a
-  virtio-ccw proxy device
-\end{itemize}
-
-To communicate the location of the summary and queue indicator bits,
-the driver uses the CCW_CMD_SET_IND_ADAPTER command with the following
-payload:
-
-\begin{lstlisting}
-struct virtio_thinint_area {
-        be64 summary_indicator;
-        be64 indicator;
-        be64 bit_nr;
-        u8 isc;
-} __attribute__ ((packed));
-\end{lstlisting}
-
-\field{summary_indicator} contains the guest address of the 8 bit summary
-indicator.
-\field{indicator} contains the guest address of an area wherein the indicators
-for the devices are contained, starting at \field{bit_nr}, one bit per
-virtqueue of the device. Bit numbers start at the left, i.e. the most
-significant bit in the first byte is assigned the bit number 0.
-\field{isc} contains the I/O interruption subclass to be used for the adapter
-I/O interrupt. It MAY be different from the isc used by the proxy
-virtio-ccw device's subchannel.
-No padding is added at the end of the structure, it is exactly 25 bytes
-in length.
-
-
-\devicenormative{\subparagraph}{Setting Up Two-Stage Queue Indicators}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Setting Up Indicators / Setting Up Two-Stage Queue Indicators}
-If the driver has already set up classic queue indicators via the
-CCW_CMD_SET_IND command, the device MUST post a unit check with
-command reject to any subsequent CCW_CMD_SET_IND_ADAPTER command.
-
-\paragraph{Legacy Interfaces: A Note on Setting Up Indicators}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Setting Up Indicators / Legacy Interfaces: A Note on Setting Up Indicators}
-
-In some cases, legacy devices will only support classic queue indicators;
-in that case, they will reject CCW_CMD_SET_IND_ADAPTER as they don't know that
-command. Some legacy devices will support two-stage queue indicators, though,
-and a driver will be able to successfully use CCW_CMD_SET_IND_ADAPTER to set
-them up.
-
-\subsection{Device Operation}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Operation}
-
-\subsubsection{Host->Guest Notification}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Operation / Host->Guest Notification}
-
-There are two modes of operation regarding host->guest notification,
-classic I/O interrupts and adapter I/O interrupts. The mode to be
-used is determined by the driver by using CCW_CMD_SET_IND respectively
-CCW_CMD_SET_IND_ADAPTER to set up queue indicators.
-
-For configuration changes, the driver always uses classic I/O
-interrupts.
-
-\paragraph{Notification via Classic I/O Interrupts}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Operation / Host->Guest Notification / Notification via Classic I/O Interrupts}
-
-If the driver used the CCW_CMD_SET_IND command to set up queue
-indicators, the device will use classic I/O interrupts for
-host->guest notification about virtqueue activity.
-
-For notifying the driver of virtqueue buffers, the device sets the
-corresponding bit in the guest-provided indicators. If an
-interrupt is not already pending for the subchannel, the device
-generates an unsolicited I/O interrupt.
-
-If the device wants to notify the driver about configuration
-changes, it sets bit 0 in the configuration indicators and
-generates an unsolicited I/O interrupt, if needed. This also
-applies if adapter I/O interrupts are used for queue notifications.
-
-\paragraph{Notification via Adapter I/O Interrupts}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Operation / Host->Guest Notification / Notification via Adapter I/O Interrupts}
-
-If the driver used the CCW_CMD_SET_IND_ADAPTER command to set up
-queue indicators, the device will use adapter I/O interrupts for
-host->guest notification about virtqueue activity.
-
-For notifying the driver of virtqueue buffers, the device sets the
-bit in the guest-provided indicator area at the corresponding offset.
-The guest-provided summary indicator is set to 0x01. An adapter I/O
-interrupt for the corresponding interruption subclass is generated.
-
-The recommended way to process an adapter I/O interrupt by the driver
-is as follows:
-
-\begin{itemize}
-\item Process all queue indicator bits associated with the summary indicator.
-\item Clear the summary indicator, performing a synchronization (memory
-barrier) afterwards.
-\item Process all queue indicator bits associated with the summary indicator
-again.
-\end{itemize}
-
-\devicenormative{\subparagraph}{Notification via Adapter I/O Interrupts}{Virtio Transport Options / Virtio over channel I/O / Device Operation / Host->Guest Notification / Notification via Adapter I/O Interrupts}
-
-The device SHOULD only generate an adapter I/O interrupt if the
-summary indicator had not been set prior to notification.
-
-\drivernormative{\subparagraph}{Notification via Adapter I/O Interrupts}{Virtio Transport Options / Virtio over channel I/O / Device Operation / Host->Guest Notification / Notification via Adapter I/O Interrupts}
-The driver
-MUST clear the summary indicator after receiving an adapter I/O
-interrupt before it processes the queue indicators.
-
-\paragraph{Legacy Interfaces: A Note on Host->Guest Notification}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Operation / Host->Guest Notification / Legacy Interfaces: A Note on Host->Guest Notification}
-
-As legacy devices and drivers support only classic queue indicators,
-host->guest notification will always be done via classic I/O interrupts.
-
-\subsubsection{Guest->Host Notification}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Operation / Guest->Host Notification}
-
-For notifying the device of virtqueue buffers, the driver
-unfortunately can't use a channel command (the asynchronous
-characteristics of channel I/O interact badly with the host block
-I/O backend). Instead, it uses a diagnose 0x500 call with subcode
-3 specifying the queue, as follows:
-
-\begin{tabular}{ |l|l|l| }
-\hline
-GPR  &   Input Value     & Output Value \\
-\hline \hline
-  1   &       0x3         &              \\
-\hline
-  2   &  Subchannel ID    & Host Cookie  \\
-\hline
-  3   & Notification data &              \\
-\hline
-  4   &   Host Cookie     &              \\
-\hline
-\end{tabular}
-
-When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
-the \field{Notification data} contains the Virtqueue number.
-
-When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
-the value has the following format:
-\lstinputlisting{notifications-be.c}
-
-See \ref{sec:Basic Facilities of a Virtio Device / Driver notifications}~\nameref{sec:Basic Facilities of a Virtio Device / Driver notifications}
-for the definition of the components.
-
-\devicenormative{\paragraph}{Guest->Host Notification}{Virtio Transport Options / Virtio over channel I/O / Device Operation / Guest->Host Notification}
-The device MUST ignore bits 0-31 (counting from the left) of GPR2.
-This aligns passing the subchannel ID with the way it is passed
-for the existing I/O instructions.
-
-The device MAY return a 64-bit host cookie in GPR2 to speed up the
-notification execution.
-
-\drivernormative{\paragraph}{Guest->Host Notification}{Virtio Transport Options / Virtio over channel I/O / Device Operation / Guest->Host Notification}
-
-For each notification, the driver SHOULD use GPR4 to pass the host cookie received in GPR2 from the previous notication.
-
-\begin{note}
-For example:
-\begin{lstlisting}
-info->cookie = do_notify(schid,
-                         virtqueue_get_queue_index(vq),
-                         info->cookie);
-\end{lstlisting}
-\end{note}
-
-\subsubsection{Resetting Devices}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Operation / Resetting Devices}
-
-In order to reset a device, a driver sends the
-CCW_CMD_VDEV_RESET command. This command does not carry any payload.
-
-The device signals completion of the virtio reset operation through successful
-conclusion of the CCW_CMD_VDEV_RESET channel command. In particular, the
-command not only triggers the reset operation, but the reset operation is
-already completed when the operation concludes successfully.
-
-\devicenormative{\paragraph}{Resetting Devices}{Virtio Transport Options / Virtio over channel I/O / Device Operation / Resetting Devices}
-
-The device MUST finish the virtio reset operation and reinitialize
-\field{device status} to zero before it concludes the CCW_CMD_VDEV_RESET
-command successfully.
-
-The device MUST NOT send notifications or interact with the queues after
-it signaled successful conclusion of the CCW_CMD_VDEV_RESET command.
-
-\drivernormative{\paragraph}{Resetting Devices}{Virtio Transport Options / Virtio over channel I/O / Device Operation / Resetting Devices}
-
-The driver MAY consider the virtio reset operation to be complete already after
-successful conclusion of the CCW_CMD_VDEV_RESET channel command, although it
-MAY also choose to verify reset completion by reading \field{device status} via
-CCW_CMD_READ_STATUS and checking whether it is 0 afterwards.
+\input{transport-ccw.tex}
 
 \chapter{Device Types}\label{sec:Device Types}
 
diff --git a/transport-ccw.tex b/transport-ccw.tex
new file mode 100644
index 0000000..93401a4
--- /dev/null
+++ b/transport-ccw.tex
@@ -0,0 +1,601 @@
+\section{Virtio Over Channel I/O}\label{sec:Virtio Transport Options / Virtio Over Channel I/O}
+
+S/390 based virtual machines support neither PCI nor MMIO, so a
+different transport is needed there.
+
+virtio-ccw uses the standard channel I/O based mechanism used for
+the majority of devices on S/390. A virtual channel device with a
+special control unit type acts as proxy to the virtio device
+(similar to the way virtio-pci uses a PCI device) and
+configuration and operation of the virtio device is accomplished
+(mostly) via channel commands. This means virtio devices are
+discoverable via standard operating system algorithms, and adding
+virtio support is mainly a question of supporting a new control
+unit type.
+
+As the S/390 is a big endian machine, the data structures transmitted
+via channel commands are big-endian: this is made clear by use of
+the types be16, be32 and be64.
+
+\subsection{Basic Concepts}\label{sec:Virtio Transport Options / Virtio over channel I/O / Basic Concepts}
+
+As a proxy device, virtio-ccw uses a channel-attached I/O control
+unit with a special control unit type (0x3832) and a control unit
+model corresponding to the attached virtio device's subsystem
+device ID, accessed via a virtual I/O subchannel and a virtual
+channel path of type 0x32. This proxy device is discoverable via
+normal channel subsystem device discovery (usually a STORE
+SUBCHANNEL loop) and answers to the basic channel commands:
+
+\begin{itemize}
+\item NO-OPERATION (0x03)
+\item BASIC SENSE (0x04)
+\item TRANSFER IN CHANNEL (0x08)
+\item SENSE ID (0xe4)
+\end{itemize}
+
+For a virtio-ccw proxy device, SENSE ID will return the following
+information:
+
+\begin{tabular}{ |l|l|l| }
+\hline
+Bytes & Description & Contents \\
+\hline \hline
+0     & reserved              & 0xff \\
+\hline
+1-2   & control unit type     & 0x3832 \\
+\hline
+3     & control unit model    & <virtio device id> \\
+\hline
+4-5   & device type           & zeroes (unset) \\
+\hline
+6     & device model          & zeroes (unset) \\
+\hline
+7-255 & extended SenseId data & zeroes (unset) \\
+\hline
+\end{tabular}
+
+A virtio-ccw proxy device facilitates:
+\begin{itemize} 
+\item Discovery and attachment of virtio devices (as described above).
+\item Initialization of virtqueues and transport-specific facilities (using
+      virtio-specific channel commands).
+\item Notifications (via hypercall and a combination of I/O interrupts
+      and indicator bits).
+\end{itemize} 
+
+\subsubsection{Channel Commands for Virtio}\label{sec:Virtio Transport Options / Virtio
+over channel I/O / Basic Concepts/ Channel Commands for Virtio}
+
+In addition to the basic channel commands, virtio-ccw defines a
+set of channel commands related to configuration and operation of
+virtio:
+
+\begin{lstlisting}
+#define CCW_CMD_SET_VQ 0x13
+#define CCW_CMD_VDEV_RESET 0x33
+#define CCW_CMD_SET_IND 0x43
+#define CCW_CMD_SET_CONF_IND 0x53
+#define CCW_CMD_SET_IND_ADAPTER 0x73
+#define CCW_CMD_READ_FEAT 0x12
+#define CCW_CMD_WRITE_FEAT 0x11
+#define CCW_CMD_READ_CONF 0x22
+#define CCW_CMD_WRITE_CONF 0x21
+#define CCW_CMD_WRITE_STATUS 0x31
+#define CCW_CMD_READ_VQ_CONF 0x32
+#define CCW_CMD_SET_VIRTIO_REV 0x83
+#define CCW_CMD_READ_STATUS 0x72
+\end{lstlisting}
+
+\subsubsection{Notifications}\label{sec:Virtio Transport Options / Virtio
+over channel I/O / Basic Concepts/ Notifications}
+
+Available buffer notifications are realized as a hypercall. No additional
+setup by the driver is needed. The operation of available buffer
+notifications is described in section \ref{sec:Virtio Transport Options /
+Virtio over channel I/O / Device Operation / Guest->Host Notification}.
+
+Used buffer notifications are realized either as so-called classic or
+adapter I/O interrupts depending on a transport level negotiation. The
+initialization is described in sections \ref{sec:Virtio Transport Options
+/ Virtio over channel I/O / Device Initialization / Setting Up Indicators
+/ Setting Up Classic Queue Indicators} and \ref{sec:Virtio Transport
+Options / Virtio over channel I/O / Device Initialization / Setting Up
+Indicators / Setting Up Two-Stage Queue Indicators} respectively.  The
+operation of each flavor is described in sections \ref{sec:Virtio
+Transport Options / Virtio over channel I/O / Device Operation /
+Host->Guest Notification / Notification via Classic I/O Interrupts} and
+\ref{sec:Virtio Transport Options / Virtio over channel I/O / Device
+Operation / Host->Guest Notification / Notification via Adapter I/O
+Interrupts} respectively. 
+
+Configuration change notifications are done using so-called classic I/O
+interrupts. The initialization is described in section \ref{sec:Virtio
+Transport Options / Virtio over channel I/O / Device Initialization /
+Setting Up Indicators / Setting Up Configuration Change Indicators} and
+the operation in section \ref{sec:Virtio Transport Options / Virtio over
+channel I/O / Device Operation / Host->Guest Notification / Notification
+via Classic I/O Interrupts}.
+
+\devicenormative{\subsubsection}{Basic Concepts}{Virtio Transport Options / Virtio over channel I/O / Basic Concepts}
+
+The virtio-ccw device acts like a normal channel device, as specified
+in \hyperref[intro:S390 PoP]{[S390 PoP]} and \hyperref[intro:S390 Common I/O]{[S390 Common I/O]}. In particular:
+
+\begin{itemize}
+\item A device MUST post a unit check with command reject for any command
+  it does not support.
+
+\item If a driver did not suppress length checks for a channel command,
+  the device MUST present a subchannel status as detailed in the
+  architecture when the actual length did not match the expected length.
+
+\item If a driver did suppress length checks for a channel command, the
+  device MUST present a check condition if the transmitted data does
+  not contain enough data to process the command. If the driver submitted
+  a buffer that was too long, the device SHOULD accept the command.
+\end{itemize}
+
+\drivernormative{\subsubsection}{Basic Concepts}{Virtio Transport Options / Virtio over channel I/O / Basic Concepts}
+
+A driver for virtio-ccw devices MUST check for a control unit
+type of 0x3832 and MUST ignore the device type and model.
+
+A driver SHOULD attempt to provide the correct length in a channel
+command even if it suppresses length checks for that command.
+
+\subsection{Device Initialization}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization}
+
+virtio-ccw uses several channel commands to set up a device.
+
+\subsubsection{Setting the Virtio Revision}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Setting the Virtio Revision}
+
+CCW_CMD_SET_VIRTIO_REV is issued by the driver to set the revision of
+the virtio-ccw transport it intends to drive the device with. It uses the
+following communication structure:
+
+\begin{lstlisting}
+struct virtio_rev_info {
+        be16 revision;
+        be16 length;
+        u8 data[];
+};
+\end{lstlisting}
+
+\field{revision} contains the desired revision id, \field{length} the length of the
+data portion and \field{data} revision-dependent additional desired options.
+
+The following values are supported:
+
+\begin{tabular}{ |l|l|l|l| }
+\hline
+\field{revision} & \field{length} & \field{data}      & remarks \\
+\hline \hline
+0        & 0      & <empty>   & legacy interface; transitional devices only \\
+\hline
+1        & 0      & <empty>   & Virtio 1 \\
+\hline
+2        & 0      & <empty>   & CCW_CMD_READ_STATUS support \\
+\hline
+3-n      &        &           & reserved for later revisions \\
+\hline
+\end{tabular}
+
+Note that a change in the virtio standard does not necessarily
+correspond to a change in the virtio-ccw revision.
+
+\devicenormative{\paragraph}{Setting the Virtio Revision}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Setting the Virtio Revision}
+
+A device MUST post a unit check with command reject for any \field{revision}
+it does not support. For any invalid combination of \field{revision}, \field{length}
+and \field{data}, it MUST post a unit check with command reject as well. A
+non-transitional device MUST reject revision id 0.
+
+A device SHOULD answer with command reject to any virtio-ccw specific
+channel command that is not contained in the revision selected by the
+driver.
+
+A device MUST answer with command reject to any attempt to select a different revision
+after a revision has been successfully selected by the driver.
+
+A device MUST treat the revision as unset from the time the associated
+subchannel has been enabled until a revision has been successfully set
+by the driver. This implies that revisions are not persistent across
+disabling and enabling of the associated subchannel.
+
+\drivernormative{\paragraph}{Setting the Virtio Revision}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Setting the Virtio Revision}
+
+A driver SHOULD start with trying to set the highest revision it
+supports and continue with lower revisions if it gets a command reject.
+
+A driver MUST NOT issue any other virtio-ccw specific channel commands
+prior to setting the revision.
+
+After a revision has been successfully selected by the driver, it
+MUST NOT attempt to select a different revision.
+
+\paragraph{Legacy Interfaces: A Note on Setting the Virtio Revision}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Setting the Virtio Revision / Legacy Interfaces: A Note on Setting the Virtio Revision}
+
+A legacy device will not support the CCW_CMD_SET_VIRTIO_REV and answer
+with a command reject. A non-transitional driver MUST stop trying to
+operate this device in that case. A transitional driver MUST operate
+the device as if it had been able to set revision 0.
+
+A legacy driver will not issue the CCW_CMD_SET_VIRTIO_REV prior to
+issuing other virtio-ccw specific channel commands. A non-transitional
+device therefore MUST answer any such attempts with a command reject.
+A transitional device MUST assume in this case that the driver is a
+legacy driver and continue as if the driver selected revision 0. This
+implies that the device MUST reject any command not valid for revision
+0, including a subsequent CCW_CMD_SET_VIRTIO_REV.
+
+\subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Configuring a Virtqueue}
+
+CCW_CMD_READ_VQ_CONF is issued by the driver to obtain information
+about a queue. It uses the following structure for communicating:
+
+\begin{lstlisting}
+struct vq_config_block {
+        be16 index;
+        be16 max_num;
+};
+\end{lstlisting}
+
+The requested number of buffers for queue \field{index} is returned in
+\field{max_num}.
+
+Afterwards, CCW_CMD_SET_VQ is issued by the driver to inform the
+device about the location used for its queue. The transmitted
+structure is
+
+\begin{lstlisting}
+struct vq_info_block {
+        be64 desc;
+        be32 res0;
+        be16 index;
+        be16 num;
+        be64 driver;
+        be64 device;
+};
+\end{lstlisting}
+
+\field{desc}, \field{driver} and \field{device} contain the guest
+addresses for the descriptor area,
+available area and used area for queue \field{index}, respectively. The actual
+virtqueue size (number of allocated buffers) is transmitted in \field{num}.
+
+\devicenormative{\paragraph}{Configuring a Virtqueue}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Configuring a Virtqueue}
+
+\field{res0} is reserved and MUST be ignored by the device.
+
+\paragraph{Legacy Interface: A Note on Configuring a Virtqueue}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Configuring a Virtqueue / Legacy Interface: A Note on Configuring a Virtqueue}
+
+For a legacy driver or for a driver that selected revision 0,
+CCW_CMD_SET_VQ uses the following communication block:
+
+\begin{lstlisting}
+struct vq_info_block_legacy {
+        be64 queue;
+        be32 align;
+        be16 index;
+        be16 num;
+};
+\end{lstlisting}
+
+\field{queue} contains the guest address for queue \field{index}, \field{num} the number of buffers
+and \field{align} the alignment. The queue layout follows \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}.
+
+\subsubsection{Communicating Status Information}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Communicating Status Information}
+
+The driver changes the status of a device via the
+CCW_CMD_WRITE_STATUS command, which transmits an 8 bit status
+value.
+
+As described in
+\ref{devicenormative:Basic Facilities of a Virtio Device / Feature Bits},
+a device sometimes fails to set the \field{device status} field: For example, it
+might fail to accept the FEATURES_OK status bit during device initialization.
+
+With revision 2, CCW_CMD_READ_STATUS is defined: It reads an 8 bit status
+value from the device and acts as a reverse operation to CCW_CMD_WRITE_STATUS.
+
+\drivernormative{\paragraph}{Communicating Status Information}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Communicating Status Information}
+
+If the device posts a unit check with command reject in response to the
+CCW_CMD_WRITE_STATUS command, the driver MUST assume that the device failed
+to set the status and the \field{device status} field retained
+its previous value.
+
+If at least revision 2 has been negotiated, the driver SHOULD use the
+CCW_CMD_READ_STATUS command to retrieve the \field{device status} field after
+a configuration change has been detected.
+
+If not at least revision 2 has been negotiated, the driver MUST NOT attempt
+to issue the CCW_CMD_READ_STATUS command.
+
+\devicenormative{\paragraph}{Communicating Status Information}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Communicating Status Information}
+
+If the device fails to set the \field{device status} field
+to the value written by the driver, the device MUST assure
+that the \field{device status} field is left unchanged and
+MUST post a unit check with command reject.
+
+If at least revision 2 has been negotiated, the device MUST return the
+current \field{device status} field if the CCW_CMD_READ_STATUS
+command is issued.
+
+\subsubsection{Handling Device Features}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Handling Device Features}
+
+Feature bits are arranged in an array of 32 bit values, making
+for a total of 8192 feature bits. Feature bits are in
+little-endian byte order.
+
+The CCW commands dealing with features use the following
+communication block:
+
+\begin{lstlisting}
+struct virtio_feature_desc {
+        le32 features;
+        u8 index;
+};
+\end{lstlisting}
+
+\field{features} are the 32 bits of features currently accessed, while
+\field{index} describes which of the feature bit values is to be
+accessed. No padding is added at the end of the structure, it is
+exactly 5 bytes in length.
+
+The guest obtains the device's device feature set via the
+CCW_CMD_READ_FEAT command. The device stores the features at \field{index}
+to \field{features}.
+
+For communicating its supported features to the device, the driver
+uses the CCW_CMD_WRITE_FEAT command, denoting a \field{features}/\field{index}
+combination.
+
+\subsubsection{Device Configuration}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Device Configuration}
+
+The device's configuration space is located in host memory.
+
+To obtain information from the configuration space, the driver
+uses CCW_CMD_READ_CONF, specifying the guest memory for the device
+to write to.
+
+For changing configuration information, the driver uses
+CCW_CMD_WRITE_CONF, specifying the guest memory for the device to
+read from.
+
+In both cases, the complete configuration space is transmitted.  This
+allows the driver to compare the new configuration space with the old
+version, and keep a generation count internally whenever it changes.
+
+\subsubsection{Setting Up Indicators}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Setting Up Indicators}
+
+In order to set up the indicator bits for host->guest notification,
+the driver uses different channel commands depending on whether it
+wishes to use traditional I/O interrupts tied to a subchannel or
+adapter I/O interrupts for virtqueue notifications. For any given
+device, the two mechanisms are mutually exclusive.
+
+For the configuration change indicators, only a mechanism using
+traditional I/O interrupts is provided, regardless of whether
+traditional or adapter I/O interrupts are used for virtqueue
+notifications.
+
+\paragraph{Setting Up Classic Queue Indicators}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Setting Up Indicators / Setting Up Classic Queue Indicators}
+
+Indicators for notification via classic I/O interrupts are contained
+in a 64 bit value per virtio-ccw proxy device.
+
+To communicate the location of the indicator bits for host->guest
+notification, the driver uses the CCW_CMD_SET_IND command,
+pointing to a location containing the guest address of the
+indicators in a 64 bit value.
+
+If the driver has already set up two-staged queue indicators via the
+CCW_CMD_SET_IND_ADAPTER command, the device MUST post a unit check
+with command reject to any subsequent CCW_CMD_SET_IND command.
+
+\paragraph{Setting Up Configuration Change Indicators}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Setting Up Indicators / Setting Up Configuration Change Indicators}
+
+Indicators for configuration change host->guest notification are
+contained in a 64 bit value per virtio-ccw proxy device.
+
+To communicate the location of the indicator bits used in the
+configuration change host->guest notification, the driver issues the
+CCW_CMD_SET_CONF_IND command, pointing to a location containing the
+guest address of the indicators in a 64 bit value.
+
+\paragraph{Setting Up Two-Stage Queue Indicators}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Setting Up Indicators / Setting Up Two-Stage Queue Indicators}
+
+Indicators for notification via adapter I/O interrupts consist of
+two stages:
+\begin{itemize}
+\item a summary indicator byte covering the virtqueues for one or more
+  virtio-ccw proxy devices
+\item a set of contigous indicator bits for the virtqueues for a
+  virtio-ccw proxy device
+\end{itemize}
+
+To communicate the location of the summary and queue indicator bits,
+the driver uses the CCW_CMD_SET_IND_ADAPTER command with the following
+payload:
+
+\begin{lstlisting}
+struct virtio_thinint_area {
+        be64 summary_indicator;
+        be64 indicator;
+        be64 bit_nr;
+        u8 isc;
+} __attribute__ ((packed));
+\end{lstlisting}
+
+\field{summary_indicator} contains the guest address of the 8 bit summary
+indicator.
+\field{indicator} contains the guest address of an area wherein the indicators
+for the devices are contained, starting at \field{bit_nr}, one bit per
+virtqueue of the device. Bit numbers start at the left, i.e. the most
+significant bit in the first byte is assigned the bit number 0.
+\field{isc} contains the I/O interruption subclass to be used for the adapter
+I/O interrupt. It MAY be different from the isc used by the proxy
+virtio-ccw device's subchannel.
+No padding is added at the end of the structure, it is exactly 25 bytes
+in length.
+
+
+\devicenormative{\subparagraph}{Setting Up Two-Stage Queue Indicators}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Setting Up Indicators / Setting Up Two-Stage Queue Indicators}
+If the driver has already set up classic queue indicators via the
+CCW_CMD_SET_IND command, the device MUST post a unit check with
+command reject to any subsequent CCW_CMD_SET_IND_ADAPTER command.
+
+\paragraph{Legacy Interfaces: A Note on Setting Up Indicators}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Setting Up Indicators / Legacy Interfaces: A Note on Setting Up Indicators}
+
+In some cases, legacy devices will only support classic queue indicators;
+in that case, they will reject CCW_CMD_SET_IND_ADAPTER as they don't know that
+command. Some legacy devices will support two-stage queue indicators, though,
+and a driver will be able to successfully use CCW_CMD_SET_IND_ADAPTER to set
+them up.
+
+\subsection{Device Operation}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Operation}
+
+\subsubsection{Host->Guest Notification}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Operation / Host->Guest Notification}
+
+There are two modes of operation regarding host->guest notification,
+classic I/O interrupts and adapter I/O interrupts. The mode to be
+used is determined by the driver by using CCW_CMD_SET_IND respectively
+CCW_CMD_SET_IND_ADAPTER to set up queue indicators.
+
+For configuration changes, the driver always uses classic I/O
+interrupts.
+
+\paragraph{Notification via Classic I/O Interrupts}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Operation / Host->Guest Notification / Notification via Classic I/O Interrupts}
+
+If the driver used the CCW_CMD_SET_IND command to set up queue
+indicators, the device will use classic I/O interrupts for
+host->guest notification about virtqueue activity.
+
+For notifying the driver of virtqueue buffers, the device sets the
+corresponding bit in the guest-provided indicators. If an
+interrupt is not already pending for the subchannel, the device
+generates an unsolicited I/O interrupt.
+
+If the device wants to notify the driver about configuration
+changes, it sets bit 0 in the configuration indicators and
+generates an unsolicited I/O interrupt, if needed. This also
+applies if adapter I/O interrupts are used for queue notifications.
+
+\paragraph{Notification via Adapter I/O Interrupts}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Operation / Host->Guest Notification / Notification via Adapter I/O Interrupts}
+
+If the driver used the CCW_CMD_SET_IND_ADAPTER command to set up
+queue indicators, the device will use adapter I/O interrupts for
+host->guest notification about virtqueue activity.
+
+For notifying the driver of virtqueue buffers, the device sets the
+bit in the guest-provided indicator area at the corresponding offset.
+The guest-provided summary indicator is set to 0x01. An adapter I/O
+interrupt for the corresponding interruption subclass is generated.
+
+The recommended way to process an adapter I/O interrupt by the driver
+is as follows:
+
+\begin{itemize}
+\item Process all queue indicator bits associated with the summary indicator.
+\item Clear the summary indicator, performing a synchronization (memory
+barrier) afterwards.
+\item Process all queue indicator bits associated with the summary indicator
+again.
+\end{itemize}
+
+\devicenormative{\subparagraph}{Notification via Adapter I/O Interrupts}{Virtio Transport Options / Virtio over channel I/O / Device Operation / Host->Guest Notification / Notification via Adapter I/O Interrupts}
+
+The device SHOULD only generate an adapter I/O interrupt if the
+summary indicator had not been set prior to notification.
+
+\drivernormative{\subparagraph}{Notification via Adapter I/O Interrupts}{Virtio Transport Options / Virtio over channel I/O / Device Operation / Host->Guest Notification / Notification via Adapter I/O Interrupts}
+The driver
+MUST clear the summary indicator after receiving an adapter I/O
+interrupt before it processes the queue indicators.
+
+\paragraph{Legacy Interfaces: A Note on Host->Guest Notification}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Operation / Host->Guest Notification / Legacy Interfaces: A Note on Host->Guest Notification}
+
+As legacy devices and drivers support only classic queue indicators,
+host->guest notification will always be done via classic I/O interrupts.
+
+\subsubsection{Guest->Host Notification}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Operation / Guest->Host Notification}
+
+For notifying the device of virtqueue buffers, the driver
+unfortunately can't use a channel command (the asynchronous
+characteristics of channel I/O interact badly with the host block
+I/O backend). Instead, it uses a diagnose 0x500 call with subcode
+3 specifying the queue, as follows:
+
+\begin{tabular}{ |l|l|l| }
+\hline
+GPR  &   Input Value     & Output Value \\
+\hline \hline
+  1   &       0x3         &              \\
+\hline
+  2   &  Subchannel ID    & Host Cookie  \\
+\hline
+  3   & Notification data &              \\
+\hline
+  4   &   Host Cookie     &              \\
+\hline
+\end{tabular}
+
+When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
+the \field{Notification data} contains the Virtqueue number.
+
+When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
+the value has the following format:
+\lstinputlisting{notifications-be.c}
+
+See \ref{sec:Basic Facilities of a Virtio Device / Driver notifications}~\nameref{sec:Basic Facilities of a Virtio Device / Driver notifications}
+for the definition of the components.
+
+\devicenormative{\paragraph}{Guest->Host Notification}{Virtio Transport Options / Virtio over channel I/O / Device Operation / Guest->Host Notification}
+The device MUST ignore bits 0-31 (counting from the left) of GPR2.
+This aligns passing the subchannel ID with the way it is passed
+for the existing I/O instructions.
+
+The device MAY return a 64-bit host cookie in GPR2 to speed up the
+notification execution.
+
+\drivernormative{\paragraph}{Guest->Host Notification}{Virtio Transport Options / Virtio over channel I/O / Device Operation / Guest->Host Notification}
+
+For each notification, the driver SHOULD use GPR4 to pass the host cookie received in GPR2 from the previous notication.
+
+\begin{note}
+For example:
+\begin{lstlisting}
+info->cookie = do_notify(schid,
+                         virtqueue_get_queue_index(vq),
+                         info->cookie);
+\end{lstlisting}
+\end{note}
+
+\subsubsection{Resetting Devices}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Operation / Resetting Devices}
+
+In order to reset a device, a driver sends the
+CCW_CMD_VDEV_RESET command. This command does not carry any payload.
+
+The device signals completion of the virtio reset operation through successful
+conclusion of the CCW_CMD_VDEV_RESET channel command. In particular, the
+command not only triggers the reset operation, but the reset operation is
+already completed when the operation concludes successfully.
+
+\devicenormative{\paragraph}{Resetting Devices}{Virtio Transport Options / Virtio over channel I/O / Device Operation / Resetting Devices}
+
+The device MUST finish the virtio reset operation and reinitialize
+\field{device status} to zero before it concludes the CCW_CMD_VDEV_RESET
+command successfully.
+
+The device MUST NOT send notifications or interact with the queues after
+it signaled successful conclusion of the CCW_CMD_VDEV_RESET command.
+
+\drivernormative{\paragraph}{Resetting Devices}{Virtio Transport Options / Virtio over channel I/O / Device Operation / Resetting Devices}
+
+The driver MAY consider the virtio reset operation to be complete already after
+successful conclusion of the CCW_CMD_VDEV_RESET channel command, although it
+MAY also choose to verify reset completion by reading \field{device status} via
+CCW_CMD_READ_STATUS and checking whether it is 0 afterwards.
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

