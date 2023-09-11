Return-Path: <virtio-dev-return-13674-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840B2EE57DF
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 10:05:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A1FF879515
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 10:05:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 657D29864A5
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 10:05:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 56EDA98635C; Mon, 11 Sep 2023 10:05:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3E285986408;
	Mon, 11 Sep 2023 10:05:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXW0lS/4L7NDmIAuOQeIiK49c2spV9NPWO7A9puxvWKldp8O/XS5eBJAqdabL2dTVgNsopXFQJkgosKiTMkvjAM+wo23k5JK7S6fR36darckSpIFvXAwTQTgtTZCWGYlxhEckZuSlIiGi7OgBc2mv2/IVaMjAtqwrIvUbdlM61fVkes6p5qcwaZ+GGjciy7jVjCcrHH4E2YkN1po2Qc4e6rbpDFmRXG0759ENKohQ6wwO1YF0N8ZAf3CSyS4QyxJKfuODFJ4+QcWHrdOpJh+phgG20Wu0oV7jBnrvpIaIYWtYXpB9sRTJwTTYgoSHak4l1EqT+LqwB3WvCTdxPqR2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRtNism9eieq55WiXAgXLdUcKsXmXh8icFK+EOB15YY=;
 b=TG4arZIclyHDMFCNYu3orSkn/wlnrC+vZ66k9y7emnnLvayKDD92fiA81r1ZFYbUWm+TMIi4UdjSfG4rKNum+O4aFmJ/KqJKEVYT0eTa52FxPZmsXb08VRENjzDpxMkLJwN57ltifGNnjFYPR8N3rhMAjT94AyofGv0h8Y3VeC8xW1Hzax4eXI5w9av5JczANI+kFgPvZJreYkFGbXILYUZ4VcWh+yPdPbg+PhFm6CodPf491UeZ05AKttvYuui79nIXWAv7oZ8C0K7nFQYc3wuQ9ygwi2XaxkHUoFDCFeFhjG5oWmsBPAuYu8ctZYO+FLt159VSR5E0eGELj5OpZg==
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
To: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?=
	<marcandre.lureau@gmail.com>, Robert Beckett <bob.beckett@collabora.com>,
	<virtio-comment@lists.oasis-open.org>, <virtio-dev@lists.oasis-open.org>
CC: <qemu-devel@nongnu.org>, <linux-kernel@vger.kernel.org>, "Stefano
 Stabellini" <sstabellini@kernel.org>, =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?=
	<roger.pau@citrix.com>, Alex Deucher <Alexander.Deucher@amd.com>, "Christian
 Koenig" <Christian.Koenig@amd.com>, Stewart Hildebrand
	<Stewart.Hildebrand@amd.com>, Xenia Ragiadakou <burzalodowa@gmail.com>,
	Honglei Huang <Honglei1.Huang@amd.com>, Julia Zhang <Julia.Zhang@amd.com>,
	Huang Rui <Ray.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>
Date: Mon, 11 Sep 2023 18:04:30 +0800
Message-ID: <20230911100430.1408168-2-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911100430.1408168-1-Jiqian.Chen@amd.com>
References: <20230911100430.1408168-1-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|DM4PR12MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3d4206-778a-432c-50a8-08dbb2ae9986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a5dsaDV8AYpfBAvoP/plHZZTCQqGHUb1NlXcMvkOGuxw+kzLuaM2qzO5B5Qw6fjB17q44sTh8vPWjEPds89g6WS8I1IpCwTd8LjZ8OP6BmpA0Azc8EhVjBg1sJBcfTL54PPzfJTuk2/pDVsV/LZhmgELj14V9MdID+L/Q26NtvjA6rvPzvJcE0nfJ1JtvtlLONZ7UnmMDf8abwqijSRwjM4NsjnvbcPFqYBNJEpWkwtIO5dgGKsCg4xM/XCwQsb6U3cJ5ah4ZZSyIOoZaK4t+wi1Ivpo3hEEDRxxV9JKOeXKUxzRjQG8b4VaC6PnxAFnSP1gOcDzxUxpPXH2OLg2415K0vqqz2t1fIwqNTl/7fafpWeufEmbYvNcMAwjt9FTupquYGVeSFZkR6TdqXUbWEzzzIhi/z9kPNcyxnfAW1A8fDfJ4OI+JXV1PDPqS7hOWkcN0JdK84Z3i+A17zTk3phk6Fx6Uvt5eiY8P+ZwKQe2+KxJYegJPcGWkovXH2uhA8pRphI3xcX5xEJst2j13PhQ8ENXGtsVqhSXHfAIOWShaAPD78IoyDXPNzKA47BrJfre3P+ScE5h9dRuNX+mo463IgmRbedtJBZEng3wlgDk613KwBnp3XCsDTvdKe/lHQOv8gU6SX5zvkCJs3qYyZPKkRZgZz5HeGpWHj2tec0SkmBEeY0Tzck40zyX55IEAzD1/hEOVBfawqGH98tdNEzyFnYwZ0x10jYi5SJzWfdmUvBsfQ6axlBdb3hLOECqqz41sqYCZvbTktLP+WLdWg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(186009)(82310400011)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(41300700001)(40480700001)(36756003)(4326008)(8676002)(8936002)(40460700003)(5660300002)(26005)(16526019)(1076003)(70586007)(70206006)(110136005)(54906003)(316002)(86362001)(356005)(82740400003)(81166007)(36860700001)(47076005)(2906002)(426003)(336012)(478600001)(2616005)(83380400001)(7696005)(6666004)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 10:05:17.1733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3d4206-778a-432c-50a8-08dbb2ae9986
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6447
Subject: [virtio-dev] [RESEND VIRTIO GPU PATCH v3 1/1] virtio-gpu: Add new feature flag VIRTIO_GPU_F_FREEZE_S3

