Return-Path: <virtio-dev-return-12297-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4915FC77B76
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:48:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3A3A3419B1
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:47:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7D50998696C
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:47:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DC04F98679F; Wed, 19 Apr 2023 01:47:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A8E0A98641F;
	Wed, 19 Apr 2023 01:47:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8N6gE32BKFGlTubFkutBAJsW7XrbDxP+G6Ts71E2Rw7QExkcc5KOUYBfM5KQzM0t3/WfeTwG4qGmOLpFvosb1NkjRTCoaMYRa0T9cKYz1gceswMgkN8vTs64VcjVhLgunUSCzak48MeYCry6gVUiN+ukv/BWtLqTCHceBhb4uII61mi4JeiYmJUrhuNjJhcn5Y3b3KExqNk/Smrv2Corkfw8HCyLkNL6ie39Nh8GRi+2lgqQIZ+ikjCzHx7So3dRa8yRvF9v3IqHeed4I1Y7JuszheekS3HrLbMzGgYAibU2qA5KwrshNLR/B4I3uQuw6lIovYvI6Kv5Rp7Tacv5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxzCzbIHOKfFXnhauB7vgKdZTIcJKwajwUkrcOfRVeg=;
 b=O+dTQ8XCWUiFKhJ92NekLhwnWaB5/IPkoDcxqTTuqDr6ga3U1AOPkGfR1Fr15+RC4hm7CI5N67P22bGRduRI7nj+SUoJLjV1I8L5j83hle5OJ0AvXj4atVg/ohK3f9dSb//rUr3vUDErC+FmNS+niR6wrGUdXgvKE06dmpz3S2T6ZisdZP09n5ZltbeDShcZO/wjU5CIYYbJdJBCSIa/EHqMAYkmMgIdTT2MB/lDqh5OnSEm+bV5T6BLSoDX46zhOrAJMdxcb+UReMy0cFApCqT0ixwEOfsKXEf/wXB5ypnMGysFs+2ny2IwsdNrSas+qQRL73NYQ4mPb9cU+L5Jsw==
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
Date: Wed, 19 Apr 2023 04:46:30 +0300
Message-ID: <20230419014639.919458-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230419014639.919458-1-parav@nvidia.com>
References: <20230419014639.919458-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B9:EE_|MN2PR12MB4376:EE_
X-MS-Office365-Filtering-Correlation-Id: 10085d49-4f54-4857-3d3e-08db4077fc6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t3osVY6JiEvPIxrXyqIs8Hb6XDuEtQB9AQSCi2MvAYwMiiqlROAZquklV8HuUTb5L/Ffkuq88uiAXUe637R0fWTQQpj/HYRpW234WyiMCrAMfP4zHJQqknklSKUhuPQuoZkIF1klY4WGL86CZ0dhdBYcALzZZQAKDqwFvjnuatblExOEeIk9zljyIzHefenTLDz3dxvLNkcLiAor8XfKLozxRlV0jaFdUFsvbzUZ6VD+ZpDhfVEzaMbgNv5OKGcIgk9rz2keeqAe7OqOv8LskuvEfSj/nVhGIq35aY7OGllKEuMbjycv4DhX4GGANYLaKFOozcDlizJm6AyZiR61Du/LebsYw8h/VpgM+10GdXdZdQhoXDISlPgoxqUDto4qOCux98NHtrA7WEzRFU7+1yYCQhmMOZpsTig1SyCgoVsX3MJMl7EqkMS2bjTEOzJmVFuYm0ACRl445pSJSivM5eD/i/UsQkRO0RXZCSkPxNadVEauW3uOp0hBqmU9YigzciohcxISY82nnVKMNOLMs/uvZ/li+114MjU6bAXDjFiNv2d2Aa7rTpbbNsTygN7HDTpa4YnpDPN3F81r+Lcr3y/xyg+aYauvzWaY6bD5vZemTXs+0WoKpc6sW7ouxzRj94OUdMzQmyk/m0u+OiTs5EH4Hf/yKMtt+d8RgnChdUFDRp/vX9oxvrRS9T9YCQfdBiPYH17DszACk0dG+I94WA6jVp5fuzDBNfRPOLFYNBSNmQSyD/QBicOJ3oO5QKIy5iZ1bKmhoIV1yyGkGCJVBrYnO2MlDdHHzMa/aCCLlPA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(316002)(4326008)(70206006)(478600001)(70586007)(110136005)(54906003)(82740400003)(8676002)(8936002)(5660300002)(356005)(41300700001)(7636003)(186003)(47076005)(36860700001)(16526019)(336012)(83380400001)(426003)(2616005)(6666004)(1076003)(966005)(107886003)(26005)(86362001)(82310400005)(36756003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 01:47:08.1132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10085d49-4f54-4857-3d3e-08db4077fc6a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF000145B9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
Subject: [virtio-dev] [PATCH v14 02/11] content.tex Replace virtqueue number with index

Replace virtqueue number with index to align to rest of the
specification.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v11->v12:
- new patch
---
 content.tex | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/content.tex b/content.tex
index 43be58b..e79d722 100644
--- a/content.tex
+++ b/content.tex
@@ -405,7 +405,7 @@ \section{Driver Notifications} \label{sec:Basic Facilities of a Virtio Device /
 
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
 this notification involves sending the
-virtqueue number to the device (method depending on the transport).
+virtqueue index to the device (method depending on the transport).
 
 However, some devices benefit from the ability to find out the
 amount of available data in the queue without accessing the virtqueue in memory:
@@ -789,13 +789,13 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
   buffer notifications.
   As mentioned in section \ref{sec:Basic Facilities of a Virtio Device / Driver notifications}, when the
   driver is required to send an available buffer notification to the device, it
-  sends the virtqueue number to be notified. The method of delivering
+  sends the virtqueue index to be notified. The method of delivering
   notifications is transport specific.
   With the PCI transport, the device can optionally provide a per-virtqueue value
-  for the driver to use in driver notifications, instead of the virtqueue number.
+  for the driver to use in driver notifications, instead of the virtqueue index.
   Some devices may benefit from this flexibility by providing, for example,
   an internal virtqueue identifier, or an internal offset related to the
-  virtqueue number.
+  virtqueue index.
 
   This feature indicates the availability of such value. The definition of the
   data to be provided in driver notification and the delivery method is
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

