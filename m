Return-Path: <virtio-dev-return-12537-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84100C77B7F
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:31:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0EBAAF3F67
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:31:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0698C9866D5
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:31:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EE2F798663F; Thu,  4 May 2023 02:31:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D33219866BC;
	Thu,  4 May 2023 02:31:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5tU5qWvs/Aw0ewL8kvgoglR04lAHHKsLq0LGZ6PT7SCJL1NyY2NwbTcs//E8DkeE/o2B05J70/UlbxpSwSu+s6af/w1+wr5xuzVpglg61wDUazCRl4COAQRLusyKm7MOP84Mf3O/WsioIb2EXxTE++Q2RIJRABvHEPDC+SanhVPhCT3rTxo6468mLyt7LRo9jpKuHlEkI46Ddwlpx2pr9EUNMBeU5mU37cOuzZxOVefqYbcTW1OqMwQ+GF/uGEmvvvXJ/21c9ytfS3sxI2QUq8/yNdSZxjkR9/xKmrK3LJFQU/3ORaOxuDoLVz9QSIhTVNeV1mRMZmpVVOPYNn9TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkCKsHnCSdNo6rSCFSv6ARAPg1nQxhHKnhmAbbUdgF8=;
 b=gHhClObJTAArwFirhGdKvdMXsNFpIYcKyOWCkTDMK99IpQsVxoDocjXdfFQDsq3+As4iDxVnDaZWT2UkcWp5aqtx9RFsbS/jXnDU9maqKEcjMqXM3e7u7t7GL/1EsartrMPYpYDKZebDyMUiUeiQJXHyBwWWy4nyKQfEaGHAPXLBE4C7Pd51bpYqnfUNBfBa1aNYMC/wj7pwmQK1rDxfQ9YzdL9RWaS6IWTSvDEs4+aDyOdkhsQYd9lxJBeI29Yxr4ny7xsw9XrziGLQQTwoOBuX1Rn4hHiwPAcqPVnMOv2ybih5xAFab6D7AYueVQZdIHnMJlni2YuSurzoQREWaQ==
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
	<david.edmondson@oracle.com>, <virtio-comment@lists.oasis-open.org>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Thu, 4 May 2023 05:29:55 +0300
Message-ID: <20230504022959.547025-8-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230504022959.547025-1-parav@nvidia.com>
References: <20230504022959.547025-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|DS7PR12MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: 21657c7d-5c00-4fed-e5d3-08db4c478aeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1Vo6HP1LXkbUOwea/8+OwR0xUhUvx/0Cst9ZL2NmNsTvydDwT5afT9favAknNy8jm5G+S3IxEXfNJqiPctuZMa6OM5R5wPgY4pv9WEoDDrKYRSn8Ze6KyqwWGp7USEMWGyoGqB/n100Qj/GZrNfOFxpaquqgl5ijjg3oTy2h8uWDCt60Bt7xyRfoRmStMd4AHJmPebveU+XMRtXmvONTnzkM3os9eRzB7zzCi7jLYv52u3Aw6g0PdkPvnvnCXYmB56IK/XW+ZQlyGxchlK1aBAwz1NFaTQWE+k9auv3abDA72zL7FIWgd/zBEJ6AQAIsn0nK87uaHCeBUmOW93k7DEPRCFHEp2eseR2b9IH7XsJeLQWgzfJN8B82JU56GveJAIOMTyXD02kXLZ44behagVRznkgBVwoBoxEWVOJ1aA40XnIwqOwFAY0VBpKK0SNlHv8BReMetsBns4TyBRjj151Q5WnVEj8VJElclM0CKFFNbZtg4MruVkKX0W3nko5BU/Z6wgwm9qScI2Oyme51l+ehSqWCBaJfNTco6PdYsV6IZBj9dkDVfHtHwSAXoJ4n2dJu188+mRY3GeiCM2goFWxCPFy1GYVcffqSycBe2Ritp4lNEZxAAN5WAwzABwxs8yJLtuwZjM5kDzTKj4KCZowkyDD7z+wpMQ/RbeLI97z9cZ9wm2bhKzQdjv65Iq3N01nKlbd8M3wsdhAn2gIYn7vVj+dohb2TrKUaRy2dtP5hUQFWtYtoDcsLk/z4NVqL
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(1076003)(26005)(83380400001)(16526019)(2906002)(186003)(36860700001)(40480700001)(2616005)(47076005)(336012)(426003)(6666004)(41300700001)(5660300002)(8936002)(966005)(36756003)(70586007)(70206006)(478600001)(316002)(4326008)(82310400005)(8676002)(86362001)(107886003)(40460700003)(7636003)(110136005)(54906003)(356005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 02:30:35.8286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21657c7d-5c00-4fed-e5d3-08db4c478aeb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6048
Subject: [virtio-dev] [PATCH v16 07/11] transport-ccw: Rename queue depth/size to other transports

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

