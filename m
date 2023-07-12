Return-Path: <virtio-dev-return-13343-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EBDEB64D9
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 09:37:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1A7F8157F06
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 09:37:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0B336986720
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 09:37:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F2A21986661; Wed, 12 Jul 2023 09:37:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C7DAD9867E6;
	Wed, 12 Jul 2023 09:37:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6OgNGziRKDrV16V3rdxHgIcyZRD2Td3JI5c0KF60OIe6GHew2tx0lMLahUvWtwieIpyzy1Te7zP388aM7JMPc/Rcm9Ih9TnTF7KsSbpgXxmHiJ37K5UcTmLYK//L7WTOyw/Ijkl/m15bYS/fEv9K7EFrfQebb6ZoGufEUNbRO5BmWCPa96th+qBadzFwMWH5gfyqLnAIi84ydcS2fZbtHWTE8qwaUehJb/7ZiDjJXwOgCDPVoleKc8dCVnc46HJdfozZx2+UPjWOaACBw5Cd6NqaoA48Ppxv/sQcNXX7F1Ajdt3NskuhlYZLHdEkUGbcoczvvSVfOvb0aAzwNe+1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qvm1RqCxJeHFITpl9C7OrfKyeNXuZVfbrxGxLQvFxu8=;
 b=cqAg4VlE/xa8kNCkz+0ZY4CLbDBgtyq+L3Qfv/r43ysZebpaQRQG7ZoyxZgFbKlX1v3m020MQmw0L3qKhYaRn39I8ZozGucOMTrfnM7fRebExy/wpPZUwQqQEtVnwstPXzCUSnqZLjyH+Z38OIpAdfaLtOYIcgvlsPJRSZHOJJMuG7v8UQET3JC1y3tKra2bzJ9tLVEjM7J73oRjzeuxk/Cyapx1KsGyVjxCb9MXHh9mO7qa3ARPiqqeSz+QMtZ56U3ZtB8lkSaqzvX/aQ5bAqIistN75v0SoPW1dgv2dWnfa0oj6j6K/YQ111DTcCvRKCG1gVt3gaOBOICbPykvXw==
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
Date: Wed, 12 Jul 2023 17:36:29 +0800
Message-ID: <20230712093629.1410765-2-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712093629.1410765-1-Jiqian.Chen@amd.com>
References: <20230712093629.1410765-1-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT024:EE_|DM6PR12MB4338:EE_
X-MS-Office365-Filtering-Correlation-Id: b17b56b5-feaf-4975-d70a-08db82bb87ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RkTE/QxHui5Sc479tsxmkDE8+yGRpRBsPb5Vt3hb5uCM+u54hCvIhHNi/EwqVlvKd0U6rvzuXj0E9LWT4wMxY4j1qGal5I9COis1ybClxQmFmCVrpfWSVopwc8UQIzsC2+cvZE+Os3R/7Rz3/PgtAR+K7wngylc+JQGIAFBjE8sCco465NGZpkCUgwX/I1CtPOEmKufHF9fFtaTng55yO3D+JmioJi0ax6kIXoYhF+XGQAJK7tzvuKSY8hQ0lf7sPtGr2NlEafBsaA5yiGOiNqcASM/CyzDDdCvLP+C7JNQ9ygZu4fnTUxpmDayBY2LEcUOs7mY8pialI9U8dsre3aQwwMr3N63rjsvUe31JeXiCfPiYnuRjN3KbA3aet8LQg9nnL/5rmdwvboAIyuxFrOz3d0mVoE/bGCFleoIlbbaYd4h6Cq375jUjWSNgrf0pmc7rGiv/2dMyTMIZz+9HfYUUupQXXDoS3TyQSwz/e8kuORU5fAifiqCZQbwAKEjQMvEPpL39JJiCGWBJkhClEo3vojEFNiR3QyNIGX+OJVa2RzrcqAjau9n7qzfFGlbyqu7eKmPASjQDVPSMrFvEK2CcaFU7qB+9BHvfFsxHXlqJVEwtLx6qnuVv5oPpTcMfGWS35IRGMPvcEQoG+iXCyytqkF9XUhIAz0V1vvZZXMi3iFGi2bcdJLyzuSA/9RTMK0PV8ZmoLGknjfd5Ydzw/KmNVc90Ho97/Ptty4fkBxdNuacywtzINvWPXzpqqKwUgDzq6bXnWCeAmV3m0Ea0MA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(46966006)(40470700004)(36840700001)(316002)(4326008)(70206006)(36860700001)(47076005)(2616005)(83380400001)(70586007)(1076003)(186003)(16526019)(40460700003)(336012)(26005)(81166007)(426003)(36756003)(356005)(2906002)(40480700001)(6666004)(82310400005)(7696005)(82740400003)(110136005)(86362001)(478600001)(54906003)(5660300002)(8936002)(8676002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:36:54.8957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b17b56b5-feaf-4975-d70a-08db82bb87ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338
Subject: [virtio-dev] [VIRTIO GPU PATCH v2 1/1] virtio-gpu: Add new feature flag VIRTIO_GPU_F_FREEZING

When we suspend/resume guest on Xen, the display can't come back.
This is because when guest suspended, it called into Qemu. Then
Qemu destroyed all resources which is used for display. So that
guest's display can't come back to the time when it was suspended.

To solve above problem, I added a new mechanism that when guest is
suspending, it will notify Qemu, and then Qemu will not destroy
resources.

Due to that mechanism needs cooperation between guest and host,
I need to add a new feature flag, so that guest and host can
negotiate whenever freezing is supported or not.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 device-types/gpu/description.tex | 35 ++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/device-types/gpu/description.tex b/device-types/gpu/description.tex
index 4435248..729dde5 100644
--- a/device-types/gpu/description.tex
+++ b/device-types/gpu/description.tex
@@ -37,6 +37,8 @@ \subsection{Feature bits}\label{sec:Device Types / GPU Device / Feature bits}
   resources is supported.
 \item[VIRTIO_GPU_F_CONTEXT_INIT (4)] multiple context types and
   synchronization timelines supported.  Requires VIRTIO_GPU_F_VIRGL.
+\item[VIRTIO_GPU_F_FREEZING (5)] freezing virtio-gpu and keeping resources
+  alive is supported.
 \end{description}
 
 \subsection{Device configuration layout}\label{sec:Device Types / GPU Device / Device configuration layout}
@@ -228,6 +230,9 @@ \subsubsection{Device Operation: Request header}\label{sec:Device Types / GPU De
         VIRTIO_GPU_CMD_UPDATE_CURSOR = 0x0300,
         VIRTIO_GPU_CMD_MOVE_CURSOR,
 
+        /* status */
+        VIRTIO_GPU_CMD_STATUS_FREEZING = 0x0400,
+
         /* success responses */
         VIRTIO_GPU_RESP_OK_NODATA = 0x1100,
         VIRTIO_GPU_RESP_OK_DISPLAY_INFO,
@@ -838,6 +843,36 @@ \subsubsection{Device Operation: cursorq}\label{sec:Device Types / GPU Device /
 
 \end{description}
 
+\subsubsection{Device Operation: status}\label{sec:Device Types / GPU Device / Device Operation / Device Operation: cursorq}
+
+\begin{lstlisting}
+struct virtio_gpu_status_freezing {
+  struct virtio_gpu_ctrl_hdr hdr;
+  __u32 freezing;
+};
+\end{lstlisting}
+
+\begin{description}
+
+\item[VIRTIO_GPU_CMD_STATUS_FREEZING]
+Notify freezing status through controlq.
+Request data is \field{struct virtio_gpu_status_freezing}.
+Response type is VIRTIO_GPU_RESP_OK_NODATA.
+
+This is added for S3 function in guest with virtio-gpu. When guest does
+S3, let it notify QEMU if virtio-gpu is in freezing status or not in
+\field{freezing}. Zero means it is not in freezing status, none-zero
+is the opposite. When virtio-gpu is in freezing status, QEMU will not
+destroy resources which are created by using commands
+VIRTIO_GPU_CMD_RESOURCE_CREATE_*, so that guest can use those resources
+to resume display.
+
+Note: this change is not enough to solve the problems of S4 function.
+QEMU may lose resources after hibernation. It needs more research and
+development.
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

