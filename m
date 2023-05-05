Return-Path: <virtio-dev-return-12560-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B011BC77B7C
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 01:47:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 13E151EDE5
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 01:47:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A3788986747
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 01:47:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8538298684E; Fri,  5 May 2023 01:47:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 055899867E6;
	Fri,  5 May 2023 01:47:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kB3bf6xKwarAzq4Te6v7toV9xAy3I5QU/3Ir1gGqKPOjOXso8Io4hYdeBWE0x1HhNJUpSkwfcrQ2BoKlMc7nQux19vXCxrfUxb5NSkmFVvFBCBPMuRXmSvTfT9e0Rl8ZsNkW6QMgGZU67dQT2XFrEpVjaluozWpbLlHCqFb75CR6ysVtfDij2OVKWzKlzP/kjd3rBW+2b+yGEOTYZW6KuY6/U1fIXZqQjNOUr4g1Y/pl0Xl/m2bHnykIqJnizt0jK+cnGoUPxO6g0GXpvWTcuKRUD5R6aFc7wWtiFo6EdltsOU+JQVZoDv0eXLg//P6v3NbB9YbBSeP26Talz/WFDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yp/HRgx73sdms51z9hQb1Q7RbOO6ihMD+zx9f8sZu4=;
 b=mL7hyC9yoZbb6AQNdCjO8s9YDrWXTRQzmkyZpfRih6klzNVl1zPm5tGeVnJzkYYi8TBj1Y55S/PZk9o3qv8KpUl80+mDoB60ihf+2rNyurq9DIZFOK7l+pa7GYtTS7xQnnStYWPGUBr+xQScLXn8HlLk9as4yE795bUkJIOgtvchDv8N3MVcFnELimajgDWxl5Qwr/MTX8wa36ySYOacwzQMk2ZogQ/DTqqF9R1FDUUGYUVm3F5HXoqmXE8XYER4fXxCSRlrxymrZW6JMyShwbN3C2uUT12p5lGN+TqChhY7pBQeY6OoCp5xxMGKY1TmMxqgNh3/a+AXqlfu1mqEDw==
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
	<david.edmondson@oracle.com>, <virtio-comment@lists.oasis-open.org>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Fri, 5 May 2023 04:46:05 +0300
Message-ID: <20230505014614.571520-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230505014614.571520-1-parav@nvidia.com>
References: <20230505014614.571520-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT088:EE_|PH7PR12MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 652871b3-4b3c-467a-d9b3-08db4d0a9ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GCguGK/jFViRbpE8QSm+x0AZetbzOAiRoJfIvL+ZCl2MeU7owNn/MfLna2ov4Z4hQkuovBThP4XKYGZqOndO30E8l/DDVcnz2ofJwdPUcLhK2L2r9YW2XVaSv8LIqAoJ3i4AlsbyM0Mqx6Z6+6FrmQ2maRviph9po38xtoeRC0MG7+dwxyPG/2NdXXO4PIqCeAnwa/xGwFMlQYvqNtkLKeNU+ArgCRJMyP2FKVBlpKuYGXjSY7W9FpgxwTUZbwoRMKi4g0Fy8/FvDPAUqtseF00UDiAipgwIP+lF3ta9MmFpBbLWx4xMC+Rco5mqM55u4eeJAOU2PHnHzXglasD7I8TJF2PAzO3iCR44J199nUD9bYBOhys3UXFseNNNQcw1qtzARozKmsvauPgjuMAfOdNopxmd41pr8LW4RlHavUqlYIaf3nbLKCRUO0leWe51hUDp/+4pQpgEhwekB5+GwhgJRBbqjE4kiOjko+/THPmSsrZeXEtdsxD/UgXbHJ5KGOIW6yLKGTCQ1TdyW2ZUkEsyFz5pzTbzpeEetiW9SlgnLQOOdtfpybpI0VkamAQ8o6AAzZvZLCJo2pcZKE4KP+x/PtQMgUqo+j2PvmgLRrINHUA64jjdr/sdADVu8fOfG/oDRC/OQZcTNM5rTxrfYrMXHILBk+PPcJyrm2G2eqrfo7NVrAv0zRQTFNBD1w9hVNE73bezLM5DZ+bR2ARRXN+2ImrlgZEaqVN344I3zeObIz8US0aikxqFeSbSbleX
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(110136005)(966005)(54906003)(6666004)(16526019)(186003)(40480700001)(478600001)(86362001)(40460700003)(41300700001)(356005)(2906002)(7636003)(82740400003)(107886003)(36756003)(316002)(8676002)(8936002)(47076005)(83380400001)(5660300002)(36860700001)(2616005)(1076003)(4326008)(70206006)(70586007)(336012)(426003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 01:46:54.5089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 652871b3-4b3c-467a-d9b3-08db4d0a9ae0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8153
Subject: [virtio-dev] [PATCH v17 02/11] content.tex Replace virtqueue number with index

Replace virtqueue number with index to align to rest of the
specification.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: David Edmondson <david.edmondson@oracle.com>
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

