Return-Path: <virtio-dev-return-14011-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DBFC001E0
	for <virtio-dev@archiver.kernel.org>; Sat, 21 Oct 2023 03:52:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E0A4F33096
	for <virtio-dev@archiver.kernel.org>; Sat, 21 Oct 2023 03:52:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CFFE3986958
	for <virtio-dev@archiver.kernel.org>; Sat, 21 Oct 2023 03:52:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C2CBA986950; Sat, 21 Oct 2023 03:52:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B37CB986952;
	Sat, 21 Oct 2023 03:52:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiMI57+qsdxApUhbML3ybnaKfN0eGeOaJrttcRFui14syEM5EsMXvubXsY7N7Fb9NW4wCZanuOFBivc3DcsKinrR1J1YzFay22lCt7W5qv26+G0HpZn92BCzWpK4vx/nSi8sZs6SdG1SuDh/Pddo7v7x2kYlqt+fAjZNRQfV5yZKp8JmtNg7HrbtwFbG/DiiPfz2bj0JKdEs/nyL4P8bvM4tgPc1dCNpPp6P1IqIUe8tM2Sgpb0TXWenTaioHtVn7RNfGvDszeHEj9a6ipHp32igOXxiL3KpJ4QCs7cDMXKFpI6PndfcacmuGf2/hGzN0bRfyf6qBbeoxG8sq2c8tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2lYHvJluFFvAczRRgK5A+sO3NnMbZmPhPnrzeg5xNU=;
 b=avG4Z5ARPx9tw8DvAUYBhYMzDETO960Q7ukc8925VEDrzER9Tv1kNPgoWY8KhfA7PHUokc7qaWiHwDdXy0heSrPZ/nxj8tHG5jp9+A4jjv2hJI1vjp9Lb9uwVJdgHlkd89fUp7sBlFb+T+/QzC1jlmdF/osk0hsN9cfmjhMXQACzvsinAAS5xcEL3vgIXwJA789LFjC/eA1O7Bal47DUqL4tIEPARa6TyFNUgcVba/kebu6jLNI2dw40WHQGNXU2YB3fKFOPZ7ajkEBUnAHufPP/Dvzb7s1+rJTAJ+vjI5qAlwE9hYxBlovlm7tIqy6NQn8zGB7sIBQQ9+b4PxFbOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, David Airlie <airlied@redhat.com>, "Gurchetan
 Singh" <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, "Robert
 Beckett" <bob.beckett@collabora.com>, Mikhail Golubev-Ciuchea
	<Mikhail.Golubev-Ciuchea@opensynergy.com>,
	<virtio-comment@lists.oasis-open.org>, <virtio-dev@lists.oasis-open.org>
CC: Honglei Huang <Honglei1.Huang@amd.com>, Julia Zhang <Julia.Zhang@amd.com>,
	Huang Rui <Ray.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>
