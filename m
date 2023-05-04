Return-Path: <virtio-dev-return-12532-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0BBC77B7F
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:30:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7A3A31318F1
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:30:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6BB349866CF
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:30:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 61FC49866AE; Thu,  4 May 2023 02:30:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4CDF59866B3;
	Thu,  4 May 2023 02:30:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zv0Jlc5O1zvLa5ThtDCqNHehhup4Ke+ir/U5Z7mQmDRu79XrmtJB7zSvrJ688bjjZqaW7yAiqjFAJ1Co+AFOu3Ghp0btznLHIpqwuC/k4O3lStFdqfvQY9tKzIojcNqtJj9jh9U6hO/R615XpZSlsXLxLL+B+h0xYyAMPzuK8JfjnXVMu4IXuyr8WY+4gdUFQ6yZsSNc8qc0pDGUMMkH9+wD/hTc4OpLyNvXXHwstrVQ5zJzvTr+dFQjr83CkkeALhzfN2TJuEtlqvBi89bCtWDfjPrIqakJF3pv89oMehOavN6IS4yYxOj9XLQCSN1VkL/0Z25/SQFaAHee2emrOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnK+pcLQEhB7rIeJo/QJ1WomcQxat3ianhPBI/Adc9Q=;
 b=QeAanJVhCEsXenBlks/w59Tfqof2ud8l7jM7GLlRrLjjNXnIyldpr/7vnxf9pBUR3Rb6Qcfy/qQyKMFTlP0dTI33moyVfgiJ9NZ7zDfsAgg3b0qt9yPJf3B+D+f/l/EzZToaUVzTViPU7xzNb4pW3kQ4nRTroTRObUGiP5Wv46QlbeZKSk8wYpTaSEb4+gHOM1zzHocKx+rGgUWThoS+qN2V0Sr4vd2NKdMUyr3A7cwpGoxTwDJU8MKvZ5ffN1sxfAeekIlBNoNirbKcZtjhgd850K99BnZ6FvE9Ma+M06hTVr+J1Bi3j6YSb9/RDgwL1RmrFk/Ttlsp7wjUN+A3rA==
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
Date: Thu, 4 May 2023 05:29:50 +0300
Message-ID: <20230504022959.547025-3-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT087:EE_|IA1PR12MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 041e8ef5-efca-4db9-06b9-08db4c4786c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ntssZnj+bUBHwBWIFsdih5HCgo84+oIn/l5e6S/wAE0b+PDepw0BqEmaulAoEE1JEJBrI2y9wH1PSvKqZUy6NSVA18I5clrmbKjQlZA+fvHExdH3/B9f69TukYdolC9ff+PV01wu1TGhecAcjQ6exsw+q9CPTN9239yjm0LKTsZc4T58QedgDmbMuGyTOFcunqyasANssiw7hewBYqU+w8cWAAwQR0ansW4Wft+oS5lZmWqCwz7W8HcIlfeXaaVuFoA/2+BCbMs1lLGmBV2vGZLKgJ+Bx+pWwiWkuo9e/GmM+9xFZsbl6FNdYTjg+lCnVjTkvBJ8tFoGLNhnDEvlM+1JmAHZzwJ0EKh7DqZqU+1TW2M1ViBQgx+15iREc0ZnuvupsumDcrYTZfty0wXU9JLjgXLh5BgEZMOoquPrNnD+tEvPFma1ktzCBmNffLSufRtut4zgWFKwPTWu0fD28SyGZCxB+2dpJQW9vtl06zcuof/HgkWP1C7necQHYpHTp4bAqmYJGdoOHo1UMHYxkCkpY1LkC7I0+Xp7z4Byw7Rk/IXUjxQ7zdd7H77wIcH4JxUudXlulqZp6Lf1rOL9n6+UjKEiFaLEbyJXrNYAX4zfZppNpqx+Gnq7pQ0DLXKVTHyyqnnJOJ1seEw3ejJ+6ZFwe2XIe7KC1gwJaA2fDIsbWZ5e2jWkH4OYCXFPtEIQWW+NS6GPBI70Fpn6x+uXmCpbdkLSwdrrsZjNNYP7Zb6y8ViIi1JQDsQEy7Lp3avQ
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(316002)(41300700001)(16526019)(2906002)(186003)(1076003)(26005)(6666004)(36756003)(54906003)(2616005)(110136005)(82310400005)(83380400001)(4326008)(107886003)(336012)(426003)(47076005)(70586007)(86362001)(70206006)(36860700001)(478600001)(40460700003)(8676002)(8936002)(82740400003)(5660300002)(966005)(356005)(7636003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 02:30:28.9371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 041e8ef5-efca-4db9-06b9-08db4c4786c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7712
Subject: [virtio-dev] [PATCH v16 02/11] content.tex Replace virtqueue number with index

Replace virtqueue number with index to align to rest of the
specification.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v11->v12:
- new patch
---
 content.tex | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/content.tex b/content.tex
index 9b694f2..9cf938c 100644
--- a/content.tex
+++ b/content.tex
@@ -406,7 +406,7 @@ \section{Driver Notifications} \label{sec:Basic Facilities of a Virtio Device /
 
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
 this notification involves sending the
-virtqueue number to the device (method depending on the transport).
+virtqueue index to the device (method depending on the transport).
 
 However, some devices benefit from the ability to find out the
 amount of available data in the queue without accessing the virtqueue in memory:
@@ -790,13 +790,13 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
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

