Return-Path: <virtio-dev-return-12144-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FC9C7619A
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:25:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DA910F3F76
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:24:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CF8AC98664C
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:24:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C1E9698636E; Tue, 11 Apr 2023 19:24:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9FB50986699;
	Tue, 11 Apr 2023 19:24:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxzEU9DyRwsTG2Fo3ZXuWc4No0hKMJNjL+5uJb9v/60i0oxOhCdtp7AluBIaUSuL8180CAXYqDTTbkoQTPZn7qNZRO1FpghyHtnUJ5E4A98uLmd4NzMhcr77mYC+WrM4Dzy1SnAAr75iyKnXqboCovK3yDwq7wBdHca7A2bbR80wVXxLz0JtzUTuNRKvB1vQNHCAdJ6Cnn2Am/Smni/QoB/nF/O2Dbs/VvQzDHouFU5PbObDaXW0j6+yACz/SO/lLt6cPoQbg+eJTmNn/Q+m+Fqw2DW9V+DBATuOvTO4G5Ndn3wvYEPazXy6I+yfcmu22+Q4e8pRQJlrNTOjhDqD5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWaxBKNF8KScQrzzpB92CrLpVDN3G3mnaFckBMfIBok=;
 b=L04t8Oy4eAM8LwZITyKnXgp7fSe/sroZzK8RkGA3q+ISO9FhxyGJjTILZJVhgetvYnvY5DFVaovpJP+IEZoHFInoiKNAJarkFHcofGIB/vlSJaL+Bu5PXyJuH0Ad69yjoaotjtAnKZB3j4bQxvrO6j2CecTq9iPViLhiviMEZYcQ9qSRb1255GK0N/kcb3KdeFeZBq08XtHNZ87OHZOEHFc5B2gLD+zGHTuyKWU5OVU99ffV12iG2ku30BBgfmWr3Rtcn+AKwIi6jv9WiTfDyGV9vzrjsEXqK1HCQMIQvqIAT/qt1o51ihTCY9uU1fT+cSK30LaH+Cwh2d/rvuWnDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <sgarzare@redhat.com>, <pasic@linux.ibm.com>,
	<virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Tue, 11 Apr 2023 22:23:36 +0300
Message-ID: <20230411192341.751841-7-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230411192341.751841-1-parav@nvidia.com>
References: <20230411192341.751841-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BA:EE_|BN9PR12MB5383:EE_
X-MS-Office365-Filtering-Correlation-Id: f75158d4-66a8-4ba4-b258-08db3ac25767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1L790+3bYyLIJs4I0NCU4jpWqSFGalk59vdBpCvxkQJkcVLO8R8yvqtjdoHKxmo7qGefQv8SnHLFNR4N4hDjc2rGDsvMyHi9SLwQa2+foUPsn1b/Px/Uht95m/mB7iCR1QyGLw0K/ku/EuOAciXCli5X1H67Tf/ybpT1xVNHlxlv4buKgaIzlEbHPZByvzqcwxb21dQq57GtZNSxlTJdErwYpJdfZNT6wHPCnKnJE9HtfnApZBzbuNhHyw1xEtYTsoUBVa2Vb4+oWtbIn0uQpmbb9czd2XOGDuME6OKbFLUp3qXm4aN+BnRe99+8CemrOYRbv9NK6lEoh8DkKcE3uAVuA5bOczU6Hh2LnPq2aStTANgHy/uLEoCU5ahpZZAhJqvEY+AqzzGnBQ8XinFY4vEkwUWW5PKjL1reOHMAS/op7MRiquQY3Sw8Ku0KCEXRbfLQ1tWFRfi3cpiPaK3pI+1PWGAk/BYk4QqIZWu7Slpj2dEjzJFniPYvEoNpEVWz7aIhn8ie+rQHC7LvGuwXC6TcOk+ROedJlN88qsY3zGMzxwWH4WBWIt1bKe2Z7vVm39BGQtZkyW47cqvpp2PnlHcAiiDCtWV4YhsRk8eqLgA0G5AOLJmlESj7JrygrDdXKUeVJAFXa4gCmlbAEr+zWiWOWgBVADieCFBLTSUEGthho45ni6tz+daes9JK4ehZkW3zaAWoiprWLuHiv81Qzx7h+W5SVuLRJXGHqYf5LXuONour36PyUzfLA9Ahv7cuENC0/t97o3gwn/jtQKY+YfWDzdx2Q1oQIkfv3/2hTZw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(36840700001)(40470700004)(46966006)(478600001)(1076003)(26005)(316002)(110136005)(186003)(16526019)(54906003)(2906002)(966005)(5660300002)(4326008)(70586007)(70206006)(107886003)(8676002)(6666004)(82310400005)(41300700001)(8936002)(7636003)(356005)(82740400003)(47076005)(40480700001)(83380400001)(86362001)(40460700003)(36756003)(2616005)(426003)(36860700001)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 19:24:16.5506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f75158d4-66a8-4ba4-b258-08db3ac25767
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF000145BA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5383
Subject: [virtio-dev] [PATCH v13 06/11] transport-mmio: Avoid referring to zero based index

VQ range is already described in the first patch in basic virtqueue
section. Hence remove the duplicate reference to it.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v12->v13:
- corrected number to index
v11->v12:
- remove changes related to 'vq number'
v8->v9:
- added 'by' at two places
- replaced 'queue number' with 'vq number'

v6->v7:
- remove text around first vq as it is already covered in the basic
  virtqueues facility section
---
 transport-mmio.tex | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/transport-mmio.tex b/transport-mmio.tex
index 164e640..2d24b4c 100644
--- a/transport-mmio.tex
+++ b/transport-mmio.tex
@@ -113,8 +113,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     following operations on \field{QueueSizeMax},
     \field{QueueSize}, \field{QueueReady},
     \field{QueueDescLow}, \field{QueueDescHigh}, \field{QueueDriverlLow}, \field{QueueDriverHigh},
-    \field{QueueDeviceLow}, \field{QueueDeviceHigh} and \field{QueueReset} apply to. The index
-    number of the first queue is zero (0x0).
+    \field{QueueDeviceLow}, \field{QueueDeviceHigh} and \field{QueueReset} apply to.
   }
   \hline
   \mmioreg{QueueSizeMax}{Maximum virtual queue size}{0x034}{R}{%
@@ -363,8 +362,7 @@ \subsubsection{Virtqueue Configuration}\label{sec:Virtio Transport Options / Vir
 The driver will typically initialize the virtual queue in the following way:
 
 \begin{enumerate}
-\item Select the queue writing its index (first queue is 0) to
-   \field{QueueSel}.
+\item Select the queue by writing its index to \field{QueueSel}.
 
 \item Check if the queue is not already in use: read \field{QueueReady},
    and expect a returned value of zero (0x0).
@@ -474,9 +472,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
     Writing to this register selects the virtual queue that the
     following operations on the \field{QueueSizeMax},
     \field{QueueSize}, \field{QueueAlign}
-    and \field{QueuePFN} registers apply to. The index
-    number of the first queue is zero (0x0).
-.
+    and \field{QueuePFN} registers apply to.
   }
   \hline
   \mmioreg{QueueSizeMax}{Maximum virtual queue size}{0x034}{R}{%
@@ -550,8 +546,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
 
 The virtual queue is configured as follows:
 \begin{enumerate}
-\item Select the queue writing its index (first queue is 0) to
-   \field{QueueSel}.
+\item Select the queue by writing its index to \field{QueueSel}.
 
 \item Check if the queue is not already in use: read \field{QueuePFN},
    expecting a returned value of zero (0x0).
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

