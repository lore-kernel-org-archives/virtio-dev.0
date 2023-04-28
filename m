Return-Path: <virtio-dev-return-12464-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83266C77B61
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:20:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 792DF42A64
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:20:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 736A19867A3
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:20:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 12B7A9867ED; Fri, 28 Apr 2023 04:20:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 362DF986688;
	Fri, 28 Apr 2023 04:20:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1DIjmlxyJuj+uXvy3us0I3uF5QMshSug/wgdr7Vp+R+zCRQPMMU6ad3AKJeiaIocQqLzYAFyXORyx/mwaX4HEOmJzpDY9BYfMxZbd1ZBo5PtynMiz7ZqOPbWMNS+PIm5QqMBAFkl+N+LqqgH35pqgzvM1+oGAWzZS1fApsOWCZiaq/pjONHuOrn4oWDlq4rYeXDBjCRnMLU6+oRW65PDw6Bg+i1DbQV5zOLkeiOHO+t/Vg/7wTmmjemUPsW/XzybyQWn+qfxgClhmCzwo9autUA54w4mQCiV7qt108dlE6zQfzRjkC2MLQlvTKrqwWswJ6plHEWIhV9aOPNtZCtdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ypIHDnxwvbkyVrQdDR4aZIdeysVL2OsNjDB2Tc1tU0=;
 b=PmaMF9Gw6svafiMQSyhzfZtZftDTnzig1Q/Z0mnlkDbj0rkwFFcx/o8uRmqRBui1oD94FQxuSlJrlhhfvL2qNAKKBLTpOrtbcUsUUL+RPdTkn3tLJRIOahRh7xNcyWWXAkOp4YlZiPzYB1/DeDgyBDiDm+QaFS+5DhauIZKg2RdbdZ0YQhgS/UPI5PWhTn/TGiyVLOPB2pvrvWx70+lGwQ/OzeUl5fPbRBJWP3johipepWhowG4T4KQ7IGh//c5S2YeNGN7jmsClbDMQx5vY6AEcji6MNgHM3+8z0/NBHZ4FrPGf58DOJpKCk58PUNW9PFtKQchDGJl8WtLWTTll0A==
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
Date: Fri, 28 Apr 2023 07:19:42 +0300
Message-ID: <20230428041949.411221-5-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT068:EE_|SA1PR12MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: d4d2e633-8815-4f75-3c6e-08db479fe0b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2cZlygDE3UTYvnu4S2rdGyeBAa6zphrPOYWMkLqoCE8lVp+WQKWkUDn+2xWM7xGFSkhJQ1yBDzCKd4LaASdd92uh6dXqr8TxkjbMhtx3znF0jlcF0JJ8bH1c6THMuoEOOuZn3CX0AnfUzD+2lT47ty67xqXVeZDUDC2TzfSi1pwqlH4y8eDmrEyipAREkd6piaovGVP9E1fObdFQQQyYWc6FByzdvSAmZbrOU940QUH14lG7xkYRsIjroDaatv5mWdEgVw2F9xQMFrosYoua8qL+hQPVHiZPPcJU1V8mSWStj0PGobzfPn3er6HrW9EbTkBFXI73bgkOmumfbGDdct9SIYQPr13yKd33jV1S+HJgFN80nuJh4EW2aR2Nl+tGwOL0qTycU88YOr/144GOwXC93fYq8liFyGc+zzGTFK/Zv+ZxgeW2yd03rglx/S2ZAd9sh2o91GN2cJuFpOwiTjDdoivTqLQTwn8atsXx+PMiJiOQL1UhzH9teX18usRwPviyHFUQnfFFrEykVw6TXwIzwXWRZPxT1hVlKZuHpEVN/CWjjsPdo9aL0x11hraDY7VMEH61sIsl7QPhRB5wnfDQkKJGQ3zRbAUIBvLUla3VwxmSzXRndBepBQjrD7x0woUiz8TcJILuN8qfvxHVTafuOr/p4GqkvrdKWoiR+/upAh175gT+2nqywsHvFkdybxGcgqCB+egu7gIhAWi7bDS8/hYFAZU2gONmv/5j6wXNkkSAzQsp8/vIAtkm6OM3ApSNfND8bEwoYNEN/6DcDA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(5660300002)(70206006)(8936002)(70586007)(8676002)(356005)(41300700001)(7636003)(316002)(82740400003)(86362001)(4326008)(40480700001)(107886003)(186003)(26005)(16526019)(6666004)(1076003)(36756003)(966005)(36860700001)(47076005)(83380400001)(336012)(2616005)(82310400005)(2906002)(426003)(478600001)(54906003)(110136005)(34020700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 04:20:19.6528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d2e633-8815-4f75-3c6e-08db479fe0b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6896
Subject: [virtio-dev] [PATCH v15 04/11] transport-pci: Avoid first vq index reference

Drop reference to first virtqueue as it is already
covered now by the generic section in first patch.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v11->v12:
- drop changes related to vq number
v9->v10:
- updated commit log to drop reference to old patch
v8->v9:
- reword the sentence to avoid future tense, like rest of the other
  fields description
- reword the sentence to avoid multiple verbs use and put -> uses
- use shorter name 'vq number' instead of 'virtqueue number'
v7->v8:
- remove note about first virtqueue number
- skipped Max's comment to put word 'structure' in same line as its
  crosses 65 chars limit per line
- reworded queue_notification data set line, as '=' and vq number
  wording was odd
v2->v3:
- addressed comments from Michael
- changed vqn to virtqueue number in the Note
- refer to vqn field instead of virtqueue number
---
 transport-pci.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index b292fc3..51ed191 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -1011,7 +1011,7 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
 The driver typically does this as follows, for each virtqueue a device has:
 
 \begin{enumerate}
-\item Write the virtqueue index (first queue is 0) to \field{queue_select}.
+\item Write the virtqueue index to \field{queue_select}.
 
 \item Read the virtqueue size from \field{queue_size}. This controls how big the virtqueue is
   (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues}). If this field is 0, the virtqueue does not exist.
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

