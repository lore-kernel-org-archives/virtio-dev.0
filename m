Return-Path: <virtio-dev-return-12470-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C012EC77B61
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:21:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CA52E15B672
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:20:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3F563986687
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:20:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BAAEB986741; Fri, 28 Apr 2023 04:20:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BC79B98668B;
	Fri, 28 Apr 2023 04:20:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gU+Iy9XEUsykPwGKp6SQ8+xhWttqyVPQhiOSNF7Vu0oj6Baa6Qz96KeqOERTTZ2+sd94LUeiSmEurnDb8tHfMgCZ8iVHY/1NTTwOwsCjkBzyJ8jmINRBPHTJ3tI3fsaFgahOES6ChoSwlTHLY49gJfY832QanBKWjoR/G7A/RApdfUIjTT6IlshcIJJvcAryiUEh639U3CS0HDmChFLla1it9pCtIz1WbLKRce3Ac0HryKWo66RtpCGWXKGjtI7umFhra4rcmRsgxkTqCUPhFxC9ZGSWL99qFmuIFFgE5RQk7bNUnaYE+J28mQTLsPx/R+CmaMA9ISHFFXF0g7zEhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkCKsHnCSdNo6rSCFSv6ARAPg1nQxhHKnhmAbbUdgF8=;
 b=IWCM7je8rliEUQi95MqZ7hwqnP6bMEVuQjfzVeyfg5XSySXDi2ORWkTTeriIGmdIQucZsy7gN4ALarlA+Q7YN0pzJv9KKvx0pdr0wlY6en7RuW2dcSZuk1zIbRBGZ/boVNf+uosuEqhVrbE9mLdMT9A+P9afx2j43ZTD+CUs2HQ0HpB1IWMhfKIAJlDmtKVoI1UVejGIr9kDBLk7u/79IjE1rkcpVC2TuCqmfKnLvSjNLurHpgjek4U/oQ+0eRQsxkQ5Tq8M5a+yQ8BwIeEdJ39RHNBhq5asJ4mG69QgTNVga/t6Vxf8hSNps8qxLH/zQsPjyu5Sk23B7fWY0FvTpg==
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
CC: <sgarzare@redhat.com>, <pasic@linux.ibm.com>,
	<virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Fri, 28 Apr 2023 07:19:45 +0300
Message-ID: <20230428041949.411221-8-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230428041949.411221-1-parav@nvidia.com>
References: <20230428041949.411221-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT003:EE_|BL1PR12MB5159:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c092b87-0829-41f4-af28-08db479fe358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gXvX1HfQ7GR3Aov0Q5isBHUQmTisA3tUr+DhRGzcQ+MISox1WAkMISmlCkjoSuYNueO0V52421lNPlKGYdbXhAjBaXLqgnpU+IjLmRnSJbiSEeByW37CwmUWFC4RqcCya4cMz2gMowEz0iX1p0nty8WPGXZlKW4Z3CMLSWxf4G2xuCpv6bB1w7Cp2IXMBbwkNNAfG90+uveFSvUKOnHZOs5jXsNZ0WQkuaR9qeu0GEWa11pddwAMJooYBxXJVS13V7vQP+UeUbu5M29ShzM0aFHy0J4z6OxeqbmrtIBFA5V4asLjvczPUvETzQE02QI9delkDaPMioeEIWwjsXagejtQQRdzwTvOCadfv9J24ChYmtjrIicl/W4a/nSoCwTkZej7qjy7M5dUCxWoVa4fa4nz2addwLxDWNMwGitsHq9XMreLHV0A5NyFSDOEvlq2qyse+HprC49zjNeTS2bB+w2/D1hIYZ0InLiksy9qMqmcqr19kWES6FouATehEv4svr3noJQR8+4qb8KvacdS8rrRE6EZAg3bII5bDwSozgx4YGK7knW3cwCxZz+tV4ozrvYdlUazlGyFB1DUpESEk1kNCmT59nMhSYx71Qw1boRQvMDyqbiIk0FizADG/usLMwUOVHGd0GLmjGGSA5/1Y3zPcnrT+w7EXi8kLI5pVJa9DvtRqMiPWljkAvtIE8z8P1LW1yt/4rc2Om0qNI9w551XL849bvXknHVGGDoHNUrd8BmUQSxLgAQfpwTBU52ygxgg5HHkn9Vs/CKCAHeaRA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(8676002)(8936002)(34020700004)(41300700001)(82740400003)(356005)(7636003)(36860700001)(316002)(2906002)(70206006)(70586007)(5660300002)(4326008)(47076005)(82310400005)(83380400001)(336012)(426003)(16526019)(2616005)(110136005)(54906003)(40480700001)(186003)(107886003)(40460700003)(86362001)(36756003)(966005)(6666004)(1076003)(478600001)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 04:20:24.0794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c092b87-0829-41f4-af28-08db479fe358
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5159
Subject: [virtio-dev] [PATCH v15 07/11] transport-ccw: Rename queue depth/size to other transports

max_num field reflects the maximum queue size/depth. Hence align name of
this field with similar field in PCI and MMIO transport to
max_queue_size.
Similarly rename 'num' to 'size'.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v9>v10:
- used lower case letter for comment first word
v8->v9:
- replaced 'named' as 'known'
v3->v4:
- moved note to comment
---
 transport-ccw.tex | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/transport-ccw.tex b/transport-ccw.tex
index c492cb9..cb476c7 100644
--- a/transport-ccw.tex
+++ b/transport-ccw.tex
@@ -237,12 +237,12 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 \begin{lstlisting}
 struct vq_config_block {
         be16 index;
-        be16 max_num;
+        be16 max_queue_size; /* previously known as max_num */
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
+        be16 size; /* previously known as num */
         be64 driver;
         be64 device;
 };
@@ -262,7 +262,7 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 \field{desc}, \field{driver} and \field{device} contain the guest
 addresses for the descriptor area,
 available area and used area for queue \field{index}, respectively. The actual
-virtqueue size (number of allocated buffers) is transmitted in \field{num}.
+virtqueue size (number of allocated buffers) is transmitted in \field{size}.
 
 \devicenormative{\paragraph}{Configuring a Virtqueue}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Configuring a Virtqueue}
 
@@ -278,11 +278,12 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
         be64 queue;
         be32 align;
         be16 index;
-        be16 num;
+        be16 size; /* previously known as num */
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