When we suspend/resume guest on Xen, the display can't come back.
This is because when guest suspended, it called into Qemu. Then
Qemu destroyed all resources which is used for display. So that
guest's display can't come back to the time when it was suspended.

To solve above problem, I added a new mechanism that when guest is
suspending, it will notify Qemu, and then Qemu will not destroy
resourcesi which are created by using commands
VIRTIO_GPU_CMD_RESOURCE_CREATE_*.

Due to that mechanism needs cooperation between guest and host,
I need to add a new feature flag, so that guest and host can
negotiate whenever freeze_S3 is supported or not.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 device-types/gpu/description.tex | 42 ++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/device-types/gpu/description.tex b/device-types/gpu/description.tex
index 4435248..1a137e7 100644
--- a/device-types/gpu/description.tex
+++ b/device-types/gpu/description.tex
@@ -37,6 +37,8 @@ \subsection{Feature bits}\label{sec:Device Types / GPU Device / Feature bits}
   resources is supported.
 \item[VIRTIO_GPU_F_CONTEXT_INIT (4)] multiple context types and
   synchronization timelines supported.  Requires VIRTIO_GPU_F_VIRGL.
+\item[VIRTIO_GPU_F_FREEZE_S3 (5)] freezing virtio-gpu and keeping resources
+  alive is supported.
 \end{description}
 
 \subsection{Device configuration layout}\label{sec:Device Types / GPU Device / Device configuration layout}
@@ -228,6 +230,9 @@ \subsubsection{Device Operation: Request header}\label{sec:Device Types / GPU De
         VIRTIO_GPU_CMD_UPDATE_CURSOR = 0x0300,
         VIRTIO_GPU_CMD_MOVE_CURSOR,
 
+        /* freeze mode */
+        VIRTIO_GPU_CMD_SET_FREEZE_MODE = 0x0400,
+
         /* success responses */
         VIRTIO_GPU_RESP_OK_NODATA = 0x1100,
         VIRTIO_GPU_RESP_OK_DISPLAY_INFO,
@@ -838,6 +843,43 @@ \subsubsection{Device Operation: cursorq}\label{sec:Device Types / GPU Device /
 
 \end{description}
 
+\subsubsection{Device Operation: freeze_mode}\label{sec:Device Types / GPU Device / Device Operation / Device Operation: freeze_mode}
+
+\begin{lstlisting}
+typedef enum {
+  VIRTIO_GPU_FREEZE_MODE_UNFREEZE = 0,
+  VIRTIO_GPU_FREEZE_MODE_FREEZE_S3 = 3,
+} virtio_gpu_freeze_mode_t;
+
+struct virtio_gpu_set_freeze_mode {
+  struct virtio_gpu_ctrl_hdr hdr;
+  virtio_gpu_freeze_mode_t freeze_mode;
+};
+\end{lstlisting}
+
+\begin{description}
+
+\item[VIRTIO_GPU_CMD_SET_FREEZE_MODE]
+Notify freeze mode through controlq.
+Request data is \field{struct virtio_gpu_set_freeze_mode}.
+Response type is VIRTIO_GPU_RESP_OK_NODATA.
+
+This is added for S3 function in guest with virtio-gpu. When guest does
+S3, let it notify QEMU that virtio-gpu is in what freeze mode in
+\field{freeze_mode}. VIRTIO_GPU_FREEZE_MODE_FREEZE_S3 means guest is
+doing S3 and virtio-gpu will be freezed, VIRTIO_GPU_FREEZE_MODE_UNFREEZE
+means virtio-gpu can be used as usual. When virtio-gpu is freezed, QEMU
+will not destroy resources which are created by using commands
+VIRTIO_GPU_CMD_RESOURCE_CREATE_*, so that guest can use those resources
+to resume display.
+
+Note: this change is not enough to solve the problems of S4 function.
+QEMU may lose resources after hibernation. It needs more research and
+development. If S4 is supported in the future, it may need another
+feature flag here.
+
+\end{description}
+
 \subsection{VGA Compatibility}\label{sec:Device Types / GPU Device / VGA Compatibility}
 
 Applies to Virtio Over PCI only.  The GPU device can come with and
-- 
2.34.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

