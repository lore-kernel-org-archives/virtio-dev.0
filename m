Return-Path: <virtio-dev-return-13388-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5DAEB64DD
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Jul 2023 12:20:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5E12B42C49
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Jul 2023 12:20:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BB2E698689B
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Jul 2023 12:20:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2F2BC986810; Thu, 20 Jul 2023 12:20:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 60BF498680E;
	Thu, 20 Jul 2023 12:19:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6rrHRS0rG/aCnklJc0fqND9s+pOQaYdbvYFYyboRFtFSwP5kFmzMKR7PAw5ImGi0uPTPMLX04XILKY8QFsSk/+lnxbSTA3F0ODOY5zdcso4eTSpFp2IVnjUmMfaKuqHUB8cpVOleSXDNu+wEXGy6xMOpvTLb9n2hqLcL6bMNOeGoObSf0wjXImP5AFJGsRVcgzjphpjYS1YRLjKB1+dqJzLQJbZYlMSMRGTkVi2kiClpI47ADbufoY96NYBCvcl943jATRJaKP1p+X5r0kmHQacpStz3jW7bgxKmDkHvwVb54PBks/OsRfldNRBc/9bmwNt+ydgS81PJE2LC+7j4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRtNism9eieq55WiXAgXLdUcKsXmXh8icFK+EOB15YY=;
 b=DjHs4EwOljvbhkFwu7qyM1iL3+fpKw6XlVz38DJEB4X2uK9oVMFLsQEZNFmaO6OKichTci9ySmH6quC6d8ZqgSzo6JB7H8Wpi+DU2nA7kzAw8YO+lN8YRJ5/ZLnG9G1MSB7P3VGF32Ji+lqrmHU6UfuNihIRVzJht8ZvR0qUJeoVW6qR7NEkU1lO+bDIZ6bU2TWQx3sOiPYQUhMAkGAY9viItNZx/sdYkZufrKApLAOihpq17I6y0CZmTvkw2u2h9tHYOFAmdADVaE9Rk9x7Z7/Di0Fx2stY+YdjWUkIqgl8AQ8dJ6i//88EFfdp1aYOptDNt1hPj1XOHBqv2TtxAw==
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
CC: Stefano Stabellini <sstabellini@kernel.org>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>, Alex Deucher
	<Alexander.Deucher@amd.com>, Christian Koenig <Christian.Koenig@amd.com>,
	Stewart Hildebrand <Stewart.Hildebrand@amd.com>, Xenia Ragiadakou
	<burzalodowa@gmail.com>, Honglei Huang <Honglei1.Huang@amd.com>, Julia Zhang
	<Julia.Zhang@amd.com>, Huang Rui <Ray.Huang@amd.com>, Jiqian Chen
	<Jiqian.Chen@amd.com>
Date: Thu, 20 Jul 2023 20:18:44 +0800
Message-ID: <20230720121844.8956-2-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720121844.8956-1-Jiqian.Chen@amd.com>
References: <20230720121844.8956-1-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT056:EE_|PH7PR12MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 273cb687-09fb-48f2-4c13-08db891b84e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NJTXGopJ3mQDImmIMSjeFIhyCYfKNnEIWrPDUXzkQ/dgwtfzHNQcTXhHPptjxKbise0bE83iQfQmwiTv13oK88Sqe56q6cWWpcmEXyDSe+2+IoHDlPMaK1wguHB/gGOvq/TGKccGhrA3QSfs4ai/sle7LO1z1R3LDNuw8zWuEiNlFxFmCPyz9cVtRKFtZvBu7038iSnkAweFf0ebVjd4Z5KVFlk5A0g+xyUrtuvtmnDVaXOVgRUMsfJFVX+IhRNx/0XwhifZXvg+Pl4GorYZv8G7pI2XYK+Ke/vg5YvlBKCPto+/6rMQQ2riteTL23mCHrVQgfxouUXiSWWzElCY2Mw68+z71oYU65ndTmEyh2BEhcYAqoQmD3qHYMKdCzc+Mxnh9FG+xwswW4D+AZHHC6MNv2KN3d5FP1IMYRneix94FOH3vp8jYy6EuS7F7+MT28ZfA8ia3e4JrsBFI49RT1C2nWXmgKg8/WmFV0ryvSRSILgAEq3OuAjuHGl7q92//dNZNUqDUAmhWfWR1owCYcyPOwZohlZbVHwe7nv200jRSt6AxguvMcPLXln+36nS0PhXwcDlyuJ4Flv36Vyr8Oy9ZN6OarOfkhbToOyh4rjAiyF9FfE4GN9RcZbqmDOJM50P1wIFFL04ldaaoGLx2IPjJVuRAQzjmk1SENI3Z6Seuxk5e0R2kq0ENZ/BiZdmrI0lC6aPRn8ipgBz8h8ej3K8BqsSDgDXsLgLaY3Ii00baNm61iIoszJ0hA3KDe77xcBTVD1jQA/UAwec7K5Eug==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(41300700001)(316002)(70586007)(4326008)(70206006)(5660300002)(54906003)(110136005)(2906002)(6666004)(7696005)(26005)(8676002)(16526019)(336012)(86362001)(186003)(1076003)(8936002)(36860700001)(36756003)(47076005)(478600001)(426003)(2616005)(83380400001)(40480700001)(81166007)(356005)(82740400003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 12:19:08.9017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 273cb687-09fb-48f2-4c13-08db891b84e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717
Subject: [virtio-dev] [VIRTIO GPU PATCH v3 1/1] virtio-gpu: Add new feature flag VIRTIO_GPU_F_FREEZE_S3

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

