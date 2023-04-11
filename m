Return-Path: <virtio-dev-return-12145-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC28C7619A
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:25:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 581DF2B023
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:24:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4F8D89865FE
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:24:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 43B189863A4; Tue, 11 Apr 2023 19:24:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2D2CB986549;
	Tue, 11 Apr 2023 19:24:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5cO71uKLWlwhA8IS1TQcdd7WVGEYjujC2dOLu8qSJvEgGGPTj69V+52KMH7+V/wTPx9fbWGxrUhbP6lElTE8WvIZvGVhe8DgSgl5tT1G6otXwzepr/1uXg1dlyKgf9HjBdQAAF5QIFKpknGZVI0XzWP0uQpJD/oBxC/kN2QWsQRmSaZ6v+MJloRs7FUyL3s3z8X+MVsTeFKLPPemZTc+AK3ak9cLrIHqwQkX8dgXuxp/tevYuq7lHfZa0szFB2w4M2D+ZuJeoAzuWYkpf3QZWDUsuDw9xpQaKx8bT9gVwmKCe0kP/qXhwCWAIsn+hnHFoxhoS8essKc+wbFGkz2GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxzCzbIHOKfFXnhauB7vgKdZTIcJKwajwUkrcOfRVeg=;
 b=Vq91wSLBS74K3KPOWysUaqXqMbJWxGUzFUPFHI2jsLMVyYoIxNL2Sru7vj53Cl2oZE/OVG9KDk/Z31o8pC9t9N9skeh0z3wGSie1S/IP920blfZNqPqW/NLF2lsJwCCxeWrySqNKQlvnj+GTSTpJ6QIxVEcfx6dyWrYgfsF2+ClQuQZoTGRJAEZ/osdg5Kz8Me2quPAEgUwlz0m9xOl3AOFGz3o4nWF1AmqhTjd/zUXtb0qWd5iH8wA3gtu8U39HesLdKd4KZO+sLISbislMF8CS7pyhGgapKHpcsKQXqQkrY6IQf4gYhwuRAWm7TftCj4sEkhEbX+YQa/JnsHbXCQ==
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
Date: Tue, 11 Apr 2023 22:23:32 +0300
Message-ID: <20230411192341.751841-3-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF000145B9:EE_|DM8PR12MB5477:EE_
X-MS-Office365-Filtering-Correlation-Id: ed0039e0-d228-43a3-7373-08db3ac256ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xakywkAT1NemI21NQgdsj6y3uNm3e5Z6J5SRJfn0irFXipLlSrizs73GT1vZAEzkRfSxOjoJDZv357++1Jth6+DDQForAv1ISSkzokhELL7TRsvVXftlKF7bewgQRRH5+ImBEBIt4jdw/jQFIg13cl9GjUT1iTXCosWfoVIDiTbnR7TazY3MKIRKdq9q2bV+bepi3ovaCTbdHABj0mEeFiUo6L7fsf2zvkvmqCv0VHb+c7ofVh0z6k9jn3pdgQN+6BdAJHIFdeVPhWbqbdMpDVhnjSEebrEX3roOYJat1H9uGZ09cRi+71F5kNXkAEmBCLBLVEv0Mkzjknbzhi7Ah/R6UM/9kntBH2O1SBzSYe+KGI9RGyhocNpIK/tyZ2mmZNp/7hEkwJ56KHifrNFiRR7QLNT628SW7YWoaRmXbTsLQArIwhtvqUewKE7onx+ojXS2RW1AowvHt2AOOQYqpoZhnbv9ShM3Dwj3DEoOR1vQ3faXP93aVkEHR5rqZJg23BkgHks+/2Hl3jOQrQP/ssrKWwdmdxuBPYEju/rqKP8g/V/S7DM8Lews+7G/l0aqk3LoIqWbFy5NjpVYMxe4gVBrbnfVLpDTIDPFDUtR/2Nr296eVXvtgkihoENPiIuD3c6HpYQDHqQ+njZYwTdWPLDLp0dLNZrJTs4MFz0TX14RVWwEBLkcFctQLwRaeDUR/XvTWKuzKXzRhv9G5pvHwDaXHYh+i/A7o5KbAEvgH7xHm2nGo+Ioan39HLICmdDVNmbV3JZK7StU47uxs7L+oBvOcuLgktpulnM+krX9t1Y=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(36756003)(86362001)(41300700001)(110136005)(70206006)(70586007)(316002)(54906003)(4326008)(6666004)(478600001)(966005)(82310400005)(40480700001)(82740400003)(5660300002)(8676002)(8936002)(2906002)(36860700001)(7636003)(186003)(16526019)(356005)(1076003)(26005)(107886003)(426003)(2616005)(47076005)(336012)(83380400001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 19:24:15.3209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0039e0-d228-43a3-7373-08db3ac256ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF000145B9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5477
Subject: [virtio-dev] [PATCH v13 02/11] content.tex Replace virtqueue number with index

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