Date: Sat, 21 Oct 2023 11:51:11 +0800
Message-ID: <20231021035111.650248-2-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021035111.650248-1-Jiqian.Chen@amd.com>
References: <20231021035111.650248-1-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|BL0PR12MB4963:EE_
X-MS-Office365-Filtering-Correlation-Id: dff0cc78-eb5c-47d8-8ab0-08dbd1e90f6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IcZWu/WC6UwBZwKFVpwmahvvVwDCUNd/y8O3t/MJPIu400YxOX7zFPZC8El2Ywyw5DVQFV3fKZRIRTsi1VzxvjzB49MuGlCByDO+3jQ8r06beZ0BiEshrlLf2ZHTKgYk+nTjdGsLO0Hn2BTw+fUtbOIDJGoy4WFurSnB2loXhUWDVo5FhYVwPfzAoiR0dFumMkv9rUFjZushoCpysCmdpSfaY8npbhoYZE6pOKSiSBUl7+M1amRxQKmsJ2CFTOsefn1S82ggdksQGc/duS07qGBkJ5QHWyMOLlmPSZwYwEJVcV303kDFwp52/G004f635pBGERaLsa0whLos3gUJca2UK4jjcYulzAFxcMjdSpzwZlPo7AX4Ikuf0wWKtskGp3KFCRmkRkiu0lTXunUyTmqWcqQmml/lMnlxlQT25CyPdbo69Zt2G/wAql33ScpkZbjOHowkh0DQMi2g2Alpqdd2SLgVhxJoz1ChA+rdZEGfKn3F99YNDSHaivMZsi9s0cf16s4S4MBhoTynMx43isKKuGxcyoZ54Bn3RBHLqJNEfdRPZlav4bzIG951zCY2gZg1eKBYvQuKWF2PtRKozp4NBDh/6JYg7PE/gp6jB8Yn4nIqAdfXc5UBUhFsjdesjCMOUIYRYL/jeXhfFCoXA7AUFWvaMOzbg/GtYKdNKWobp0mCQk9mxJcz7gPGcAfKE8dSdJmoydW+V6zwPNBANUOm8dx/KG0ULpobv2xNQW2xM/KQyyFr/tP3KUYVGkyIvaJ9ly19NKLBfQeylAYdl11EdHZ1f2EJruhFHbMsh64=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(1800799009)(64100799003)(82310400011)(451199024)(186009)(36840700001)(40470700004)(46966006)(8676002)(7696005)(66899024)(7416002)(40460700003)(86362001)(47076005)(5660300002)(41300700001)(2906002)(4326008)(336012)(356005)(83380400001)(40480700001)(26005)(1076003)(82740400003)(16526019)(2616005)(81166007)(36860700001)(426003)(478600001)(54906003)(8936002)(6666004)(36756003)(110136005)(70586007)(70206006)(316002)(921008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2023 03:51:51.9076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dff0cc78-eb5c-47d8-8ab0-08dbd1e90f6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4963
Subject: [virtio-dev] [PATCH v6 1/1] content: Add new feature VIRTIO_F_PRESERVE_RESOURCES

In some scenes, Qemu may reset or destroy resources of virtio device,
but some of them can't be re-created, so that causes some problems.

For example, when we do S3 for guest, guest will set device_status to
0, it causes Qemu to reset virtioi-gpu device, and then all render
resources of virtio-gpu will be destroyed. As a result, after guest
resuming, the display can't come back, and we only see a black screen.

In order to deal with the above scene, we need a mechanism that allows
guest and Qemu to negotiate their behaviors for resources. So, this
patch adds a new feature named VIRTIO_F_PRESERVE_RESOURCES. It allows
guest to tell Qemu when there is a need to preserve resources, guest
must preserve resources until 0 is set.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 conformance.tex   |  2 ++
 content.tex       | 25 +++++++++++++++++++++++++
 transport-pci.tex |  6 ++++++
 3 files changed, 33 insertions(+)

diff --git a/conformance.tex b/conformance.tex
index dc00e84..60cc0b1 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -91,6 +91,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{drivernormative:Basic Facilities of a Virtio Device / Packed Virtqueues / The Virtqueue Descriptor Table / Indirect Descriptors}
 \item \ref{drivernormative:Basic Facilities of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device / Updating flags}
 \item \ref{drivernormative:Basic Facilities of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device / Sending Available Buffer Notifications}
+\item \ref{drivernormative:Basic Facilities of a Virtio Device / Preserve Resources}
 \item \ref{drivernormative:General Initialization And Device Operation / Device Initialization}
 \item \ref{drivernormative:General Initialization And Device Operation / Device Cleanup}
 \item \ref{drivernormative:Reserved Feature Bits}
@@ -172,6 +173,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{devicenormative:Basic Facilities of a Virtio Device / Packed Virtqueues / The Virtqueue Descriptor Table}
 \item \ref{devicenormative:Basic Facilities of a Virtio Device / Packed Virtqueues / Scatter-Gather Support}
 \item \ref{devicenormative:Basic Facilities of a Virtio Device / Shared Memory Regions}
+\item \ref{devicenormative:Basic Facilities of a Virtio Device / Preserve Resources}
 \item \ref{devicenormative:Reserved Feature Bits}
 \end{itemize}
 
diff --git a/content.tex b/content.tex
index 0a62dce..b6b1859 100644
--- a/content.tex
+++ b/content.tex
@@ -502,6 +502,27 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
 types. It is RECOMMENDED that devices generate version 4
 UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
 
+\section{Preserve Resources}\label{sec:Basic Facilities of a Virtio Device / Preserve Resources}
+
+As virtio devices are paravirtualization devices by design.
+There are various devices resources created by sending commands
+from frontend and stored in backend.
+
+In some scenes, resources may be destroyed or reset, some of
+them can be re-created since frontend has enough information
+, but some can't. At this case, we can set \field{Preserve Resources}
+to 1 by specific transport, to prevent resources being destroyed.
+
+Which kind of resources need to be preserved and how to preserve
+resources depend on specific devices.
+
+\drivernormative{\subsection}{Preserve Resources}{Basic Facilities of a Virtio Device / Preserve resources}
+A driver SHOULD set \field{Preserve Resources} to 1 when there is a need
+to preserve resources.
+
+\devicenormative{\subsection}{Preserve Resources}{Basic Facilities of a Virtio Device / Preserve resources}
+A device MUST NOT destroy resources until \field{Preserve Resources} is 0.
+
 \input{admin.tex}
 
 \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
@@ -872,6 +893,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 	\ref{devicenormative:Basic Facilities of a Virtio Device / Feature Bits} for
 	handling features reserved for future use.
 
+  \item[VIRTIO_F_PRESERVE_RESOURCES(42)] This feature indicates
+  that the device need to preserve resources.
+  See \ref{sec:Basic Facilities of a Virtio Device / Preserve Resources}.
+
 \end{description}
 
 \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
diff --git a/transport-pci.tex b/transport-pci.tex
index a5c6719..f6eea65 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -325,6 +325,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
         /* About the administration virtqueue. */
         le16 admin_queue_index;         /* read-only for driver */
         le16 admin_queue_num;         /* read-only for driver */
+        le16 preserve_resources;        /* read-write */
 };
 \end{lstlisting}
 
@@ -428,6 +429,11 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 	The value 0 indicates no supported administration virtqueues.
 	This field is valid only if VIRTIO_F_ADMIN_VQ has been
 	negotiated.
+
+\item[\field{preserve_resources}]
+        The driver writes this to let device preserve resources whenever driver has demands.
+        1 - device need to preserve resources which can't be re-created, until 0 is set.
+        0 - all resources can be destroyed.
 \end{description}
 
 \devicenormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
-- 
2.34.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

