Return-Path: <virtio-dev-return-13187-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9133AEB64DD
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 09:54:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D9E2A23D6C
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 09:54:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CA2C39866FB
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 09:54:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BD1349865E9; Fri, 30 Jun 2023 09:54:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A60B49866EC;
	Fri, 30 Jun 2023 09:54:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IA2myvca6wooCmImcqenuq4lBgSgYsZf7KNknG+fiFOL7CvWioZIlIjWEcJUW0VSC48B0juqOgGV8RUqDbGX6YoEXjmM3wQlxwho7lKs6NRtYFyVAsxtjwUL6yU6LHSVrFxmz1X8MQoalyfWryx+pwLR1ca4aTIEmvD2Yq3k4mlacP7lzPaoC/ZQk00i9EIHoJz7+PEsAm/bGec3l7SXlKMPT1DocaHnZJHw2nYm4Fdi6/ldVaVE+DRaB1bxjGrwTD6fWU39Jbk4SxfDEBGQ5bbfhkbPjyS1airPTi1ls5YVTK4LkvjNtG+YEPEF7qq6IwDTlcGGS1ZzGLjqkhXCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4jUw+HkAyFnO/aQ5KraQKHPKbZG00TO17TFZ6/nOIc=;
 b=i7AYdA4uKQ8mTry2jAh0/m8hTHtMFDfHQAXiOX5WaDateFw1aMj495THquml/1AOBpRqYFcRroiVHllGVSZdNDhdldrMbBE2JCipLk4xmz0AZm8ypT9w8JDFkL3uAsz2p7cwSF/D27rrYAozoy+QCkRcw3yaG+F05u1ImyAMoUUKy50eayG+N2i/jvqlV4sYq5zwPJkALwlg1UuzPfqj9X9bwzJsJ67tvOS/ZIjVsGhUD9/SzPCXcoK4gNqg8Szj4uI6vaMNH4bTLUMlFPygquckSUajZaUy4rG740IpAEgnXstvijFFMfW18JQujE2vHOuSxZF/K4vhilvEEgi13g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.oasis-open.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: <virtio-comment@lists.oasis-open.org>, <virtio-dev@lists.oasis-open.org>
CC: Jiqian Chen <Jiqian.Chen@amd.com>
Date: Fri, 30 Jun 2023 17:53:44 +0800
Message-ID: <20230630095344.856316-2-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630095344.856316-1-Jiqian.Chen@amd.com>
References: <20230630095344.856316-1-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|BY5PR12MB4081:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af18382-7273-4273-edff-08db794fef27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6umZE8Y22ZDy/ydEEKjTm6VWAva7vLUvpoXfVhEZU2PUGHz8VZIAtfEyce7nP/Y0yGfDNdd4jKqokYYAXm9sbcpDVE4OBRCNtBmosLwwwm4ZFLH+mghDDdoKvYvYZEJjYLy3JBPfM7V0f882rTPCh6luDBX+U6HKPg0FpydmQHtMiWMMxTradgw+glvz3v0iCuCyUGy6CHETz+AYtOm40geiimKVkkdzC3OCmrTXEmSU4QUn4tEqvVWLzTeNtpuM3QhVXYvSetg2lFwgggc04vVW5estEmKUC4kfvZOKLB8PkhELEreSIhnskJZ9nMaARlDEmZcYtPzAB1X1q7AFqPRdQmmc1BHBzI8f4bPRBl4sgcoSWr1H9V3d+JccmiGEd62nrcXjvWJs8bg2AApk609gGEzLt8AaLqd6TElTBHufgsy1ZFYO7mXKqfK9NDoO2iEUCESXltmLy84LBe3li9z68ECEFGM+2t5DpdGqGF4Zl8Dh++h1XkoEHQ8kE/2t/UGknYUd5PdG0hst8ErqJlRj12v1uf9WseEVhqEBA2hMTWTyDZZ7AwHC6t2rqD1aEcjtiSifosn31qD1TUVAyjv9j028wRE1Mufku8w9AcqkasB87QzSueX2I4U1PeT1omaNDclGpwfbMVOcmBpwfvDzDpGUTTJMUpCOvnJKkSwquvpxhvo/ife8FNQizs+rZUYoOBD2VGpLuND8netalq285mPZtAZ+2MY17X2Ot7S4/wcoKkX0jet0Y3bphy34smay8q+GYOsG+p3Tvk7Ztw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(7696005)(478600001)(40460700003)(6666004)(47076005)(36860700001)(186003)(26005)(16526019)(40480700001)(1076003)(336012)(2616005)(426003)(83380400001)(36756003)(82740400003)(82310400005)(86362001)(81166007)(356005)(4326008)(70586007)(70206006)(450100002)(2906002)(316002)(5660300002)(8936002)(8676002)(41300700001)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 09:54:02.4337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af18382-7273-4273-edff-08db794fef27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081
Subject: [virtio-dev] [VIRTIO GPU PATCH 1/1] virtio-gpu: Add new feature flag VIRTIO_GPU_F_FREEZING

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
 device-types/gpu/description.tex | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/device-types/gpu/description.tex b/device-types/gpu/description.tex
index 4435248..11e37bf 100644
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
@@ -838,6 +843,28 @@ \subsubsection{Device Operation: cursorq}\label{sec:Device Types / GPU Device /
 
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
+Guest notifies QEMU if virtio-gpu is in freezing status or not in \field{freezing}.
+zero means it is not in freezing status, none-zero is the opposite.
+When guest is in freezing status, QEMU will not destroy resources.
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

