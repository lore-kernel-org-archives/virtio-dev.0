Return-Path: <virtio-dev-return-11727-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF10C6FD1F
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 21:53:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 12C3498FB9
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 21:53:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BA8CF986579
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 21:53:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A844798648C; Wed, 22 Mar 2023 21:53:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7E4F49864B8;
	Wed, 22 Mar 2023 21:53:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6Lk+XdyXryrd8jg2ag4RtYS8DT614IWcp7mF8xC1O/FdZhmIYRDMAbo72Xc+oTOUCbgz0FA9cWtv8eYWLzHeqi9vJubnz5aE/8EjHOcgRAaDaf2uZAZQk15CE2OGZB6SPNaFcJ4/AgzXAv4LRfMg4z9A2UJUUdHbcns2qyTIdoJEIZXWr9e8UGrv4L0PMzMeNlgs7mw2x1i8rFUdmzCMJXvTv5Ihh6/R+lNNafZHyN9Q5ZUVfLpEPgD3RYGAWqLhJc1P31lNJYsfD77NCH+hVkELZVBcUwD+ml8DRf6A4K7QmJRT7FiHaOXiw4Da1btrLAOqZ4ghAvnUOs22S8Wyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9rv62A6GUE0xs+vJ9ZuoQfMlX6hJBVsIC9G2phIbuo=;
 b=Wb8q/zXqa2v515J7pTC/h5+lPvVuKTqxH6LN/7cgE5c0YR/cdN6qFnOo7Uof/FM5a29w+i1HX/wk4D4p03yOUX+tDSPZKSfznKEtBQbXLo7hFlzXNsHyp3IMrPBWPzW4KPts1T0tY8/w7lasEgJJ9Fanp+kUgLKrirqI5dspMYhBTy/M+dVlFpnhGGYbCboYNX3SpHuAcxChEKFxWFtzvJa/rS/8x4foSp+MJkxBv3w81t6nn8iRtOz/a7pYzUpTmcGiyy2gx3Qi9G46z3q6jCteAcDGjw/BSrEIPYDj6cih+udJNaNxAbvd3tq+ZjnXwXtSMswf3S/NyYjrt4rlBw==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>,
	<pasic@linux.ibm.com>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Wed, 22 Mar 2023 23:52:40 +0200
Message-ID: <20230322215243.249524-6-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230322215243.249524-1-parav@nvidia.com>
References: <20230322215243.249524-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT050:EE_|PH7PR12MB7988:EE_
X-MS-Office365-Filtering-Correlation-Id: f4aa9441-f44f-433a-04df-08db2b1fd382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wbrKyaDCXabvC0gdc1AVhVeACowKxgnHu34uU7Hw5lT0kfiN5gMuitUXGsxMwi+Vk98zLe/Ij0THBfBNjEUK98iZ1i8G4poJi4VS58m+0Zq4qkMpTXnNnu/oJZ5X+tZd/BeXTecaYHeFOGetDhWmfZ2n4xKzeI5vA0tT8Dc1mH0fcTFKfn3lYnfsEAfHJAeWuZ5JhtqdLNA++uQHvchrFgkM6dbCLEH0CU5RVDFVcf8Km8POKiezB2vGz+MKR/7XNQ8OGKCfQJXVNy4A7NjuWNaCYvsxBbnCsfPOHqKnBbjt7Kapg80zyThaoahtWrVlQr28ut8vjhrWM9f7hyQTtZ7TF39R3thsVicS15IVlE1WYfBJA8f7XcQt8v94P6ZhawC7a5EqHNNeCdSfJsO8452WZkImHE8CBt9N9nmU4Sb/EDgyD7Hrvt1D84X4DIuCggH4VK5pcy1EQ+QQHKXinyZZJc1+z+mt83p0xefPzLQhsIEnGkUHTD1Y80eDN1Tw3f+7PEyD94ALIVi7ygGUw4k/eSe/PinMLR/8bPSKnTVZqn39O2ioiwGWmKDIswYcKUftT15Cz66v6Etld8MKyg9jAhovULI6LZ+S9WxzUEvkBrn3dcEW0YrDiVZs7/o42HBT1E8fSdop+7bpGBjHWyD1+4gsl44AN/sdlrOJ2JNP7A3gGRr6QY4NFYlAbpkJWoGFi6MPjVaDWZs8A6UpLhvvyCD9LH752fcCA1hg0FiPwyAq5Xj7T5fkVxAoxP+PrL/z2PlsN3GG3lRozS0vIgrXQlMYejhixESJkTpb1ak=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199018)(36840700001)(40470700004)(46966006)(966005)(426003)(2616005)(54906003)(47076005)(82310400005)(16526019)(316002)(478600001)(1076003)(5660300002)(107886003)(6666004)(83380400001)(186003)(356005)(110136005)(26005)(86362001)(70206006)(40460700003)(7636003)(336012)(36860700001)(82740400003)(70586007)(40480700001)(41300700001)(8676002)(2906002)(8936002)(36756003)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 21:53:09.4145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4aa9441-f44f-433a-04df-08db2b1fd382
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7988
Subject: [virtio-dev] [PATCH v4 5/8] transport-ccw: Rename queue depth/size to other transports

max_num field reflects the maximum queue size/depth. Hence align name of
this field with similar field in PCI and MMIO transport to
max_queue_size.
Similarly rename 'num' to 'size'.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
v3->v4:
- moved note to comment
---
 transport-ccw.tex | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/transport-ccw.tex b/transport-ccw.tex
index c492cb9..b4bc83b 100644
--- a/transport-ccw.tex
+++ b/transport-ccw.tex
@@ -237,12 +237,12 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 \begin{lstlisting}
 struct vq_config_block {
         be16 index;
-        be16 max_num;
+        be16 max_queue_size; /* Previously named as max_num */
 };
 \end{lstlisting}
 
 The requested number of buffers for queue \field{index} is returned in
-\field{max_num}.
+\field{max_queue_size}.
 
 Afterwards, CCW_CMD_SET_VQ is issued by the driver to inform the
 device about the location used for its queue. The transmitted
@@ -253,7 +253,7 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
         be64 desc;
         be32 res0;
         be16 index;
-        be16 num;
+        be16 size; /* Previously named as num */
         be64 driver;
         be64 device;
 };
@@ -262,7 +262,8 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 \field{desc}, \field{driver} and \field{device} contain the guest
 addresses for the descriptor area,
 available area and used area for queue \field{index}, respectively. The actual
-virtqueue size (number of allocated buffers) is transmitted in \field{num}.
+virtqueue size (number of allocated buffers) is transmitted in
+\field{size}.
 
 \devicenormative{\paragraph}{Configuring a Virtqueue}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Configuring a Virtqueue}
 
@@ -278,11 +279,12 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
         be64 queue;
         be32 align;
         be16 index;
-        be16 num;
+        be16 size; /* Previously named as num */
 };
 \end{lstlisting}
 
-\field{queue} contains the guest address for queue \field{index}, \field{num} the number of buffers
+\field{queue} contains the guest address for queue \field{index},
+\field{size} the number of buffers
 and \field{align} the alignment. The queue layout follows \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}.
 
 \subsubsection{Communicating Status Information}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Communicating Status Information}
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

