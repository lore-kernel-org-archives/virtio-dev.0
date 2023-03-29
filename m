Return-Path: <virtio-dev-return-11847-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B719DC6FD18
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 21:24:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D7E60F3F57
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 21:24:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CEB4398654B
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 21:24:24 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C4B079864EB; Wed, 29 Mar 2023 21:24:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A8448986547;
	Wed, 29 Mar 2023 21:24:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8VUmZ338WhImLfbX4nwJET65hByRPKPoiYHa9Vw4NP/kuyA2M6H/gak5uGrmFia1NlNt6Z/K7/XlQj0CRuQqXYmoh6AGvzq5iCVsCaMnGG3dYbuh6FoXDEUQ/3xSsJ9OglrBi4gTC/wUfTUjKqHGU2k1IyEK1wXvQUZN2TppL1ebnncZJ6breRWBSztdAXEchTyScfTykhSQCFa4uCLzi9kVDG3TRaEMg+bo5s+qV4XUFFdizUczXHF2S8w8VHPAvR2lOL+LJc+RNKT+4Rb9ggm5r2YYuQv+vIic5/ZN9jtuMFS8+1bdvJjmfA/HLcjPMlxMMspeLNH65oT3JE/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5yzW3jc6X13b0m59miospBpOj5X6WhfnZElVzmGSbU=;
 b=GX1DctDvVS1RyYQF5+fiBAPeMV/sp1qyxFZ//pxDtoN8nBB6Nz03uEETMshxirQBjOCE4ptCGHNm1cm43Ik/ZtcMmJCRXMFaJ5QDq5rEyT4Ps7L791hRtloRZoZvNY8RtMr/ZwTDWNQqRcadooxz6PWVu1KjPrIl92yb8qU8yGS4abLkt56+xUWwA9R8KNV/va+t0NMVqg1Vi2YpflnNGSK96zk6/LdYJOvxzGEtIuvB8gB4YM8r0Rxx0upz0AGmzGQHbxk4qK4Uv9r5p6wi3RfnPFRnUFfdR88z0lCl902JJoqPzbHRS+TBmYkvgaySGj/GPRP5MBniQmDP1tk6HA==
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
CC: <sgarzare@redhat.com>, <virtio-comment@lists.oasis-open.org>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Date: Thu, 30 Mar 2023 00:23:35 +0300
Message-ID: <20230329212341.465843-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230329212341.465843-1-parav@nvidia.com>
References: <20230329212341.465843-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT022:EE_|MW6PR12MB8997:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa142b5-100c-4ac9-e42c-08db309bed21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U45UVESpDNHjz8K3BVBirAjKwLyH4TsPsoj5LVhda9GaeJFG4ERSe4EbaMtQiYZFAW4qPuCXOebUCAuMm+OR1LPusTGSf3Sqvj5WDdlI77vrj2/rOLcuTY+/3EjsYlEXOUlSyiUQVmEkVV1nWm3NSWQNRQsdMlYkIb6zQdV5JTykJUCRq0mIchUdQkjmYzbz924rHftqSOMRckVt30QHSYQ9h4YVcJWPUEUZ6yRfY4fsg8xGXQ1ayhfbp43ixByxYPXlcenh9nX1rnBEHOx0y/83fE2OFEbG5VVvFnhegTXpPG82ZFGrruJ8CA0YWzT9wEGP0qQpnFTIjY9C+mVsgcOBkjYNiVmOguCZkbwzHVtjNQ9SWF/qRryOseuPfU/IBtRuCXXjhMH9GU4DgXZ691jmBbRvL3t0hz5H7HLk3OWU1pWapxvN4VJ8RDEc2zWKMU9iXJPyvbznfDCam25i2X9LeocZG6Bn0P+AWucsKILFCNNlsicvYJoEnilaFvCqBHWoqcbUPrfTf3AmHIAxa+OUpIkQqu9JbnlV9LcDHB1xidJQV8X0FOD4Pht7qiaboXsvaShfJiZ1Z1UcwajT+5SIh8wAfunSekI5AJkAJp5dLUM3FRtVcIccxwWzFYrU1Pd8ZysBvryyHGQ2mXdqoWCnVjezdbHiCcGD306IDt0a4yBBvajtY4uO29E2l762kxMkq+ykXFjZbEshBwZ44y7Cy3L+la4vTxnGJFlGzXR9XmC+h6xRFZtdN/WlEROwfPQQWGWSUdaD1EVaCI/LZiRQep9M9HaaYWfjrwzbEewmaoZAY2E1KB0kpVqaOic/80rVsb2sRbjqV6Xhkh+AWw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(6666004)(1076003)(356005)(7636003)(82740400003)(107886003)(26005)(966005)(2616005)(47076005)(426003)(186003)(34020700004)(36860700001)(16526019)(8936002)(5660300002)(2906002)(336012)(36756003)(54906003)(478600001)(82310400005)(316002)(110136005)(41300700001)(4326008)(86362001)(8676002)(70206006)(40460700003)(70586007)(40480700001)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 21:24:05.7511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa142b5-100c-4ac9-e42c-08db309bed21
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8997
Subject: [virtio-dev] [PATCH v10 2/8] transport-pci: Refer to the vq by its number

Currently specification uses virtqueue index and
number interchangeably to refer to the virtqueue.

Instead refer to it by its number.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
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
 transport-pci.tex | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index b07a822..0f3a48b 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -390,13 +390,14 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 
 \item[\field{queue_notify_data}]
         This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated.
-        The driver will use this value to put it in the 'virtqueue number' field
+        The driver uses this value in the field \field{vqn}
         in the available buffer notification structure.
         See section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Available Buffer Notifications}.
         \begin{note}
         This field provides the device with flexibility to determine how virtqueues
         will be referred to in available buffer notifications.
-        In a trivial case the device can set \field{queue_notify_data}=vqn. Some devices
+        In a trivial case the device can set
+        \field{queue_notify_data} to the vq number. Some devices
         may benefit from providing another value, for example an internal virtqueue
         identifier, or an internal offset related to the virtqueue number.
         \end{note}
@@ -1005,7 +1006,7 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
 The driver typically does this as follows, for each virtqueue a device has:
 
 \begin{enumerate}
-\item Write the virtqueue index (first queue is 0) to \field{queue_select}.
+\item Write the vq number to \field{queue_select}.
 
 \item Read the virtqueue size from \field{queue_size}. This controls how big the virtqueue is
   (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues}). If this field is 0, the virtqueue does not exist.
@@ -1035,8 +1036,8 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
 
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
 the driver sends an available buffer notification to the device by writing
-the 16-bit virtqueue index
-of this virtqueue to the Queue Notify address.
+the 16-bit vq number of this virtqueue to the Queue Notify
+address.
 
 When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
 the driver sends an available buffer notification to the device by writing
@@ -1053,7 +1054,7 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
 If VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated:
 \begin{itemize}
 \item If VIRTIO_F_NOTIFICATION_DATA has not been negotiated, the driver MUST use the
-\field{queue_notify_data} value instead of the virtqueue index.
+\field{queue_notify_data} value instead of the vq number.
 \item If VIRTIO_F_NOTIFICATION_DATA has been negotiated, the driver MUST set the
 \field{vqn} field to the \field{queue_notify_data} value.
 \end{itemize}
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

