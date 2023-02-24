Return-Path: <virtio-dev-return-11264-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7A6C6FA8E
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 22:24:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0F4F667067
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 22:24:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4721398698B
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 22:24:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 073E8986A20; Fri, 24 Feb 2023 22:24:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B19789867BA;
	Fri, 24 Feb 2023 22:23:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5N/hTByK7tmPDZtFNPGUnXOtzWgCDWfenHXNjD03Ko0WLJnw/2aEf5l3T1b/+hBcvq63bGyAdlpxobEABSvCmTub9UFNF2WJ73Wm/5vU7b/yeewH9FiWHZlcYETvZZr+EhqNPVnq0LXgl7JJjB5nohAhT5ivBOGZICjfdiV3pOOF5Ztz2AUY+/r6uQMfY/dENoknUaHVdGhX3b+YEEiSWHZxSthm8kds0aLjWFcZlJ1x0vuZ25ezLnWdKqNHxg75PgJEtiZD0lppE4ZoVcfml69BTTrzJjcf/xigVAgIZVyNiDG9XsfzRJsYRjUxJpjzd1JcFqwF/gEoWtrkeLcLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJISKqOQFqR8eLYSElBidvftHbEOyYMBwpb1E61nRpQ=;
 b=AfIzisMiEX8KZ14rmVoqA4a++gJiXNxmPtWbs3t3U7GREde8j2mDJRRkNgSqvjznXfwAPuSpaoNZ8QFPr7kA9Ep/mEop/SuwM8k7MCsiMMhtLksqwRHfvryTPi0CpKm9H3tTQIRHKq3KL2tDhooi6BXyF42hB416dAipnJb141lKb4HR06dO1xrIU3wl23RsSo2p7OdMdcj41oamAyb3TaVUlbylpaKRJT5eXXDXvE0klfhsmnL49NnKD6+UNxys7BWqAgnbTvmRwwlfc6MmstThq6Xi/0ljn//DPQcJdUIxZVCNsp7N6Y4tMGPId8A7HyG6B6red9ayeojPXfV+mg==
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
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Sat, 25 Feb 2023 00:22:15 +0200
Message-ID: <20230224222215.339715-7-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT069:EE_|DM6PR12MB4154:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e9e8aba-52a3-4704-a1f3-08db16b5a812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u7ThhL7fPF/OW4mCLPTM9eD+S8dZbE38qNqOggQVEAk4OMC2ZNh9JbiqQzS2ORTSW0GOM7gE9DLmsw/DDSQBI90YI+JFdnc/5JuArDAqTUWv1r380HOiQixTNiqD2legRnNh5RUt3oVHNt71VVQ1sKaYr8rvUX68RfBlwTVQMuxgc9j0RojWc7j4pkIUfmI4wMy3glgWi5SOUYFVQwXwsUZCw6ZUlq0limb/985QGYA9Mq+sc733V7YR/WJuhbDHTUG3Ukb1+/hE3IZHygPub62Cht9/XzyaX3YkNsN8FN4D5e7DJoumBEBRX/7GPG2ovk87uav1RTi+ULUShAsPA4lFoo2okDDG7VQG4ypYaIcYXpvRau9mDxCgEMl8A35Q3nPs6Lby7EkCKeiRYO8kjPqAMmgSlg4aZ4epZS7WNyU2CrJwAaSXpnFOJmPwsV390QAZjhoP0aUtNsfzZ3c1ORy/AHcTfBxPJyfpT6ItU5X7QBg9F5ETVyL92BpgifOtBvREr8NTOpSJRD9me0TUoBR6UVcb2MWgjUuTrEcXnWhtLJjQ9ZdtvnX492/BCLs3b2AofWAmTjPzCvnwLte8twhYGUfKjgR8sgvyvss96PvUHwpY3ZUqYi/SxnjIG19mZksH/tAmbPNxzX8mrkPVUU67tyANZPa6RRX3Fgi+ecUyTISejLrfvT7skcQFzWKRyO31r7XD9EHS7KMu/i4WsVOXKivYVvlennaYdP3cuIKnr444OKIb++KqC0O9P6+AH6s4VtlxkBK0xsydyW8VFw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(83380400001)(426003)(47076005)(16526019)(2906002)(36756003)(1076003)(107886003)(6666004)(82310400005)(86362001)(478600001)(54906003)(41300700001)(8936002)(110136005)(966005)(82740400003)(34020700004)(7636003)(36860700001)(186003)(40480700001)(26005)(336012)(356005)(2616005)(4326008)(316002)(40460700003)(5660300002)(8676002)(70206006)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 22:22:46.5711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9e8aba-52a3-4704-a1f3-08db16b5a812
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154
Subject: [virtio-dev] [PATCH v5 6/6] transport-ccw: Fix spellings and white spaces
Message-ID: <20230224222215.scheGgrKVPQWQFbeLYzTREghsmwc_osgoEc5X9qj2H0@z>

Now that we have individual files, fix reported spelling errors.

While at it, remove extra white spaces.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/157
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v1->v2:
- remove trailing white spaces
---
 transport-ccw.tex | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/transport-ccw.tex b/transport-ccw.tex
index 93401a4..c492cb9 100644
--- a/transport-ccw.tex
+++ b/transport-ccw.tex
@@ -56,13 +56,13 @@ \subsection{Basic Concepts}\label{sec:Virtio Transport Options / Virtio over cha
 \end{tabular}
 
 A virtio-ccw proxy device facilitates:
-\begin{itemize} 
+\begin{itemize}
 \item Discovery and attachment of virtio devices (as described above).
 \item Initialization of virtqueues and transport-specific facilities (using
       virtio-specific channel commands).
 \item Notifications (via hypercall and a combination of I/O interrupts
       and indicator bits).
-\end{itemize} 
+\end{itemize}
 
 \subsubsection{Channel Commands for Virtio}\label{sec:Virtio Transport Options / Virtio
 over channel I/O / Basic Concepts/ Channel Commands for Virtio}
@@ -107,7 +107,7 @@ \subsubsection{Notifications}\label{sec:Virtio Transport Options / Virtio
 Host->Guest Notification / Notification via Classic I/O Interrupts} and
 \ref{sec:Virtio Transport Options / Virtio over channel I/O / Device
 Operation / Host->Guest Notification / Notification via Adapter I/O
-Interrupts} respectively. 
+Interrupts} respectively.
 
 Configuration change notifications are done using so-called classic I/O
 interrupts. The initialization is described in section \ref{sec:Virtio
@@ -413,7 +413,7 @@ \subsubsection{Setting Up Indicators}\label{sec:Virtio Transport Options / Virti
 \begin{itemize}
 \item a summary indicator byte covering the virtqueues for one or more
   virtio-ccw proxy devices
-\item a set of contigous indicator bits for the virtqueues for a
+\item a set of contiguous indicator bits for the virtqueues for a
   virtio-ccw proxy device
 \end{itemize}
 
@@ -563,7 +563,7 @@ \subsubsection{Guest->Host Notification}\label{sec:Virtio Transport Options / Vi
 
 \drivernormative{\paragraph}{Guest->Host Notification}{Virtio Transport Options / Virtio over channel I/O / Device Operation / Guest->Host Notification}
 
-For each notification, the driver SHOULD use GPR4 to pass the host cookie received in GPR2 from the previous notication.
+For each notification, the driver SHOULD use GPR4 to pass the host cookie received in GPR2 from the previous notification.
 
 \begin{note}
 For example:
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

